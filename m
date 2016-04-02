From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  2 Apr 2016 20:56:02 +0200
Subject: [PATCH] ARM: pxa: activate pinctrl for device-tree machines
Message-ID: <1459623362-18324-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pincontrol is not yet ready for all PXA platforms.
For example, a legacy platform, if PINCTRL was activated, will fail its
calls to gpio_request() or gpio_direction_output(), as the pinctrl
driver might not be available, such as for pxa25x and pxa3xx.

As a step forward, activate pincontrol for all device-tree available
machines, ie. pxa27x device-tree based and pxa3xx device-tree based.

If it appears later that pincontrol is also required for legacy
platforms and if the mfp->pinctrl conversion can be achieved, then
PINCTRL will be activated for the whole PXA architecture.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 7ee4652b4c61..cd894d69e766 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -6,6 +6,7 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
 config MACH_PXA27X_DT
 	bool "Support PXA27x platforms from device tree"
+	select PINCTRL
 	select POWER_SUPPLY
 	select PXA27x
 	select USE_OF
@@ -17,6 +18,7 @@ config MACH_PXA27X_DT
 config MACH_PXA3XX_DT
 	bool "Support PXA3xx platforms from device tree"
 	select CPU_PXA300
+	select PINCTRL
 	select POWER_SUPPLY
 	select PXA3xx
 	select USE_OF
-- 
2.1.4
