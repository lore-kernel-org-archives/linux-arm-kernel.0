From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 10 Feb 2016 13:26:21 -0600
Subject: [PATCHv10 1/4] EDAC,
 altera: Add Altera L2 Cache and OCRAM EDAC Support
Message-ID: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Adding L2 Cache and On-Chip RAM EDAC support for the
Altera SoCs using the EDAC device  model. The SDRAM
controller is using the Memory Controller model.

Each type of ECC is individually configurable.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v10: Changes noted by maintainer included: Fix tear-down of debugfs
     error path- remove specific device debugfs dirs. Addition of
     warning if neither IRQ triggered. Cleanup of comments.
     Better function naming. Cleaner alloc functions.
v9:  Improve device tree node release. Free managed resources
     on error path. Fix ocram memory leak.
v8:  Remove MASK from single bit mask names.
     s/altr,edac/altr,socfpga-ecc-manager
     Use debugfs instead of sysfs.
     Add chip family name to match string.
     Fix header year.
     Fix build dependencies & change commit accordingly.
     s/CONFIG_EDAC_ALTERA_MC/CONFIG_EDAC_ALTERA
v7:  s/of_get_named_gen_pool/of_gen_pool_get
     Remove #ifdef for EDAC_DEBUG
     Use -ENODEV instead of EPROBE_DEFER
v6:  Convert to nested EDAC in device tree. Force L2 cache
     on for L2Cache ECC & remove L2 cache syscon for checking
     enable bit. Update year in header.
v5:  No change.
v4:  Change mask defines to use BIT().
     Fix comment style to agree with kernel coding style.
     Better printk description for read != write in trigger.
     Remove SysFS debugging message.
     Better dci->mod_name
     Move gen_pool pointer assignment to end of function.
     Invert logic to reduce indent in ocram depenency check.
     Change from dev_err() to edac_printk()
     Replace magic numbers with defines & comments.
     Improve error injection test.
     Change Makefile intermediary name to altr (from alt)
v3:  Move OCRAM and L2 cache EDAC functions into altera_edac.c
     instead of separate files.
v2:  Fix L2 dependency comments.
---
 drivers/edac/Kconfig       |   26 ++-
 drivers/edac/Makefile      |    2 +-
 drivers/edac/altera_edac.c |  492 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 512 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index ef25000..37755e6 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -367,14 +367,30 @@ config EDAC_OCTEON_PCI
 	  Support for error detection and correction on the
 	  Cavium Octeon family of SOCs.
 
-config EDAC_ALTERA_MC
-	bool "Altera SDRAM Memory Controller EDAC"
+config EDAC_ALTERA
+	bool "Altera SOCFPGA ECC"
 	depends on EDAC_MM_EDAC=y && ARCH_SOCFPGA
 	help
 	  Support for error detection and correction on the
-	  Altera SDRAM memory controller. Note that the
-	  preloader must initialize the SDRAM before loading
-	  the kernel.
+	  Altera SOCs. This must be selected for SDRAM ECC.
+	  Note that the preloader must initialize the SDRAM
+	  before loading the kernel.
+
+config EDAC_ALTERA_L2C
+	bool "Altera L2 Cache ECC"
+	depends on EDAC_ALTERA=y
+	select CACHE_L2X0
+	help
+	  Support for error detection and correction on the
+	  Altera L2 cache Memory for Altera SoCs. This option
+	  requires L2 cache so it will force that selection.
+
+config EDAC_ALTERA_OCRAM
+	bool "Altera On-Chip RAM ECC"
+	depends on EDAC_ALTERA=y && SRAM && GENERIC_ALLOCATOR
+	help
+	  Support for error detection and correction on the
+	  Altera On-Chip RAM Memory for Altera SoCs.
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index be163e2..f9e4a3e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -67,6 +67,6 @@ obj-$(CONFIG_EDAC_OCTEON_L2C)		+= octeon_edac-l2c.o
 obj-$(CONFIG_EDAC_OCTEON_LMC)		+= octeon_edac-lmc.o
 obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 
-obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
+obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 9296409..63e4209 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright Altera Corporation (C) 2014-2015. All rights reserved.
+ *  Copyright Altera Corporation (C) 2014-2016. All rights reserved.
  *  Copyright 2011-2012 Calxeda, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -17,8 +17,10 @@
  * Adapted from the highbank_mc_edac driver.
  */
 
+#include <asm/cacheflush.h>
 #include <linux/ctype.h>
 #include <linux/edac.h>
+#include <linux/genalloc.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -34,6 +36,7 @@
 
 #define EDAC_MOD_STR		"altera_edac"
 #define EDAC_VERSION		"1"
+#define EDAC_DEVICE		"Altera"
 
 static const struct altr_sdram_prv_data c5_data = {
 	.ecc_ctrl_offset    = CV_CTLCFG_OFST,
@@ -75,6 +78,31 @@ static const struct altr_sdram_prv_data a10_data = {
 	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
 };
 
+/************************** EDAC Device Defines **************************/
+
+/* OCRAM ECC Management Group Defines */
+#define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
+#define ALTR_OCR_ECC_EN                 BIT(0)
+#define ALTR_OCR_ECC_INJS               BIT(1)
+#define ALTR_OCR_ECC_INJD               BIT(2)
+#define ALTR_OCR_ECC_SERR               BIT(3)
+#define ALTR_OCR_ECC_DERR               BIT(4)
+
+/* L2 ECC Management Group Defines */
+#define ALTR_MAN_GRP_L2_ECC_OFFSET      0x00
+#define ALTR_L2_ECC_EN                  BIT(0)
+#define ALTR_L2_ECC_INJS                BIT(1)
+#define ALTR_L2_ECC_INJD                BIT(2)
+
+#define ALTR_UE_TRIGGER_CHAR            'U'   /* Trigger for UE */
+#define ALTR_TRIGGER_READ_WRD_CNT       32    /* Line size x 4 */
+#define ALTR_TRIG_OCRAM_BYTE_SIZE       128   /* Line size x 4 */
+#define ALTR_TRIG_L2C_BYTE_SIZE         4096  /* Full Page */
+
+/*********************** EDAC Memory Controller Functions ****************/
+
+/* The SDRAM controller uses the EDAC Memory Controller framework.       */
+
 static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 {
 	struct mem_ctl_info *mci = dev_id;
@@ -504,6 +532,466 @@ static struct platform_driver altr_sdram_edac_driver = {
 
 module_platform_driver(altr_sdram_edac_driver);
 
+/************************* EDAC Parent Probe *************************/
+
+static const struct of_device_id altr_edac_device_of_match[];
+
+static const struct of_device_id altr_edac_of_match[] = {
+	{ .compatible = "altr,socfpga-ecc-manager" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altr_edac_of_match);
+
+static int altr_edac_probe(struct platform_device *pdev)
+{
+	of_platform_populate(pdev->dev.of_node, altr_edac_device_of_match,
+			     NULL, &pdev->dev);
+	return 0;
+}
+
+static struct platform_driver altr_edac_driver = {
+	.probe =  altr_edac_probe,
+	.driver = {
+		.name = "socfpga_ecc_manager",
+		.of_match_table = altr_edac_of_match,
+	},
+};
+module_platform_driver(altr_edac_driver);
+
+/************************* EDAC Device Functions *************************/
+
+/*
+ * EDAC Device Functions (shared between various IPs).
+ * The discrete memories use the EDAC Device framework. The probe
+ * and error handling functions are very similar between memories
+ * so they are shared. The memory allocation and freeing for EDAC
+ * trigger testing are different for each memory.
+ */
+
+const struct edac_device_prv_data ocramecc_data;
+const struct edac_device_prv_data l2ecc_data;
+
+struct edac_device_prv_data {
+	int (*setup)(struct platform_device *pdev, void __iomem *base);
+	int ce_clear_mask;
+	int ue_clear_mask;
+	char dbgfs_name[20];
+	void * (*alloc_mem)(size_t size, void **other);
+	void (*free_mem)(void *p, size_t size, void *other);
+	int ecc_enable_mask;
+	int ce_set_mask;
+	int ue_set_mask;
+	int trig_alloc_sz;
+};
+
+struct altr_edac_device_dev {
+	void __iomem *base;
+	int sb_irq;
+	int db_irq;
+	const struct edac_device_prv_data *data;
+	struct dentry *debugfs_dir;
+	char *edac_dev_name;
+};
+
+static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
+{
+	irqreturn_t ret_value = IRQ_NONE;
+	struct edac_device_ctl_info *dci = dev_id;
+	struct altr_edac_device_dev *drvdata = dci->pvt_info;
+	const struct edac_device_prv_data *priv = drvdata->data;
+
+	if (irq == drvdata->sb_irq) {
+		if (priv->ce_clear_mask)
+			writel(priv->ce_clear_mask, drvdata->base);
+		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
+		ret_value = IRQ_HANDLED;
+	} else if (irq == drvdata->db_irq) {
+		if (priv->ue_clear_mask)
+			writel(priv->ue_clear_mask, drvdata->base);
+		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
+		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+		ret_value = IRQ_HANDLED;
+	} else {
+		WARN_ON(1);
+	}
+
+	return ret_value;
+}
+
+static ssize_t altr_edac_device_trig(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+
+{
+	u32 *ptemp, i, error_mask;
+	int result = 0;
+	u8 trig_type;
+	unsigned long flags;
+	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
+	const struct edac_device_prv_data *priv = drvdata->data;
+	void *generic_ptr = edac_dci->dev;
+
+	if (!user_buf || get_user(trig_type, user_buf))
+		return -EFAULT;
+
+	if (!priv->alloc_mem)
+		return -ENOMEM;
+
+	/*
+	 * Note that generic_ptr is initialized to the device * but in
+	 * some alloc_functions, this is overridden and returns data.
+	 */
+	ptemp = priv->alloc_mem(priv->trig_alloc_sz, &generic_ptr);
+	if (!ptemp) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Inject: Buffer Allocation error\n");
+		return -ENOMEM;
+	}
+
+	if (trig_type == ALTR_UE_TRIGGER_CHAR)
+		error_mask = priv->ue_set_mask;
+	else
+		error_mask = priv->ce_set_mask;
+
+	edac_printk(KERN_ALERT, EDAC_DEVICE,
+		    "Trigger Error Mask (0x%X)\n", error_mask);
+
+	local_irq_save(flags);
+	/* write ECC corrupted data out. */
+	for (i = 0; i < (priv->trig_alloc_sz / sizeof(*ptemp)); i++) {
+		/* Read data so we're in the correct state */
+		rmb();
+		if (ACCESS_ONCE(ptemp[i]))
+			result = -1;
+		/* Toggle Error bit (it is latched), leave ECC enabled */
+		writel(error_mask, drvdata->base);
+		writel(priv->ecc_enable_mask, drvdata->base);
+		ptemp[i] = i;
+	}
+	/* Ensure it has been written out */
+	wmb();
+	local_irq_restore(flags);
+
+	if (result)
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Mem Not Cleared\n");
+
+	/* Read out written data. ECC error caused here */
+	for (i = 0; i < ALTR_TRIGGER_READ_WRD_CNT; i++)
+		if (ACCESS_ONCE(ptemp[i]) != i)
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "Read doesn't match written data\n");
+
+	if (priv->free_mem)
+		priv->free_mem(ptemp, priv->trig_alloc_sz, generic_ptr);
+
+	return count;
+}
+
+static const struct file_operations altr_edac_device_inject_fops = {
+	.open = simple_open,
+	.write = altr_edac_device_trig,
+	.llseek = generic_file_llseek,
+};
+
+static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
+				      const struct edac_device_prv_data *priv)
+{
+	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
+
+	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
+		return;
+
+	drvdata->debugfs_dir = edac_debugfs_create_dir(drvdata->edac_dev_name);
+	if (!drvdata->debugfs_dir)
+		return;
+
+	if (!edac_debugfs_create_file(priv->dbgfs_name, S_IWUSR,
+				      drvdata->debugfs_dir, edac_dci,
+				      &altr_edac_device_inject_fops))
+		debugfs_remove_recursive(drvdata->debugfs_dir);
+}
+
+static const struct of_device_id altr_edac_device_of_match[] = {
+#ifdef CONFIG_EDAC_ALTERA_L2C
+	{ .compatible = "altr,socfpga-l2-ecc", .data = (void *)&l2ecc_data },
+#endif
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
+	{ .compatible = "altr,socfpga-ocram-ecc",
+	  .data = (void *)&ocramecc_data },
+#endif
+	{},
+};
+MODULE_DEVICE_TABLE(of, altr_edac_device_of_match);
+
+/*
+ * altr_edac_device_probe()
+ *	This is a generic EDAC device driver that will support
+ *	various Altera memory devices such as the L2 cache ECC and
+ *	OCRAM ECC as well as the memories for other peripherals.
+ *	Module specific initialization is done by passing the
+ *	function index in the device tree.
+ */
+static int altr_edac_device_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci;
+	struct altr_edac_device_dev *drvdata;
+	struct resource *r;
+	int res = 0;
+	struct device_node *np = pdev->dev.of_node;
+	char *ecc_name = (char *)np->name;
+	static int dev_instance;
+
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to open devm\n");
+		return -ENOMEM;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to get mem resource\n");
+		res = -ENODEV;
+		goto fail;
+	}
+
+	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
+				     dev_name(&pdev->dev))) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s:Error requesting mem region\n", ecc_name);
+		res = -EBUSY;
+		goto fail;
+	}
+
+	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
+					 1, ecc_name, 1, 0, NULL, 0,
+					 dev_instance++);
+
+	if (!dci) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: Unable to allocate EDAC device\n", ecc_name);
+		res = -ENOMEM;
+		goto fail;
+	}
+
+	drvdata = dci->pvt_info;
+	dci->dev = &pdev->dev;
+	platform_set_drvdata(pdev, dci);
+	drvdata->edac_dev_name = ecc_name;
+
+	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (!drvdata->base)
+		goto fail1;
+
+	/* Get driver specific data for this EDAC device */
+	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
+
+	/* Check specific dependencies for the module */
+	if (drvdata->data->setup) {
+		res = drvdata->data->setup(pdev, drvdata->base);
+		if (res)
+			goto fail1;
+	}
+
+	drvdata->sb_irq = platform_get_irq(pdev, 0);
+	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
+			       altr_edac_device_handler,
+			       0, dev_name(&pdev->dev), dci);
+	if (res)
+		goto fail1;
+
+	drvdata->db_irq = platform_get_irq(pdev, 1);
+	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
+			       altr_edac_device_handler,
+			       0, dev_name(&pdev->dev), dci);
+	if (res)
+		goto fail1;
+
+	dci->mod_name = "Altera ECC Manager";
+	dci->dev_name = drvdata->edac_dev_name;
+
+	res = edac_device_add_device(dci);
+	if (res)
+		goto fail1;
+
+	altr_create_edacdev_dbgfs(dci, drvdata->data);
+
+	devres_close_group(&pdev->dev, NULL);
+
+	return 0;
+
+fail1:
+	edac_device_free_ctl_info(dci);
+fail:
+	devres_release_group(&pdev->dev, NULL);
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
+
+	return res;
+}
+
+static int altr_edac_device_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+	struct altr_edac_device_dev *drvdata = dci->pvt_info;
+
+	debugfs_remove_recursive(drvdata->debugfs_dir);
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return 0;
+}
+
+static struct platform_driver altr_edac_device_driver = {
+	.probe =  altr_edac_device_probe,
+	.remove = altr_edac_device_remove,
+	.driver = {
+		.name = "altr_edac_device",
+		.of_match_table = altr_edac_device_of_match,
+	},
+};
+module_platform_driver(altr_edac_device_driver);
+
+/*********************** OCRAM EDAC Device Functions *********************/
+
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
+
+static void *ocram_alloc_mem(size_t size, void **other)
+{
+	struct device_node *np;
+	struct gen_pool *gp;
+	void *sram_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-ocram-ecc");
+	if (!np)
+		return NULL;
+
+	gp = of_gen_pool_get(np, "iram", 0);
+	of_node_put(np);
+	if (!gp)
+		return NULL;
+
+	sram_addr = (void *)gen_pool_alloc(gp, size);
+	if (!sram_addr)
+		return NULL;
+
+	memset(sram_addr, 0, size);
+	/* Ensure data is written out */
+	wmb();
+
+	/* Remember this handle for freeing  later */
+	*other = gp;
+
+	return sram_addr;
+}
+
+static void ocram_free_mem(void *p, size_t size, void *other)
+{
+	gen_pool_free((struct gen_pool *)other, (u32)p, size);
+}
+
+/*
+ * altr_ocram_check_deps()
+ *	Test for OCRAM cache ECC dependencies upon entry because
+ *	platform specific startup should have initialized the
+ *	On-Chip RAM memory and enabled the ECC.
+ *	Can't turn on ECC here because accessing un-initialized
+ *	memory will cause CE/UE errors possibly causing an ABORT.
+ */
+static int altr_ocram_check_deps(struct platform_device *pdev,
+				 void __iomem *base)
+{
+	if (readl(base) & ALTR_OCR_ECC_EN)
+		return 0;
+
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "OCRAM: No ECC present or ECC disabled.\n");
+	return -ENODEV;
+}
+
+const struct edac_device_prv_data ocramecc_data = {
+	.setup = altr_ocram_check_deps,
+	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
+	.ue_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_DERR),
+	.dbgfs_name = "altr_ocram_trigger",
+	.alloc_mem = ocram_alloc_mem,
+	.free_mem = ocram_free_mem,
+	.ecc_enable_mask = ALTR_OCR_ECC_EN,
+	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
+	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
+	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
+};
+
+#endif	/* CONFIG_EDAC_ALTERA_OCRAM */
+
+/********************* L2 Cache EDAC Device Functions ********************/
+
+#ifdef CONFIG_EDAC_ALTERA_L2C
+
+static void *l2_alloc_mem(size_t size, void **other)
+{
+	struct device *dev = *other;
+	void *ptemp = devm_kzalloc(dev, size, GFP_KERNEL);
+
+	if (!ptemp)
+		return NULL;
+
+	/* Make sure everything is written out */
+	wmb();
+
+	/*
+	 * Clean all cache levels up to LoC (includes L2)
+	 * This ensures the corrupted data is written into
+	 * L2 cache for readback test (which causes ECC error).
+	 */
+	flush_cache_all();
+
+	return ptemp;
+}
+
+static void l2_free_mem(void *p, size_t size, void *other)
+{
+	struct device *dev = other;
+
+	if (dev && p)
+		devm_kfree(dev, p);
+}
+
+/*
+ * altr_l2_check_deps()
+ *	Test for L2 cache ECC dependencies upon entry because
+ *	platform specific startup should have initialized the L2
+ *	memory and enabled the ECC.
+ *	Bail if ECC is not enabled.
+ *	Note that L2 Cache Enable is forced at build time.
+ */
+static int altr_l2_check_deps(struct platform_device *pdev,
+			      void __iomem *base)
+{
+	if (readl(base) & ALTR_L2_ECC_EN)
+		return 0;
+
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "L2: No ECC present, or ECC disabled\n");
+	return -ENODEV;
+}
+
+const struct edac_device_prv_data l2ecc_data = {
+	.setup = altr_l2_check_deps,
+	.ce_clear_mask = 0,
+	.ue_clear_mask = 0,
+	.dbgfs_name = "altr_l2_trigger",
+	.alloc_mem = l2_alloc_mem,
+	.free_mem = l2_free_mem,
+	.ecc_enable_mask = ALTR_L2_ECC_EN,
+	.ce_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJS),
+	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
+	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+};
+
+#endif	/* CONFIG_EDAC_ALTERA_L2C */
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Thor Thayer");
-MODULE_DESCRIPTION("EDAC Driver for Altera SDRAM Controller");
+MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
-- 
1.7.9.5
