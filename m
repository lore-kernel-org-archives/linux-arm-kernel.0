From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:58 +0200
Subject: [PATCH 06/11] dmaengine: mpc512x: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/mpc512x_dma.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 881db2bcb48b..fc08bb3af440 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -885,6 +885,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	struct resource res;
 	ulong regs_start, regs_size;
 	int retval, i;
+	u8 chancnt;
 
 	mdma = devm_kzalloc(dev, sizeof(struct mpc_dma), GFP_KERNEL);
 	if (!mdma) {
@@ -956,10 +957,6 @@ static int mpc_dma_probe(struct platform_device *op)
 
 	dma = &mdma->dma;
 	dma->dev = dev;
-	if (mdma->is_mpc8308)
-		dma->chancnt = MPC8308_DMACHAN_MAX;
-	else
-		dma->chancnt = MPC512x_DMACHAN_MAX;
 	dma->device_alloc_chan_resources = mpc_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = mpc_dma_free_chan_resources;
 	dma->device_issue_pending = mpc_dma_issue_pending;
@@ -972,7 +969,12 @@ static int mpc_dma_probe(struct platform_device *op)
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
 
-	for (i = 0; i < dma->chancnt; i++) {
+	if (mdma->is_mpc8308)
+		chancnt = MPC8308_DMACHAN_MAX;
+	else
+		chancnt = MPC512x_DMACHAN_MAX;
+
+	for (i = 0; i < chancnt; i++) {
 		mchan = &mdma->channels[i];
 
 		mchan->chan.device = dma;
-- 
2.1.1
