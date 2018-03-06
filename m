From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  6 Mar 2018 20:18:49 +0900
Subject: [PATCH] phy: add 'depends on HAS_IOMEM' to fix unmet dependency
Message-ID: <1520335129-11101-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet
direct dependencies" in Kconfig phase.

Detected by "make ARCH=score allyesconfig".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
https://lkml.org/lkml/2018/2/27/284

We agreed to add 'depends on HAS_IOMEM' to drivers causing
unmet dependency.


 drivers/phy/hisilicon/Kconfig | 1 +
 drivers/phy/ralink/Kconfig    | 1 +
 drivers/phy/rockchip/Kconfig  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 6164c4c..1131ba6 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -4,6 +4,7 @@
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index b17635b..14fd219 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -4,6 +4,7 @@
 config PHY_RALINK_USB
 	tristate "Ralink USB PHY driver"
 	depends on RALINK || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index f5325b2..0e15119 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -29,6 +29,7 @@ config PHY_ROCKCHIP_INNO_USB2
 config PHY_ROCKCHIP_PCIE
 	tristate "Rockchip PCIe PHY Driver"
 	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
-- 
2.7.4
