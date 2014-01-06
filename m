From: 21cnbao@gmail.com (Barry Song)
Date: Mon,  6 Jan 2014 15:12:51 +0800
Subject: [PATCH v2] dmaengine: sirf: enable generic dt binding for dma channels
Message-ID: <1388992371-7908-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

move to support of_dma_request_slave_channel() and dma_request_slave_channel.
we add a xlate() to let dma clients be able to find right dma_chan by generic
"dmas" properties in dts.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 use dma_get_slave_channel() function which makes it a bit
 cleaner according to Lars-Peter's feedback

 arch/arm/boot/dts/atlas6.dtsi |    4 ++++
 arch/arm/boot/dts/prima2.dtsi |    4 ++++
 drivers/dma/sirf-dma.c        |   25 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 978bab4..afe0d76 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -259,6 +259,8 @@
 				reg = <0xb00b0000 0x10000>;
 				interrupts = <12>;
 				clocks = <&clks 24>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			dmac1: dma-controller at b0160000 {
@@ -267,6 +269,8 @@
 				reg = <0xb0160000 0x10000>;
 				interrupts = <13>;
 				clocks = <&clks 25>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			vip at b00C0000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index daee5894..38782e5 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -276,6 +276,8 @@
 				reg = <0xb00b0000 0x10000>;
 				interrupts = <12>;
 				clocks = <&clks 24>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			dmac1: dma-controller at b0160000 {
@@ -284,6 +286,8 @@
 				reg = <0xb0160000 0x10000>;
 				interrupts = <13>;
 				clocks = <&clks 25>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			vip at b00C0000 {
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 6aec3ad..546bf3b 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/of_dma.h>
 #include <linux/sirfsoc_dma.h>
 
 #include "dmaengine.h"
@@ -81,6 +82,7 @@ struct sirfsoc_dma_regs {
 
 struct sirfsoc_dma {
 	struct dma_device		dma;
+	dma_cap_mask_t			cap;
 	struct tasklet_struct		tasklet;
 	struct sirfsoc_dma_chan		channels[SIRFSOC_DMA_CHANNELS];
 	void __iomem			*base;
@@ -640,6 +642,18 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL(sirfsoc_dma_filter_id);
 
+static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
+	struct of_dma *ofdma)
+{
+	struct sirfsoc_dma *sdma = ofdma->of_dma_data;
+	unsigned int request = dma_spec->args[0];
+
+	if (request > SIRFSOC_DMA_CHANNELS)
+		return NULL;
+
+	return dma_get_slave_channel(&(sdma->channels[request].chan));
+}
+
 static int sirfsoc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
@@ -744,11 +758,21 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	if (ret)
 		goto free_irq;
 
+	/* Device-tree DMA controller registration */
+	ret = of_dma_controller_register(dn, of_dma_sirfsoc_xlate, sdma);
+	if (ret) {
+		sdma->cap = dma->cap_mask;
+		dev_err(dev, "failed to register DMA controller\n");
+		goto unreg_dma_dev;
+	}
+
 	pm_runtime_enable(&op->dev);
 	dev_info(dev, "initialized SIRFSOC DMAC driver\n");
 
 	return 0;
 
+unreg_dma_dev:
+	dma_async_device_unregister(dma);
 free_irq:
 	free_irq(sdma->irq, sdma);
 irq_dispose:
@@ -761,6 +785,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
 
+	of_dma_controller_free(op->dev.of_node);
 	dma_async_device_unregister(&sdma->dma);
 	free_irq(sdma->irq, sdma);
 	irq_dispose_mapping(sdma->irq);
-- 
1.7.5.4
