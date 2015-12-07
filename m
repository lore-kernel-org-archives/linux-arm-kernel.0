From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 7 Dec 2015 20:49:22 +0800
Subject: [PATCH v2 5/7] usb: xhci: plat: Remove checks for optional clock in
 error/remove path
In-Reply-To: <1449492564-4803-1-git-send-email-jszhang@marvell.com>
References: <1449492564-4803-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449492564-4803-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
clk_{unprepare, disable}()") allows NULL or error pointer to be passed
unconditionally.

This patch is to simplify probe error and remove code paths.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d990135..62f02e5 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -197,8 +197,7 @@ put_usb3_hcd:
 	usb_put_hcd(xhci->shared_hcd);
 
 disable_clk:
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 
 put_hcd:
 	usb_put_hcd(hcd);
@@ -218,8 +217,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(xhci->shared_hcd);
 
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
 
 	return 0;
-- 
2.6.2
