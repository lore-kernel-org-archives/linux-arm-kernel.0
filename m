From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 28 Apr 2016 11:42:20 +0800
Subject: [PATCH v2 1/2] usb: core: buffer: avoid NULL pointer dereferrence
Message-ID: <1461814941-28345-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NULL pointer dereferrence will happen when class driver
wants to allocate zero length buffer and pool_max[0]
can't be used, so simply returns NULL in the case.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/buffer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 2741566..98e39f9 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -122,6 +122,9 @@ void *hcd_buffer_alloc(
 	struct usb_hcd		*hcd = bus_to_hcd(bus);
 	int			i;
 
+	if (size == 0)
+		return NULL;
+
 	/* some USB hosts just use PIO */
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
 	    (!bus->controller->dma_mask &&
-- 
1.7.9.5
