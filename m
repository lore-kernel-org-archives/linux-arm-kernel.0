From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:31 +0900
Subject: [PATCH 07/12] ARM: S5PV210: introduce
 arch/arm/mach-s5pv210/common.[ch]
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] which are used only in the
arch/arm/mach-s5pv210/ directory. The common.c file merges
the cpu.c and init.c which are used commonly on S5PCV210/S5PC100
SoC and the common.h local header file replaces with plat/s5pv210.h
file.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile               |   19 +++--
 arch/arm/mach-s5pv210/clock.c                |    3 +-
 arch/arm/mach-s5pv210/{cpu.c => common.c}    |  109 ++++++++++++++++++++++----
 arch/arm/mach-s5pv210/common.h               |   35 ++++++++
 arch/arm/mach-s5pv210/init.c                 |   44 ----------
 arch/arm/mach-s5pv210/mach-aquila.c          |    5 +-
 arch/arm/mach-s5pv210/mach-goni.c            |    5 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c        |    5 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c        |    5 +-
 arch/arm/mach-s5pv210/mach-torbreck.c        |    5 +-
 arch/arm/plat-s5p/cpu.c                      |   10 ---
 arch/arm/plat-samsung/include/plat/s5pv210.h |   33 --------
 12 files changed, 158 insertions(+), 120 deletions(-)
 rename arch/arm/mach-s5pv210/{cpu.c => common.c} (68%)
 create mode 100644 arch/arm/mach-s5pv210/common.h
 delete mode 100644 arch/arm/mach-s5pv210/init.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5pv210.h

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 009fbe5..4c59186 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -10,18 +10,20 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-# Core support for S5PV210 system
+# Core
+
+obj-y				+= common.o clock.o
 
-obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o
-obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_PM)		+= pm.o
 
+obj-y				+= dma.o
+
 # machine support
 
 obj-$(CONFIG_MACH_AQUILA)	+= mach-aquila.o
-obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
-obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
 obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
+obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
+obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
 obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
 
 # device support
@@ -29,11 +31,12 @@ obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
+obj-y					+= setup-i2c0.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_FIMC)	+= setup-fimc.o
-obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
-obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S5PV210_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PV210_SETUP_I2C2)	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PV210_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 4c5ac7a..f2dbf5f 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -29,7 +29,8 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/s5pv210.h>
+
+#include "common.h"
 
 static unsigned long xtal;
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/common.c
similarity index 68%
rename from arch/arm/mach-s5pv210/cpu.c
rename to arch/arm/mach-s5pv210/common.c
index 84ec746..2899ee8 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -1,12 +1,13 @@
-/* linux/arch/arm/mach-s5pv210/cpu.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
+ * Common Codes for S5PV210
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -21,33 +22,75 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
+#include <linux/serial_core.h>
 
+#include <asm/proc-fns.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <asm/proc-fns.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
-#include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/fb-core.h>
-#include <plat/s5pv210.h>
+#include <plat/devs.h>
+#include <plat/reset.h>
+#include <plat/sdhci.h>
 #include <plat/adc-core.h>
 #include <plat/ata-core.h>
+#include <plat/fb-core.h>
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
-#include <plat/sdhci.h>
-#include <plat/reset.h>
 #include <plat/tv-core.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+static const char name_s5pv210[] = "S5PV210/S5PC110";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= S5PV210_CPU_ID,
+		.idmask		= S5PV210_CPU_MASK,
+		.map_io		= s5pv210_map_io,
+		.init_clocks	= s5pv210_init_clocks,
+		.init_uarts	= s5pv210_init_uarts,
+		.init		= s5pv210_init,
+		.name		= name_s5pv210,
+	},
+};
 
 /* Initial IO mappings */
 
 static struct map_desc s5pv210_iodesc[] __initdata = {
 	{
+		.virtual	= (unsigned long)S5P_VA_CHIPID,
+		.pfn		= __phys_to_pfn(S5PV210_PA_CHIPID),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_SYS,
+		.pfn		= __phys_to_pfn(S5PV210_PA_SYSCON),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(S5PV210_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(S5PV210_PA_WATCHDOG),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
 		.pfn		= __phys_to_pfn(S5PV210_PA_SYSTIMER),
 		.length		= SZ_4K,
@@ -113,14 +156,27 @@ static void s5pv210_sw_reset(void)
 	__raw_writel(0x1, S5P_SWRESET);
 }
 
-/* s5pv210_map_io
+/*
+ * s5pv210_map_io
  *
  * register the standard cpu IO areas
-*/
+ */
 
-void __init s5pv210_map_io(void)
+void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 {
+	/* initialize the io descriptors we need for initialization */
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+	if (mach_desc)
+		iotable_init(mach_desc, size);
+
+	/* detect cpu id and rev. */
+	s5p_init_cpu(S5P_VA_CHIPID);
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
+void __init s5pv210_map_io(void)
+{
 	init_consistent_dma_size(14 << 20);
 
 	/* initialise device information early */
@@ -186,7 +242,6 @@ static int __init s5pv210_core_init(void)
 {
 	return sysdev_class_register(&s5pv210_sysclass);
 }
-
 core_initcall(s5pv210_core_init);
 
 int __init s5pv210_init(void)
@@ -201,3 +256,29 @@ int __init s5pv210_init(void)
 
 	return sysdev_register(&s5pv210_sysdev);
 }
+
+static struct s3c24xx_uart_clksrc s5pv210_serial_clocks[] = {
+	[0] = {
+		.name		= "pclk",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+
+void __init s5pv210_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5pv210_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5pv210_serial_clocks);
+		}
+	}
+
+	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/mach-s5pv210/common.h b/arch/arm/mach-s5pv210/common.h
new file mode 100644
index 0000000..f74ef96
--- /dev/null
+++ b/arch/arm/mach-s5pv210/common.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S5PV210 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S5PV210_COMMON_H
+#define __ARCH_ARM_MACH_S5PV210_COMMON_H
+
+void s5pv210_init_io(struct map_desc *mach_desc, int size);
+void s5pv210_init_irq(void);
+
+void s5pv210_register_clocks(void);
+void s5pv210_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5PV210
+
+extern  int s5pv210_init(void);
+extern void s5pv210_map_io(void);
+extern void s5pv210_init_clocks(int xtal);
+extern void s5pv210_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define s5pv210_init_clocks NULL
+#define s5pv210_init_uarts NULL
+#define s5pv210_map_io NULL
+#define s5pv210_init NULL
+#endif
+
+#endif /* __ARCH_ARM_MACH_S5PV210_COMMON_H */
diff --git a/arch/arm/mach-s5pv210/init.c b/arch/arm/mach-s5pv210/init.c
deleted file mode 100644
index 4865ae2..0000000
--- a/arch/arm/mach-s5pv210/init.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/init.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5pv210.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc s5pv210_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-void __init s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5pv210_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5pv210_serial_clocks);
-		}
-	}
-
-	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 71ca956..167f03c 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -33,7 +33,6 @@
 
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
@@ -42,6 +41,8 @@
 #include <plat/s5p-time.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define AQUILA_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -645,7 +646,7 @@ static void __init aquila_sound_init(void)
 
 static void __init aquila_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pv210_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(aquila_uartcfgs, ARRAY_SIZE(aquila_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 448fd9e..ab39ded 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -38,7 +38,6 @@
 
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
@@ -55,6 +54,8 @@
 #include <media/s5p_fimc.h>
 #include <media/noon010pc30.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -891,7 +892,7 @@ static void __init goni_sound_init(void)
 
 static void __init goni_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pv210_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(goni_uartcfgs, ARRAY_SIZE(goni_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index c2531ff..b8c2c07 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -25,7 +25,6 @@
 #include <mach/regs-clock.h>
 
 #include <plat/regs-serial.h>
-#include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/ata.h>
@@ -33,6 +32,8 @@
 #include <plat/pm.h>
 #include <plat/s5p-time.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC110_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -110,7 +111,7 @@ static struct i2c_board_info smdkc110_i2c_devs2[] __initdata = {
 
 static void __init smdkc110_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pv210_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 4ca77c4..4bd8743 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -34,7 +34,6 @@
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
 #include <plat/gpio-cfg.h>
-#include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/adc.h>
@@ -48,6 +47,8 @@
 #include <plat/backlight.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -278,7 +279,7 @@ static struct platform_pwm_backlight_data smdkv210_bl_data = {
 
 static void __init smdkv210_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pv210_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
 	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index df70fcb..aece529 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -24,12 +24,13 @@
 #include <mach/regs-clock.h>
 
 #include <plat/regs-serial.h>
-#include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/iic.h>
 #include <plat/s5p-time.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define TORBRECK_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -103,7 +104,7 @@ static struct i2c_board_info torbreck_i2c_devs2[] __initdata = {
 
 static void __init torbreck_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pv210_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(torbreck_uartcfgs, ARRAY_SIZE(torbreck_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 74bcd71..63c3fad 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -20,26 +20,16 @@
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
-#include <plat/s5pv210.h>
 #include <plat/exynos4.h>
 
 /* table of supported CPUs */
 
-static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
 static const char name_exynos4412[] = "EXYNOS4412";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= S5PV210_CPU_ID,
-		.idmask		= S5PV210_CPU_MASK,
-		.map_io		= s5pv210_map_io,
-		.init_clocks	= s5pv210_init_clocks,
-		.init_uarts	= s5pv210_init_uarts,
-		.init		= s5pv210_init,
-		.name		= name_s5pv210,
-	}, {
 		.idcode		= EXYNOS4210_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
diff --git a/arch/arm/plat-samsung/include/plat/s5pv210.h b/arch/arm/plat-samsung/include/plat/s5pv210.h
deleted file mode 100644
index b4bc6be7..0000000
--- a/arch/arm/plat-samsung/include/plat/s5pv210.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s5pv210.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for s5pv210 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S5PV210 related SoCs */
-
-extern void s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s5pv210_register_clocks(void);
-extern void s5pv210_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5PV210
-
-extern  int s5pv210_init(void);
-extern void s5pv210_init_irq(void);
-extern void s5pv210_map_io(void);
-extern void s5pv210_init_clocks(int xtal);
-
-#define s5pv210_init_uarts s5pv210_common_init_uarts
-
-#else
-#define s5pv210_init_clocks NULL
-#define s5pv210_init_uarts NULL
-#define s5pv210_map_io NULL
-#define s5pv210_init NULL
-#endif
-- 
1.7.4.4
