From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:50 +0200
Subject: [PATCH 15/39] dma: coh901318: add devicetree support
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-16-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for probing the COH 901 318 DMA controller
and channels from the device tree.

Contains portions of a sketch patch from Arnd Bergmann.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Folded in channel translation, request and filtering from
  the device tree based on a patch by Arnd Bergmann.
- Added device tree binding documentation.
---
 .../devicetree/bindings/dma/ste-coh901318.txt      | 32 ++++++++++++++++
 drivers/dma/coh901318.c                            | 43 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ste-coh901318.txt

diff --git a/Documentation/devicetree/bindings/dma/ste-coh901318.txt b/Documentation/devicetree/bindings/dma/ste-coh901318.txt
new file mode 100644
index 0000000..091ad05
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ste-coh901318.txt
@@ -0,0 +1,32 @@
+ST-Ericsson COH 901 318 DMA Controller
+
+This is a DMA controller which has begun as a fork of the
+ARM PL08x PrimeCell VHDL code.
+
+Required properties:
+- compatible: should be "stericsson,coh901318"
+- reg: register locations and length
+- interrupts: the single DMA IRQ
+- #dma-cells: must be set to <1>, as the channels on the
+  COH 901 318 are simple and identified by a single number
+- dma-channels: the number of DMA channels handled
+
+Example:
+
+dmac: dma-controller at c00020000 {
+	compatible = "stericsson,coh901318";
+	reg = <0xc0020000 0x1000>;
+	interrupt-parent = <&vica>;
+	interrupts = <2>;
+	#dma-cells = <1>;
+	dma-channels = <40>;
+};
+
+Consumers example:
+
+uart0: serial at c0013000 {
+	compatible = "...";
+	(...)
+	dmas = <&dmac 17 &dmac 18>;
+	dma-names = "tx", "rx";
+};
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 3b23061..9bfaddd 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -22,6 +22,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/platform_data/dma-coh901318.h>
+#include <linux/of_dma.h>
 
 #include "coh901318.h"
 #include "dmaengine.h"
@@ -1788,6 +1789,35 @@ bool coh901318_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL(coh901318_filter_id);
 
+struct coh901318_filter_args {
+	struct coh901318_base *base;
+	unsigned int ch_nr;
+};
+
+static bool coh901318_filter_base_and_id(struct dma_chan *chan, void *data)
+{
+	struct coh901318_filter_args *args = data;
+
+	if (&args->base->dma_slave == chan->device &&
+	    args->ch_nr == to_coh901318_chan(chan)->id)
+		return true;
+
+	return false;
+}
+
+static struct dma_chan *coh901318_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct coh901318_filter_args args = {
+		.base = ofdma->of_dma_data,
+		.ch_nr = dma_spec->args[0],
+	};
+	dma_cap_mask_t cap;
+	dma_cap_zero(cap);
+	dma_cap_set(DMA_SLAVE, cap);
+
+	return dma_request_channel(cap, coh901318_filter_base_and_id, &args);
+}
 /*
  * DMA channel allocation
  */
@@ -2735,12 +2765,19 @@ static int __init coh901318_probe(struct platform_device *pdev)
 	if (err)
 		goto err_register_memcpy;
 
+	err = of_dma_controller_register(pdev->dev.of_node, coh901318_xlate,
+					 base);
+	if (err)
+		goto err_register_of_dma;
+
 	platform_set_drvdata(pdev, base);
 	dev_info(&pdev->dev, "Initialized COH901318 DMA on virtual base 0x%08x\n",
 		(u32) base->virtbase);
 
 	return err;
 
+ err_register_of_dma:
+	dma_async_device_unregister(&base->dma_memcpy);
  err_register_memcpy:
 	dma_async_device_unregister(&base->dma_slave);
  err_register_slave:
@@ -2752,17 +2789,23 @@ static int coh901318_remove(struct platform_device *pdev)
 {
 	struct coh901318_base *base = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&base->dma_memcpy);
 	dma_async_device_unregister(&base->dma_slave);
 	coh901318_pool_destroy(&base->pool);
 	return 0;
 }
 
+static const struct of_device_id coh901318_dt_match[] = {
+	{ .compatible = "stericsson,coh901318" },
+	{},
+};
 
 static struct platform_driver coh901318_driver = {
 	.remove = coh901318_remove,
 	.driver = {
 		.name	= "coh901318",
+		.of_match_table = coh901318_dt_match,
 	},
 };
 
-- 
1.7.11.3
