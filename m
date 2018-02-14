From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Feb 2018 17:16:19 +0100
Subject: [PATCH 1/2] usb: host: xhci-plat: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180214161620.4401-1-gregory.clement@bootlin.com>
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
Message-ID: <20180214161620.4401-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6f038306c14d..79afaac57ef6 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -319,8 +319,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 
 disable_clk:
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 
 put_hcd:
 	usb_put_hcd(hcd);
@@ -346,8 +345,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(xhci->shared_hcd);
 
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
 
 	pm_runtime_set_suspended(&dev->dev);
-- 
2.15.1
