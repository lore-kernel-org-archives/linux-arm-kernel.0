From: chunfeng.yun@mediatek.com (chunfeng.yun at mediatek.com)
Date: Wed, 27 May 2015 19:48:00 +0800
Subject: [PATCH 3/6] xhci: probe phy before add usb_hcd
In-Reply-To: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1432727283-20303-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

find the phy driver before add primary usb_hcd to avoid acessing
xHCI register which may hangup the system when the phy is not loaded
yet and the related powers or clocks put in phy driver are not
enabled.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-plat.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 783e819..c10f5fa 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -127,9 +127,21 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto disable_clk;
 	}
 
+	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
+	if (IS_ERR(hcd->usb_phy)) {
+		ret = PTR_ERR(hcd->usb_phy);
+		if (ret == -EPROBE_DEFER)
+			goto disable_clk;
+		hcd->usb_phy = NULL;
+	} else {
+		ret = usb_phy_init(hcd->usb_phy);
+		if (ret)
+			goto disable_clk;
+	}
+
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret)
-		goto disable_clk;
+		goto disable_usb_phy;
 
 	device_wakeup_enable(hcd->self.controller);
 
@@ -156,33 +168,21 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
-	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
-	if (IS_ERR(hcd->usb_phy)) {
-		ret = PTR_ERR(hcd->usb_phy);
-		if (ret == -EPROBE_DEFER)
-			goto put_usb3_hcd;
-		hcd->usb_phy = NULL;
-	} else {
-		ret = usb_phy_init(hcd->usb_phy);
-		if (ret)
-			goto put_usb3_hcd;
-	}
-
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
-		goto disable_usb_phy;
+		goto put_usb3_hcd;
 
 	return 0;
 
-disable_usb_phy:
-	usb_phy_shutdown(hcd->usb_phy);
-
 put_usb3_hcd:
 	usb_put_hcd(xhci->shared_hcd);
 
 dealloc_usb2_hcd:
 	usb_remove_hcd(hcd);
 
+disable_usb_phy:
+	usb_phy_shutdown(hcd->usb_phy);
+
 disable_clk:
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
-- 
1.8.1.1.dirty
