From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Apr 2015 10:03:32 +0200
Subject: [PATCH] pinctrl: fix allmodconfig noise
Message-ID: <1429085012-25183-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was some mess in the dependencies in the pinctrl
Kconfig for compile tests under allmodconfig. Mea Culpa.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig          | 5 ++++-
 drivers/pinctrl/mediatek/Kconfig | 3 +++
 drivers/pinctrl/nomadik/Kconfig  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c6f299ba25cb..aeb5729fbda6 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -95,9 +95,11 @@ config PINCTRL_FALCON
 
 config PINCTRL_MESON
 	bool
+	depends on OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
+	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
 
@@ -229,7 +231,8 @@ config PINCTRL_XWAY
 
 config PINCTRL_TB10X
 	bool
-	depends on ARC_PLAT_TB10X
+	depends on OF && ARC_PLAT_TB10X
+	select GPIOLIB
 
 endmenu
 
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 5983cf5b2c46..6b3551cad111 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -2,6 +2,7 @@ if ARCH_MEDIATEK || COMPILE_TEST
 
 config PINCTRL_MTK_COMMON
 	bool
+	depends on OF
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
@@ -10,12 +11,14 @@ config PINCTRL_MTK_COMMON
 # For ARMv7 SoCs
 config PINCTRL_MT8135
 	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
+	depends on OF
 	default MACH_MT8135
 	select PINCTRL_MTK_COMMON
 
 # For ARMv8 SoCs
 config PINCTRL_MT8173
 	bool "Mediatek MT8173 pin control"
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_COMMON
diff --git a/drivers/pinctrl/nomadik/Kconfig b/drivers/pinctrl/nomadik/Kconfig
index d48a5aa24a29..f4fcebfce68c 100644
--- a/drivers/pinctrl/nomadik/Kconfig
+++ b/drivers/pinctrl/nomadik/Kconfig
@@ -30,9 +30,9 @@ if (ARCH_U8500 || ARCH_NOMADIK)
 config PINCTRL_NOMADIK
 	bool "Nomadik pin controller driver"
 	depends on ARCH_U8500 || ARCH_NOMADIK
+	depends on OF && GPIOLIB
 	select PINMUX
 	select PINCONF
-	select GPIOLIB
 	select OF_GPIO
 	select GPIOLIB_IRQCHIP
 
-- 
1.9.3
