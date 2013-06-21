From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 22:30:54 +0200
Subject: [PATCH] ARM: mxs: don't select HAVE_PWM
Message-ID: <201306212230.55179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. MXS actually
uses that framework, and selecting the symbol anyway might
cause build errors like

drivers/built-in.o: In function `pwm_beeper_resume':
:(.text+0x1f4fc0): undefined reference to `pwm_config'
:(.text+0x1f4fc8): undefined reference to `pwm_enable'
drivers/built-in.o: In function `pwm_beeper_suspend':
:(.text+0x1f4ffc): undefined reference to `pwm_disable'

when CONFIG_PWM is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 59c30ef..616fe02 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -3,7 +3,6 @@ config SOC_IMX23
 	select ARM_AMBA
 	select ARM_CPU_SUSPEND if PM
 	select CPU_ARM926T
-	select HAVE_PWM
 	select PINCTRL_IMX23
 
 config SOC_IMX28
@@ -12,7 +11,6 @@ config SOC_IMX28
 	select ARM_CPU_SUSPEND if PM
 	select CPU_ARM926T
 	select HAVE_CAN_FLEXCAN if CAN
-	select HAVE_PWM
 	select PINCTRL_IMX28
 
 config ARCH_MXS
