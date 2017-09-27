From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 27 Sep 2017 17:22:58 +0800
Subject: [PATCH 2/9] usb: xhci-mtk: use ports count from xhci in
 xhci_mtk_sch_init()
In-Reply-To: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1506503879.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1506503879.git.chunfeng.yun@mediatek.com>
Message-ID: <2a1d5bad7e63918e1bfdaa7bb328594d36567d9d.1506503879.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of ports count from xhci but not from ippc in
xhci_mtk_sch_init()

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c |    3 ++-
 drivers/usb/host/xhci-mtk.c     |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 6e7ddf6..bfc51bc 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -287,12 +287,13 @@ static bool need_bw_sch(struct usb_host_endpoint *ep,
 
 int xhci_mtk_sch_init(struct xhci_hcd_mtk *mtk)
 {
+	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct mu3h_sch_bw_info *sch_array;
 	int num_usb_bus;
 	int i;
 
 	/* ss IN and OUT are separated */
-	num_usb_bus = mtk->num_u3_ports * 2 + mtk->num_u2_ports;
+	num_usb_bus = xhci->num_usb3_ports * 2 + xhci->num_usb2_ports;
 
 	sch_array = kcalloc(num_usb_bus, sizeof(*sch_array), GFP_KERNEL);
 	if (sch_array == NULL)
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index c197a6d..9502ca4 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -492,7 +492,6 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_mtk_setup(struct usb_hcd *hcd)
 {
-	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	int ret;
 
@@ -507,8 +506,6 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 		return ret;
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
-		mtk->num_u3_ports = xhci->num_usb3_ports;
-		mtk->num_u2_ports = xhci->num_usb2_ports;
 		ret = xhci_mtk_sch_init(mtk);
 		if (ret)
 			return ret;
-- 
1.7.9.5
