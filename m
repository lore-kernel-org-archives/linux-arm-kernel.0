From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  8 Jun 2017 16:11:21 +1200
Subject: [RFC PATCH 1/4] EDAC: mvebu: Add driver for Marvell Armada SoCs
In-Reply-To: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an EDAC driver for the memory controller and L2 cache used on
a number of Marvell Armada SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/edac/Kconfig      |   7 +
 drivers/edac/Makefile     |   1 +
 drivers/edac/mvebu_edac.c | 506 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/mvebu_edac.h |  66 ++++++
 4 files changed, 580 insertions(+)
 create mode 100644 drivers/edac/mvebu_edac.c
 create mode 100644 drivers/edac/mvebu_edac.h

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2aeed18..5cc84b333949 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -266,6 +266,13 @@ config EDAC_MV64X60
 	  Support for error detection and correction on the Marvell
 	  MV64360 and MV64460 chipsets.
 
+config EDAC_MVEBU
+	tristate "Marvell Armada 370/385/XP"
+	depends on ARCH_MVEBU
+	help
+	  Support for error detection and correction on the Marvell
+	  ARM SoCs.
+
 config EDAC_PASEMI
 	tristate "PA Semi PWRficient"
 	depends on PPC_PASEMI && PCI
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 0fd9ffa63299..29de6c23d15c 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -59,6 +59,7 @@ layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
 
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
+obj-$(CONFIG_EDAC_MVEBU)		+= mvebu_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
 obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
 obj-$(CONFIG_EDAC_AMD8111)		+= amd8111_edac.o
diff --git a/drivers/edac/mvebu_edac.c b/drivers/edac/mvebu_edac.c
new file mode 100644
index 000000000000..624cf10f821b
--- /dev/null
+++ b/drivers/edac/mvebu_edac.c
@@ -0,0 +1,506 @@
+/*
+ * EDAC driver for Marvell ARM SoCs
+ *
+ * Copyright (C) 2017 Allied Telesis Labs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/edac.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+
+#include "edac_module.h"
+#include "mvebu_edac.h"
+
+static const char *mvebu_ctl_name = "MVEBU";
+static int edac_mc_idx;
+static int edac_l2_idx;
+
+/*********************** DRAM err device **********************************/
+
+static void mvebu_mc_check(struct mem_ctl_info *mci)
+{
+	struct mvebu_mc_pdata *pdata = mci->pvt_info;
+	u32 reg;
+	u32 err_addr;
+	u32 sdram_ecc;
+	u32 comp_ecc;
+	u32 syndrome;
+
+	reg = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
+	if (!reg)
+		return;
+
+	err_addr = reg & ~0x3;
+	sdram_ecc = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_RCVD);
+	comp_ecc = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CALC);
+	syndrome = sdram_ecc ^ comp_ecc;
+
+	/* first bit clear in ECC Err Reg, 1 bit error, correctable by HW */
+	if (!(reg & 0x1))
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
+				     err_addr >> PAGE_SHIFT,
+				     err_addr & PAGE_MASK, syndrome,
+				     0, 0, -1,
+				     mci->ctl_name, "");
+	else	/* 2 bit error, UE */
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
+				     err_addr >> PAGE_SHIFT,
+				     err_addr & PAGE_MASK, 0,
+				     0, 0, -1,
+				     mci->ctl_name, "");
+
+	/* clear the error */
+	writel(0, pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
+}
+
+static irqreturn_t mvebu_mc_isr(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct mvebu_mc_pdata *pdata = mci->pvt_info;
+	u32 reg;
+
+	reg = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
+	if (!reg)
+		return IRQ_NONE;
+
+	/* writing 0's to the ECC err addr in check function clears irq */
+	mvebu_mc_check(mci);
+
+	return IRQ_HANDLED;
+}
+
+static void get_total_mem(struct mvebu_mc_pdata *pdata)
+{
+	struct device_node *np = NULL;
+	struct resource res;
+	int ret;
+	unsigned long total_mem = 0;
+
+	for_each_node_by_type(np, "memory") {
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			continue;
+
+		total_mem += resource_size(&res);
+	}
+
+	pdata->total_mem = total_mem;
+}
+
+static void mvebu_init_csrows(struct mem_ctl_info *mci,
+				struct mvebu_mc_pdata *pdata)
+{
+	struct csrow_info *csrow;
+	struct dimm_info *dimm;
+
+	u32 devtype;
+	u32 ctl;
+
+	get_total_mem(pdata);
+
+	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_CONFIG);
+
+	csrow = mci->csrows[0];
+	dimm = csrow->channels[0]->dimm;
+
+	dimm->nr_pages = pdata->total_mem >> PAGE_SHIFT;
+	dimm->grain = 8;
+
+	dimm->mtype = (ctl & MVEBU_SDRAM_REGISTERED) ? MEM_RDDR : MEM_DDR;
+
+	devtype = (ctl >> 20) & 0x3;
+	switch (devtype) {
+	case 0x0:
+		dimm->dtype = DEV_X32;
+		break;
+	case 0x2:		/* could be X8 too, but no way to tell */
+		dimm->dtype = DEV_X16;
+		break;
+	case 0x3:
+		dimm->dtype = DEV_X4;
+		break;
+	default:
+		dimm->dtype = DEV_UNKNOWN;
+		break;
+	}
+
+	dimm->edac_mode = EDAC_SECDED;
+}
+
+static int mvebu_mc_err_probe(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[2];
+	struct mvebu_mc_pdata *pdata;
+	struct resource *r;
+	u32 ctl;
+	int res = 0;
+
+	if (!devres_open_group(&pdev->dev, mvebu_mc_err_probe, GFP_KERNEL))
+		return -ENOMEM;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = 1;
+	layers[1].is_virt_csrow = false;
+	mci = edac_mc_alloc(edac_mc_idx, ARRAY_SIZE(layers), layers,
+			    sizeof(struct mvebu_mc_pdata));
+	if (!mci) {
+		pr_err("%s: No memory for CPU err\n", __func__);
+		devres_release_group(&pdev->dev, mvebu_mc_err_probe);
+		return -ENOMEM;
+	}
+
+	pdata = mci->pvt_info;
+	mci->pdev = &pdev->dev;
+	platform_set_drvdata(pdev, mci);
+	pdata->name = "mvebu_mc_err";
+	mci->dev_name = dev_name(&pdev->dev);
+	pdata->edac_idx = edac_mc_idx++;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		pr_err("%s: Unable to get resource for MC err regs\n",
+		       __func__);
+		res = -ENOENT;
+		goto err;
+	}
+
+	pdata->mc_vbase = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pdata->mc_vbase)) {
+		pr_err("%s: Unable to setup MC err regs\n", __func__);
+		res = PTR_ERR(pdata->mc_vbase);
+		goto err;
+	}
+
+	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_CONFIG);
+	if (!(ctl & MVEBU_SDRAM_ECC)) {
+		/* Non-ECC RAM? */
+		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
+		res = -ENODEV;
+		goto err;
+	}
+
+	edac_dbg(3, "init mci\n");
+	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_DDR;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = EDAC_MOD_STR;
+	mci->mod_ver = MVEBU_REVISION;
+	mci->ctl_name = mvebu_ctl_name;
+
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		mci->edac_check = mvebu_mc_check;
+
+	mci->ctl_page_to_phys = NULL;
+
+	mci->scrub_mode = SCRUB_SW_SRC;
+
+	mvebu_init_csrows(mci, pdata);
+
+	/* setup MC registers */
+	writel(0, pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
+	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
+	ctl = (ctl & 0xff00ffff) | 0x10000;
+	writel(ctl, pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
+
+	if (edac_op_state == EDAC_OPSTATE_INT) {
+		/* acquire interrupt that reports errors */
+		pdata->irq = platform_get_irq(pdev, 0);
+		res = devm_request_irq(&pdev->dev,
+				       pdata->irq,
+				       mvebu_mc_isr,
+				       0,
+				       "[EDAC] MC err",
+				       mci);
+		if (res < 0) {
+			pr_err("%s: Unable to request irq %d\n", __func__,
+			       pdata->irq);
+			res = -ENODEV;
+			goto err;
+		}
+
+		pr_info("acquired irq %d for MC Err\n",
+		       pdata->irq);
+	}
+
+	res = edac_mc_add_mc(mci);
+	if (res) {
+		edac_dbg(3, "failed edac_mc_add_mc()\n");
+		goto err;
+	}
+
+
+	/* get this far and it's successful */
+	edac_dbg(3, "success\n");
+
+	return 0;
+
+err:
+	devres_release_group(&pdev->dev, mvebu_mc_err_probe);
+	edac_mc_free(mci);
+	return res;
+}
+
+static int mvebu_mc_err_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_dbg(0, "\n");
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct of_device_id mvebu_mc_err_of_match[] = {
+	{ .compatible = "marvell,armada-xp-sdram-controller", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_mc_err_of_match);
+
+static struct platform_driver mvebu_mc_err_driver = {
+	.probe = mvebu_mc_err_probe,
+	.remove = mvebu_mc_err_remove,
+	.driver = {
+		   .name = "mvebu_mc_err",
+		   .of_match_table = of_match_ptr(mvebu_mc_err_of_match),
+	},
+};
+
+/*********************** L2 err device **********************************/
+static void mvebu_l2_check(struct edac_device_ctl_info *edac_dev)
+{
+
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+	u32 val;
+
+	val = readl(pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
+	if (!(val & 1))
+		return;
+
+	pr_err("ECC Error in CPU L2 cache\n");
+	pr_err("L2 Error Attributes Capture Register: 0x%08x\n", val);
+	pr_err("L2 Error Address Capture Register: 0x%08x\n",
+		readl(pdata->l2_vbase + MVEBU_L2_ERR_ADDR));
+
+	if (L2_ERR_TYPE(val) == 0)
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+
+	if (L2_ERR_TYPE(val) == 1)
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+
+	writel(BIT(0), pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
+}
+
+static irqreturn_t mvebu_l2_isr(int irq, void *dev_id)
+{
+	struct edac_device_ctl_info *edac_dev = dev_id;
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+	u32 val;
+
+	val = readl(pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
+	if (!(val & 1))
+		return IRQ_NONE;
+
+	mvebu_l2_check(edac_dev);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t inject_ctrl_show(struct edac_device_ctl_info *edac_dev,
+				char *data)
+{
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return sprintf(data, "0x%08x",
+		       readl(pdata->l2_vbase + MVEBU_L2_ERR_INJ_CTRL));
+}
+
+static ssize_t inject_ctrl_store(struct edac_device_ctl_info *edac_dev,
+				 const char *data, size_t count)
+{
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+	unsigned long val;
+
+	if (!kstrtoul(data, 0, &val)) {
+		writel(val, pdata->l2_vbase + MVEBU_L2_ERR_INJ_CTRL);
+		return count;
+	}
+
+	return 0;
+}
+
+static ssize_t inject_mask_show(struct edac_device_ctl_info *edac_dev,
+				     char *data)
+{
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+
+	return sprintf(data, "0x%08x",
+		       readl(pdata->l2_vbase + MVEBU_L2_ERR_INJ_MASK));
+}
+
+static ssize_t inject_mask_store(struct edac_device_ctl_info *edac_dev,
+				      const char *data, size_t count)
+{
+	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
+	unsigned long val;
+
+	if (!kstrtoul(data, 0, &val)) {
+		writel(val, pdata->l2_vbase + MVEBU_L2_ERR_INJ_MASK);
+		return count;
+	}
+
+	return 0;
+}
+
+static struct edac_dev_sysfs_attribute mvebu_l2_sysfs_attributes[] = {
+	__ATTR_RW(inject_ctrl),
+	__ATTR_RW(inject_mask),
+	{},
+};
+
+static int mvebu_l2_err_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct mvebu_l2_pdata *pdata;
+	struct resource *r;
+	int res;
+
+	if (!devres_open_group(&pdev->dev, mvebu_l2_err_probe, GFP_KERNEL))
+		return -ENOMEM;
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*pdata),
+					      "cpu", 1, "L", 1, 2, NULL, 0,
+					      edac_l2_idx);
+	if (!edac_dev) {
+		devres_release_group(&pdev->dev, mvebu_l2_err_probe);
+		return -ENOMEM;
+	}
+
+	pdata = edac_dev->pvt_info;
+	pdata->name = "mvebu_l2_err";
+	edac_dev->dev = &pdev->dev;
+	dev_set_drvdata(edac_dev->dev, edac_dev);
+	edac_dev->mod_name = EDAC_MOD_STR;
+	edac_dev->ctl_name = pdata->name;
+	edac_dev->dev_name = pdata->name;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* skip to error registers */
+	r->start += 0x600;
+
+	pdata->l2_vbase = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pdata->l2_vbase)) {
+		res = PTR_ERR(pdata->l2_vbase);
+		goto err;
+	}
+
+	writel(L2_ERR_UE_THRESH(1) | L2_ERR_CE_THRESH(1),
+	       pdata->l2_vbase + MVEBU_L2_ERR_THRESH);
+	writel(BIT(0), pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
+
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		edac_dev->edac_check = mvebu_l2_check;
+
+	edac_dev->sysfs_attributes = mvebu_l2_sysfs_attributes;
+
+	pdata->edac_idx = edac_l2_idx++;
+
+	if (edac_op_state == EDAC_OPSTATE_INT) {
+		pdata->irq = platform_get_irq(pdev, 0);
+		res = devm_request_irq(&pdev->dev, pdata->irq,
+				       mvebu_l2_isr, IRQF_SHARED,
+				       "[EDAC] L2 err", edac_dev);
+		if (res < 0)
+			goto err;
+	}
+
+	if (edac_device_add_device(edac_dev) > 0) {
+		res = -EIO;
+		goto err;
+	}
+
+	devres_remove_group(&pdev->dev, mvebu_l2_err_probe);
+	return 0;
+
+err:
+	devres_release_group(&pdev->dev, mvebu_l2_err_probe);
+	edac_device_free_ctl_info(edac_dev);
+	return res;
+}
+
+static int mvebu_l2_err_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(edac_dev);
+	return 0;
+}
+
+static const struct of_device_id mvebu_l2_err_of_match[] = {
+	{ .compatible = "marvell,aurora-system-cache", },
+	{},
+};
+
+static struct platform_driver mvebu_l2_err_driver = {
+	.probe = mvebu_l2_err_probe,
+	.remove = mvebu_l2_err_remove,
+	.driver = {
+		   .name = "mvebu_l2_err",
+		   .of_match_table = of_match_ptr(mvebu_l2_err_of_match),
+	},
+};
+
+static struct platform_driver * const drivers[] = {
+	&mvebu_mc_err_driver,
+	&mvebu_l2_err_driver,
+};
+
+static int __init mvebu_edac_init(void)
+{
+	/* make sure error reporting method is sane */
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
+	return  platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+}
+module_init(mvebu_edac_init);
+
+static void __exit mvebu_edac_exit(void)
+{
+	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
+}
+module_exit(mvebu_edac_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Allied Telesis Labs");
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state,
+		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
diff --git a/drivers/edac/mvebu_edac.h b/drivers/edac/mvebu_edac.h
new file mode 100644
index 000000000000..33f0534b87df
--- /dev/null
+++ b/drivers/edac/mvebu_edac.h
@@ -0,0 +1,66 @@
+/*
+ * EDAC defs for Marvell SoCs
+ *
+ * Copyright (C) 2017 Allied Telesis Labs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details
+ */
+#ifndef _MVEBU_EDAC_H_
+#define _MVEBU_EDAC_H_
+
+#define MVEBU_REVISION " Ver: 2.0.0"
+#define EDAC_MOD_STR	"MVEBU_edac"
+
+/*
+ * L2 Err Registers
+ */
+#define MVEBU_L2_ERR_COUNT		0x00	/* 0x8600 */
+#define MVEBU_L2_ERR_THRESH		0x04	/* 0x8604 */
+#define MVEBU_L2_ERR_ATTR		0x08	/* 0x8608 */
+#define MVEBU_L2_ERR_ADDR		0x0c	/* 0x860c */
+#define MVEBU_L2_ERR_CAP		0x10	/* 0x8610 */
+#define MVEBU_L2_ERR_INJ_CTRL		0x14	/* 0x8614 */
+#define MVEBU_L2_ERR_INJ_MASK		0x18	/* 0x8618 */
+
+#define L2_ERR_UE_THRESH(val)		((val & 0xff) << 16)
+#define L2_ERR_CE_THRESH(val)		(val & 0xffff)
+#define L2_ERR_TYPE(val)		((val >> 8) & 0x3)
+
+/*
+ * SDRAM Controller Registers
+ */
+#define MVEBU_SDRAM_CONFIG		0x00	/* 0x1400 */
+#define MVEBU_SDRAM_ERR_DATA_HI		0x40	/* 0x1440 */
+#define MVEBU_SDRAM_ERR_DATA_LO		0x44	/* 0x1444 */
+#define MVEBU_SDRAM_ERR_ECC_RCVD	0x48	/* 0x1448 */
+#define MVEBU_SDRAM_ERR_ECC_CALC	0x4c	/* 0x144c */
+#define MVEBU_SDRAM_ERR_ADDR		0x50	/* 0x1450 */
+#define MVEBU_SDRAM_ERR_ECC_CNTL	0x54	/* 0x1454 */
+#define MVEBU_SDRAM_ERR_ECC_ERR_CNT	0x58	/* 0x1458 */
+
+#define MVEBU_SDRAM_REGISTERED	0x20000
+#define MVEBU_SDRAM_ECC		0x40000
+
+struct mvebu_l2_pdata {
+	void __iomem *l2_vbase;
+	char *name;
+	int irq;
+	int edac_idx;
+};
+
+struct mvebu_mc_pdata {
+	void __iomem *mc_vbase;
+	int total_mem;
+	char *name;
+	int irq;
+	int edac_idx;
+};
+
+#endif
-- 
2.13.0
