From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:03:35 +0200
Subject: [PATCH 1/3] dmaengine i.MX SDMA: lock channel 0
In-Reply-To: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
References: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314263017-18099-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

channel0 of the sdma engine is the configuration channel. It
is a shared resource and thus must be protected by a mutex.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 7bd7e98..f50c87c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -318,6 +318,7 @@ struct sdma_engine {
 	dma_addr_t			context_phys;
 	struct dma_device		dma_device;
 	struct clk			*clk;
+	struct mutex			channel_0_lock;
 	struct sdma_script_start_addrs	*script_addrs;
 };
 
@@ -415,11 +416,15 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	dma_addr_t buf_phys;
 	int ret;
 
+	mutex_lock(&sdma->channel_0_lock);
+
 	buf_virt = dma_alloc_coherent(NULL,
 			size,
 			&buf_phys, GFP_KERNEL);
-	if (!buf_virt)
-		return -ENOMEM;
+	if (!buf_virt) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
 
 	bd0->mode.command = C0_SETPM;
 	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
@@ -433,6 +438,9 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	dma_free_coherent(NULL, size, buf_virt, buf_phys);
 
+err_out:
+	mutex_unlock(&sdma->channel_0_lock);
+
 	return ret;
 }
 
@@ -656,6 +664,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	dev_dbg(sdma->dev, "event_mask0 = 0x%08x\n", sdmac->event_mask0);
 	dev_dbg(sdma->dev, "event_mask1 = 0x%08x\n", sdmac->event_mask1);
 
+	mutex_lock(&sdma->channel_0_lock);
+
 	memset(context, 0, sizeof(*context));
 	context->channel_state.pc = load_address;
 
@@ -676,6 +686,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	ret = sdma_run_channel(&sdma->channel[0]);
 
+	mutex_unlock(&sdma->channel_0_lock);
+
 	return ret;
 }
 
@@ -1274,6 +1286,8 @@ static int __init sdma_probe(struct platform_device *pdev)
 	if (!sdma)
 		return -ENOMEM;
 
+	mutex_init(&sdma->channel_0_lock);
+
 	sdma->dev = &pdev->dev;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.5.4
