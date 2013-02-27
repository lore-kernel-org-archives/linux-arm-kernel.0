From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:43 +0800
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-mtd at lists.infradead.org
---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   17 ++++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   51 +-------------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    3 +-
 3 files changed, 12 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index 3fb3f901..6f74e23 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -7,10 +7,12 @@ Required properties:
   - compatible : should be "fsl,<chip>-gpmi-nand"
   - reg : should contain registers location and length for gpmi and bch.
   - reg-names: Should contain the reg names "gpmi-nand" and "bch"
-  - interrupts : The first is the DMA interrupt number for GPMI.
-                 The second is the BCH interrupt number.
-  - interrupt-names : The interrupt names "gpmi-dma", "bch";
-  - fsl,gpmi-dma-channel : Should contain the dma channel it uses.
+  - interrupts : BCH interrupt number.
+  - interrupt-names : Should be "bch".
+  - dmas: DMA specifier, consisting of a phandle to DMA controller node
+    and GPMI DMA channel ID.
+    Refer to dma.txt and fsl-mxs-dma.txt for details.
+  - dma-names: Must be "gpmi".
 
 Optional properties:
   - nand-on-flash-bbt: boolean to enable on flash bbt option if not
@@ -27,9 +29,10 @@ gpmi-nand at 8000c000 {
 	#size-cells = <1>;
 	reg = <0x8000c000 2000>, <0x8000a000 2000>;
 	reg-names = "gpmi-nand", "bch";
-	interrupts = <88>, <41>;
-	interrupt-names = "gpmi-dma", "bch";
-	fsl,gpmi-dma-channel = <4>;
+	interrupts = <41>;
+	interrupt-names = "bch";
+	dmas = <&dma_apbh 4>;
+	dma-names = "gpmi";
 
 	partition at 0 {
 	...
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 717881a..64d4d61 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -36,7 +36,6 @@
 #define GPMI_NAND_GPMI_REGS_ADDR_RES_NAME  "gpmi-nand"
 #define GPMI_NAND_BCH_REGS_ADDR_RES_NAME   "bch"
 #define GPMI_NAND_BCH_INTERRUPT_RES_NAME   "bch"
-#define GPMI_NAND_DMA_INTERRUPT_RES_NAME   "gpmi-dma"
 
 /* add our owner bbt descriptor */
 static uint8_t scan_ff_pattern[] = { 0xff };
@@ -420,28 +419,6 @@ static void release_bch_irq(struct gpmi_nand_data *this)
 		free_irq(i, this);
 }
 
-static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct gpmi_nand_data *this = param;
-	int dma_channel = (int)this->private;
-
-	if (!mxs_dma_is_apbh(chan))
-		return false;
-	/*
-	 * only catch the GPMI dma channels :
-	 *	for mx23 :	MX23_DMA_GPMI0 ~ MX23_DMA_GPMI3
-	 *		(These four channels share the same IRQ!)
-	 *
-	 *	for mx28 :	MX28_DMA_GPMI0 ~ MX28_DMA_GPMI7
-	 *		(These eight channels share the same IRQ!)
-	 */
-	if (dma_channel == chan->chan_id) {
-		chan->private = &this->dma_data;
-		return true;
-	}
-	return false;
-}
-
 static void release_dma_channels(struct gpmi_nand_data *this)
 {
 	unsigned int i;
@@ -455,36 +432,10 @@ static void release_dma_channels(struct gpmi_nand_data *this)
 static int acquire_dma_channels(struct gpmi_nand_data *this)
 {
 	struct platform_device *pdev = this->pdev;
-	struct resource *r_dma;
-	struct device_node *dn;
-	u32 dma_channel;
-	int ret;
 	struct dma_chan *dma_chan;
-	dma_cap_mask_t mask;
-
-	/* dma channel, we only use the first one. */
-	dn = pdev->dev.of_node;
-	ret = of_property_read_u32(dn, "fsl,gpmi-dma-channel", &dma_channel);
-	if (ret) {
-		pr_err("unable to get DMA channel from dt.\n");
-		goto acquire_err;
-	}
-	this->private = (void *)dma_channel;
-
-	/* gpmi dma interrupt */
-	r_dma = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					GPMI_NAND_DMA_INTERRUPT_RES_NAME);
-	if (!r_dma) {
-		pr_err("Can't get resource for DMA\n");
-		goto acquire_err;
-	}
-	this->dma_data.chan_irq = r_dma->start;
 
 	/* request dma channel */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
+	dma_chan = dma_request_slave_channel(&pdev->dev, "gpmi");
 	if (!dma_chan) {
 		pr_err("Failed to request DMA channel.\n");
 		goto acquire_err;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 0729477..a7685e3 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -20,7 +20,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/fsl/mxs-dma.h>
+#include <linux/dmaengine.h>
 
 #define GPMI_CLK_MAX 5 /* MX6Q needs five clocks */
 struct resources {
@@ -180,7 +180,6 @@ struct gpmi_nand_data {
 	/* DMA channels */
 #define DMA_CHANS		8
 	struct dma_chan		*dma_chans[DMA_CHANS];
-	struct mxs_dma_data	dma_data;
 	enum dma_ops_type	last_dma_type;
 	enum dma_ops_type	dma_type;
 	struct completion	dma_done;
-- 
1.7.9.5
