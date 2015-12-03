From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Dec 2015 14:14:14 +0800
Subject: [PATCH] usb: xhci: fix config fail of FS hub behind a HS hub with MTT
Message-ID: <1449123254-21654-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if a full speed hub connects to a high speed hub which
supports MTT, the MTT field of its slot context will be set
to 1 when xHCI driver setups an xHCI virtual device in
xhci_setup_addressable_virt_dev(); once usb core fetch its
hub descriptor, and need to update the xHC's internal data
structures for the device, the HUB field of its slot context
will be set to 1 too, meanwhile MTT is also set before,
this will cause configure endpoint command fail, so in the
case, we should clear MTT to 0 for full speed hub according
to section 6.2.2

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6cbcd1e..27c8cf8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4785,8 +4785,16 @@ int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
 	slot_ctx = xhci_get_slot_ctx(xhci, config_cmd->in_ctx);
 	slot_ctx->dev_info |= cpu_to_le32(DEV_HUB);
+	/*
+	 * refer to section 6.2.2: MTT should be 0 for full speed hub,
+	 * but it may be already set to 1 when setup an xHCI virtual
+	 * device, so clear it anyway.
+	 */
 	if (tt->multi)
 		slot_ctx->dev_info |= cpu_to_le32(DEV_MTT);
+	else if (hdev->speed == USB_SPEED_FULL)
+		slot_ctx->dev_info &= cpu_to_le32(~DEV_MTT);
+
 	if (xhci->hci_version > 0x95) {
 		xhci_dbg(xhci, "xHCI version %x needs hub "
 				"TT think time and number of ports\n",
-- 
1.8.1.1.dirty
