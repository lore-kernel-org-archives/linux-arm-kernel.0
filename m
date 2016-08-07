From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  7 Aug 2016 21:01:49 +0200
Subject: [PATCH] dmaengine: pxa_dma: fix debug message
In-Reply-To: <1470596509-1726-1-git-send-email-robert.jarzmik@free.fr>
References: <1470596509-1726-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1470596509-1726-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a very tight timeframe, the debug message in the transfer completion
handler can be misleading, as the completion test report can change just
after the message, and the code flow cannot be deduced from the debug
message.

This is just a cleanup to make debugging easier.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 64758daa9eee..b7414c5c9932 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -668,6 +668,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	struct virt_dma_desc *vd, *tmp;
 	unsigned int dcsr;
 	unsigned long flags;
+	bool vd_completed;
 	dma_cookie_t last_started = 0;
 
 	BUG_ON(!chan);
@@ -678,15 +679,17 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
+		vd_completed = is_desc_completed(vd);
 		dev_dbg(&chan->vc.chan.dev->device,
-			"%s(): checking txd %p[%x]: completed=%d\n",
-			__func__, vd, vd->tx.cookie, is_desc_completed(vd));
+			"%s(): checking txd %p[%x]: completed=%d dcsr=0x%x\n",
+			__func__, vd, vd->tx.cookie, vd_completed,
+			dcsr);
 		last_started = vd->tx.cookie;
 		if (to_pxad_sw_desc(vd)->cyclic) {
 			vchan_cyclic_callback(vd);
 			break;
 		}
-		if (is_desc_completed(vd)) {
+		if (vd_completed) {
 			list_del(&vd->node);
 			vchan_cookie_complete(vd);
 		} else {
-- 
2.1.4
