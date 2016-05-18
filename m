From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 16:17:36 +0200
Subject: [PATCH] ARM: exynos: don't select keyboard driver
Message-ID: <1463581102-1007639-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung-keypad driver is implicitly selected by ARCH_EXYNOS4 (why?),
but this fails if CONFIG_INPUT is a loadable module:

drivers/input/built-in.o: In function `samsung_keypad_remove':
drivers/input/keyboard/samsung-keypad.c:461: undefined reference to `input_unregister_device'
drivers/input/built-in.o: In function `samsung_keypad_irq':
drivers/input/keyboard/samsung-keypad.c:137: undefined reference to `input_event'
drivers/input/built-in.o: In function `samsung_keypad_irq':
include/linux/input.h:389: undefined reference to `input_event'
drivers/input/built-in.o: In function `samsung_keypad_probe':
drivers/input/keyboard/samsung-keypad.c:358: undefined reference to `devm_input_allocate_device'
drivers/input/built-in.o:(.debug_addr+0x34): undefined reference to `input_set_capability'

This removes the 'select' as suggested by Krzysztof Kozlowski and
instead enables the driver from the defconfig files.

The problem does not happen on mainline kernels, as we don't normally
build built-in input drivers when CONFIG_INPUT=m, but I am experimenting
with a patch to change this, and the samsung keypad driver showed up
as one example that was silently broken before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.org/lkml/2016/2/14/55
---
 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/mach-exynos/Kconfig        | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index a8cf295724c5..1124a51e0d16 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -82,6 +82,7 @@ CONFIG_TOUCHSCREEN_MMS114=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MAX77693_HAPTIC=y
 CONFIG_INPUT_MAX8997_HAPTIC=y
+CONFIG_KEYBOARD_SAMSUNG=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f7e0d49b515a..a9bb659cdbbb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -264,6 +264,7 @@ CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=m
+CONFIG_KEYBOARD_SAMSUNG=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index dc9b6fb103c6..8ce964ddb4e3 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -61,7 +61,6 @@ config ARCH_EXYNOS4
 	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
 	select CPU_EXYNOS4210
 	select GIC_NON_BANKED
-	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
 	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Samsung EXYNOS4 (Cortex-A9) SoC based systems
-- 
2.7.0
