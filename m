From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 May 2013 15:48:10 +0900
Subject: [PATCH] ARM: shmobile: marzen: Use error values in usb_power_*
In-Reply-To: <1369205290-6272-1-git-send-email-horms+renesas@verge.net.au>
References: <1369205290-6272-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369205290-6272-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the marzen board code as if USB PHY isn't enabled
they phy will have a value set by ERR_PTR() rather than be NULL.

Without this patch a NULL pointer dereference  and kernel panic
occurs on initialisation of USB on marzen.

This resolves a regression introduced in 3.10-rc1 by
b7fa5c2aec5be083eb2719b405089703608e9bc6
("usb: phy: return -ENXIO when PHY layer isn't enabled").

Tested-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..b9594e9 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -212,8 +212,8 @@ static struct platform_device *marzen_devices[] __initdata = {
 static struct usb_phy *phy;
 static int usb_power_on(struct platform_device *pdev)
 {
-	if (!phy)
-		return -EIO;
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
@@ -225,7 +225,7 @@ static int usb_power_on(struct platform_device *pdev)
 
 static void usb_power_off(struct platform_device *pdev)
 {
-	if (!phy)
+	if (IS_ERR(phy))
 		return;
 
 	usb_phy_shutdown(phy);
-- 
1.8.2.1
