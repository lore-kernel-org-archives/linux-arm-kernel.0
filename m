From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 16 Feb 2016 20:40:21 +0100
Subject: [PATCH] dmaengine: pxa_dma: fix cyclic transfers
Message-ID: <1455651621-3990-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing audio with pxa2xx-ac97, underrun were happening while the
user application was correctly feeding the music. Debug proved that the
cyclic transfer is not cyclic, ie. the last descriptor did not loop on
the first.

This was tested on a pxa27x platform.

Fixes: a57e16cf0333 ("dmaengine: pxa: add pxa dmaengine driver")
Reported-by: Vasily Khoruzhick <anarsoul@gmail.com> 
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> 
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index f2a0310ae771..ca6c088edc8a 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -583,6 +583,8 @@ static void set_updater_desc(struct pxad_desc_sw *sw_desc,
 		(PXA_DCMD_LENGTH & sizeof(u32));
 	if (flags & DMA_PREP_INTERRUPT)
 		updater->dcmd |= PXA_DCMD_ENDIRQEN;
+	if (sw_desc->cyclic)
+		sw_desc->hw_desc[sw_desc->nb_desc - 2]->ddadr = sw_desc->first;
 }
 
 static bool is_desc_completed(struct virt_dma_desc *vd)
@@ -673,6 +675,10 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 		dev_dbg(&chan->vc.chan.dev->device,
 			"%s(): checking txd %p[%x]: completed=%d\n",
 			__func__, vd, vd->tx.cookie, is_desc_completed(vd));
+		if (to_pxad_sw_desc(vd)->cyclic) {
+			vchan_cyclic_callback(vd);
+			break;
+		}
 		if (is_desc_completed(vd)) {
 			list_del(&vd->node);
 			vchan_cookie_complete(vd);
-- 
2.1.4
