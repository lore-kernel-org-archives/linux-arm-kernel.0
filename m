From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Dec 2015 14:17:28 +0800
Subject: [PATCH] usb: xhci-mtk: fix bpkts value of LS/HS periodic eps not
 behind TT
Message-ID: <1449123448-22476-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when a LS or FS device doesn't connect though a HS hub,
the @bPkts field of its periodic endpoint context should
be set to 1.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index c30de7c..73f763c 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -275,8 +275,9 @@ static bool need_bw_sch(struct usb_host_endpoint *ep,
 		return false;
 
 	/*
-	 * for LS & FS periodic endpoints which its device don't attach
-	 * to TT are also ignored, root-hub will schedule them directly
+	 * for LS & FS periodic endpoints which its device is not behind
+	 * a TT are also ignored, root-hub will schedule them directly,
+	 * but need set @bpkts field of endpoint context to 1.
 	 */
 	if (is_fs_or_ls(speed) && !has_tt)
 		return false;
@@ -339,8 +340,17 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		GET_MAX_PACKET(usb_endpoint_maxp(&ep->desc)),
 		usb_endpoint_dir_in(&ep->desc), ep);
 
-	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT))
+	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT)) {
+		/*
+		 * set @bpkts to 1 if it is LS or FS periodic endpoint, and its
+		 * device does not connected through an external HS hub
+		 */
+		if (usb_endpoint_xfer_int(&ep->desc)
+			|| usb_endpoint_xfer_isoc(&ep->desc))
+			ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(1));
+
 		return 0;
+	}
 
 	bw_index = get_bw_index(xhci, udev, ep);
 	sch_bw = &sch_array[bw_index];
-- 
1.8.1.1.dirty
