From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 15:07:06 +0100
Subject: [PATCH 2/2] ARM: s3c64xx: get rid of custom <mach/gpio.h>
Message-ID: <1386857226-4992-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isolates the custom S3C64xx GPIO definition table to
<linux/platform_data/gpio-samsung-s3x64xx.h> as this is
used in a few different places in the kernel, removing the
need to depend on the implicit inclusion of <mach/gpio.h>
from <linux/gpio.h> and thus getting rid of a few nasty
cross-dependencies.

Also delete the CONFIG_SAMSUNG_GPIO_EXTRA stuff. Instead
roof the number of GPIOs for this platform:
First sum up all the GPIO banks from A to Q: 187 GPIOs.
Add the 16 "board GPIOs" and the roof for SAMSUNG_GPIO_EXTRA,
128, so in total maximum 187+16+128 = 331 GPIOs, so let's
take the same roof as for S3C24XX: 512. This way we can do
away with the GPIO calculation macros for GPIO_BOARD_START,
BOARD_NR_GPIOS and the definition of ARCH_NR_GPIOS.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch depends on
"ARM: s3c24xx: get rid of custom <mach/gpio.h>"

If one of the maintainers give me an ACK for this I will
take it through the GPIO tree.
---
 arch/arm/Kconfig                                   | 3 +--
 arch/arm/mach-s3c64xx/Kconfig                      | 3 ---
 arch/arm/mach-s3c64xx/common.c                     | 1 +
 arch/arm/mach-s3c64xx/crag6410.h                   | 2 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  | 1 +
 arch/arm/mach-s3c64xx/mach-anw6410.c               | 1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              | 1 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   | 1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              | 1 +
 arch/arm/mach-s3c64xx/mach-real6410.c              | 1 +
 arch/arm/mach-s3c64xx/mach-smartq.c                | 1 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               | 1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c               | 1 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              | 1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c              | 1 +
 arch/arm/mach-s3c64xx/pm.c                         | 1 +
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c             | 1 +
 arch/arm/mach-s3c64xx/setup-i2c0.c                 | 1 +
 arch/arm/mach-s3c64xx/setup-i2c1.c                 | 1 +
 arch/arm/mach-s3c64xx/setup-ide.c                  | 1 +
 arch/arm/mach-s3c64xx/setup-keypad.c               | 1 +
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c           | 1 +
 arch/arm/mach-s3c64xx/setup-spi.c                  | 1 +
 drivers/gpio/gpio-samsung.c                        | 3 +++
 include/linux/platform_data/gpio-samsung-s3c64xx.h | 9 +++++----
 25 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6a26bcb3a63a..103437986684 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -732,7 +732,6 @@ config ARCH_S3C64XX
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_TCM
-	select NEED_MACH_GPIO_H
 	select NO_IOPORT
 	select PLAT_SAMSUNG
 	select PM_GENERIC_DOMAINS
@@ -1592,7 +1591,7 @@ config ARM_PSCI
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX || ARCH_S3C24XX
+	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 2cb8dc55b50e..175f01501129 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -192,7 +192,6 @@ config SMDK6410_WM1190_EV1
 	select MFD_WM8350_I2C
 	select REGULATOR
 	select REGULATOR_WM8350
-	select SAMSUNG_GPIO_EXTRA64
 	help
 	  The Wolfson Microelectronics 1190-EV1 is a WM835x based PMIC
 	  and audio daughtercard for the Samsung SMDK6410 reference
@@ -208,7 +207,6 @@ config SMDK6410_WM1192_EV1
 	select MFD_WM831X_I2C
 	select REGULATOR
 	select REGULATOR_WM831X
-	select SAMSUNG_GPIO_EXTRA64
 	help
 	  The Wolfson Microelectronics 1192-EV1 is a WM831x based PMIC
 	  daughtercard for the Samsung SMDK6410 reference platform.
@@ -294,7 +292,6 @@ config MACH_WLF_CRAGG_6410
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select SAMSUNG_GPIO_EXTRA128
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 7a3ce4c39e5f..64edda37bde3 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <clocksource/samsung_pwm.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c64xx/crag6410.h b/arch/arm/mach-s3c64xx/crag6410.h
index 4c3c9994fc2c..9ef20b8fd36f 100644
--- a/arch/arm/mach-s3c64xx/crag6410.h
+++ b/arch/arm/mach-s3c64xx/crag6410.h
@@ -11,7 +11,7 @@
 #ifndef MACH_CRAG6410_H
 #define MACH_CRAG6410_H
 
-#include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #define GLENFARCLAS_PMIC_IRQ_BASE	IRQ_BOARD_START
 
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index e367e87bbc29..6f58c80235dc 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -21,6 +21,7 @@
 
 #include <plat/devs.h>
 #include <linux/platform_data/asoc-s3c.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 
 static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index d266dd5f7060..546f45b59ea1 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -43,6 +43,7 @@
 
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/fb.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 758e31b26550..7b913595e4ee 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -32,6 +32,7 @@
 
 #include <linux/platform_data/pca953x.h>
 #include <linux/platform_data/s3c-hsotg.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 614a03a92cf7..009b19525cbf 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -35,6 +35,7 @@
 
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/fb.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 58d46a3d7b78..14c96ee5a3fe 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -38,6 +38,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 8bed37b3d5ac..af45149a96b3 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -39,6 +39,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index a6b338fd0470..0271b3a191e5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -36,6 +36,7 @@
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <plat/samsung-time.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 8aca5daf3d05..15b6c2f98086 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index a052e107c0b4..e3b58942ee68 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 27381cfcabbe..bdbbddb803d5 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -35,6 +35,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/samsung-time.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d5ea938cc9a1..a8977da87eb1 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/pwm_backlight.h>
 #include <linux/platform_data/s3c-hsotg.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 8cdb824a3b43..99c778eecab6 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pm_domain.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 2cf80026c58d..222792691b41 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
index 40666ba8d607..f269dabc9593 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c0.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c0.c
@@ -19,6 +19,7 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
index 3fdb24c4e62a..aa2bfcd5e818 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c1.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c1.c
@@ -19,6 +19,7 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
index 648d8b85bf6b..81dcebeaeb53 100644
--- a/arch/arm/mach-s3c64xx/setup-ide.c
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -18,6 +18,7 @@
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/ata-samsung_cf.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 void s3c64xx_ide_setup_gpio(void)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index 1d4d0ee9e870..e236f40c9053 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -11,6 +11,7 @@
 */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 #include <plat/keypad.h>
 
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 6eac071afae2..79192b7217df 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
index 4dc53450d715..dad4728ccb52 100644
--- a/arch/arm/mach-s3c64xx/setup-spi.c
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 268214c57799..be7b0bd4eed4 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -30,6 +30,9 @@
 #ifdef CONFIG_ARCH_S3C24XX
 #include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #endif
+#ifdef CONFIG_ARCH_S3C64XX
+#include <linux/platform_data/gpio-samsung-s3c64xx.h>
+#endif
 
 #include <asm/irq.h>
 
diff --git a/include/linux/platform_data/gpio-samsung-s3c64xx.h b/include/linux/platform_data/gpio-samsung-s3c64xx.h
index 8b540c42d5dd..9c81fac3b2d5 100644
--- a/include/linux/platform_data/gpio-samsung-s3c64xx.h
+++ b/include/linux/platform_data/gpio-samsung-s3c64xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c6400/include/mach/gpio.h
- *
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
@@ -12,6 +11,9 @@
  * published by the Free Software Foundation.
 */
 
+#ifndef GPIO_SAMSUNG_S3C64XX_H
+#define GPIO_SAMSUNG_S3C64XX_H
+
 /* GPIO bank sizes */
 #define S3C64XX_GPIO_A_NR	(8)
 #define S3C64XX_GPIO_B_NR	(7)
@@ -88,6 +90,5 @@ enum s3c_gpio_number {
 /* define the number of gpios we need to the one after the GPQ() range */
 #define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
 
-#define BOARD_NR_GPIOS	(16 + CONFIG_SAMSUNG_GPIO_EXTRA)
+#endif /* GPIO_SAMSUNG_S3C64XX_H */
 
-#define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
-- 
1.8.3.1
