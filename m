From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 18 Jan 2016 11:14:44 +0100
Subject: [PATCH] dmaengine: at_xdmac: fix resume for cyclic transfers
Message-ID: <1453112084-4879-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Songjun Wu <songjun.wu@atmel.com>

When having cyclic transfers, the channel was paused when performing
suspend but was not correctly resumed.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel
eXtended DMA Controller driver")
Cc: <stable@vger.kernel.org> # 4.1 and later
---
 drivers/dma/at_xdmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 39f5966..64f5d1b 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1700,6 +1700,7 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
 		at_xdmac_remove_xfer(atchan, desc);
 
+	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
@@ -1832,6 +1833,8 @@ static int atmel_xdmac_resume(struct device *dev)
 		atchan = to_at_xdmac_chan(chan);
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
+			if (at_xdmac_chan_is_paused(atchan))
+				at_xdmac_device_resume(chan);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
-- 
2.5.0
