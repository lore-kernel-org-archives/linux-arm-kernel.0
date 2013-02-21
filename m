From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 20 Feb 2013 23:07:23 -0500
Subject: [V8 PATCH 13/16] usb: ehci: ehci-mv: add extern chip support
In-Reply-To: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361419646-9052-14-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It does the similar things as what we do for udc driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mv.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 3e89bd4..ae5d8dc 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -138,6 +138,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	struct ehci_hcd *ehci;
 	struct ehci_hcd_mv *ehci_mv;
 	struct resource *r;
+	struct mv_usb2_phy *mv_phy;
 	int clk_i, retval = -ENODEV;
 	u32 offset;
 	size_t size;
@@ -199,6 +200,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		retval = PTR_ERR(ehci_mv->phy);
 		goto err_clear_drvdata;
 	}
+	mv_phy = container_of(ehci_mv->phy, struct mv_usb2_phy, phy);
 
 	retval = mv_ehci_enable(ehci_mv);
 	if (retval) {
@@ -251,8 +253,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 #endif
 	} else {
-		if (pdata->set_vbus)
-			pdata->set_vbus(1);
+		if (mv_usb2_has_extern_call(mv_phy, vbus, set_vbus))
+			mv_usb2_extern_call(mv_phy, vbus, set_vbus, 1);
 
 		retval = usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
 		if (retval) {
@@ -270,8 +272,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	return 0;
 
 err_set_vbus:
-	if (pdata->set_vbus)
-		pdata->set_vbus(0);
+	if (mv_usb2_has_extern_call(mv_phy, vbus, set_vbus))
+		mv_usb2_extern_call(mv_phy, vbus, set_vbus, 0);
 err_disable_clk:
 	mv_ehci_disable(ehci_mv);
 err_clear_drvdata:
@@ -286,6 +288,7 @@ static int mv_ehci_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_mv *ehci_mv = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_mv->hcd;
+	struct mv_usb2_phy *mv_phy;
 
 	if (hcd->rh_registered)
 		usb_remove_hcd(hcd);
@@ -293,9 +296,10 @@ static int mv_ehci_remove(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(ehci_mv->otg))
 		otg_set_host(ehci_mv->otg->otg, NULL);
 
+	mv_phy = container_of(ehci_mv->phy, struct mv_usb2_phy, phy);
 	if (ehci_mv->mode == MV_USB_MODE_HOST) {
-		if (ehci_mv->pdata->set_vbus)
-			ehci_mv->pdata->set_vbus(0);
+		if (mv_usb2_has_extern_call(mv_phy, vbus, set_vbus))
+			mv_usb2_extern_call(mv_phy, vbus, set_vbus, 1);
 
 		mv_ehci_disable(ehci_mv);
 	}
-- 
1.7.4.1
