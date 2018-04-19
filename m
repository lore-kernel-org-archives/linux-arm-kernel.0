From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 19 Apr 2018 15:30:52 +0200
Subject: [PATCH v2 1/2] usb: host: xhci-plat: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180419133053.11894-1-gregory.clement@bootlin.com>
References: <20180419133053.11894-1-gregory.clement@bootlin.com>
Message-ID: <20180419133053.11894-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df327dcc2bac..f0231fea524e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -320,8 +320,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 
 disable_clk:
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 
 put_hcd:
 	usb_put_hcd(hcd);
@@ -347,8 +346,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(xhci->shared_hcd);
 
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
 
 	pm_runtime_set_suspended(&dev->dev);
-- 
2.16.3
