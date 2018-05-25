From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 25 May 2018 17:24:57 +0800
Subject: [PATCH] usb: gadget: composite: fix delayed_status race condition
 when set_interface
Message-ID: <75dc545f259a68d36d49c0c663d5cac19bb61a24.1527240183.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It happens when enable debug log, if set_alt() returns
USB_GADGET_DELAYED_STATUS and usb_composite_setup_continue()
is called before increasing count of @delayed_status,
so fix it by using spinlock of @cdev->lock.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Jay Hsu <shih-chieh.hsu@mediatek.com>
---
 drivers/usb/gadget/composite.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index f242c2b..d2fa071 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1719,6 +1719,8 @@ static int fill_ext_prop(struct usb_configuration *c, int interface, u8 *buf)
 		 */
 		if (w_value && !f->get_alt)
 			break;
+
+		spin_lock(&cdev->lock);
 		value = f->set_alt(f, w_index, w_value);
 		if (value == USB_GADGET_DELAYED_STATUS) {
 			DBG(cdev,
@@ -1728,6 +1730,7 @@ static int fill_ext_prop(struct usb_configuration *c, int interface, u8 *buf)
 			DBG(cdev, "delayed_status count %d\n",
 					cdev->delayed_status);
 		}
+		spin_unlock(&cdev->lock);
 		break;
 	case USB_REQ_GET_INTERFACE:
 		if (ctrl->bRequestType != (USB_DIR_IN|USB_RECIP_INTERFACE))
-- 
1.9.1
