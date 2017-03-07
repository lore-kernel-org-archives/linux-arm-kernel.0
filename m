From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 7 Mar 2017 14:57:20 +0800
Subject: [PATCH 1/2] usb: xhci-mtk: rebuild xhci_mtk_setup()
Message-ID: <1488869841-9959-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

simplify xhci_mtk_setup() and add xhci_mtk_start() for
xhci_driver_overrides struct

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 67d5dc7..9636884 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -381,8 +381,10 @@ static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
 }
 
 static int xhci_mtk_setup(struct usb_hcd *hcd);
+static int xhci_mtk_start(struct usb_hcd *hcd);
 static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
 	.reset = xhci_mtk_setup,
+	.start = xhci_mtk_start,
 };
 
 static struct hc_driver __read_mostly xhci_mtk_hc_driver;
@@ -492,7 +494,6 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_mtk_setup(struct usb_hcd *hcd)
 {
-	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	int ret;
 
@@ -502,9 +503,14 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 			return ret;
 	}
 
-	ret = xhci_gen_setup(hcd, xhci_mtk_quirks);
-	if (ret)
-		return ret;
+	return xhci_gen_setup(hcd, xhci_mtk_quirks);
+}
+
+static int xhci_mtk_start(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
+	int ret;
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		mtk->num_u3_ports = xhci->num_usb3_ports;
@@ -514,7 +520,7 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 			return ret;
 	}
 
-	return ret;
+	return xhci_run(hcd);
 }
 
 static int xhci_mtk_probe(struct platform_device *pdev)
-- 
1.7.9.5
