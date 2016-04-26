From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 26 Apr 2016 20:57:34 +0800
Subject: [RESEND PATCH v2 1/7] usb: xhci: plat: Fix suspend/resume when the
 optional clk exists
In-Reply-To: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
Message-ID: <1461675460-2295-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4718c1774051 ("usb: host: xhci-plat: add clock support") adds
optional clk support, but it forgets to prepare/disable and
enable/unprepare the clk in the resume/suspend path. This path fixes
this issue by adding missing clk related calls.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: 4718c1774051 ("usb: host: xhci-plat: add clock support")
---
 drivers/usb/host/xhci-plat.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 474b5fa..8cb46cb 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -295,6 +295,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int xhci_plat_suspend(struct device *dev)
 {
+	int ret;
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 
@@ -306,14 +307,25 @@ static int xhci_plat_suspend(struct device *dev)
 	 * reconsider this when xhci_plat_suspend enlarges its scope, e.g.,
 	 * also applies to runtime suspend.
 	 */
-	return xhci_suspend(xhci, device_may_wakeup(dev));
+	ret = xhci_suspend(xhci, device_may_wakeup(dev));
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(xhci->clk);
+
+	return ret;
 }
 
 static int xhci_plat_resume(struct device *dev)
 {
+	int ret;
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 
+	ret = clk_prepare_enable(xhci->clk);
+	if (ret)
+		return ret;
+
 	return xhci_resume(xhci, 0);
 }
 
-- 
2.8.1
