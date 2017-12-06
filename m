From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 6 Dec 2017 14:42:56 +0800
Subject: [PATCH] usb: xhci: fix TDS for MTK xHCI1.1
Message-ID: <035626be9cb863b145b02369fe517d1c80335398.1512542108.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MTK's xHCI 1.0 or latter, TD size is the number of max
packet sized packets remaining in the TD, not including
this TRB (following spec).

For MTK's xHCI 0.96 and older, TD size is the number of max
packet sized packets remaining in the TD, including this TRB
(not following spec).

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c239c68..0619869 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3108,7 +3108,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 {
 	u32 maxp, total_packet_count;
 
-	/* MTK xHCI is mostly 0.97 but contains some features from 1.0 */
+	/* MTK xHCI 0.96 contains some features from 1.0 */
 	if (xhci->hci_version < 0x100 && !(xhci->quirks & XHCI_MTK_HOST))
 		return ((td_total_len - transferred) >> 10);
 
@@ -3117,8 +3117,8 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 	    trb_buff_len == td_total_len)
 		return 0;
 
-	/* for MTK xHCI, TD size doesn't include this TRB */
-	if (xhci->quirks & XHCI_MTK_HOST)
+	/* for MTK xHCI 0.96, TD size include this TRB, but not in 1.x */
+	if ((xhci->quirks & XHCI_MTK_HOST) && (xhci->hci_version < 0x100))
 		trb_buff_len = 0;
 
 	maxp = usb_endpoint_maxp(&urb->ep->desc);
-- 
1.9.1
