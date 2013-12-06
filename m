From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  6 Dec 2013 10:31:20 +0100
Subject: [PATCH] ARM: s3c24xx: get rid of custom <mach/gpio.h>
Message-ID: <1386322280-23756-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isolates the custom S3C24xx GPIO definition table to
<linux/platform_data/gpio-samsung-s3x24xx.h> as this is
used in a few different places in the kernel, removing the
need to depend on the implicit inclusion of <mach/gpio.h>
from <linux/gpio.h> and thus getting rid of a few nasty
cross-dependencies.

We also delete the nifty CONFIG_S3C24XX_GPIO_EXTRA stuff.
The biggest this can ever be for the S3C24XX is
CONFIG_S3C24XX_GPIO_EXTRA = 128, and then for CPU_S3C2443 or
CPU_S3C2416 32*12 GPIOs are added, so 32*12+128 = 512
is the absolute roof value on this platform. So we set
the size of ARCH_NR_GPIO to this and the GPIOs array will
fit any S3C24XX platform, as per pattern from other archs.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
If one of the maintainers give me an ACK for this I will
take it through the GPIO tree.
---
 arch/arm/Kconfig                                   |   3 +-
 arch/arm/mach-s3c24xx/Kconfig                      |  21 ----
 arch/arm/mach-s3c24xx/common-smdk.c                |   2 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            |   1 +
 arch/arm/mach-s3c24xx/include/mach/gpio.h          | 114 ---------------------
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |   1 +
 arch/arm/mach-s3c24xx/mach-anubis.c                |   1 +
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   1 +
 arch/arm/mach-s3c24xx/mach-bast.c                  |   1 +
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   1 +
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   1 +
 arch/arm/mach-s3c24xx/mach-jive.c                  |   1 +
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   1 +
 arch/arm/mach-s3c24xx/mach-n30.c                   |   1 +
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |   1 +
 arch/arm/mach-s3c24xx/mach-osiris.c                |   1 +
 arch/arm/mach-s3c24xx/mach-qt2410.c                |   1 +
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   1 +
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   1 +
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |   1 +
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |   1 +
 arch/arm/mach-s3c24xx/mach-vr1000.c                |   1 +
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 |   1 +
 arch/arm/mach-s3c24xx/pm.c                         |   1 +
 arch/arm/mach-s3c24xx/s3c2410.c                    |   1 +
 arch/arm/mach-s3c24xx/s3c2416.c                    |   1 +
 arch/arm/mach-s3c24xx/s3c2440.c                    |   1 +
 arch/arm/mach-s3c24xx/s3c2442.c                    |   1 +
 arch/arm/mach-s3c24xx/s3c2443.c                    |   1 +
 arch/arm/mach-s3c24xx/setup-i2c.c                  |   1 +
 arch/arm/mach-s3c24xx/setup-sdhci-gpio.c           |   1 +
 arch/arm/mach-s3c24xx/setup-ts.c                   |   1 +
 arch/arm/mach-s3c24xx/simtec-usb.c                 |   1 +
 arch/arm/plat-samsung/pm-gpio.c                    |   1 +
 arch/arm/plat-samsung/setup-camif.c                |   1 +
 drivers/gpio/gpio-samsung.c                        |   1 +
 drivers/mmc/host/s3cmci.c                          |   1 +
 include/linux/platform_data/gpio-samsung-s3c24xx.h | 106 +++++++++++++++++++
 38 files changed, 141 insertions(+), 138 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/gpio.h
 create mode 100644 include/linux/platform_data/gpio-samsung-s3c24xx.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7eee953..6a26bcb3a63a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -710,7 +710,6 @@ config ARCH_S3C24XX
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	select SAMSUNG_ATAGS
 	help
@@ -1593,7 +1592,7 @@ config ARM_PSCI
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX
+	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX || ARCH_S3C24XX
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 8f1d327e0cd1..d876431d64c0 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -180,27 +180,6 @@ config CPU_LLSERIAL_S3C2440
 	  Selected if there is an S3C2440 (or register compatible) serial
 	  low-level implementation needed
 
-# gpio configurations
-
-config S3C24XX_GPIO_EXTRA
-	int
-	default 128 if S3C24XX_GPIO_EXTRA128
-	default 64 if S3C24XX_GPIO_EXTRA64
-	default 16 if ARCH_H1940
-	default 0
-
-config S3C24XX_GPIO_EXTRA64
-	bool
-	help
-	  Add an extra 64 gpio numbers to the available GPIO pool. This is
-	  available for boards that need extra gpios for external devices.
-
-config S3C24XX_GPIO_EXTRA128
-	bool
-	help
-	  Add an extra 128 gpio numbers to the available GPIO pool. This is
-	  available for boards that need extra gpios for external devices.
-
 config S3C24XX_PLL
 	bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
 	depends on ARM_S3C24XX_CPUFREQ
diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 404444dd3840..0a84a9c9f429 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -38,7 +38,7 @@
 
 #include <mach/regs-gpio.h>
 #include <linux/platform_data/leds-s3c24xx.h>
-
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index 5b98bfd1df43..f2b859f4c894 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -18,6 +18,7 @@
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio.h b/arch/arm/mach-s3c24xx/include/mach/gpio.h
deleted file mode 100644
index 14591563ca70..000000000000
--- a/arch/arm/mach-s3c24xx/include/mach/gpio.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/*
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* some boards require extra gpio capacity to support external
- * devices that need GPIO.
- */
-
-#ifndef __MACH_GPIO_H
-#define __MACH_GPIO_H __FILE__
-
-#ifdef CONFIG_CPU_S3C244X
-#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
-#else
-#define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
-#endif
-
-/*
- * GPIO sizes for various SoCs:
- *
- *   2410 2412 2440 2443 2416
- *             2442
- *   ---- ---- ---- ---- ----
- * A  23   22   25   16   25
- * B  11   11   11   11   9
- * C  16   15   16   16   16
- * D  16   16   16   16   16
- * E  16   16   16   16   16
- * F  8    8    8    8    8
- * G  16   16   16   16   8
- * H  11   11   9    15   15
- * J  --   --   13   16   --
- * K  --   --   --   --   16
- * L  --   --   --   15   7
- * M  --   --   --   2    2
- */
-
-/* GPIO bank sizes */
-
-#define S3C2410_GPIO_A_NR	(32)
-#define S3C2410_GPIO_B_NR	(32)
-#define S3C2410_GPIO_C_NR	(32)
-#define S3C2410_GPIO_D_NR	(32)
-#define S3C2410_GPIO_E_NR	(32)
-#define S3C2410_GPIO_F_NR	(32)
-#define S3C2410_GPIO_G_NR	(32)
-#define S3C2410_GPIO_H_NR	(32)
-#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
-#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
-
-#if CONFIG_S3C_GPIO_SPACE != 0
-#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
-#endif
-
-#define S3C2410_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
-
-#ifndef __ASSEMBLY__
-
-enum s3c_gpio_number {
-	S3C2410_GPIO_A_START = 0,
-	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
-	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
-	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
-	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
-	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
-	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
-	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
-	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
-	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
-	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
-	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
-};
-
-#endif /* __ASSEMBLY__ */
-
-/* S3C2410 GPIO number definitions. */
-
-#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
-#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
-#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
-#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
-#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
-#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
-#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
-#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
-#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
-#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
-#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
-#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
-
-#include <plat/gpio-cfg.h>
-
-#ifdef CONFIG_CPU_S3C244X
-#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
-#else
-#define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
-#endif
-
-#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index e27b5c91b3db..530e9a624466 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -54,6 +54,7 @@
 #include <mach/regs-gpio.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index c1fb6c37867f..b60a248c033a 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -37,6 +37,7 @@
 #include <mach/regs-lcd.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 6dfeeb7ef469..74401196b429 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -38,6 +38,7 @@
 #include <mach/regs-lcd.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 22d6ae926d91..47fe7af87129 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -35,6 +35,7 @@
 #include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <net/ax88796.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 13d8d073675a..c2c2ac78cea8 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -70,6 +70,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/fb.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 952b6a040d1f..d25d8b18512c 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -46,6 +46,7 @@
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <sound/uda1380.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 43c23e220f5b..434dbf231773 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -34,6 +34,7 @@
 #include <plat/regs-serial.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 4a18d49a63e0..48af11fc15fd 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -46,6 +46,7 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 2cb46c37c920..7fcb887f5289 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -42,6 +42,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/regs-serial.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 01f4354206f9..0f27ac44db09 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -39,6 +39,7 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 58d6fbe5bf1f..040b16aff93d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -33,6 +33,7 @@
 
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index f8feaeadb55a..96c3bc858710 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -54,6 +54,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 034b7fe45c49..d492fb938bbb 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -45,6 +45,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <sound/uda1380.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 3bc6231d0a1f..319ed8033475 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -35,6 +35,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index c9d31ef28dd1..86e25012b0c1 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -39,6 +39,7 @@
 
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <mach/fb.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index f88e672ad1e4..0cc691d01d60 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -41,6 +41,7 @@
 
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 42e7187fed60..86e7ffdca33f 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -37,6 +37,7 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index 2d82c4f116cd..e4cd56e8b90b 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -28,6 +28,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index caa5b7211380..2baa887b28d2 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -34,6 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/regs-serial.h>
 #include <mach/regs-clock.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 34676d1d5fec..db22f748ce8d 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 9ef3ccfbe196..cb77880029f7 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -36,6 +36,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index 5f9d6569475d..22e5dbdcbe8d 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 6819961f6b19..4ba093b4e495 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -35,6 +35,7 @@
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
 #include <linux/atomic.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index b6c71918b25c..faa1086924c4 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/setup-i2c.c b/arch/arm/mach-s3c24xx/setup-i2c.c
index 7b4f33332d19..3d1fd5ce24e5 100644
--- a/arch/arm/mach-s3c24xx/setup-i2c.c
+++ b/arch/arm/mach-s3c24xx/setup-i2c.c
@@ -17,6 +17,7 @@ struct platform_device;
 
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 
diff --git a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
index f65cb3ef16ce..2835241f732a 100644
--- a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/regs-gpio.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
index 4e11affce3a8..1ea4056f6fdc 100644
--- a/arch/arm/mach-s3c24xx/setup-ts.c
+++ b/arch/arm/mach-s3c24xx/setup-ts.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 struct platform_device; /* don't need the contents */
 
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index 2ed2e32430dc..a007e5f16583 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -32,6 +32,7 @@
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/devs.h>
 
 #include "bast.h"
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index a8de3cfe2ee1..bfc82be6d9f7 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/gpio-core.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/plat-samsung/setup-camif.c b/arch/arm/plat-samsung/setup-camif.c
index e01bf760af2c..70cf503c9a6b 100644
--- a/arch/arm/plat-samsung/setup-camif.c
+++ b/arch/arm/plat-samsung/setup-camif.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/gpio-cfg.h>
 
 /* Number of camera port pins, without FIELD */
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 76e02b9460e6..6258262bfeeb 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/of_address.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/irq.h>
 
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2fce5ea5eb39..11ba3cbb0951 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -26,6 +26,7 @@
 #include <mach/dma.h>
 
 #include <linux/platform_data/mmc-s3cmci.h>
+#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include "s3cmci.h"
 
diff --git a/include/linux/platform_data/gpio-samsung-s3c24xx.h b/include/linux/platform_data/gpio-samsung-s3c24xx.h
new file mode 100644
index 000000000000..6604efe4f67c
--- /dev/null
+++ b/include/linux/platform_data/gpio-samsung-s3c24xx.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H __FILE__
+
+/*
+ * GPIO sizes for various SoCs:
+ *
+ *   2410 2412 2440 2443 2416
+ *             2442
+ *   ---- ---- ---- ---- ----
+ * A  23   22   25   16   25
+ * B  11   11   11   11   9
+ * C  16   15   16   16   16
+ * D  16   16   16   16   16
+ * E  16   16   16   16   16
+ * F  8    8    8    8    8
+ * G  16   16   16   16   8
+ * H  11   11   9    15   15
+ * J  --   --   13   16   --
+ * K  --   --   --   --   16
+ * L  --   --   --   15   7
+ * M  --   --   --   2    2
+ */
+
+/* GPIO bank sizes */
+
+#define S3C2410_GPIO_A_NR	(32)
+#define S3C2410_GPIO_B_NR	(32)
+#define S3C2410_GPIO_C_NR	(32)
+#define S3C2410_GPIO_D_NR	(32)
+#define S3C2410_GPIO_E_NR	(32)
+#define S3C2410_GPIO_F_NR	(32)
+#define S3C2410_GPIO_G_NR	(32)
+#define S3C2410_GPIO_H_NR	(32)
+#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
+#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
+
+#if CONFIG_S3C_GPIO_SPACE != 0
+#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
+#endif
+
+#define S3C2410_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
+
+#ifndef __ASSEMBLY__
+
+enum s3c_gpio_number {
+	S3C2410_GPIO_A_START = 0,
+	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
+	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
+	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
+	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
+	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
+	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
+	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
+	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
+	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
+	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
+	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
+};
+
+#endif /* __ASSEMBLY__ */
+
+/* S3C2410 GPIO number definitions. */
+
+#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
+#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
+#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
+#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
+#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
+#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
+#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
+#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
+#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
+#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
+#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
+#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
+
+#include <plat/gpio-cfg.h>
+
+#ifdef CONFIG_CPU_S3C244X
+#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
+#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+#define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
+#else
+#define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
+#endif
+
+#endif /* __MACH_GPIO_H */
-- 
1.8.3.1
