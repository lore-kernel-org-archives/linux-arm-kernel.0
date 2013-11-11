From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 11 Nov 2013 17:13:11 +0800
Subject: [PATCH] dmaengine: sirf: enable generic dt binding for dma channels
Message-ID: <1384161191-24140-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move to support of_dma_request_slave_channel() and dma_request_slave_channel.
we add a xlate and filter function to let dma clients be able to find right
dma_chan by generic "dmas" properties in dts.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |  4 ++++
 arch/arm/boot/dts/prima2.dtsi |  4 ++++
 drivers/dma/sirf-dma.c        | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 6db4f81..21fa6a7 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -233,6 +233,8 @@
 				reg = <0xb00b0000 0x10000>;
 				interrupts = <12>;
 				clocks = <&clks 24>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			dmac1: dma-controller at b0160000 {
@@ -241,6 +243,8 @@
 				reg = <0xb0160000 0x10000>;
 				interrupts = <13>;
 				clocks = <&clks 25>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			vip at b00C0000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 27ed9f5..a69004c 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -264,6 +264,8 @@
 				reg = <0xb00b0000 0x10000>;
 				interrupts = <12>;
 				clocks = <&clks 24>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			dmac1: dma-controller at b0160000 {
@@ -272,6 +274,8 @@
 				reg = <0xb0160000 0x10000>;
 				interrupts = <13>;
 				clocks = <&clks 25>;
+				#dma-cells = <1>;
+				#dma-channels = <16>;
 			};
 
 			vip at b00C0000 {
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 6aec3ad..6bb2f6e 100644
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
@@ -90,6 +92,11 @@ struct sirfsoc_dma {
 	struct sirfsoc_dma_regs		regs_save;
 };
 
+struct sirfsoc_dma_filter_args {
+	struct sirfsoc_dma *sdma;
+	unsigned int chan_id;
+};
+
 #define DRV_NAME	"sirfsoc_dma"
 
 static int sirfsoc_dma_runtime_suspend(struct device *dev);
@@ -624,6 +631,17 @@ sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
 	return &sdesc->desc;
 }
 
+static bool sirfsoc_dma_dt_filter(struct dma_chan *chan, void *param)
+{
+	struct sirfsoc_dma_filter_args *fargs = param;
+
+	if (chan->device != &fargs->sdma->dma)
+		return false;
+
+	return (chan->chan_id == fargs->chan_id);
+}
+
+
 /*
  * The DMA controller consists of 16 independent DMA channels.
  * Each channel is allocated to a different function
@@ -640,6 +658,24 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL(sirfsoc_dma_filter_id);
 
+static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
+	struct of_dma *ofdma)
+{
+	struct sirfsoc_dma *sdma = ofdma->of_dma_data;
+	struct sirfsoc_dma_filter_args fargs;
+
+	if (!sdma)
+		return NULL;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	fargs.sdma = sdma;
+	fargs.chan_id = dma_spec->args[0];
+
+	return dma_request_channel(sdma->cap, sirfsoc_dma_dt_filter, &fargs);
+}
+
 static int sirfsoc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
@@ -744,11 +780,21 @@ static int sirfsoc_dma_probe(struct platform_device *op)
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
@@ -761,6 +807,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
 
+	of_dma_controller_free(op->dev.of_node);
 	dma_async_device_unregister(&sdma->dma);
 	free_irq(sdma->irq, sdma);
 	irq_dispose_mapping(sdma->irq);
-- 
1.8.2.3
