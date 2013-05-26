From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 26 May 2013 11:53:20 +0200
Subject: [PATCH v7 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
References: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369562001-11494-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding devicetree support for imx-dma driver. Use driver name for
function 'imx_dma_is_general_purpose' because the devicename for
devicetree initialized devices is different.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
---

Notes:
    Changes in V6:
    - Style fixes in imxdma_xlate function, moved request assignment and removed
      unnecessary cast.
    
    Changes in V5:
    - Style fix
    - Documentation reference
    
    Changes in V4:
    - Directly use "imxdma_channel" as proposed by Arnd. This removes the
    allocation of imx_dma_data.
    - Simplify function imx_dma_is_general_purpose using driver names.
    
    Changes in V3:
    - Create a imxdma translate function to pass the device object into the
    filter function.
    
    Changes in V2:
    - Change the driver to use generic DMA DT bindings.
    - Add a imx-dma filter function that sets the dma request line in
      private data.

 .../devicetree/bindings/dma/fsl-imx-dma.txt        | 48 ++++++++++++++
 drivers/dma/imx-dma.c                              | 75 ++++++++++++++++++++++
 include/linux/platform_data/dma-imx.h              |  6 +-
 3 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
new file mode 100644
index 0000000..2717ecb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
@@ -0,0 +1,48 @@
+* Freescale Direct Memory Access (DMA) Controller for i.MX
+
+This document will only describe differences to the generic DMA Controller and
+DMA request bindings as described in dma/dma.txt .
+
+* DMA controller
+
+Required properties:
+- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
+- reg : Should contain DMA registers location and length
+- interrupts : First item should be DMA interrupt, second one is optional and
+    should contain DMA Error interrupt
+- #dma-cells : Has to be 1. imx-dma does not support anything else.
+
+Optional properties:
+- #dma-channels : Number of DMA channels supported. Should be 16.
+- #dma-requests : Number of DMA requests supported.
+
+Example:
+
+	dma: dma at 10001000 {
+		compatible = "fsl,imx27-dma";
+		reg = <0x10001000 0x1000>;
+		interrupts = <32 33>;
+		#dma-cells = <1>;
+		#dma-channels = <16>;
+	};
+
+
+* DMA client
+
+Clients have to specify the DMA requests with phandles in a list.
+
+Required properties:
+- dmas: List of one or more DMA request specifiers. One DMA request specifier
+    consists of a phandle to the DMA controller followed by the integer
+    specifiying the request line.
+- dma-names: List of string identifiers for the DMA requests. For the correct
+    names, have a look at the specific client driver.
+
+Example:
+
+	sdhci1: sdhci at 10013000 {
+		...
+		dmas = <&dma 7>;
+		dma-names = "rx-tx";
+		...
+	};
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index f285833..34c54cf 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -27,6 +27,8 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx.h>
@@ -186,6 +188,11 @@ struct imxdma_engine {
 	enum imx_dma_type		devtype;
 };
 
+struct imxdma_filter_data {
+	struct imxdma_engine	*imxdma;
+	int			 request;
+};
+
 static struct platform_device_id imx_dma_devtype[] = {
 	{
 		.name = "imx1-dma",
@@ -202,6 +209,22 @@ static struct platform_device_id imx_dma_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_dma_devtype);
 
+static const struct of_device_id imx_dma_of_dev_id[] = {
+	{
+		.compatible = "fsl,imx1-dma",
+		.data = &imx_dma_devtype[IMX1_DMA],
+	}, {
+		.compatible = "fsl,imx21-dma",
+		.data = &imx_dma_devtype[IMX21_DMA],
+	}, {
+		.compatible = "fsl,imx27-dma",
+		.data = &imx_dma_devtype[IMX27_DMA],
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx_dma_of_dev_id);
+
 static inline int is_imx1_dma(struct imxdma_engine *imxdma)
 {
 	return imxdma->devtype == IMX1_DMA;
@@ -996,13 +1019,50 @@ static void imxdma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&imxdma->lock, flags);
 }
 
+static bool imxdma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct imxdma_filter_data *fdata = param;
+	struct imxdma_channel *imxdma_chan = to_imxdma_chan(chan);
+
+	if (chan->device->dev != fdata->imxdma->dev)
+		return false;
+
+	imxdma_chan->dma_request = fdata->request;
+	chan->private = NULL;
+
+	return true;
+}
+
+static struct dma_chan *imxdma_xlate(struct of_phandle_args *dma_spec,
+						struct of_dma *ofdma)
+{
+	int count = dma_spec->args_count;
+	struct imxdma_engine *imxdma = ofdma->of_dma_data;
+	struct imxdma_filter_data fdata = {
+		.imxdma = imxdma,
+	};
+
+	if (count != 1)
+		return NULL;
+
+	fdata.request = dma_spec->args[0];
+
+	return dma_request_channel(imxdma->dma_device.cap_mask,
+					imxdma_filter_fn, &fdata);
+}
+
 static int __init imxdma_probe(struct platform_device *pdev)
 	{
 	struct imxdma_engine *imxdma;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	int ret, i;
 	int irq, irq_err;
 
+	of_id = of_match_device(imx_dma_of_dev_id, &pdev->dev);
+	if (of_id)
+		pdev->id_entry = of_id->data;
+
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
 		return -ENOMEM;
@@ -1136,8 +1196,19 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (pdev->dev.of_node) {
+		ret = of_dma_controller_register(pdev->dev.of_node,
+				imxdma_xlate, imxdma);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to register of_dma_controller\n");
+			goto err_of_dma_controller;
+		}
+	}
+
 	return 0;
 
+err_of_dma_controller:
+	dma_async_device_unregister(&imxdma->dma_device);
 err:
 	clk_disable_unprepare(imxdma->dma_ipg);
 	clk_disable_unprepare(imxdma->dma_ahb);
@@ -1150,6 +1221,9 @@ static int imxdma_remove(struct platform_device *pdev)
 
         dma_async_device_unregister(&imxdma->dma_device);
 
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
 	clk_disable_unprepare(imxdma->dma_ipg);
 	clk_disable_unprepare(imxdma->dma_ahb);
 
@@ -1159,6 +1233,7 @@ static int imxdma_remove(struct platform_device *pdev)
 static struct platform_driver imxdma_driver = {
 	.driver		= {
 		.name	= "imx-dma",
+		.of_match_table = imx_dma_of_dev_id,
 	},
 	.id_table	= imx_dma_devtype,
 	.remove		= imxdma_remove,
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index f6d30cc..beac6b8 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -60,10 +60,8 @@ static inline int imx_dma_is_ipu(struct dma_chan *chan)
 
 static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 {
-	return strstr(dev_name(chan->device->dev), "sdma") ||
-		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
-		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
-		!strcmp(dev_name(chan->device->dev), "imx27-dma");
+	return !strcmp(chan->device->dev->driver->name, "imx-sdma") ||
+		!strcmp(chan->device->dev->driver->name, "imx-dma");
 }
 
 #endif
-- 
1.8.2.1
