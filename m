From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:19 +0100
Subject: [PATCH 09/23] usb: exynos: do not include plat/usb-phy.h
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definitions have moved to include/linux/usb/samsung-usb-phy.h,
and plat/usb-phy.h is unavailable from drivers in a multiplatform
configuration.

Also fix up the plat/usb-phy.h header file to use the definitions
from the new header instead of providing a separate copy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/setup-usb-phy.c         | 8 ++++----
 arch/arm/mach-s3c64xx/setup-usb-phy.c        | 4 ++--
 arch/arm/mach-s5pv210/setup-usb-phy.c        | 4 ++--
 arch/arm/plat-samsung/include/plat/usb-phy.h | 5 +----
 drivers/usb/host/ehci-s5p.c                  | 1 -
 drivers/usb/host/ohci-exynos.c               | 1 -
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index b81cc56..6af4066 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -204,9 +204,9 @@ static int exynos4210_usb_phy1_exit(struct platform_device *pdev)
 
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return exynos4210_usb_phy0_init(pdev);
-	else if (type == S5P_USB_PHY_HOST)
+	else if (type == USB_PHY_TYPE_HOST)
 		return exynos4210_usb_phy1_init(pdev);
 
 	return -EINVAL;
@@ -214,9 +214,9 @@ int s5p_usb_phy_init(struct platform_device *pdev, int type)
 
 int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return exynos4210_usb_phy0_exit(pdev);
-	else if (type == S5P_USB_PHY_HOST)
+	else if (type == USB_PHY_TYPE_HOST)
 		return exynos4210_usb_phy1_exit(pdev);
 
 	return -EINVAL;
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index c8174d9..ca960bd 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -76,7 +76,7 @@ static int s3c_usb_otgphy_exit(struct platform_device *pdev)
 
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return s3c_usb_otgphy_init(pdev);
 
 	return -EINVAL;
@@ -84,7 +84,7 @@ int s5p_usb_phy_init(struct platform_device *pdev, int type)
 
 int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return s3c_usb_otgphy_exit(pdev);
 
 	return -EINVAL;
diff --git a/arch/arm/mach-s5pv210/setup-usb-phy.c b/arch/arm/mach-s5pv210/setup-usb-phy.c
index 356a090..b2ee533 100644
--- a/arch/arm/mach-s5pv210/setup-usb-phy.c
+++ b/arch/arm/mach-s5pv210/setup-usb-phy.c
@@ -80,7 +80,7 @@ static int s5pv210_usb_otgphy_exit(struct platform_device *pdev)
 
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return s5pv210_usb_otgphy_init(pdev);
 
 	return -EINVAL;
@@ -88,7 +88,7 @@ int s5p_usb_phy_init(struct platform_device *pdev, int type)
 
 int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_DEVICE)
+	if (type == USB_PHY_TYPE_DEVICE)
 		return s5pv210_usb_otgphy_exit(pdev);
 
 	return -EINVAL;
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 959bcdb..ab34dfa 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -11,10 +11,7 @@
 #ifndef __PLAT_SAMSUNG_USB_PHY_H
 #define __PLAT_SAMSUNG_USB_PHY_H __FILE__
 
-enum s5p_usb_phy_type {
-	S5P_USB_PHY_DEVICE,
-	S5P_USB_PHY_HOST,
-};
+#include <linux/usb/samsung_usb_phy.h>
 
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 20ebf6a..7dc9c15 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/usb-ehci-s5p.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/samsung_usb_phy.h>
-#include <plat/usb-phy.h>
 
 #define EHCI_INSNREG00(base)			(base + 0x90)
 #define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index e3b7e85..b5b5977 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -17,7 +17,6 @@
 #include <linux/platform_data/usb-exynos.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/samsung_usb_phy.h>
-#include <plat/usb-phy.h>
 
 struct exynos_ohci_hcd {
 	struct device *dev;
-- 
1.8.1.2
