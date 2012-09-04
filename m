From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  4 Sep 2012 15:08:01 +0300
Subject: [RFC update 1/2] dmaengine: omap: Support for element mode in cyclic
 DMA
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346760482-12794-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When src_maxburst/dst_maxburst is set to 0 by the users of cyclic DMA
(mostly audio) indicates that we should configure the omap DMA to element
sync mode instead of packet mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ae05618..b77a40d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -413,7 +413,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->dev_addr = dev_addr;
 	d->fi = burst;
 	d->es = es;
-	d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	if (burst)
+		d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	else
+		d->sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	d->sync_type = sync_type;
 	d->periph_port = OMAP_DMA_PORT_MPUI;
 	d->sg[0].addr = buf_addr;
-- 
1.7.12
