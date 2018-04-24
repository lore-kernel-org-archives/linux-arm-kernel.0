From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 24 Apr 2018 13:35:58 -0500
Subject: [PATCH 2/3] edac: altera: Add support for Stratix10 SDRAM EDAC
In-Reply-To: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1524594959-5259-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add support for SDRAM ECC on the Stratix10 platform to
the EDAC device driver. Although Stratix10 is very similar
to the Arria10, hypervisor support for Stratix10 SDRAM ECC
requires the use of SMC calls to a higher priority
exception level to handle some register reads/writes.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/Kconfig       |   2 +-
 drivers/edac/altera_edac.c | 459 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h | 114 +++++++++++
 3 files changed, 574 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 3c4017007647..3c66b02b2473 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -379,7 +379,7 @@ config EDAC_THUNDERX
 
 config EDAC_ALTERA
 	bool "Altera SOCFPGA ECC"
-	depends on EDAC=y && ARCH_SOCFPGA
+	depends on EDAC=y && (ARCH_SOCFPGA || ARM64)
 	help
 	  Support for error detection and correction on the
 	  Altera SOCs. This must be selected for SDRAM ECC.
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 11d6419788c2..7ed885379719 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1,4 +1,5 @@
 /*
+ *  Copyright (C) 2017-2018, Intel Corporation
  *  Copyright Altera Corporation (C) 2014-2016. All rights reserved.
  *  Copyright 2011-2012 Calxeda, Inc.
  *
@@ -80,6 +81,25 @@ static const struct altr_sdram_prv_data a10_data = {
 	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
 };
 
+static const struct altr_sdram_prv_data s10_data = {
+	.ecc_ctrl_offset    = S10_ECCCTRL1_OFST,
+	.ecc_ctl_en_mask    = A10_ECCCTRL1_ECC_EN,
+	.ecc_stat_offset    = S10_INTSTAT_OFST,
+	.ecc_stat_ce_mask   = A10_INTSTAT_SBEERR,
+	.ecc_stat_ue_mask   = A10_INTSTAT_DBEERR,
+	.ecc_saddr_offset   = S10_SERRADDR_OFST,
+	.ecc_daddr_offset   = S10_DERRADDR_OFST,
+	.ecc_irq_en_offset  = S10_ERRINTEN_OFST,
+	.ecc_irq_en_mask    = A10_ECC_IRQ_EN_MASK,
+	.ecc_irq_clr_offset = S10_INTSTAT_OFST,
+	.ecc_irq_clr_mask   = (A10_INTSTAT_SBEERR | A10_INTSTAT_DBEERR),
+	.ecc_cnt_rst_offset = S10_ECCCTRL1_OFST,
+	.ecc_cnt_rst_mask   = A10_ECC_CNT_RESET_MASK,
+	.ce_ue_trgr_offset  = S10_DIAGINTTEST_OFST,
+	.ce_set_mask        = A10_DIAGINT_TSERRA_MASK,
+	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
+};
+
 /*********************** EDAC Memory Controller Functions ****************/
 
 /* The SDRAM controller uses the EDAC Memory Controller framework.       */
@@ -231,6 +251,7 @@ static unsigned long get_total_mem(void)
 static const struct of_device_id altr_sdram_ctrl_of_match[] = {
 	{ .compatible = "altr,sdram-edac", .data = &c5_data},
 	{ .compatible = "altr,sdram-edac-a10", .data = &a10_data},
+	{ .compatible = "altr,sdram-edac-s10", .data = &s10_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_sdram_ctrl_of_match);
@@ -477,6 +498,292 @@ static int altr_sdram_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**************** Stratix 10 EDAC Memory Controller Functions ************/
+
+/**
+ * s10_protected_reg_write
+ * Write to a protected SMC register.
+ * @context: Not used.
+ * @reg: Address of register
+ * @value: Value to write
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *	   INTEL_SIP_SMC_REG_ERROR on error
+ *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct arm_smccc_res result;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE, reg, val, 0, 0,
+		      0, 0, 0, &result);
+
+	return (int)result.a0;
+}
+
+/**
+ * s10_protected_reg_read
+ * Read the status of a protected SMC register
+ * @context: Not used.
+ * @reg: Address of register
+ * @value: Value read.
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *	   INTEL_SIP_SMC_REG_ERROR on error
+ *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct arm_smccc_res result;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, reg, 0, 0, 0,
+		      0, 0, 0, &result);
+
+	*val = (unsigned int)result.a1;
+
+	return (int)result.a0;
+}
+
+static bool s10_sdram_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case S10_ECCCTRL1_OFST:
+	case S10_ERRINTEN_OFST:
+	case S10_INTMODE_OFST:
+	case S10_INTSTAT_OFST:
+	case S10_DIAGINTTEST_OFST:
+	case S10_SYSMGR_ECC_INTMASK_VAL_OFST:
+	case S10_SYSMGR_ECC_INTMASK_SET_OFST:
+	case S10_SYSMGR_ECC_INTMASK_CLR_OFST:
+		return true;
+	}
+	return false;
+}
+
+static bool s10_sdram_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case S10_ECCCTRL1_OFST:
+	case S10_ERRINTEN_OFST:
+	case S10_INTMODE_OFST:
+	case S10_INTSTAT_OFST:
+	case S10_DERRADDR_OFST:
+	case S10_SERRADDR_OFST:
+	case S10_DIAGINTTEST_OFST:
+	case S10_SYSMGR_ECC_INTMASK_VAL_OFST:
+	case S10_SYSMGR_ECC_INTMASK_SET_OFST:
+	case S10_SYSMGR_ECC_INTMASK_CLR_OFST:
+	case S10_SYSMGR_ECC_INTSTAT_SERR_OFST:
+	case S10_SYSMGR_ECC_INTSTAT_DERR_OFST:
+		return true;
+	}
+	return false;
+}
+
+static bool s10_sdram_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case S10_ECCCTRL1_OFST:
+	case S10_ERRINTEN_OFST:
+	case S10_INTMODE_OFST:
+	case S10_INTSTAT_OFST:
+	case S10_DERRADDR_OFST:
+	case S10_SERRADDR_OFST:
+	case S10_DIAGINTTEST_OFST:
+	case S10_SYSMGR_ECC_INTMASK_VAL_OFST:
+	case S10_SYSMGR_ECC_INTMASK_SET_OFST:
+	case S10_SYSMGR_ECC_INTMASK_CLR_OFST:
+	case S10_SYSMGR_ECC_INTSTAT_SERR_OFST:
+	case S10_SYSMGR_ECC_INTSTAT_DERR_OFST:
+		return true;
+	}
+	return false;
+}
+
+static const struct regmap_config s10_sdram_regmap_cfg = {
+	.name = "s10_ddr",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xffffffff,
+	.writeable_reg = s10_sdram_writeable_reg,
+	.readable_reg = s10_sdram_readable_reg,
+	.volatile_reg = s10_sdram_volatile_reg,
+	.reg_read = s10_protected_reg_read,
+	.reg_write = s10_protected_reg_write,
+	.use_single_rw = true,
+};
+
+static int altr_s10_sdram_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+	struct altr_sdram_mc_data *drvdata;
+	const struct altr_sdram_prv_data *priv;
+	struct regmap *regmap;
+	struct dimm_info *dimm;
+	u32 read_reg;
+	struct resource *res;
+	int irq, ret = 0;
+	unsigned long mem_size;
+	void __iomem *reg_base;
+
+	id = of_match_device(altr_sdram_ctrl_of_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	/* Grab specific offsets and masks for Stratix10 */
+	priv = of_match_node(altr_sdram_ctrl_of_match,
+			     pdev->dev.of_node)->data;
+	/* Grab the register range from the sdr controller in device tree */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	regmap = devm_regmap_init(&pdev->dev, NULL, (void *)priv,
+				  &s10_sdram_regmap_cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Validate the SDRAM controller has ECC enabled */
+	if (regmap_read(regmap, priv->ecc_ctrl_offset, &read_reg) ||
+	    ((read_reg & priv->ecc_ctl_en_mask) != priv->ecc_ctl_en_mask)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No ECC/ECC disabled [0x%08X]\n", read_reg);
+		return -ENODEV;
+	}
+
+	/* Grab memory size from device tree. */
+	mem_size = get_total_mem();
+	if (!mem_size) {
+		edac_printk(KERN_ERR, EDAC_MC, "Unable to calculate memory size\n");
+		return -ENODEV;
+	}
+
+	/* Ensure the SDRAM Interrupt is disabled */
+	if (regmap_update_bits(regmap, priv->ecc_irq_en_offset,
+			       priv->ecc_irq_en_mask, 0)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Error disabling SDRAM ECC IRQ\n");
+		return -ENODEV;
+	}
+
+	/* Toggle to clear the SDRAM Error count */
+	if (regmap_update_bits(regmap, priv->ecc_cnt_rst_offset,
+			       priv->ecc_cnt_rst_mask,
+			       priv->ecc_cnt_rst_mask)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Error clearing SDRAM ECC count\n");
+		return -ENODEV;
+	}
+
+	if (regmap_update_bits(regmap, priv->ecc_cnt_rst_offset,
+			       priv->ecc_cnt_rst_mask, 0)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Error clearing SDRAM ECC count\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No irq %d in DT\n", irq);
+		return -ENODEV;
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = 1;
+	layers[1].is_virt_csrow = false;
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct altr_sdram_mc_data));
+	if (!mci)
+		return -ENOMEM;
+
+	mci->pdev = &pdev->dev;
+	drvdata = mci->pvt_info;
+	drvdata->mc_vbase = regmap;
+	drvdata->data = priv;
+	platform_set_drvdata(pdev, mci);
+
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Unable to get managed device resource\n");
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	mci->mtype_cap = MEM_FLAG_DDR3;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = EDAC_MOD_STR;
+	mci->ctl_name = dev_name(&pdev->dev);
+	mci->scrub_mode = SCRUB_SW_SRC;
+	mci->dev_name = dev_name(&pdev->dev);
+
+	dimm = *mci->dimms;
+	dimm->nr_pages = ((mem_size - 1) >> PAGE_SHIFT) + 1;
+	dimm->grain = 8;
+	dimm->dtype = DEV_X8;
+	dimm->mtype = MEM_DDR3;
+	dimm->edac_mode = EDAC_SECDED;
+
+	ret = edac_mc_add_mc(mci);
+	if (ret < 0)
+		goto err;
+
+	ret = devm_request_irq(&pdev->dev, irq, altr_sdram_mc_err_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_mc_printk(mci, KERN_ERR,
+			       "Unable to request irq %d\n", irq);
+		ret = -ENODEV;
+		goto err2;
+	}
+
+	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
+			       priv->ecc_irq_en_mask, priv->ecc_irq_en_mask)) {
+		edac_mc_printk(mci, KERN_ERR,
+			       "Error enabling SDRAM ECC IRQ\n");
+		ret = -ENODEV;
+		goto err2;
+	}
+
+	altr_sdr_mc_create_debugfs_nodes(mci);
+
+	devres_close_group(&pdev->dev, NULL);
+
+	return 0;
+
+err2:
+	edac_mc_del_mc(&pdev->dev);
+err:
+	devres_release_group(&pdev->dev, NULL);
+free:
+	edac_mc_free(mci);
+	edac_printk(KERN_ERR, EDAC_MC,
+		    "EDAC Probe Failed; Error %d\n", ret);
+
+	return ret;
+}
+
+static int altr_s10_sdram_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+/************** </Stratix10 EDAC Memory Controller Functions> ***********/
+
 /*
  * If you want to suspend, need to disable EDAC by removing it
  * from the device tree or defconfig.
@@ -508,6 +815,20 @@ static struct platform_driver altr_sdram_edac_driver = {
 
 module_platform_driver(altr_sdram_edac_driver);
 
+static struct platform_driver altr_s10_sdram_edac_driver = {
+	.probe = altr_s10_sdram_probe,
+	.remove = altr_s10_sdram_remove,
+	.driver = {
+		.name = "altr_s10_sdram_edac",
+#ifdef CONFIG_PM
+		.pm = &altr_sdram_pm_ops,
+#endif
+		.of_match_table = altr_sdram_ctrl_of_match,
+	},
+};
+
+module_platform_driver(altr_s10_sdram_edac_driver);
+
 /************************* EDAC Parent Probe *************************/
 
 static const struct of_device_id altr_edac_device_of_match[];
@@ -1925,6 +2246,144 @@ static struct platform_driver altr_edac_a10_driver = {
 };
 module_platform_driver(altr_edac_a10_driver);
 
+/************** Stratix 10 EDAC Device Controller Functions> ************/
+
+static void altr_edac_s10_irq_handler(struct irq_desc *desc)
+{
+	int dberr, bit, sm_offset, irq_status;
+	unsigned long flags;
+	struct altr_stratix10_edac *edac = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int irq = irq_desc_get_irq(desc);
+
+	spin_lock_irqsave(&edac->lock, flags);
+	dberr = (irq == edac->db_irq) ? 1 : 0;
+	sm_offset = dberr ? S10_SYSMGR_ECC_INTSTAT_DERR_OFST :
+			    S10_SYSMGR_ECC_INTSTAT_SERR_OFST;
+
+	chained_irq_enter(chip, desc);
+
+	s10_protected_reg_read(NULL, sm_offset, &irq_status);
+
+	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
+		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
+		if (irq)
+			generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(chip, desc);
+	spin_unlock_irqrestore(&edac->lock, flags);
+}
+
+static void s10_eccmgr_irq_mask(struct irq_data *d)
+{
+	struct altr_stratix10_edac *edac = irq_data_get_irq_chip_data(d);
+
+	s10_protected_reg_write(edac, S10_SYSMGR_ECC_INTMASK_SET_OFST,
+				BIT(d->hwirq));
+}
+
+static void s10_eccmgr_irq_unmask(struct irq_data *d)
+{
+	struct altr_stratix10_edac *edac = irq_data_get_irq_chip_data(d);
+
+	s10_protected_reg_write(edac, S10_SYSMGR_ECC_INTMASK_CLR_OFST,
+				BIT(d->hwirq));
+}
+
+static int s10_eccmgr_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				    irq_hw_number_t hwirq)
+{
+	struct altr_stratix10_edac *edac = d->host_data;
+
+	irq_set_chip_and_handler(irq, &edac->irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, edac);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops s10_eccmgr_ic_ops = {
+	.map = s10_eccmgr_irqdomain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static int altr_edac_s10_probe(struct platform_device *pdev)
+{
+	struct altr_stratix10_edac *edac;
+	struct device_node *child;
+
+	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
+	if (!edac)
+		return -ENOMEM;
+
+	edac->dev = &pdev->dev;
+	platform_set_drvdata(pdev, edac);
+	INIT_LIST_HEAD(&edac->s10_ecc_devices);
+	spin_lock_init(&edac->lock);
+
+	edac->ecc_mgr_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"altr,sysmgr-syscon");
+	if (IS_ERR(edac->ecc_mgr_map)) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to get syscon altr,sysmgr-syscon\n");
+		return PTR_ERR(edac->ecc_mgr_map);
+	}
+
+	edac->irq_chip.name = pdev->dev.of_node->name;
+	edac->irq_chip.irq_mask = s10_eccmgr_irq_mask;
+	edac->irq_chip.irq_unmask = s10_eccmgr_irq_unmask;
+	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
+					     &s10_eccmgr_ic_ops, edac);
+	if (!edac->domain) {
+		dev_err(&pdev->dev, "Error adding IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	edac->sb_irq = platform_get_irq(pdev, 0);
+	if (edac->sb_irq < 0) {
+		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+		return edac->sb_irq;
+	}
+
+	irq_set_chained_handler_and_data(edac->sb_irq,
+					 altr_edac_s10_irq_handler,
+					 edac);
+
+	edac->db_irq = platform_get_irq(pdev, 1);
+	if (edac->db_irq >= 0)
+		irq_set_chained_handler_and_data(edac->db_irq,
+						 altr_edac_s10_irq_handler,
+						 edac);
+
+	for_each_child_of_node(pdev->dev.of_node, child) {
+		if (!of_device_is_available(child))
+			continue;
+
+		if (of_device_is_compatible(child, "altr,sdram-edac-s10"))
+			of_platform_populate(pdev->dev.of_node,
+					     altr_sdram_ctrl_of_match,
+					     NULL, &pdev->dev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id altr_edac_s10_of_match[] = {
+	{ .compatible = "altr,socfpga-s10-ecc-manager" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altr_edac_s10_of_match);
+
+static struct platform_driver altr_edac_s10_driver = {
+	.probe =  altr_edac_s10_probe,
+	.driver = {
+		.name = "socfpga_s10_ecc_manager",
+		.of_match_table = altr_edac_s10_of_match,
+	},
+};
+module_platform_driver(altr_edac_s10_driver);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Thor Thayer");
 MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index cbc96290f743..1024528dc67a 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -18,6 +18,7 @@
 #ifndef _ALTERA_EDAC_H
 #define _ALTERA_EDAC_H
 
+#include <linux/arm-smccc.h>
 #include <linux/edac.h>
 #include <linux/types.h>
 
@@ -94,6 +95,7 @@
 /* SDRAM Controller Address Width Register */
 #define CV_DRAMADDRW               0xFFC2502C
 #define A10_DRAMADDRW              0xFFCFA0A8
+#define S10_DRAMADDRW              0xF80110E0
 
 /* SDRAM Controller Address Widths Field Register */
 #define DRAMADDRW_COLBIT_MASK      0x001F
@@ -115,6 +117,7 @@
 /* SDRAM Controller Interface Data Width Register */
 #define CV_DRAMIFWIDTH             0xFFC25030
 #define A10_DRAMIFWIDTH            0xFFCFB008
+#define S10_DRAMIFWIDTH            0xF8011008
 
 /* SDRAM Controller Interface Data Width Defines */
 #define CV_DRAMIFWIDTH_16B_ECC     24
@@ -164,6 +167,30 @@
 #define A10_INTMASK_CLR_OFST       0x10
 #define A10_DDR0_IRQ_MASK          BIT(17)
 
+/************* Stratix10 Defines **************/
+
+/* SDRAM Controller EccCtrl Register */
+#define S10_ECCCTRL1_OFST          0xF8011100
+
+/* SDRAM Controller DRAM IRQ Register */
+#define S10_ERRINTEN_OFST          0xF8011110
+
+/* SDRAM Interrupt Mode Register */
+#define S10_INTMODE_OFST           0xF801111C
+
+/* SDRAM Controller Error Status Register */
+#define S10_INTSTAT_OFST           0xF8011120
+
+/* SDRAM Controller ECC Error Address Register */
+#define S10_DERRADDR_OFST          0xF801112C
+#define S10_SERRADDR_OFST          0xF8011130
+
+/* SDRAM Controller ECC Diagnostic Register */
+#define S10_DIAGINTTEST_OFST       0xF8011124
+
+/* SDRAM Single Bit Error Count Compare Set Register */
+#define S10_SERRCNTREG_OFST        0xF801113C
+
 struct altr_sdram_prv_data {
 	int ecc_ctrl_offset;
 	int ecc_ctl_en_mask;
@@ -296,6 +323,16 @@ struct altr_sdram_mc_data {
 /* A10 ECC Controller memory initialization timeout */
 #define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
 
+/************* Stratix10 Defines **************/
+
+/* Stratix10 ECC Manager Defines */
+#define S10_SYSMGR_ECC_INTMASK_VAL_OFST   0xFFD12090
+#define S10_SYSMGR_ECC_INTMASK_SET_OFST   0xFFD12094
+#define S10_SYSMGR_ECC_INTMASK_CLR_OFST   0xFFD12098
+
+#define S10_SYSMGR_ECC_INTSTAT_SERR_OFST  0xFFD1209C
+#define S10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xFFD120A0
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
@@ -340,4 +377,81 @@ struct altr_arria10_edac {
 	struct list_head	a10_ecc_devices;
 };
 
+/*
+ * Functions specified by ARM SMC Calling convention:
+ *
+ * FAST call executes atomic operations, returns when the requested operation
+ * has completed.
+ * STD call starts a operation which can be preempted by a non-secure
+ * interrupt. The call can return before the requested operation has
+ * completed.
+ *
+ * a0..a7 is used as register names in the descriptions below, on arm32
+ * that translates to r0..r7 and on arm64 to w0..w7.
+ */
+
+#define INTEL_SIP_SMC_STD_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_64, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+#define INTEL_SIP_SMC_FAST_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+#define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
+#define INTEL_SIP_SMC_STATUS_OK				0x0
+#define INTEL_SIP_SMC_REG_ERROR				0x5
+
+/*
+ * Request INTEL_SIP_SMC_REG_READ
+ *
+ * Read a protected register using SMCCC
+ *
+ * Call register usage:
+ * a0: INTEL_SIP_SMC_REG_READ.
+ * a1: register address.
+ * a2-7: not used.
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
+ *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
+ * a1: Value in the register
+ * a2-3: not used.
+ */
+#define INTEL_SIP_SMC_FUNCID_REG_READ 7
+#define INTEL_SIP_SMC_REG_READ \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_READ)
+
+/*
+ * Request INTEL_SIP_SMC_REG_WRITE
+ *
+ * Write a protected register using SMCCC
+ *
+ * Call register usage:
+ * a0: INTEL_SIP_SMC_REG_WRITE.
+ * a1: register address
+ * a2: value to program into register.
+ * a3-7: not used.
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
+ *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
+ * a1-3: not used.
+ */
+#define INTEL_SIP_SMC_FUNCID_REG_WRITE 8
+#define INTEL_SIP_SMC_REG_WRITE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
+
+struct altr_stratix10_edac {
+	struct device		*dev;
+	struct regmap		*ecc_mgr_map;
+	int sb_irq;
+	int db_irq;
+	struct irq_domain	*domain;
+	struct irq_chip		irq_chip;
+	struct list_head	s10_ecc_devices;
+	/* Spinlock protects SMC calls */
+	spinlock_t		lock;
+};
+
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.7.4
