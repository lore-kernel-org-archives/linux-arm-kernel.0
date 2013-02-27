From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:39 +0800
Subject: [PATCH 03/12] dma: mxs-dma: move to generic device tree binding
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update mxs-dma driver to adopt generic DMA device tree binding.  It
calls of_dma_controller_register() with mxs specific of_dma_xlate to
get the generic DMA device tree helper support.  Then DMA clients only
need to call dma_request_slave_channel() for requesting a DMA channel
from dmaengine.

The existing way of requesting channel, clients directly call
dma_request_channel(), still work there, and will be removed after
all mxs-dma clients get converted to generic DMA device tree helper.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index bb86f7f..4edf8e9 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -27,6 +27,7 @@
 #include <linux/stmp_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 
 #include <asm/irq.h>
 
@@ -139,6 +140,9 @@ struct mxs_dma_engine {
 	struct dma_device		dma_device;
 	struct device_dma_parameters	dma_parms;
 	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
+	struct platform_device		*pdev;
+	struct of_dma_filter_info	filter_info;
+	unsigned int			nr_channels;
 };
 
 struct mxs_dma_type {
@@ -350,10 +354,8 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int ret;
 
-	if (!data)
-		return -EINVAL;
-
-	mxs_chan->chan_irq = data->chan_irq;
+	if (data)
+		mxs_chan->chan_irq = data->chan_irq;
 
 	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
 				CCW_BLOCK_SIZE, &mxs_chan->ccw_phys,
@@ -665,8 +667,59 @@ err_out:
 	return ret;
 }
 
+struct mxs_dma_filter_param {
+	struct device_node *of_node;
+	unsigned int chan_id;
+};
+
+struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
+			       struct of_dma *ofdma)
+{
+	struct mxs_dma_engine *mxs_dma = ofdma->of_dma_data;
+	struct of_dma_filter_info *info = &mxs_dma->filter_info;
+	struct mxs_dma_filter_param param;
+	int count = dma_spec->args_count;
+
+	if (!info || !info->filter_fn)
+		return NULL;
+
+	if (count != 1)
+		return NULL;
+
+	param.of_node = ofdma->of_node;
+	param.chan_id = dma_spec->args[0];
+
+	if (param.chan_id >= mxs_dma->nr_channels)
+		return NULL;
+
+	return dma_request_channel(info->dma_cap, info->filter_fn, &param);
+}
+
+static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)
+{
+	struct mxs_dma_filter_param *param = fn_param;
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_irq;
+
+	if (mxs_dma->dma_device.dev->of_node != param->of_node)
+		return false;
+
+	if (chan->chan_id != param->chan_id)
+		return false;
+
+	chan_irq = platform_get_irq(mxs_dma->pdev, param->chan_id);
+	if (chan_irq < 0)
+		return false;
+
+	mxs_chan->chan_irq = chan_irq;
+
+	return true;
+}
+
 static int __init mxs_dma_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
 	const struct mxs_dma_type *dma_type;
@@ -678,6 +731,12 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (!mxs_dma)
 		return -ENOMEM;
 
+	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		return ret;
+	}
+
 	of_id = of_match_device(mxs_dma_dt_ids, &pdev->dev);
 	if (of_id)
 		id_entry = of_id->data;
@@ -723,6 +782,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mxs_dma->pdev = pdev;
 	mxs_dma->dma_device.dev = &pdev->dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
@@ -743,6 +803,15 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mxs_dma->filter_info.dma_cap = mxs_dma->dma_device.cap_mask;
+	mxs_dma->filter_info.filter_fn = mxs_dma_filter_fn;
+	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
+	if (ret) {
+		dev_err(mxs_dma->dma_device.dev,
+			"failed to register controller\n");
+		dma_async_device_unregister(&mxs_dma->dma_device);
+	}
+
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
 
 	return 0;
-- 
1.7.9.5
