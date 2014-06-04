From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jun 2014 15:33:56 +0200
Subject: [PATCH 2/4] ARM: mach-s5p: get rid of all <mach/gpio.h> headers
In-Reply-To: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1401888838-3126-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This renames all the local <mach/gpio.h> headers in the S5P platforms
to <mach/gpio-samsung.h> indicating a scope local to this platform,
and cuts the implicit inclusion of <mach/gpio.h> from <linux/gpio.h>
by removing the use of NEED_MACH_GPIO_H from all S5P variants.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                  |   3 -
 arch/arm/mach-s5p64x0/common.c                    |   2 +-
 arch/arm/mach-s5p64x0/dev-audio.c                 |   3 +-
 arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h | 127 +++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/gpio.h         | 128 --------------------
 arch/arm/mach-s5p64x0/mach-smdk6440.c             |   1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c             |   1 +
 arch/arm/mach-s5p64x0/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5p64x0/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5p64x0/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5p64x0/setup-spi.c                 |   2 +-
 arch/arm/mach-s5pc100/dev-audio.c                 |   2 +-
 arch/arm/mach-s5pc100/include/mach/gpio-samsung.h | 140 +++++++++++++++++++++
 arch/arm/mach-s5pc100/include/mach/gpio.h         | 141 ----------------------
 arch/arm/mach-s5pc100/mach-smdkc100.c             |   1 +
 arch/arm/mach-s5pc100/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5pc100/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5pc100/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5pc100/setup-ide.c                 |   2 +-
 arch/arm/mach-s5pc100/setup-keypad.c              |   2 +-
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5pc100/setup-spi.c                 |   2 +-
 arch/arm/mach-s5pv210/dev-audio.c                 |   2 +-
 arch/arm/mach-s5pv210/include/mach/gpio-samsung.h | 135 +++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h         | 136 ---------------------
 arch/arm/mach-s5pv210/mach-aquila.c               |   1 +
 arch/arm/mach-s5pv210/mach-goni.c                 |   1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c             |   1 +
 arch/arm/mach-s5pv210/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5pv210/setup-fimc.c                |   3 +-
 arch/arm/mach-s5pv210/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5pv210/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5pv210/setup-i2c2.c                |   2 +-
 arch/arm/mach-s5pv210/setup-ide.c                 |   2 +-
 arch/arm/mach-s5pv210/setup-keypad.c              |   2 +-
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5pv210/setup-spi.c                 |   2 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h    |   3 +
 arch/arm/plat-samsung/pm-gpio.c                   |   2 -
 arch/arm/plat-samsung/s5p-irq-eint.c              |   2 +-
 drivers/gpio/gpio-samsung.c                       |   3 -
 sound/soc/samsung/goni_wm8994.c                   |   2 +-
 43 files changed, 440 insertions(+), 440 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pc100/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 692399cc1170..72f74f67bf72 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -783,7 +783,6 @@ config ARCH_S5P64X0
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
 	select SAMSUNG_ATAGS
 	select SAMSUNG_WDT_RESET
 	help
@@ -802,7 +801,6 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
 	select SAMSUNG_ATAGS
 	select SAMSUNG_WDT_RESET
 	help
@@ -822,7 +820,6 @@ config ARCH_S5PV210
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	select SAMSUNG_ATAGS
 	help
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 9a43be002d78..b56ffbd7cefe 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -24,7 +24,6 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/reboot.h>
 
@@ -39,6 +38,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index 723d4773c323..ea4a22822595 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -10,7 +10,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/asoc-s3c.h>
@@ -18,6 +17,8 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
+#include <mach/gpio-samsung.h>
+
 
 static int s5p6440_cfg_i2s(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h b/arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..fec01a4e6463
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h
@@ -0,0 +1,127 @@
+/*
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+/* GPIO bank sizes */
+
+#define S5P6440_GPIO_A_NR	(6)
+#define S5P6440_GPIO_B_NR	(7)
+#define S5P6440_GPIO_C_NR	(8)
+#define S5P6440_GPIO_F_NR	(16)
+#define S5P6440_GPIO_G_NR	(7)
+#define S5P6440_GPIO_H_NR	(10)
+#define S5P6440_GPIO_I_NR	(16)
+#define S5P6440_GPIO_J_NR	(12)
+#define S5P6440_GPIO_N_NR	(16)
+#define S5P6440_GPIO_P_NR	(8)
+#define S5P6440_GPIO_R_NR	(15)
+
+#define S5P6450_GPIO_A_NR	(6)
+#define S5P6450_GPIO_B_NR	(7)
+#define S5P6450_GPIO_C_NR	(8)
+#define S5P6450_GPIO_D_NR	(8)
+#define S5P6450_GPIO_F_NR	(16)
+#define S5P6450_GPIO_G_NR	(14)
+#define S5P6450_GPIO_H_NR	(10)
+#define S5P6450_GPIO_I_NR	(16)
+#define S5P6450_GPIO_J_NR	(12)
+#define S5P6450_GPIO_K_NR	(5)
+#define S5P6450_GPIO_N_NR	(16)
+#define S5P6450_GPIO_P_NR	(11)
+#define S5P6450_GPIO_Q_NR	(14)
+#define S5P6450_GPIO_R_NR	(15)
+#define S5P6450_GPIO_S_NR	(8)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5P64X0_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p6440_gpio_number {
+	S5P6440_GPIO_A_START	= 0,
+	S5P6440_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_A),
+	S5P6440_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_B),
+	S5P6440_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_C),
+	S5P6440_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_F),
+	S5P6440_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_G),
+	S5P6440_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_H),
+	S5P6440_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_I),
+	S5P6440_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_J),
+	S5P6440_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_N),
+	S5P6440_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_P),
+};
+
+enum s5p6450_gpio_number {
+	S5P6450_GPIO_A_START	= 0,
+	S5P6450_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_A),
+	S5P6450_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_B),
+	S5P6450_GPIO_D_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_C),
+	S5P6450_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_D),
+	S5P6450_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_F),
+	S5P6450_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_G),
+	S5P6450_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_H),
+	S5P6450_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_I),
+	S5P6450_GPIO_K_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_J),
+	S5P6450_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_K),
+	S5P6450_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_N),
+	S5P6450_GPIO_Q_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_P),
+	S5P6450_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_Q),
+	S5P6450_GPIO_S_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_R),
+};
+
+/* GPIO number definitions */
+
+#define S5P6440_GPA(_nr)	(S5P6440_GPIO_A_START + (_nr))
+#define S5P6440_GPB(_nr)	(S5P6440_GPIO_B_START + (_nr))
+#define S5P6440_GPC(_nr)	(S5P6440_GPIO_C_START + (_nr))
+#define S5P6440_GPF(_nr)	(S5P6440_GPIO_F_START + (_nr))
+#define S5P6440_GPG(_nr)	(S5P6440_GPIO_G_START + (_nr))
+#define S5P6440_GPH(_nr)	(S5P6440_GPIO_H_START + (_nr))
+#define S5P6440_GPI(_nr)	(S5P6440_GPIO_I_START + (_nr))
+#define S5P6440_GPJ(_nr)	(S5P6440_GPIO_J_START + (_nr))
+#define S5P6440_GPN(_nr)	(S5P6440_GPIO_N_START + (_nr))
+#define S5P6440_GPP(_nr)	(S5P6440_GPIO_P_START + (_nr))
+#define S5P6440_GPR(_nr)	(S5P6440_GPIO_R_START + (_nr))
+
+#define S5P6450_GPA(_nr)	(S5P6450_GPIO_A_START + (_nr))
+#define S5P6450_GPB(_nr)	(S5P6450_GPIO_B_START + (_nr))
+#define S5P6450_GPC(_nr)	(S5P6450_GPIO_C_START + (_nr))
+#define S5P6450_GPD(_nr)	(S5P6450_GPIO_D_START + (_nr))
+#define S5P6450_GPF(_nr)	(S5P6450_GPIO_F_START + (_nr))
+#define S5P6450_GPG(_nr)	(S5P6450_GPIO_G_START + (_nr))
+#define S5P6450_GPH(_nr)	(S5P6450_GPIO_H_START + (_nr))
+#define S5P6450_GPI(_nr)	(S5P6450_GPIO_I_START + (_nr))
+#define S5P6450_GPJ(_nr)	(S5P6450_GPIO_J_START + (_nr))
+#define S5P6450_GPK(_nr)	(S5P6450_GPIO_K_START + (_nr))
+#define S5P6450_GPN(_nr)	(S5P6450_GPIO_N_START + (_nr))
+#define S5P6450_GPP(_nr)	(S5P6450_GPIO_P_START + (_nr))
+#define S5P6450_GPQ(_nr)	(S5P6450_GPIO_Q_START + (_nr))
+#define S5P6450_GPR(_nr)	(S5P6450_GPIO_R_START + (_nr))
+#define S5P6450_GPS(_nr)	(S5P6450_GPIO_S_START + (_nr))
+
+/* the end of the S5P64X0 specific gpios */
+
+#define S5P6440_GPIO_END	(S5P6440_GPR(S5P6440_GPIO_R_NR) + 1)
+#define S5P6450_GPIO_END	(S5P6450_GPS(S5P6450_GPIO_S_NR) + 1)
+
+#define S5P64X0_GPIO_END	(S5P6440_GPIO_END > S5P6450_GPIO_END ?	\
+				 S5P6440_GPIO_END : S5P6450_GPIO_END)
+
+#define S3C_GPIO_END		S5P64X0_GPIO_END
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
deleted file mode 100644
index cbd325e14477..000000000000
--- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/gpio.h
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P64X0 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-/* GPIO bank sizes */
-
-#define S5P6440_GPIO_A_NR	(6)
-#define S5P6440_GPIO_B_NR	(7)
-#define S5P6440_GPIO_C_NR	(8)
-#define S5P6440_GPIO_F_NR	(16)
-#define S5P6440_GPIO_G_NR	(7)
-#define S5P6440_GPIO_H_NR	(10)
-#define S5P6440_GPIO_I_NR	(16)
-#define S5P6440_GPIO_J_NR	(12)
-#define S5P6440_GPIO_N_NR	(16)
-#define S5P6440_GPIO_P_NR	(8)
-#define S5P6440_GPIO_R_NR	(15)
-
-#define S5P6450_GPIO_A_NR	(6)
-#define S5P6450_GPIO_B_NR	(7)
-#define S5P6450_GPIO_C_NR	(8)
-#define S5P6450_GPIO_D_NR	(8)
-#define S5P6450_GPIO_F_NR	(16)
-#define S5P6450_GPIO_G_NR	(14)
-#define S5P6450_GPIO_H_NR	(10)
-#define S5P6450_GPIO_I_NR	(16)
-#define S5P6450_GPIO_J_NR	(12)
-#define S5P6450_GPIO_K_NR	(5)
-#define S5P6450_GPIO_N_NR	(16)
-#define S5P6450_GPIO_P_NR	(11)
-#define S5P6450_GPIO_Q_NR	(14)
-#define S5P6450_GPIO_R_NR	(15)
-#define S5P6450_GPIO_S_NR	(8)
-
-/* GPIO bank numbers */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-
-#define S5P64X0_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p6440_gpio_number {
-	S5P6440_GPIO_A_START	= 0,
-	S5P6440_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_A),
-	S5P6440_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_B),
-	S5P6440_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_C),
-	S5P6440_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_F),
-	S5P6440_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_G),
-	S5P6440_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_H),
-	S5P6440_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_I),
-	S5P6440_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_J),
-	S5P6440_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_N),
-	S5P6440_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_P),
-};
-
-enum s5p6450_gpio_number {
-	S5P6450_GPIO_A_START	= 0,
-	S5P6450_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_A),
-	S5P6450_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_B),
-	S5P6450_GPIO_D_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_C),
-	S5P6450_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_D),
-	S5P6450_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_F),
-	S5P6450_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_G),
-	S5P6450_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_H),
-	S5P6450_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_I),
-	S5P6450_GPIO_K_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_J),
-	S5P6450_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_K),
-	S5P6450_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_N),
-	S5P6450_GPIO_Q_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_P),
-	S5P6450_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_Q),
-	S5P6450_GPIO_S_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_R),
-};
-
-/* GPIO number definitions */
-
-#define S5P6440_GPA(_nr)	(S5P6440_GPIO_A_START + (_nr))
-#define S5P6440_GPB(_nr)	(S5P6440_GPIO_B_START + (_nr))
-#define S5P6440_GPC(_nr)	(S5P6440_GPIO_C_START + (_nr))
-#define S5P6440_GPF(_nr)	(S5P6440_GPIO_F_START + (_nr))
-#define S5P6440_GPG(_nr)	(S5P6440_GPIO_G_START + (_nr))
-#define S5P6440_GPH(_nr)	(S5P6440_GPIO_H_START + (_nr))
-#define S5P6440_GPI(_nr)	(S5P6440_GPIO_I_START + (_nr))
-#define S5P6440_GPJ(_nr)	(S5P6440_GPIO_J_START + (_nr))
-#define S5P6440_GPN(_nr)	(S5P6440_GPIO_N_START + (_nr))
-#define S5P6440_GPP(_nr)	(S5P6440_GPIO_P_START + (_nr))
-#define S5P6440_GPR(_nr)	(S5P6440_GPIO_R_START + (_nr))
-
-#define S5P6450_GPA(_nr)	(S5P6450_GPIO_A_START + (_nr))
-#define S5P6450_GPB(_nr)	(S5P6450_GPIO_B_START + (_nr))
-#define S5P6450_GPC(_nr)	(S5P6450_GPIO_C_START + (_nr))
-#define S5P6450_GPD(_nr)	(S5P6450_GPIO_D_START + (_nr))
-#define S5P6450_GPF(_nr)	(S5P6450_GPIO_F_START + (_nr))
-#define S5P6450_GPG(_nr)	(S5P6450_GPIO_G_START + (_nr))
-#define S5P6450_GPH(_nr)	(S5P6450_GPIO_H_START + (_nr))
-#define S5P6450_GPI(_nr)	(S5P6450_GPIO_I_START + (_nr))
-#define S5P6450_GPJ(_nr)	(S5P6450_GPIO_J_START + (_nr))
-#define S5P6450_GPK(_nr)	(S5P6450_GPIO_K_START + (_nr))
-#define S5P6450_GPN(_nr)	(S5P6450_GPIO_N_START + (_nr))
-#define S5P6450_GPP(_nr)	(S5P6450_GPIO_P_START + (_nr))
-#define S5P6450_GPQ(_nr)	(S5P6450_GPIO_Q_START + (_nr))
-#define S5P6450_GPR(_nr)	(S5P6450_GPIO_R_START + (_nr))
-#define S5P6450_GPS(_nr)	(S5P6450_GPIO_S_START + (_nr))
-
-/* the end of the S5P64X0 specific gpios */
-
-#define S5P6440_GPIO_END	(S5P6440_GPR(S5P6440_GPIO_R_NR) + 1)
-#define S5P6450_GPIO_END	(S5P6450_GPS(S5P6450_GPIO_S_NR) + 1)
-
-#define S5P64X0_GPIO_END	(S5P6440_GPIO_END > S5P6450_GPIO_END ?	\
-				 S5P6440_GPIO_END : S5P6450_GPIO_END)
-
-#define S3C_GPIO_END		S5P64X0_GPIO_END
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 6840e197cb2d..037318867459 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -39,6 +39,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index fa1341c074ca..e191d9019beb 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -39,6 +39,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s5p64x0/setup-fb-24bpp.c b/arch/arm/mach-s5p64x0/setup-fb-24bpp.c
index f346ee4af54d..37252bece7d4 100644
--- a/arch/arm/mach-s5p64x0/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5p64x0/setup-fb-24bpp.c
@@ -11,11 +11,11 @@
 */
 
 #include <linux/fb.h>
-#include <linux/gpio.h>
 
 #include <plat/cpu.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s5p64x0_fb_gpio_setup_24bpp(void)
 {
diff --git a/arch/arm/mach-s5p64x0/setup-i2c0.c b/arch/arm/mach-s5p64x0/setup-i2c0.c
index 569b76ac98cb..7589eb33624e 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c0.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c0.c
@@ -14,11 +14,11 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include "i2c.h"
diff --git a/arch/arm/mach-s5p64x0/setup-i2c1.c b/arch/arm/mach-s5p64x0/setup-i2c1.c
index 867374e6d0bc..f7a949b3bc55 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c1.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c1.c
@@ -14,11 +14,11 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include "i2c.h"
diff --git a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
index 8410af0d12bf..c09c5834e2fd 100644
--- a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
@@ -12,10 +12,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
index 7664356720ca..d19d1102e28c 100644
--- a/arch/arm/mach-s5p64x0/setup-spi.c
+++ b/arch/arm/mach-s5p64x0/setup-spi.c
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 46f488b09391..d24f653cc0cf 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -10,7 +10,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/asoc-s3c.h>
@@ -18,6 +17,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
+#include <mach/gpio-samsung.h>
 
 static int s5pc100_cfg_i2s(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio-samsung.h b/arch/arm/mach-s5pc100/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..fa239e9378f1
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/gpio-samsung.h
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - GPIO lib support
+ *
+ * Base on mach-s3c6400/include/mach/gpio.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+/* GPIO bank sizes */
+#define S5PC100_GPIO_A0_NR	(8)
+#define S5PC100_GPIO_A1_NR	(5)
+#define S5PC100_GPIO_B_NR	(8)
+#define S5PC100_GPIO_C_NR	(5)
+#define S5PC100_GPIO_D_NR	(7)
+#define S5PC100_GPIO_E0_NR	(8)
+#define S5PC100_GPIO_E1_NR	(6)
+#define S5PC100_GPIO_F0_NR	(8)
+#define S5PC100_GPIO_F1_NR	(8)
+#define S5PC100_GPIO_F2_NR	(8)
+#define S5PC100_GPIO_F3_NR	(4)
+#define S5PC100_GPIO_G0_NR	(8)
+#define S5PC100_GPIO_G1_NR	(3)
+#define S5PC100_GPIO_G2_NR	(7)
+#define S5PC100_GPIO_G3_NR	(7)
+#define S5PC100_GPIO_H0_NR	(8)
+#define S5PC100_GPIO_H1_NR	(8)
+#define S5PC100_GPIO_H2_NR	(8)
+#define S5PC100_GPIO_H3_NR	(8)
+#define S5PC100_GPIO_I_NR	(8)
+#define S5PC100_GPIO_J0_NR	(8)
+#define S5PC100_GPIO_J1_NR	(5)
+#define S5PC100_GPIO_J2_NR	(8)
+#define S5PC100_GPIO_J3_NR	(8)
+#define S5PC100_GPIO_J4_NR	(4)
+#define S5PC100_GPIO_K0_NR	(8)
+#define S5PC100_GPIO_K1_NR	(6)
+#define S5PC100_GPIO_K2_NR	(8)
+#define S5PC100_GPIO_K3_NR	(8)
+#define S5PC100_GPIO_L0_NR	(8)
+#define S5PC100_GPIO_L1_NR	(8)
+#define S5PC100_GPIO_L2_NR	(8)
+#define S5PC100_GPIO_L3_NR	(8)
+#define S5PC100_GPIO_L4_NR	(8)
+
+/* GPIO bank numbes */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5PC100_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5PC100_GPIO_A0_START	= 0,
+	S5PC100_GPIO_A1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_A0),
+	S5PC100_GPIO_B_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_A1),
+	S5PC100_GPIO_C_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_B),
+	S5PC100_GPIO_D_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_C),
+	S5PC100_GPIO_E0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_D),
+	S5PC100_GPIO_E1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_E0),
+	S5PC100_GPIO_F0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_E1),
+	S5PC100_GPIO_F1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F0),
+	S5PC100_GPIO_F2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F1),
+	S5PC100_GPIO_F3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F2),
+	S5PC100_GPIO_G0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F3),
+	S5PC100_GPIO_G1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G0),
+	S5PC100_GPIO_G2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G1),
+	S5PC100_GPIO_G3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G2),
+	S5PC100_GPIO_H0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G3),
+	S5PC100_GPIO_H1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H0),
+	S5PC100_GPIO_H2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H1),
+	S5PC100_GPIO_H3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H2),
+	S5PC100_GPIO_I_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H3),
+	S5PC100_GPIO_J0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_I),
+	S5PC100_GPIO_J1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J0),
+	S5PC100_GPIO_J2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J1),
+	S5PC100_GPIO_J3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J2),
+	S5PC100_GPIO_J4_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J3),
+	S5PC100_GPIO_K0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J4),
+	S5PC100_GPIO_K1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K0),
+	S5PC100_GPIO_K2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K1),
+	S5PC100_GPIO_K3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K2),
+	S5PC100_GPIO_L0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K3),
+	S5PC100_GPIO_L1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L0),
+	S5PC100_GPIO_L2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L1),
+	S5PC100_GPIO_L3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L2),
+	S5PC100_GPIO_L4_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L3),
+	S5PC100_GPIO_END	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L4),
+};
+
+/* S5PC100 GPIO number definitions. */
+#define S5PC100_GPA0(_nr)	(S5PC100_GPIO_A0_START + (_nr))
+#define S5PC100_GPA1(_nr)	(S5PC100_GPIO_A1_START + (_nr))
+#define S5PC100_GPB(_nr)	(S5PC100_GPIO_B_START + (_nr))
+#define S5PC100_GPC(_nr)	(S5PC100_GPIO_C_START + (_nr))
+#define S5PC100_GPD(_nr)	(S5PC100_GPIO_D_START + (_nr))
+#define S5PC100_GPE0(_nr)	(S5PC100_GPIO_E0_START + (_nr))
+#define S5PC100_GPE1(_nr)	(S5PC100_GPIO_E1_START + (_nr))
+#define S5PC100_GPF0(_nr)	(S5PC100_GPIO_F0_START + (_nr))
+#define S5PC100_GPF1(_nr)	(S5PC100_GPIO_F1_START + (_nr))
+#define S5PC100_GPF2(_nr)	(S5PC100_GPIO_F2_START + (_nr))
+#define S5PC100_GPF3(_nr)	(S5PC100_GPIO_F3_START + (_nr))
+#define S5PC100_GPG0(_nr)	(S5PC100_GPIO_G0_START + (_nr))
+#define S5PC100_GPG1(_nr)	(S5PC100_GPIO_G1_START + (_nr))
+#define S5PC100_GPG2(_nr)	(S5PC100_GPIO_G2_START + (_nr))
+#define S5PC100_GPG3(_nr)	(S5PC100_GPIO_G3_START + (_nr))
+#define S5PC100_GPH0(_nr)	(S5PC100_GPIO_H0_START + (_nr))
+#define S5PC100_GPH1(_nr)	(S5PC100_GPIO_H1_START + (_nr))
+#define S5PC100_GPH2(_nr)	(S5PC100_GPIO_H2_START + (_nr))
+#define S5PC100_GPH3(_nr)	(S5PC100_GPIO_H3_START + (_nr))
+#define S5PC100_GPI(_nr)	(S5PC100_GPIO_I_START + (_nr))
+#define S5PC100_GPJ0(_nr)	(S5PC100_GPIO_J0_START + (_nr))
+#define S5PC100_GPJ1(_nr)	(S5PC100_GPIO_J1_START + (_nr))
+#define S5PC100_GPJ2(_nr)	(S5PC100_GPIO_J2_START + (_nr))
+#define S5PC100_GPJ3(_nr)	(S5PC100_GPIO_J3_START + (_nr))
+#define S5PC100_GPJ4(_nr)	(S5PC100_GPIO_J4_START + (_nr))
+#define S5PC100_GPK0(_nr)	(S5PC100_GPIO_K0_START + (_nr))
+#define S5PC100_GPK1(_nr)	(S5PC100_GPIO_K1_START + (_nr))
+#define S5PC100_GPK2(_nr)	(S5PC100_GPIO_K2_START + (_nr))
+#define S5PC100_GPK3(_nr)	(S5PC100_GPIO_K3_START + (_nr))
+#define S5PC100_GPL0(_nr)	(S5PC100_GPIO_L0_START + (_nr))
+#define S5PC100_GPL1(_nr)	(S5PC100_GPIO_L1_START + (_nr))
+#define S5PC100_GPL2(_nr)	(S5PC100_GPIO_L2_START + (_nr))
+#define S5PC100_GPL3(_nr)	(S5PC100_GPIO_L3_START + (_nr))
+#define S5PC100_GPL4(_nr)	(S5PC100_GPIO_L4_START + (_nr))
+
+/* It used the end of the S5PC100 gpios */
+#define S3C_GPIO_END		S5PC100_GPIO_END
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
deleted file mode 100644
index 291c57504bab..000000000000
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ /dev/null
@@ -1,141 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/gpio.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - GPIO lib support
- *
- * Base on mach-s3c6400/include/mach/gpio.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-/* GPIO bank sizes */
-#define S5PC100_GPIO_A0_NR	(8)
-#define S5PC100_GPIO_A1_NR	(5)
-#define S5PC100_GPIO_B_NR	(8)
-#define S5PC100_GPIO_C_NR	(5)
-#define S5PC100_GPIO_D_NR	(7)
-#define S5PC100_GPIO_E0_NR	(8)
-#define S5PC100_GPIO_E1_NR	(6)
-#define S5PC100_GPIO_F0_NR	(8)
-#define S5PC100_GPIO_F1_NR	(8)
-#define S5PC100_GPIO_F2_NR	(8)
-#define S5PC100_GPIO_F3_NR	(4)
-#define S5PC100_GPIO_G0_NR	(8)
-#define S5PC100_GPIO_G1_NR	(3)
-#define S5PC100_GPIO_G2_NR	(7)
-#define S5PC100_GPIO_G3_NR	(7)
-#define S5PC100_GPIO_H0_NR	(8)
-#define S5PC100_GPIO_H1_NR	(8)
-#define S5PC100_GPIO_H2_NR	(8)
-#define S5PC100_GPIO_H3_NR	(8)
-#define S5PC100_GPIO_I_NR	(8)
-#define S5PC100_GPIO_J0_NR	(8)
-#define S5PC100_GPIO_J1_NR	(5)
-#define S5PC100_GPIO_J2_NR	(8)
-#define S5PC100_GPIO_J3_NR	(8)
-#define S5PC100_GPIO_J4_NR	(4)
-#define S5PC100_GPIO_K0_NR	(8)
-#define S5PC100_GPIO_K1_NR	(6)
-#define S5PC100_GPIO_K2_NR	(8)
-#define S5PC100_GPIO_K3_NR	(8)
-#define S5PC100_GPIO_L0_NR	(8)
-#define S5PC100_GPIO_L1_NR	(8)
-#define S5PC100_GPIO_L2_NR	(8)
-#define S5PC100_GPIO_L3_NR	(8)
-#define S5PC100_GPIO_L4_NR	(8)
-
-/* GPIO bank numbes */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-
-#define S5PC100_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p_gpio_number {
-	S5PC100_GPIO_A0_START	= 0,
-	S5PC100_GPIO_A1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_A0),
-	S5PC100_GPIO_B_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_A1),
-	S5PC100_GPIO_C_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_B),
-	S5PC100_GPIO_D_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_C),
-	S5PC100_GPIO_E0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_D),
-	S5PC100_GPIO_E1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_E0),
-	S5PC100_GPIO_F0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_E1),
-	S5PC100_GPIO_F1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F0),
-	S5PC100_GPIO_F2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F1),
-	S5PC100_GPIO_F3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F2),
-	S5PC100_GPIO_G0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_F3),
-	S5PC100_GPIO_G1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G0),
-	S5PC100_GPIO_G2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G1),
-	S5PC100_GPIO_G3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G2),
-	S5PC100_GPIO_H0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_G3),
-	S5PC100_GPIO_H1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H0),
-	S5PC100_GPIO_H2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H1),
-	S5PC100_GPIO_H3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H2),
-	S5PC100_GPIO_I_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_H3),
-	S5PC100_GPIO_J0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_I),
-	S5PC100_GPIO_J1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J0),
-	S5PC100_GPIO_J2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J1),
-	S5PC100_GPIO_J3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J2),
-	S5PC100_GPIO_J4_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J3),
-	S5PC100_GPIO_K0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_J4),
-	S5PC100_GPIO_K1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K0),
-	S5PC100_GPIO_K2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K1),
-	S5PC100_GPIO_K3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K2),
-	S5PC100_GPIO_L0_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_K3),
-	S5PC100_GPIO_L1_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L0),
-	S5PC100_GPIO_L2_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L1),
-	S5PC100_GPIO_L3_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L2),
-	S5PC100_GPIO_L4_START	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L3),
-	S5PC100_GPIO_END	= S5PC100_GPIO_NEXT(S5PC100_GPIO_L4),
-};
-
-/* S5PC100 GPIO number definitions. */
-#define S5PC100_GPA0(_nr)	(S5PC100_GPIO_A0_START + (_nr))
-#define S5PC100_GPA1(_nr)	(S5PC100_GPIO_A1_START + (_nr))
-#define S5PC100_GPB(_nr)	(S5PC100_GPIO_B_START + (_nr))
-#define S5PC100_GPC(_nr)	(S5PC100_GPIO_C_START + (_nr))
-#define S5PC100_GPD(_nr)	(S5PC100_GPIO_D_START + (_nr))
-#define S5PC100_GPE0(_nr)	(S5PC100_GPIO_E0_START + (_nr))
-#define S5PC100_GPE1(_nr)	(S5PC100_GPIO_E1_START + (_nr))
-#define S5PC100_GPF0(_nr)	(S5PC100_GPIO_F0_START + (_nr))
-#define S5PC100_GPF1(_nr)	(S5PC100_GPIO_F1_START + (_nr))
-#define S5PC100_GPF2(_nr)	(S5PC100_GPIO_F2_START + (_nr))
-#define S5PC100_GPF3(_nr)	(S5PC100_GPIO_F3_START + (_nr))
-#define S5PC100_GPG0(_nr)	(S5PC100_GPIO_G0_START + (_nr))
-#define S5PC100_GPG1(_nr)	(S5PC100_GPIO_G1_START + (_nr))
-#define S5PC100_GPG2(_nr)	(S5PC100_GPIO_G2_START + (_nr))
-#define S5PC100_GPG3(_nr)	(S5PC100_GPIO_G3_START + (_nr))
-#define S5PC100_GPH0(_nr)	(S5PC100_GPIO_H0_START + (_nr))
-#define S5PC100_GPH1(_nr)	(S5PC100_GPIO_H1_START + (_nr))
-#define S5PC100_GPH2(_nr)	(S5PC100_GPIO_H2_START + (_nr))
-#define S5PC100_GPH3(_nr)	(S5PC100_GPIO_H3_START + (_nr))
-#define S5PC100_GPI(_nr)	(S5PC100_GPIO_I_START + (_nr))
-#define S5PC100_GPJ0(_nr)	(S5PC100_GPIO_J0_START + (_nr))
-#define S5PC100_GPJ1(_nr)	(S5PC100_GPIO_J1_START + (_nr))
-#define S5PC100_GPJ2(_nr)	(S5PC100_GPIO_J2_START + (_nr))
-#define S5PC100_GPJ3(_nr)	(S5PC100_GPIO_J3_START + (_nr))
-#define S5PC100_GPJ4(_nr)	(S5PC100_GPIO_J4_START + (_nr))
-#define S5PC100_GPK0(_nr)	(S5PC100_GPIO_K0_START + (_nr))
-#define S5PC100_GPK1(_nr)	(S5PC100_GPIO_K1_START + (_nr))
-#define S5PC100_GPK2(_nr)	(S5PC100_GPIO_K2_START + (_nr))
-#define S5PC100_GPK3(_nr)	(S5PC100_GPIO_K3_START + (_nr))
-#define S5PC100_GPL0(_nr)	(S5PC100_GPIO_L0_START + (_nr))
-#define S5PC100_GPL1(_nr)	(S5PC100_GPIO_L1_START + (_nr))
-#define S5PC100_GPL2(_nr)	(S5PC100_GPIO_L2_START + (_nr))
-#define S5PC100_GPL3(_nr)	(S5PC100_GPIO_L3_START + (_nr))
-#define S5PC100_GPL4(_nr)	(S5PC100_GPIO_L4_START + (_nr))
-
-/* It used the end of the S5PC100 gpios */
-#define S3C_GPIO_END		S5PC100_GPIO_END
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 668af3ac31f3..0710139b52eb 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -31,6 +31,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
index 8978e4cf9ed5..64362e354eba 100644
--- a/arch/arm/mach-s5pc100/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
 
 #include <mach/map.h>
+#include <mach/gpio-samsung.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
diff --git a/arch/arm/mach-s5pc100/setup-i2c0.c b/arch/arm/mach-s5pc100/setup-i2c0.c
index 89a6a769d622..4911bcba3932 100644
--- a/arch/arm/mach-s5pc100/setup-i2c0.c
+++ b/arch/arm/mach-s5pc100/setup-i2c0.c
@@ -17,9 +17,9 @@
 
 struct platform_device; /* don't need the contents */
 
-#include <linux/gpio.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s5pc100/setup-i2c1.c b/arch/arm/mach-s5pc100/setup-i2c1.c
index faa667ef02cb..421e50a88117 100644
--- a/arch/arm/mach-s5pc100/setup-i2c1.c
+++ b/arch/arm/mach-s5pc100/setup-i2c1.c
@@ -17,9 +17,9 @@
 
 struct platform_device; /* don't need the contents */
 
-#include <linux/gpio.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s5pc100/setup-ide.c b/arch/arm/mach-s5pc100/setup-ide.c
index 223aae044466..22470793b33b 100644
--- a/arch/arm/mach-s5pc100/setup-ide.c
+++ b/arch/arm/mach-s5pc100/setup-ide.c
@@ -11,11 +11,11 @@
 */
 
 #include <linux/kernel.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
 
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 static void s5pc100_ide_cfg_gpios(unsigned int base, unsigned int nr)
 {
diff --git a/arch/arm/mach-s5pc100/setup-keypad.c b/arch/arm/mach-s5pc100/setup-keypad.c
index ada377f0c206..57dc9d3219dc 100644
--- a/arch/arm/mach-s5pc100/setup-keypad.c
+++ b/arch/arm/mach-s5pc100/setup-keypad.c
@@ -10,8 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index 6010c0310cb5..c5b4ca0e5217 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -14,12 +14,12 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/sdhci.h>
+#include <mach/gpio-samsung.h>
 
 void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
index 183567961de1..1bb26657b513 100644
--- a/arch/arm/mach-s5pc100/setup-spi.c
+++ b/arch/arm/mach-s5pc100/setup-spi.c
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 2d67361ef431..90356ad10c54 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -10,7 +10,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/asoc-s3c.h>
@@ -18,6 +17,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
+#include <mach/gpio-samsung.h>
 
 #define S5PV210_AUDSS_INT_MEM	(0xC0000000)
 
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio-samsung.h b/arch/arm/mach-s5pv210/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..e193b891e7b2
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/gpio-samsung.h
@@ -0,0 +1,135 @@
+/*
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+/* Practically, GPIO banks up to MP03 are the configurable gpio banks */
+
+/* GPIO bank sizes */
+#define S5PV210_GPIO_A0_NR	(8)
+#define S5PV210_GPIO_A1_NR	(4)
+#define S5PV210_GPIO_B_NR	(8)
+#define S5PV210_GPIO_C0_NR	(5)
+#define S5PV210_GPIO_C1_NR	(5)
+#define S5PV210_GPIO_D0_NR	(4)
+#define S5PV210_GPIO_D1_NR	(6)
+#define S5PV210_GPIO_E0_NR	(8)
+#define S5PV210_GPIO_E1_NR	(5)
+#define S5PV210_GPIO_F0_NR	(8)
+#define S5PV210_GPIO_F1_NR	(8)
+#define S5PV210_GPIO_F2_NR	(8)
+#define S5PV210_GPIO_F3_NR	(6)
+#define S5PV210_GPIO_G0_NR	(7)
+#define S5PV210_GPIO_G1_NR	(7)
+#define S5PV210_GPIO_G2_NR	(7)
+#define S5PV210_GPIO_G3_NR	(7)
+#define S5PV210_GPIO_H0_NR	(8)
+#define S5PV210_GPIO_H1_NR	(8)
+#define S5PV210_GPIO_H2_NR	(8)
+#define S5PV210_GPIO_H3_NR	(8)
+#define S5PV210_GPIO_I_NR	(7)
+#define S5PV210_GPIO_J0_NR	(8)
+#define S5PV210_GPIO_J1_NR	(6)
+#define S5PV210_GPIO_J2_NR	(8)
+#define S5PV210_GPIO_J3_NR	(8)
+#define S5PV210_GPIO_J4_NR	(5)
+
+#define S5PV210_GPIO_MP01_NR	(8)
+#define S5PV210_GPIO_MP02_NR	(4)
+#define S5PV210_GPIO_MP03_NR	(8)
+#define S5PV210_GPIO_MP04_NR	(8)
+#define S5PV210_GPIO_MP05_NR	(8)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5PV210_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5PV210_GPIO_A0_START	= 0,
+	S5PV210_GPIO_A1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A0),
+	S5PV210_GPIO_B_START 	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A1),
+	S5PV210_GPIO_C0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_B),
+	S5PV210_GPIO_C1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C0),
+	S5PV210_GPIO_D0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C1),
+	S5PV210_GPIO_D1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D0),
+	S5PV210_GPIO_E0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D1),
+	S5PV210_GPIO_E1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E0),
+	S5PV210_GPIO_F0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E1),
+	S5PV210_GPIO_F1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F0),
+	S5PV210_GPIO_F2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F1),
+	S5PV210_GPIO_F3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F2),
+	S5PV210_GPIO_G0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F3),
+	S5PV210_GPIO_G1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G0),
+	S5PV210_GPIO_G2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G1),
+	S5PV210_GPIO_G3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G2),
+	S5PV210_GPIO_H0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G3),
+	S5PV210_GPIO_H1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H0),
+	S5PV210_GPIO_H2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H1),
+	S5PV210_GPIO_H3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H2),
+	S5PV210_GPIO_I_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H3),
+	S5PV210_GPIO_J0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_I),
+	S5PV210_GPIO_J1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J0),
+	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
+	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
+	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
+	S5PV210_GPIO_MP01_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
+	S5PV210_GPIO_MP02_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
+	S5PV210_GPIO_MP03_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
+	S5PV210_GPIO_MP04_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP03),
+	S5PV210_GPIO_MP05_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP04),
+};
+
+/* S5PV210 GPIO number definitions */
+#define S5PV210_GPA0(_nr)	(S5PV210_GPIO_A0_START + (_nr))
+#define S5PV210_GPA1(_nr)	(S5PV210_GPIO_A1_START + (_nr))
+#define S5PV210_GPB(_nr)	(S5PV210_GPIO_B_START + (_nr))
+#define S5PV210_GPC0(_nr)	(S5PV210_GPIO_C0_START + (_nr))
+#define S5PV210_GPC1(_nr)	(S5PV210_GPIO_C1_START + (_nr))
+#define S5PV210_GPD0(_nr)	(S5PV210_GPIO_D0_START + (_nr))
+#define S5PV210_GPD1(_nr)	(S5PV210_GPIO_D1_START + (_nr))
+#define S5PV210_GPE0(_nr)	(S5PV210_GPIO_E0_START + (_nr))
+#define S5PV210_GPE1(_nr)	(S5PV210_GPIO_E1_START + (_nr))
+#define S5PV210_GPF0(_nr)	(S5PV210_GPIO_F0_START + (_nr))
+#define S5PV210_GPF1(_nr)	(S5PV210_GPIO_F1_START + (_nr))
+#define S5PV210_GPF2(_nr)	(S5PV210_GPIO_F2_START + (_nr))
+#define S5PV210_GPF3(_nr)	(S5PV210_GPIO_F3_START + (_nr))
+#define S5PV210_GPG0(_nr)	(S5PV210_GPIO_G0_START + (_nr))
+#define S5PV210_GPG1(_nr)	(S5PV210_GPIO_G1_START + (_nr))
+#define S5PV210_GPG2(_nr)	(S5PV210_GPIO_G2_START + (_nr))
+#define S5PV210_GPG3(_nr)	(S5PV210_GPIO_G3_START + (_nr))
+#define S5PV210_GPH0(_nr)	(S5PV210_GPIO_H0_START + (_nr))
+#define S5PV210_GPH1(_nr)	(S5PV210_GPIO_H1_START + (_nr))
+#define S5PV210_GPH2(_nr)	(S5PV210_GPIO_H2_START + (_nr))
+#define S5PV210_GPH3(_nr)	(S5PV210_GPIO_H3_START + (_nr))
+#define S5PV210_GPI(_nr)	(S5PV210_GPIO_I_START + (_nr))
+#define S5PV210_GPJ0(_nr)	(S5PV210_GPIO_J0_START + (_nr))
+#define S5PV210_GPJ1(_nr)	(S5PV210_GPIO_J1_START + (_nr))
+#define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
+#define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
+#define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
+#define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
+#define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
+#define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
+#define S5PV210_MP04(_nr)	(S5PV210_GPIO_MP04_START + (_nr))
+#define S5PV210_MP05(_nr)	(S5PV210_GPIO_MP05_START + (_nr))
+
+/* the end of the S5PV210 specific gpios */
+#define S5PV210_GPIO_END	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) + 1)
+#define S3C_GPIO_END		S5PV210_GPIO_END
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
deleted file mode 100644
index e6f80d57c38e..000000000000
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/gpio.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-/* Practically, GPIO banks up to MP03 are the configurable gpio banks */
-
-/* GPIO bank sizes */
-#define S5PV210_GPIO_A0_NR	(8)
-#define S5PV210_GPIO_A1_NR	(4)
-#define S5PV210_GPIO_B_NR	(8)
-#define S5PV210_GPIO_C0_NR	(5)
-#define S5PV210_GPIO_C1_NR	(5)
-#define S5PV210_GPIO_D0_NR	(4)
-#define S5PV210_GPIO_D1_NR	(6)
-#define S5PV210_GPIO_E0_NR	(8)
-#define S5PV210_GPIO_E1_NR	(5)
-#define S5PV210_GPIO_F0_NR	(8)
-#define S5PV210_GPIO_F1_NR	(8)
-#define S5PV210_GPIO_F2_NR	(8)
-#define S5PV210_GPIO_F3_NR	(6)
-#define S5PV210_GPIO_G0_NR	(7)
-#define S5PV210_GPIO_G1_NR	(7)
-#define S5PV210_GPIO_G2_NR	(7)
-#define S5PV210_GPIO_G3_NR	(7)
-#define S5PV210_GPIO_H0_NR	(8)
-#define S5PV210_GPIO_H1_NR	(8)
-#define S5PV210_GPIO_H2_NR	(8)
-#define S5PV210_GPIO_H3_NR	(8)
-#define S5PV210_GPIO_I_NR	(7)
-#define S5PV210_GPIO_J0_NR	(8)
-#define S5PV210_GPIO_J1_NR	(6)
-#define S5PV210_GPIO_J2_NR	(8)
-#define S5PV210_GPIO_J3_NR	(8)
-#define S5PV210_GPIO_J4_NR	(5)
-
-#define S5PV210_GPIO_MP01_NR	(8)
-#define S5PV210_GPIO_MP02_NR	(4)
-#define S5PV210_GPIO_MP03_NR	(8)
-#define S5PV210_GPIO_MP04_NR	(8)
-#define S5PV210_GPIO_MP05_NR	(8)
-
-/* GPIO bank numbers */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-
-#define S5PV210_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p_gpio_number {
-	S5PV210_GPIO_A0_START	= 0,
-	S5PV210_GPIO_A1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A0),
-	S5PV210_GPIO_B_START 	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A1),
-	S5PV210_GPIO_C0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_B),
-	S5PV210_GPIO_C1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C0),
-	S5PV210_GPIO_D0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C1),
-	S5PV210_GPIO_D1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D0),
-	S5PV210_GPIO_E0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D1),
-	S5PV210_GPIO_E1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E0),
-	S5PV210_GPIO_F0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E1),
-	S5PV210_GPIO_F1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F0),
-	S5PV210_GPIO_F2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F1),
-	S5PV210_GPIO_F3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F2),
-	S5PV210_GPIO_G0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F3),
-	S5PV210_GPIO_G1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G0),
-	S5PV210_GPIO_G2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G1),
-	S5PV210_GPIO_G3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G2),
-	S5PV210_GPIO_H0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G3),
-	S5PV210_GPIO_H1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H0),
-	S5PV210_GPIO_H2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H1),
-	S5PV210_GPIO_H3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H2),
-	S5PV210_GPIO_I_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H3),
-	S5PV210_GPIO_J0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_I),
-	S5PV210_GPIO_J1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J0),
-	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
-	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
-	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
-	S5PV210_GPIO_MP01_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
-	S5PV210_GPIO_MP02_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
-	S5PV210_GPIO_MP03_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
-	S5PV210_GPIO_MP04_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP03),
-	S5PV210_GPIO_MP05_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP04),
-};
-
-/* S5PV210 GPIO number definitions */
-#define S5PV210_GPA0(_nr)	(S5PV210_GPIO_A0_START + (_nr))
-#define S5PV210_GPA1(_nr)	(S5PV210_GPIO_A1_START + (_nr))
-#define S5PV210_GPB(_nr)	(S5PV210_GPIO_B_START + (_nr))
-#define S5PV210_GPC0(_nr)	(S5PV210_GPIO_C0_START + (_nr))
-#define S5PV210_GPC1(_nr)	(S5PV210_GPIO_C1_START + (_nr))
-#define S5PV210_GPD0(_nr)	(S5PV210_GPIO_D0_START + (_nr))
-#define S5PV210_GPD1(_nr)	(S5PV210_GPIO_D1_START + (_nr))
-#define S5PV210_GPE0(_nr)	(S5PV210_GPIO_E0_START + (_nr))
-#define S5PV210_GPE1(_nr)	(S5PV210_GPIO_E1_START + (_nr))
-#define S5PV210_GPF0(_nr)	(S5PV210_GPIO_F0_START + (_nr))
-#define S5PV210_GPF1(_nr)	(S5PV210_GPIO_F1_START + (_nr))
-#define S5PV210_GPF2(_nr)	(S5PV210_GPIO_F2_START + (_nr))
-#define S5PV210_GPF3(_nr)	(S5PV210_GPIO_F3_START + (_nr))
-#define S5PV210_GPG0(_nr)	(S5PV210_GPIO_G0_START + (_nr))
-#define S5PV210_GPG1(_nr)	(S5PV210_GPIO_G1_START + (_nr))
-#define S5PV210_GPG2(_nr)	(S5PV210_GPIO_G2_START + (_nr))
-#define S5PV210_GPG3(_nr)	(S5PV210_GPIO_G3_START + (_nr))
-#define S5PV210_GPH0(_nr)	(S5PV210_GPIO_H0_START + (_nr))
-#define S5PV210_GPH1(_nr)	(S5PV210_GPIO_H1_START + (_nr))
-#define S5PV210_GPH2(_nr)	(S5PV210_GPIO_H2_START + (_nr))
-#define S5PV210_GPH3(_nr)	(S5PV210_GPIO_H3_START + (_nr))
-#define S5PV210_GPI(_nr)	(S5PV210_GPIO_I_START + (_nr))
-#define S5PV210_GPJ0(_nr)	(S5PV210_GPIO_J0_START + (_nr))
-#define S5PV210_GPJ1(_nr)	(S5PV210_GPIO_J1_START + (_nr))
-#define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
-#define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
-#define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
-#define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
-#define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
-#define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
-#define S5PV210_MP04(_nr)	(S5PV210_GPIO_MP04_START + (_nr))
-#define S5PV210_MP05(_nr)	(S5PV210_GPIO_MP05_START + (_nr))
-
-/* the end of the S5PV210 specific gpios */
-#define S5PV210_GPIO_END	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) + 1)
-#define S3C_GPIO_END		S5PV210_GPIO_END
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index cc37edacda26..4262d8ff1988 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -31,6 +31,7 @@
 #include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index c1ce921c4088..096a8173a1d9 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -38,6 +38,7 @@
 #include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 2a6655fb63e7..a146089c9ee6 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -32,6 +32,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/regs-srom.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
index 55103c8220b3..815e329f70c4 100644
--- a/arch/arm/mach-s5pv210/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
@@ -13,12 +13,12 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
 
 #include <mach/map.h>
 #include <plat/fb.h>
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 static void s5pv210_fb_cfg_gpios(unsigned int base, unsigned int nr)
 {
diff --git a/arch/arm/mach-s5pv210/setup-fimc.c b/arch/arm/mach-s5pv210/setup-fimc.c
index 54cc5b11be0b..36945ec437f8 100644
--- a/arch/arm/mach-s5pv210/setup-fimc.c
+++ b/arch/arm/mach-s5pv210/setup-fimc.c
@@ -8,9 +8,10 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
+#include <linux/kernel.h>
 #include <plat/gpio-cfg.h>
 #include <plat/camport.h>
+#include <mach/gpio-samsung.h>
 
 int s5pv210_fimc_setup_gpio(enum s5p_camport_id id)
 {
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
index 4a15849766c0..b0f2b69ac743 100644
--- a/arch/arm/mach-s5pv210/setup-i2c0.c
+++ b/arch/arm/mach-s5pv210/setup-i2c0.c
@@ -14,12 +14,12 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
index 4777f6b97a92..aac1da7b9071 100644
--- a/arch/arm/mach-s5pv210/setup-i2c1.c
+++ b/arch/arm/mach-s5pv210/setup-i2c1.c
@@ -14,12 +14,12 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s5pv210/setup-i2c2.c b/arch/arm/mach-s5pv210/setup-i2c2.c
index bbce6c74b915..eff4503b903f 100644
--- a/arch/arm/mach-s5pv210/setup-i2c2.c
+++ b/arch/arm/mach-s5pv210/setup-i2c2.c
@@ -14,12 +14,12 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c2_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s5pv210/setup-ide.c b/arch/arm/mach-s5pv210/setup-ide.c
index ea123d546bd2..5b6042d97892 100644
--- a/arch/arm/mach-s5pv210/setup-ide.c
+++ b/arch/arm/mach-s5pv210/setup-ide.c
@@ -11,9 +11,9 @@
 */
 
 #include <linux/kernel.h>
-#include <linux/gpio.h>
 
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 static void s5pv210_ide_cfg_gpios(unsigned int base, unsigned int nr)
 {
diff --git a/arch/arm/mach-s5pv210/setup-keypad.c b/arch/arm/mach-s5pv210/setup-keypad.c
index c56420a52f48..faf6178f3a1b 100644
--- a/arch/arm/mach-s5pv210/setup-keypad.c
+++ b/arch/arm/mach-s5pv210/setup-keypad.c
@@ -11,8 +11,8 @@
  *
  */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index 0512ada00522..0dd055b47579 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -15,12 +15,12 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/sdhci.h>
+#include <mach/gpio-samsung.h>
 
 void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
diff --git a/arch/arm/mach-s5pv210/setup-spi.c b/arch/arm/mach-s5pv210/setup-spi.c
index 81aecc162f82..e1faf8ea4502 100644
--- a/arch/arm/mach-s5pv210/setup-spi.c
+++ b/arch/arm/mach-s5pv210/setup-spi.c
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index cf5aae5b0975..6ce11bfdc37e 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -14,6 +14,9 @@
 #ifndef __PLAT_SAMSUNG_GPIO_CORE_H
 #define __PLAT_SAMSUNG_GPIO_CORE_H
 
+/* Bring in machine-local definitions, especially S3C_GPIO_END */
+#include <mach/gpio-samsung.h>
+
 #define GPIOCON_OFF	(0x00)
 #define GPIODAT_OFF	(0x04)
 
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index da268813901b..adc91662f72b 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -19,9 +19,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S3C64XX)
 #include <mach/gpio-samsung.h>
-#endif
 
 #include <plat/gpio-core.h>
 #include <plat/pm.h>
diff --git a/arch/arm/plat-samsung/s5p-irq-eint.c b/arch/arm/plat-samsung/s5p-irq-eint.c
index ebee4dc11a94..dcd8c2cbf5bb 100644
--- a/arch/arm/plat-samsung/s5p-irq-eint.c
+++ b/arch/arm/plat-samsung/s5p-irq-eint.c
@@ -14,7 +14,6 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
 #include <linux/of.h>
 
@@ -26,6 +25,7 @@
 
 #include <plat/gpio-cfg.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 static inline void s5p_irq_eint_mask(struct irq_data *data)
 {
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 07105ee5c9ae..90d4b807519a 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -32,10 +32,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S3C64XX)
 #include <mach/gpio-samsung.h>
-#endif
 
 #include <plat/cpu.h>
 #include <plat/gpio-core.h>
diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index 9506d7617223..3b527dcfc0aa 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -16,7 +16,7 @@
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
-#include <mach/gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include "../codecs/wm8994.h"
 
-- 
1.9.3
