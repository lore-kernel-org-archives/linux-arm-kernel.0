From: b32955@freescale.com (Huang Shijie)
Date: Wed, 2 May 2012 14:13:28 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
Message-ID: <1335939209-15625-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi support for mx6q.
add DT support to mx6q and mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
Please select the CONFIG_USE_OF before you do the comipler-test.

v2 -- > v3:
	[0] split this patch from a patch set to avoid git-am failure.
	[1] fix the binding file.
	[2] remove the unused header files.
	[3] fix Coding style.

v1 -- > v2:
	[1] merge the gpmi/bch into one device node.
	[2] add partition support.
	[3] misc.

---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   33 +++++
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/mtd/nand/gpmi-nand/bch-regs.h              |   42 +++++--
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   18 ++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  129 ++++++++++----------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +-
 include/linux/mtd/gpmi-nand.h                      |    8 +-
 7 files changed, 149 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
new file mode 100644
index 0000000..1a5bbd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -0,0 +1,33 @@
+* Freescale General-Purpose Media Interface (GPMI)
+
+The GPMI nand controller provides an interface to control the
+NAND flash chips. We support only one NAND chip now.
+
+Required properties:
+  - compatible : should be "fsl,<chip>-gpmi-nand"
+  - reg : should contain registers location and length for gpmi and bch.
+  - reg-names: Should contain the reg names "gpmi-nand" and "bch"
+  - interrupts : The first is the DMA interrupt number for GPMI.
+                 The second is the BCH interrupt number.
+  - interrupt-names : The interrupt names "gpmi-dma", "bch";
+  - fsl,gpmi-dma-channel : Should contain the dma channel it uses.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
+Examples:
+
+gpmi-nand at 8000c000 {
+	compatible = "fsl,imx28-gpmi-nand";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x8000c000 2000>, <0x8000a000 2000>;
+	reg-names = "gpmi-nand", "bch";
+	interrupts = <88>, <41>;
+	interrupt-names = "gpmi-dma", "bch";
+	fsl,gpmi-dma-channel = <4>;
+
+	partition at 0 {
+	...
+	};
+};
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7d17cec..bf0a28d 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -440,7 +440,7 @@ config MTD_NAND_NANDSIM
 
 config MTD_NAND_GPMI_NAND
         bool "GPMI NAND Flash Controller driver"
-        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
         help
 	 Enables NAND Flash support for IMX23 or IMX28.
 	 The GPMI controller is very powerful, with the help of BCH
diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
index 4effb8c..a092451 100644
--- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
@@ -51,15 +51,26 @@
 
 #define BP_BCH_FLASH0LAYOUT0_ECC0		12
 #define BM_BCH_FLASH0LAYOUT0_ECC0	(0xf << BP_BCH_FLASH0LAYOUT0_ECC0)
-#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
-	(((v) << BP_BCH_FLASH0LAYOUT0_ECC0) & BM_BCH_FLASH0LAYOUT0_ECC0)
+#define MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0		11
+#define MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)
+#define BF_BCH_FLASH0LAYOUT0_ECC0(v, x)				\
+	(GPMI_IS_MX6Q(x)					\
+		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0)	\
+		: (((v) << BP_BCH_FLASH0LAYOUT0_ECC0)		\
+			& BM_BCH_FLASH0LAYOUT0_ECC0)		\
+	)
 
 #define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
 #define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
-#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
-	(((v) << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)\
-					 & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
+#define MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE	\
+			(0x3ff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
+#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v, x)				\
+	(GPMI_IS_MX6Q(x)						\
+		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)	\
+		: ((v) & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)		\
+	)
 
 #define HW_BCH_FLASH0LAYOUT1			0x00000090
 
@@ -72,13 +83,24 @@
 
 #define BP_BCH_FLASH0LAYOUT1_ECCN		12
 #define BM_BCH_FLASH0LAYOUT1_ECCN	(0xf << BP_BCH_FLASH0LAYOUT1_ECCN)
-#define BF_BCH_FLASH0LAYOUT1_ECCN(v)		\
-	(((v) << BP_BCH_FLASH0LAYOUT1_ECCN) & BM_BCH_FLASH0LAYOUT1_ECCN)
+#define MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN		11
+#define MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)
+#define BF_BCH_FLASH0LAYOUT1_ECCN(v, x)				\
+	(GPMI_IS_MX6Q(x)					\
+		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN)	\
+		: (((v) << BP_BCH_FLASH0LAYOUT1_ECCN)		\
+			& BM_BCH_FLASH0LAYOUT1_ECCN)		\
+	)
 
 #define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
 #define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
-#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
-	(((v) << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE) \
-					 & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
+#define MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE	\
+			(0x3ff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
+#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v, x)				\
+	(GPMI_IS_MX6Q(x)						\
+		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)	\
+		: ((v) & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)		\
+	)
 #endif
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index fa5200b..a1f4332 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -224,13 +224,13 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	/* Configure layout 0. */
 	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
 			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
-			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)
-			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size),
+			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
 
 	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
-			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)
-			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size),
+			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
 
 	/* Set *all* chip selects to use layout 0. */
@@ -256,11 +256,12 @@ static unsigned int ns_to_cycles(unsigned int time,
 	return max(k, min);
 }
 
+#define DEF_MIN_PROP_DELAY	5
+#define DEF_MAX_PROP_DELAY	9
 /* Apply timing to current hardware conditions. */
 static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
 					struct gpmi_nfc_hardware_timing *hw)
 {
-	struct gpmi_nand_platform_data *pdata = this->pdata;
 	struct timing_threshod *nfc = &timing_default_threshold;
 	struct nand_chip *nand = &this->nand;
 	struct nand_timing target = this->timing;
@@ -277,8 +278,8 @@ static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
 	int ideal_sample_delay_in_ns;
 	unsigned int sample_delay_factor;
 	int tEYE;
-	unsigned int min_prop_delay_in_ns = pdata->min_prop_delay_in_ns;
-	unsigned int max_prop_delay_in_ns = pdata->max_prop_delay_in_ns;
+	unsigned int min_prop_delay_in_ns = DEF_MIN_PROP_DELAY;
+	unsigned int max_prop_delay_in_ns = DEF_MAX_PROP_DELAY;
 
 	/*
 	 * If there are multiple chips, we need to relax the timings to allow
@@ -804,7 +805,8 @@ int gpmi_is_ready(struct gpmi_nand_data *this, unsigned chip)
 	if (GPMI_IS_MX23(this)) {
 		mask = MX23_BM_GPMI_DEBUG_READY0 << chip;
 		reg = readl(r->gpmi_regs + HW_GPMI_DEBUG);
-	} else if (GPMI_IS_MX28(this)) {
+	} else if (GPMI_IS_MX28(this) || GPMI_IS_MX6Q(this)) {
+		/* MX28 shares the same R/B register as MX6Q. */
 		mask = MX28_BF_GPMI_STAT_READY_BUSY(1 << chip);
 		reg = readl(r->gpmi_regs + HW_GPMI_STAT);
 	} else
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 75b1dde..4585fb0 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/mtd/gpmi-nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of_device.h>
 #include "gpmi-nand.h"
 
 /* add our owner bbt descriptor */
@@ -385,7 +386,7 @@ static void release_bch_irq(struct gpmi_nand_data *this)
 static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct gpmi_nand_data *this = param;
-	struct resource *r = this->private;
+	int dma_channel = (int)this->private;
 
 	if (!mxs_dma_is_apbh(chan))
 		return false;
@@ -397,7 +398,7 @@ static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
 	 *	for mx28 :	MX28_DMA_GPMI0 ~ MX28_DMA_GPMI7
 	 *		(These eight channels share the same IRQ!)
 	 */
-	if (r->start <= chan->chan_id && chan->chan_id <= r->end) {
+	if (dma_channel == chan->chan_id) {
 		chan->private = &this->dma_data;
 		return true;
 	}
@@ -417,57 +418,45 @@ static void release_dma_channels(struct gpmi_nand_data *this)
 static int __devinit acquire_dma_channels(struct gpmi_nand_data *this)
 {
 	struct platform_device *pdev = this->pdev;
-	struct gpmi_nand_platform_data *pdata = this->pdata;
-	struct resources *res = &this->resources;
-	struct resource *r, *r_dma;
-	unsigned int i;
+	struct resource *r_dma;
+	struct device_node *dn;
+	int dma_channel;
+	unsigned int ret;
+	struct dma_chan *dma_chan;
+	dma_cap_mask_t mask;
+
+	/* dma channel, we only use the first one. */
+	dn = pdev->dev.of_node;
+	ret = of_property_read_u32(dn, "fsl,gpmi-dma-channel", &dma_channel);
+	if (ret) {
+		pr_err("unable to get DMA channel from dt.\n");
+		goto acquire_err;
+	}
+	this->private = (void *)dma_channel;
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-					GPMI_NAND_DMA_CHANNELS_RES_NAME);
+	/* gpmi dma interrupt */
 	r_dma = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
 					GPMI_NAND_DMA_INTERRUPT_RES_NAME);
-	if (!r || !r_dma) {
+	if (!r_dma) {
 		pr_err("Can't get resource for DMA\n");
-		return -ENXIO;
+		goto acquire_err;
 	}
+	this->dma_data.chan_irq = r_dma->start;
 
-	/* used in gpmi_dma_filter() */
-	this->private = r;
-
-	for (i = r->start; i <= r->end; i++) {
-		struct dma_chan *dma_chan;
-		dma_cap_mask_t mask;
-
-		if (i - r->start >= pdata->max_chip_count)
-			break;
+	/* request dma channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		/* get the DMA interrupt */
-		if (r_dma->start == r_dma->end) {
-			/* only register the first. */
-			if (i == r->start)
-				this->dma_data.chan_irq = r_dma->start;
-			else
-				this->dma_data.chan_irq = NO_IRQ;
-		} else
-			this->dma_data.chan_irq = r_dma->start + (i - r->start);
-
-		dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
-		if (!dma_chan)
-			goto acquire_err;
-
-		/* fill the first empty item */
-		this->dma_chans[i - r->start] = dma_chan;
+	dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
+	if (!dma_chan) {
+		pr_err("dma_request_channel failed.\n");
+		goto acquire_err;
 	}
 
-	res->dma_low_channel = r->start;
-	res->dma_high_channel = i;
+	this->dma_chans[0] = dma_chan;
 	return 0;
 
 acquire_err:
-	pr_err("Can't acquire DMA channel %u\n", i);
 	release_dma_channels(this);
 	return -EINVAL;
 }
@@ -1461,9 +1450,9 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
 
 static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 {
-	struct gpmi_nand_platform_data *pdata = this->pdata;
 	struct mtd_info  *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
+	struct mtd_part_parser_data ppdata = {};
 	int ret;
 
 	/* init current chip */
@@ -1501,14 +1490,14 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
-	ret = nand_scan(mtd, pdata->max_chip_count);
+	ret = nand_scan(mtd, 1);
 	if (ret) {
 		pr_err("Chip scan failed\n");
 		goto err_out;
 	}
 
-	ret = mtd_device_parse_register(mtd, NULL, NULL,
-			pdata->partitions, pdata->partition_count);
+	ppdata.of_node = this->pdev->dev.of_node;
+	ret = mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
 	if (ret)
 		goto err_out;
 	return 0;
@@ -1518,12 +1507,41 @@ err_out:
 	return ret;
 }
 
+static const struct platform_device_id gpmi_ids[] = {
+	{ .name = "imx23-gpmi-nand", .driver_data = IS_MX23, },
+	{ .name = "imx28-gpmi-nand", .driver_data = IS_MX28, },
+	{ .name = "imx6q-gpmi-nand", .driver_data = IS_MX6Q, },
+	{},
+};
+
+static const struct of_device_id gpmi_nand_id_table[] = {
+	{
+		.compatible = "fsl,imx23-gpmi-nand",
+		.data = (void *)&gpmi_ids[IS_MX23]
+	}, {
+		.compatible = "fsl,imx28-gpmi-nand",
+		.data = (void *)&gpmi_ids[IS_MX28]
+	}, {
+		.compatible = "fsl,imx6q-gpmi-nand",
+		.data = (void *)&gpmi_ids[IS_MX6Q]
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
+
 static int __devinit gpmi_nand_probe(struct platform_device *pdev)
 {
-	struct gpmi_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct gpmi_nand_data *this;
+	const struct of_device_id *of_id;
 	int ret;
 
+	of_id = of_match_device(gpmi_nand_id_table, &pdev->dev);
+	if (of_id) {
+		pdev->id_entry = of_id->data;
+	} else {
+		pr_err("Failed to find the right device id.\n");
+		return -ENOMEM;
+	}
+
 	this = kzalloc(sizeof(*this), GFP_KERNEL);
 	if (!this) {
 		pr_err("Failed to allocate per-device memory\n");
@@ -1533,13 +1551,6 @@ static int __devinit gpmi_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, this);
 	this->pdev  = pdev;
 	this->dev   = &pdev->dev;
-	this->pdata = pdata;
-
-	if (pdata->platform_init) {
-		ret = pdata->platform_init();
-		if (ret)
-			goto platform_init_error;
-	}
 
 	ret = acquire_resources(this);
 	if (ret)
@@ -1557,7 +1568,6 @@ static int __devinit gpmi_nand_probe(struct platform_device *pdev)
 
 exit_nfc_init:
 	release_resources(this);
-platform_init_error:
 exit_acquire_resources:
 	platform_set_drvdata(pdev, NULL);
 	kfree(this);
@@ -1575,19 +1585,10 @@ static int __exit gpmi_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id gpmi_ids[] = {
-	{
-		.name = "imx23-gpmi-nand",
-		.driver_data = IS_MX23,
-	}, {
-		.name = "imx28-gpmi-nand",
-		.driver_data = IS_MX28,
-	}, {},
-};
-
 static struct platform_driver gpmi_nand_driver = {
 	.driver = {
 		.name = "gpmi-nand",
+		.of_match_table = gpmi_nand_id_table,
 	},
 	.probe   = gpmi_nand_probe,
 	.remove  = __exit_p(gpmi_nand_remove),
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index ec6180d..ce5daa1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -266,8 +266,10 @@ extern int gpmi_read_page(struct gpmi_nand_data *,
 #define STATUS_UNCORRECTABLE	0xfe
 
 /* Use the platform_id to distinguish different Archs. */
-#define IS_MX23			0x1
-#define IS_MX28			0x2
+#define IS_MX23			0x0
+#define IS_MX28			0x1
+#define IS_MX6Q			0x2
 #define GPMI_IS_MX23(x)		((x)->pdev->id_entry->driver_data == IS_MX23)
 #define GPMI_IS_MX28(x)		((x)->pdev->id_entry->driver_data == IS_MX28)
+#define GPMI_IS_MX6Q(x)		((x)->pdev->id_entry->driver_data == IS_MX6Q)
 #endif
diff --git a/include/linux/mtd/gpmi-nand.h b/include/linux/mtd/gpmi-nand.h
index 69b6dbf..ed3c4e0 100644
--- a/include/linux/mtd/gpmi-nand.h
+++ b/include/linux/mtd/gpmi-nand.h
@@ -23,12 +23,12 @@
 #define GPMI_NAND_RES_SIZE	6
 
 /* Resource names for the GPMI NAND driver. */
-#define GPMI_NAND_GPMI_REGS_ADDR_RES_NAME  "GPMI NAND GPMI Registers"
+#define GPMI_NAND_GPMI_REGS_ADDR_RES_NAME  "gpmi-nand"
 #define GPMI_NAND_GPMI_INTERRUPT_RES_NAME  "GPMI NAND GPMI Interrupt"
-#define GPMI_NAND_BCH_REGS_ADDR_RES_NAME   "GPMI NAND BCH Registers"
-#define GPMI_NAND_BCH_INTERRUPT_RES_NAME   "GPMI NAND BCH Interrupt"
+#define GPMI_NAND_BCH_REGS_ADDR_RES_NAME   "bch"
+#define GPMI_NAND_BCH_INTERRUPT_RES_NAME   "bch"
 #define GPMI_NAND_DMA_CHANNELS_RES_NAME    "GPMI NAND DMA Channels"
-#define GPMI_NAND_DMA_INTERRUPT_RES_NAME   "GPMI NAND DMA Interrupt"
+#define GPMI_NAND_DMA_INTERRUPT_RES_NAME   "gpmi-dma"
 
 /**
  * struct gpmi_nand_platform_data - GPMI NAND driver platform data.
-- 
1.7.0.4
