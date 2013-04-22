From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 14:32:47 +0200
Subject: [PATCH 19/23] ARM: u300: add the COH 901 318 DMAC to device tree
In-Reply-To: <1366624779-6820-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624779-6820-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201304221432.47444.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds the COH 901 318 DMA controller to the U300
> device tree. All devices now converted to device tree
> so far will start to find their DMA channels.
> 
> Note that the U300 is not yet using the device tree
> to obtain DMA channels, but this is a first step.

I think you definitely should implement the entire binding at once.
It should be really trivial for this driver, see the patch below.
I did not even build test it, but I'm sure you'll figure out the rest.

8<-----
Subject: dma: coh901318: implement of_dma_controller API

This provides a simple xlate and filter function pair for the coh901318
dma engine. Every request line is tied to one channel here, so this is
really trivial: the only information we need to pass is the channel number.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 797940e..a90ba74 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1788,6 +1788,35 @@ bool coh901318_filter_id(struct dma_chan *chan, void *chan_id)
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
+	return dma_request_channel(cap, coh901318_filter_base_and_id, args);
+}
 /*
  * DMA channel allocation
  */
@@ -2735,12 +2764,18 @@ static int __init coh901318_probe(struct platform_device *pdev)
 	if (err)
 		goto err_register_memcpy;
 
+	ret = of_dma_controller_register(pdev->dev.of_node, coh901318_xlate, base);
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
@@ -2752,6 +2787,7 @@ static int __exit coh901318_remove(struct platform_device *pdev)
 {
 	struct coh901318_base *base = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&base->dma_memcpy);
 	dma_async_device_unregister(&base->dma_slave);
 	coh901318_pool_destroy(&base->pool);
