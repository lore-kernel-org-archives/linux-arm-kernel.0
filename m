From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 28 Apr 2016 11:42:21 +0800
Subject: [PATCH v2 2/2] usb: misc: usbtest: fix error of urb allocation
In-Reply-To: <1461814941-28345-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1461814941-28345-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1461814941-28345-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

urb allocation will fail when usbtest_alloc_urb() tries to
allocate zero length buffer, but it doesn't need it in fact,
so just skips buffer allocation in the case.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/misc/usbtest.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 92fdb6e..de485d8 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -287,6 +287,9 @@ static struct urb *usbtest_alloc_urb(
 	if (usb_pipein(pipe))
 		urb->transfer_flags |= URB_SHORT_NOT_OK;
 
+	if ((bytes + offset) == 0)
+		return urb;
+
 	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
 		urb->transfer_buffer = usb_alloc_coherent(udev, bytes + offset,
 			GFP_KERNEL, &urb->transfer_dma);
-- 
1.7.9.5
