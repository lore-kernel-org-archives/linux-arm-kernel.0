From: songjun.wu@microchip.com (Songjun Wu)
Date: Wed, 28 Sep 2016 13:28:57 +0800
Subject: [PATCH] [media] atmel-isc: start dma in some scenario
Message-ID: <1475040538-32591-1-git-send-email-songjun.wu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a new vb buf is added to vb queue, the queue is
empty and steaming, dma should be started.

Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
---

 drivers/media/platform/atmel/atmel-isc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index ccfe13b..8e25d3f 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -617,7 +617,13 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 	unsigned long flags;
 
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
-	list_add_tail(&buf->list, &isc->dma_queue);
+	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
+		vb2_is_streaming(vb->vb2_queue)) {
+		isc->cur_frm = buf;
+		isc_start_dma(isc->regmap, isc->cur_frm,
+			isc->current_fmt->reg_dctrl_dview);
+	} else
+		list_add_tail(&buf->list, &isc->dma_queue);
 	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
 }
 
-- 
2.7.4
