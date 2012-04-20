From: b32955@freescale.com (Huang Shijie)
Date: Fri, 20 Apr 2012 17:24:19 +0800
Subject: [PATCH 3/3] mtd: gpmi: add device tree support for mx6q-arm2 and
 mx28evk
In-Reply-To: <1334913859-5314-1-git-send-email-b32955@freescale.com>
References: <1334913859-5314-1-git-send-email-b32955@freescale.com>
Message-ID: <1334913859-5314-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add DT support to mx6q-arm2 and mx28evk.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   30 +++
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/mtd/nand/gpmi-nand/bch-regs.h              |   42 +++-
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   18 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  240 +++++++++-----------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +-
 6 files changed, 181 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
new file mode 100644
index 0000000..e1181ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -0,0 +1,30 @@
+* Freescale General-Purpose Media Interface (GPMI)
+
+The GPMI nand controller provides an interface to control the
+NAND flash chips. We support only one NAND chips now.
+
+The GPMI nand controller required properties:
+  - compatible : should be "fsl,<chip>-gpmi-nand"
+  - reg : should contain registers location and length.
+  - interrupts : should contain the DMA interrupt number for GPMI.
+                 We do not use the GPMI interrupt.
+  - dma_channel: Should contain the dma channel it uses.
+
+The BCH required properties:
+  - compatible : should be "fsl,<chip>-bch"
+  - reg : should contain registers location and length.
+  - interrupts : should contain the BCH interrupt.
+
+Examples:
+
+gpmi-nand at 8000c000 {
+	compatible = "fsl,imx28-gpmi-nand";
+	reg = <0x8000c000 2000>;
+	interrupts = <88>;
+	dma_channel = <4>;
+};
+bch at 8000a000 {
+	compatible = "fsl,imx28-bch";
+	reg = <0x8000a000 2000>;
+	interrupts = <41>;
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
index 75b1dde..5c6af5d 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -24,6 +24,9 @@
 #include <linux/module.h>
 #include <linux/mtd/gpmi-nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include "gpmi-nand.h"
 
 /* add our owner bbt descriptor */
@@ -306,36 +309,6 @@ int start_dma_with_bch_irq(struct gpmi_nand_data *this,
 	return 0;
 }
 
-static int __devinit
-acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
-{
-	struct platform_device *pdev = this->pdev;
-	struct resources *res = &this->resources;
-	struct resource *r;
-	void *p;
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
-	if (!r) {
-		pr_err("Can't get resource for %s\n", res_name);
-		return -ENXIO;
-	}
-
-	p = ioremap(r->start, resource_size(r));
-	if (!p) {
-		pr_err("Can't remap %s\n", res_name);
-		return -ENOMEM;
-	}
-
-	if (!strcmp(res_name, GPMI_NAND_GPMI_REGS_ADDR_RES_NAME))
-		res->gpmi_regs = p;
-	else if (!strcmp(res_name, GPMI_NAND_BCH_REGS_ADDR_RES_NAME))
-		res->bch_regs = p;
-	else
-		pr_err("unknown resource name : %s\n", res_name);
-
-	return 0;
-}
-
 static void release_register_block(struct gpmi_nand_data *this)
 {
 	struct resources *res = &this->resources;
@@ -347,32 +320,6 @@ static void release_register_block(struct gpmi_nand_data *this)
 	res->bch_regs = NULL;
 }
 
-static int __devinit
-acquire_bch_irq(struct gpmi_nand_data *this, irq_handler_t irq_h)
-{
-	struct platform_device *pdev = this->pdev;
-	struct resources *res = &this->resources;
-	const char *res_name = GPMI_NAND_BCH_INTERRUPT_RES_NAME;
-	struct resource *r;
-	int err;
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res_name);
-	if (!r) {
-		pr_err("Can't get resource for %s\n", res_name);
-		return -ENXIO;
-	}
-
-	err = request_irq(r->start, irq_h, 0, res_name, this);
-	if (err) {
-		pr_err("Can't own %s\n", res_name);
-		return err;
-	}
-
-	res->bch_low_interrupt = r->start;
-	res->bch_high_interrupt = r->end;
-	return 0;
-}
-
 static void release_bch_irq(struct gpmi_nand_data *this)
 {
 	struct resources *res = &this->resources;
@@ -385,7 +332,7 @@ static void release_bch_irq(struct gpmi_nand_data *this)
 static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct gpmi_nand_data *this = param;
-	struct resource *r = this->private;
+	int dma_channel = (int)this->private;
 
 	if (!mxs_dma_is_apbh(chan))
 		return false;
@@ -397,7 +344,7 @@ static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
 	 *	for mx28 :	MX28_DMA_GPMI0 ~ MX28_DMA_GPMI7
 	 *		(These eight channels share the same IRQ!)
 	 */
-	if (r->start <= chan->chan_id && chan->chan_id <= r->end) {
+	if (dma_channel == chan->chan_id) {
 		chan->private = &this->dma_data;
 		return true;
 	}
@@ -414,85 +361,91 @@ static void release_dma_channels(struct gpmi_nand_data *this)
 		}
 }
 
-static int __devinit acquire_dma_channels(struct gpmi_nand_data *this)
+static const char *bch_node_name[] __devinitconst = {
+	[IS_MX23] = "fsl,imx23-bch",
+	[IS_MX28] = "fsl,imx28-bch",
+	[IS_MX6Q] = "fsl,imx6q-bch",
+};
+
+static int __devinit acquire_resources(struct gpmi_nand_data *this)
 {
-	struct platform_device *pdev = this->pdev;
-	struct gpmi_nand_platform_data *pdata = this->pdata;
 	struct resources *res = &this->resources;
-	struct resource *r, *r_dma;
-	unsigned int i;
+	struct platform_device *pdev = this->pdev;
+	struct resource *r;
+	struct device_node *dn;
+	unsigned int irq;
+	int ret = -EINVAL;
+
+	/* gpmi */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		pr_err("Can't get gpmi resource.\n");
+		goto exit_regs;
+	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-					GPMI_NAND_DMA_CHANNELS_RES_NAME);
-	r_dma = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					GPMI_NAND_DMA_INTERRUPT_RES_NAME);
-	if (!r || !r_dma) {
-		pr_err("Can't get resource for DMA\n");
-		return -ENXIO;
+	res->gpmi_regs = ioremap(r->start, resource_size(r));
+	if (!res->gpmi_regs) {
+		pr_err("Can't remap for gpmi.\n");
+		goto exit_regs;
 	}
 
-	/* used in gpmi_dma_filter() */
-	this->private = r;
+	/* bch */
+	dn = of_find_compatible_node(NULL, NULL,
+			bch_node_name[pdev->id_entry->driver_data]);
+	if (dn) {
+		res->bch_regs = of_iomap(dn, 0);
+		if (!res->bch_regs) {
+			of_node_put(dn);
+			goto exit_regs;
+		}
+	} else {
+		pr_err("Can't find device node for BCH.\n");
+		goto exit_regs;
+	}
 
-	for (i = r->start; i <= r->end; i++) {
+	irq = irq_of_parse_and_map(dn, 0);
+	ret = request_irq(irq, bch_irq, 0, NULL, this);
+	if (ret) {
+		of_node_put(dn);
+		pr_err("interrupt request failed\n");
+		goto exit_regs;
+	}
+	res->bch_low_interrupt = res->bch_high_interrupt = irq;
+	of_node_put(dn);
+
+	/* apbh-dma channel */
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (r) {
 		struct dma_chan *dma_chan;
 		dma_cap_mask_t mask;
-
-		if (i - r->start >= pdata->max_chip_count)
-			break;
+		int dma_channel;
 
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
 
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
-	}
-
-	res->dma_low_channel = r->start;
-	res->dma_high_channel = i;
-	return 0;
-
-acquire_err:
-	pr_err("Can't acquire DMA channel %u\n", i);
-	release_dma_channels(this);
-	return -EINVAL;
-}
-
-static int __devinit acquire_resources(struct gpmi_nand_data *this)
-{
-	struct resources *res = &this->resources;
-	int ret;
-
-	ret = acquire_register_block(this, GPMI_NAND_GPMI_REGS_ADDR_RES_NAME);
-	if (ret)
-		goto exit_regs;
-
-	ret = acquire_register_block(this, GPMI_NAND_BCH_REGS_ADDR_RES_NAME);
-	if (ret)
-		goto exit_regs;
+		this->dma_data.chan_irq = r->start;
 
-	ret = acquire_bch_irq(this, bch_irq);
-	if (ret)
-		goto exit_regs;
+		/* We only support one chip now, so we need one DMA channel.*/
+		dn = pdev->dev.of_node;
+		ret = of_property_read_u32(dn, "dma_channel", &dma_channel);
+		if (ret) {
+			pr_err("unable to get DMA channel from dt.\n");
+			goto exit_dma_channels;
+		}
+		this->private = (void *)dma_channel;
 
-	ret = acquire_dma_channels(this);
-	if (ret)
+		dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
+		if (!dma_chan) {
+			pr_err("dma_request_channel failed.\n");
+			goto exit_dma_channels;
+		}
+		this->dma_chans[0] = dma_chan;
+	} else {
+		pr_err("Can't find irq for dma\n");
 		goto exit_dma_channels;
+	}
 
+	/* gpmi clock */
 	res->clock = clk_get(&this->pdev->dev, NULL);
 	if (IS_ERR(res->clock)) {
 		pr_err("can not get the clock\n");
@@ -1461,7 +1414,6 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
 
 static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 {
-	struct gpmi_nand_platform_data *pdata = this->pdata;
 	struct mtd_info  *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
 	int ret;
@@ -1501,14 +1453,13 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
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
+	ret = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
 	if (ret)
 		goto err_out;
 	return 0;
@@ -1518,12 +1469,38 @@ err_out:
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
 	struct gpmi_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct gpmi_nand_data *this;
+	const struct of_device_id *of_id;
 	int ret;
 
+	of_id = of_match_device(gpmi_nand_id_table, &pdev->dev);
+	if (of_id)
+		pdev->id_entry = of_id->data;
+
 	this = kzalloc(sizeof(*this), GFP_KERNEL);
 	if (!this) {
 		pr_err("Failed to allocate per-device memory\n");
@@ -1535,7 +1512,7 @@ static int __devinit gpmi_nand_probe(struct platform_device *pdev)
 	this->dev   = &pdev->dev;
 	this->pdata = pdata;
 
-	if (pdata->platform_init) {
+	if (pdata && pdata->platform_init) {
 		ret = pdata->platform_init();
 		if (ret)
 			goto platform_init_error;
@@ -1575,19 +1552,10 @@ static int __exit gpmi_nand_remove(struct platform_device *pdev)
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
-- 
1.7.0.4
