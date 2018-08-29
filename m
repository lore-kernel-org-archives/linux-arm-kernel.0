From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 29 Aug 2018 10:55:18 +0800
Subject: [PATCH 6/6] usb: xhci-mtk: supports SSP without external USB3 gen2 hub
In-Reply-To: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
Message-ID: <0b0ebe56390a9a66d5d84c5717665bf7d2ae179c.1535510898.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supports SSP scheduling only for SSP device directly connected
to root hub but not through external USB3 gen2 hub which need
use a new scheduling way.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 36050a1..fea5555 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -13,6 +13,7 @@
 #include "xhci.h"
 #include "xhci-mtk.h"
 
+#define SSP_BW_BOUNDARY	130000
 #define SS_BW_BOUNDARY	51000
 /* table 5-5. High-speed Isoc Transaction Limits in usb_20 spec */
 #define HS_BW_BOUNDARY	6144
@@ -25,7 +26,7 @@
 #define TT_MICROFRAMES_MAX 9
 
 /* mtk scheduler bitmasks */
-#define EP_BPKTS(p)	((p) & 0x3f)
+#define EP_BPKTS(p)	((p) & 0x7f)
 #define EP_BCSCOUNT(p)	(((p) & 0x7) << 8)
 #define EP_BBM(p)	((p) << 11)
 #define EP_BOFFSET(p)	((p) & 0x3fff)
@@ -56,7 +57,7 @@ static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
 
 	virt_dev = xhci->devs[udev->slot_id];
 
-	if (udev->speed == USB_SPEED_SUPER) {
+	if (udev->speed >= USB_SPEED_SUPER) {
 		if (usb_endpoint_dir_out(&ep->desc))
 			bw_index = (virt_dev->real_port - 1) * 2;
 		else
@@ -177,7 +178,7 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 
 	if (is_fs_or_ls(udev->speed))
 		len_bw_budget_table = TT_MICROFRAMES_MAX;
-	else if ((udev->speed == USB_SPEED_SUPER)
+	else if ((udev->speed >= USB_SPEED_SUPER)
 			&& usb_endpoint_xfer_isoc(&ep->desc))
 		len_bw_budget_table = get_esit(ep_ctx);
 	else
@@ -249,7 +250,7 @@ static void setup_sch_info(struct usb_device *udev,
 		sch_ep->pkts = max_burst + 1;
 		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
 		bwb_table[0] = sch_ep->bw_cost_per_microframe;
-	} else if (udev->speed == USB_SPEED_SUPER) {
+	} else if (udev->speed >= USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
 		sch_ep->burst_mode = 1;
@@ -511,8 +512,12 @@ static int check_sch_bw(struct usb_device *udev,
 			break;
 	}
 
-	bw_boundary = (udev->speed == USB_SPEED_SUPER)
-				? SS_BW_BOUNDARY : HS_BW_BOUNDARY;
+	if (udev->speed == USB_SPEED_SUPER_PLUS)
+		bw_boundary = SSP_BW_BOUNDARY;
+	else if (udev->speed == USB_SPEED_SUPER)
+		bw_boundary = SS_BW_BOUNDARY;
+	else
+		bw_boundary = HS_BW_BOUNDARY;
 
 	/* check bandwidth */
 	if (min_bw > bw_boundary)
-- 
1.9.1
