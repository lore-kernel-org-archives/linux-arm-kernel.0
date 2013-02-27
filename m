From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:42 +0800
Subject: [PATCH 06/12] i2c: i2c-mxs: move to use generic DMA helper
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c at vger.kernel.org
---
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |   12 ++++---
 drivers/i2c/busses/i2c-mxs.c                      |   40 ++-------------------
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
index 7a3fe9e..c32f4e9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -3,10 +3,13 @@
 Required properties:
 - compatible: Should be "fsl,<chip>-i2c"
 - reg: Should contain registers location and length
-- interrupts: Should contain ERROR and DMA interrupts
+- interrupts: Should contain ERROR interrupt number
 - clock-frequency: Desired I2C bus clock frequency in Hz.
                    Only 100000Hz and 400000Hz modes are supported.
-- fsl,i2c-dma-channel: APBX DMA channel for the I2C
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and I2C DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: Must be "i2c".
 
 Examples:
 
@@ -15,7 +18,8 @@ i2c0: i2c at 80058000 {
 	#size-cells = <0>;
 	compatible = "fsl,imx28-i2c";
 	reg = <0x80058000 2000>;
-	interrupts = <111 68>;
+	interrupts = <111>;
 	clock-frequency = <100000>;
-	fsl,i2c-dma-channel = <6>;
+	dmas = <&dma_apbx 6>;
+	dma-names = "i2c";
 };
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 22d8ad3..1f282df 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -31,7 +31,6 @@
 #include <linux/of_i2c.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/fsl/mxs-dma.h>
 
 #define DRIVER_NAME "mxs-i2c"
 
@@ -113,9 +112,7 @@ struct mxs_i2c_dev {
 	uint32_t timing1;
 
 	/* DMA support components */
-	int				dma_channel;
 	struct dma_chan         	*dmach;
-	struct mxs_dma_data		dma_data;
 	uint32_t			pio_data[2];
 	uint32_t			addr_data;
 	struct scatterlist		sg_io[2];
@@ -518,21 +515,6 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
-static bool mxs_i2c_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_i2c_dev *i2c = param;
-
-	if (!mxs_dma_is_apbx(chan))
-		return false;
-
-	if (chan->chan_id != i2c->dma_channel)
-		return false;
-
-	chan->private = &i2c->dma_data;
-
-	return true;
-}
-
 static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, int speed)
 {
 	/* The I2C block clock run at 24MHz */
@@ -577,17 +559,6 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	struct device_node *node = dev->of_node;
 	int ret;
 
-	/*
-	 * TODO: This is a temporary solution and should be changed
-	 * to use generic DMA binding later when the helpers get in.
-	 */
-	ret = of_property_read_u32(node, "fsl,i2c-dma-channel",
-				   &i2c->dma_channel);
-	if (ret) {
-		dev_err(dev, "Failed to get DMA channel!\n");
-		return -ENODEV;
-	}
-
 	ret = of_property_read_u32(node, "clock-frequency", &speed);
 	if (ret) {
 		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
@@ -607,8 +578,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	struct resource *res;
 	resource_size_t res_size;
-	int err, irq, dmairq;
-	dma_cap_mask_t mask;
+	int err, irq;
 
 	pinctrl = devm_pinctrl_get_select_default(dev);
 	if (IS_ERR(pinctrl))
@@ -620,9 +590,8 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	dmairq = platform_get_irq(pdev, 1);
 
-	if (!res || irq < 0 || dmairq < 0)
+	if (!res || irq < 0)
 		return -ENOENT;
 
 	res_size = resource_size(res);
@@ -648,10 +617,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	i2c->dma_data.chan_irq = dmairq;
-	i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
+	i2c->dmach = dma_request_slave_channel(dev, "i2c");
 	if (!i2c->dmach) {
 		dev_err(dev, "Failed to request dma\n");
 		return -ENODEV;
-- 
1.7.9.5
