From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 26 Apr 2016 20:57:36 +0800
Subject: [RESEND PATCH v2 3/7] usb: xhci: plat: Fix suspend/resume when the
 optional usb_phy exists
In-Reply-To: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
Message-ID: <1461675460-2295-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") adds the
usb_phy for usb3, but it forgets to shutdown/init the usb_phy in the
suspend/resume path. This patch fixes this issue by adding missing
usb_phy related calls.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/host/xhci-plat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 9ff89e9..fbd23fd 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -313,6 +313,7 @@ static int xhci_plat_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	usb_phy_shutdown(xhci->shared_hcd->usb_phy);
 	clk_disable_unprepare(xhci->clk);
 
 	return ret;
@@ -328,6 +329,10 @@ static int xhci_plat_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = usb_phy_init(xhci->shared_hcd->usb_phy);
+	if (ret)
+		return ret;
+
 	return xhci_resume(xhci, 0);
 }
 
-- 
2.8.1
