From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  7 Aug 2016 21:01:48 +0200
Subject: [PATCH] dmaengine: pxa_dma: fix hotchain corner case
Message-ID: <1470596509-1726-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case where a descriptor is chained on a running channel, and as
explained in the comment in the code 10 lines above, the success of the
chaining is ensured either if :
 - the DMA is still running
 - or if the chained transfer is completed

Unfortunately the transfer completness test was done on the descriptor
to which the transfer was chained, and not the transfer being chained at
the end, ie. hot-chained.

This corner case is extremely hard to trigger, as usually the DMA chain
is still running, and the first case takes care of returning success of
the hot-chaining. It was seen by hot-chaining several "small transfers"
to a running "big transfer", not in a real-life usecase but by testing
the robustness of the driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e756a30ccba2..64758daa9eee 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -635,7 +635,7 @@ static bool pxad_try_hotchain(struct virt_dma_chan *vc,
 		vd_last_issued = list_entry(vc->desc_issued.prev,
 					    struct virt_dma_desc, node);
 		pxad_desc_chain(vd_last_issued, vd);
-		if (is_chan_running(chan) || is_desc_completed(vd_last_issued))
+		if (is_chan_running(chan) || is_desc_completed(vd))
 			return true;
 	}
 
-- 
2.1.4
