From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:48 -0500
Subject: [V6 PATCH 13/16] usb: ehci: ehci-mv: add extern chip support
In-Reply-To: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1360135431-27280-14-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It does the similar things as what we do for udc driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index be504fd..171e145 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -256,8 +256,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 #endif
 	} else {
-		if (pdata->set_vbus)
-			pdata->set_vbus(1);
+		if (mv_usb2_has_extern_call(ehci_mv->mvphy, vbus, set_vbus))
+			mv_usb2_extern_call(ehci_mv->mvphy, vbus, set_vbus, 1);
 
 		retval = usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
 		if (retval) {
@@ -275,8 +275,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	return 0;
 
 err_set_vbus:
-	if (pdata->set_vbus)
-		pdata->set_vbus(0);
+	if (mv_usb2_has_extern_call(ehci_mv->mvphy, vbus, set_vbus))
+		mv_usb2_extern_call(ehci_mv->mvphy, vbus, set_vbus, 0);
 err_disable_clk:
 	mv_ehci_disable(ehci_mv);
 err_clear_drvdata:
@@ -299,8 +299,8 @@ static int mv_ehci_remove(struct platform_device *pdev)
 		otg_set_host(ehci_mv->otg->otg, NULL);
 
 	if (ehci_mv->mode == MV_USB_MODE_HOST) {
-		if (ehci_mv->pdata->set_vbus)
-			ehci_mv->pdata->set_vbus(0);
+		if (mv_usb2_has_extern_call(ehci_mv->mvphy, vbus, set_vbus))
+			mv_usb2_extern_call(ehci_mv->mvphy, vbus, set_vbus, 1);
 
 		mv_ehci_disable(ehci_mv);
 	}
-- 
1.7.4.1
