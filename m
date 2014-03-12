From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Mar 2014 16:48:13 +0100
Subject: [PATCH] phy: exynos: fix building as a module
Message-ID: <10501799.dhM9cVfZmk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The top-level phy-samsung-usb2 driver may be configured as a
loadable module, which currently causes link errors because
of the dependency on the exynos{5250,4x12,4210}_usb2_phy_config
symbol. Solving this could be achieved by exporting these
symbols, but as the SoC-specific parts of the driver are not
currently built as modules, it seems better to just link
everything into one module and avoid the need for the export.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 2faf78e..7728518 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,8 +13,9 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
 obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
-obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-samsung-usb2.o
-obj-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
-obj-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
-obj-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
+obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
+phy-exynos-usb2-y			+= phy-samsung-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
