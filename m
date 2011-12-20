From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:29 +0900
Subject: [PATCH 05/12] ARM: S5PC100: introduce
 arch/arm/mach-s5pc100/common.[ch]
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] which are used only in the
arch/arm/mach-s5pc100/ directory. The common.c file merges
the cpu.c and init.c which are used commonly on S5PC100 SoC
and the common.h local header file replaces with plat/s5pc100.h
file.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile               |   29 ++++-----
 arch/arm/mach-s5pc100/clock.c                |    3 +-
 arch/arm/mach-s5pc100/{cpu.c => common.c}    |   94 ++++++++++++++++++++------
 arch/arm/mach-s5pc100/common.h               |   35 ++++++++++
 arch/arm/mach-s5pc100/init.c                 |   24 -------
 arch/arm/mach-s5pc100/mach-smdkc100.c        |    5 +-
 arch/arm/plat-s5p/cpu.c                      |   10 ---
 arch/arm/plat-samsung/include/plat/s5pc100.h |   33 ---------
 8 files changed, 127 insertions(+), 106 deletions(-)
 rename arch/arm/mach-s5pc100/{cpu.c => common.c} (68%)
 create mode 100644 arch/arm/mach-s5pc100/common.h
 delete mode 100644 arch/arm/mach-s5pc100/init.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5pc100.h

diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index a5e6e60..c3166c4 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -9,28 +9,25 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-# Core support for S5PC100 system
+# Core
 
-obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o
-obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
-obj-$(CONFIG_CPU_S5PC100)	+= dma.o
+obj-y				+= common.o clock.o
 
-# Helper and device support
-
-obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
-obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
-obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
-obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
-obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-
-# device support
-obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+obj-y				+= dma.o
 
 # machine support
 
 obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
 
 # device support
+
 obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+
+obj-y					+= setup-i2c0.o
+obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
+obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
+obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
+obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 8d47709..c4c7489 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -27,7 +27,8 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/s5pc100.h>
+
+#include "common.h"
 
 static struct clk s5p_clk_otgphy = {
 	.name		= "otg_phy",
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/common.c
similarity index 68%
rename from arch/arm/mach-s5pc100/cpu.c
rename to arch/arm/mach-s5pc100/common.c
index fd2708e..e6eadac 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -1,17 +1,16 @@
-/* linux/arch/arm/mach-s5pc100/cpu.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
  *
- * Based on mach-s3c6410/cpu.c
+ * Common Codes for S5PC100
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -26,35 +25,72 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 
+#include <asm/irq.h>
+#include <asm/proc-fns.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <asm/proc-fns.h>
-
-#include <mach/hardware.h>
 #include <mach/map.h>
-#include <asm/irq.h>
-
-#include <plat/regs-serial.h>
+#include <mach/hardware.h>
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/ata-core.h>
-#include <plat/iic-core.h>
 #include <plat/sdhci.h>
 #include <plat/adc-core.h>
-#include <plat/onenand-core.h>
+#include <plat/ata-core.h>
 #include <plat/fb-core.h>
+#include <plat/iic-core.h>
+#include <plat/onenand-core.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
 
-#include <plat/s5pc100.h>
+static const char name_s5pc100[] = "S5PC100";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= S5PC100_CPU_ID,
+		.idmask		= S5PC100_CPU_MASK,
+		.map_io		= s5pc100_map_io,
+		.init_clocks	= s5pc100_init_clocks,
+		.init_uarts	= s5pc100_init_uarts,
+		.init		= s5pc100_init,
+		.name		= name_s5pc100,
+	},
+};
 
 /* Initial IO mappings */
 
 static struct map_desc s5pc100_iodesc[] __initdata = {
 	{
+		.virtual	= (unsigned long)S5P_VA_CHIPID,
+		.pfn		= __phys_to_pfn(S5PC100_PA_CHIPID),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_SYS,
+		.pfn		= __phys_to_pfn(S5PC100_PA_SYSCON),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(S5PC100_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(S5PC100_PA_WATCHDOG),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(S5PC100_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
 		.pfn		= __phys_to_pfn(S5PC100_PA_SYSTIMER),
 		.length		= SZ_16K,
@@ -100,15 +136,27 @@ static void s5pc100_idle(void)
 	local_irq_enable();
 }
 
-/* s5pc100_map_io
+/*
+ * s5pc100_map_io
  *
- * register the standard cpu IO areas
-*/
+ * register the standard CPU IO areas
+ */
 
-void __init s5pc100_map_io(void)
+void __init s5pc100_init_io(struct map_desc *mach_desc, int size)
 {
+	/* initialize the io descriptors we need for initialization */
 	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
+	if (mach_desc)
+		iotable_init(mach_desc, size);
+
+	/* detect cpu id and rev. */
+	s5p_init_cpu(S5P_VA_CHIPID);
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
 
+void __init s5pc100_map_io(void)
+{
 	/* initialise device information early */
 	s5pc100_default_sdhci0();
 	s5pc100_default_sdhci1();
@@ -155,7 +203,6 @@ static int __init s5pc100_core_init(void)
 {
 	return sysdev_class_register(&s5pc100_sysclass);
 }
-
 core_initcall(s5pc100_core_init);
 
 int __init s5pc100_init(void)
@@ -167,3 +214,10 @@ int __init s5pc100_init(void)
 
 	return sysdev_register(&s5pc100_sysdev);
 }
+
+/* uart registration process */
+
+void __init s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/mach-s5pc100/common.h b/arch/arm/mach-s5pc100/common.h
new file mode 100644
index 0000000..4822b87
--- /dev/null
+++ b/arch/arm/mach-s5pc100/common.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S5PC100 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S5PC100_COMMON_H
+#define __ARCH_ARM_MACH_S5PC100_COMMON_H
+
+void s5pc100_init_io(struct map_desc *mach_desc, int size);
+void s5pc100_init_irq(void);
+
+void s5pc100_register_clocks(void);
+void s5pc100_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5PC100
+
+extern  int s5pc100_init(void);
+extern void s5pc100_map_io(void);
+extern void s5pc100_init_clocks(int xtal);
+extern void s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define s5pc100_init_clocks NULL
+#define s5pc100_init_uarts NULL
+#define s5pc100_map_io NULL
+#define s5pc100_init NULL
+#endif
+
+#endif /* __ARCH_ARM_MACH_S5PC100_COMMON_H */
diff --git a/arch/arm/mach-s5pc100/init.c b/arch/arm/mach-s5pc100/init.c
deleted file mode 100644
index 19d7b52..0000000
--- a/arch/arm/mach-s5pc100/init.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/* linux/arch/arm/plat-s5pc100/s5pc100-init.c
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5pc100.h>
-
-/* uart registration process */
-void __init s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 93ebe3a..76bcc0b 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -43,7 +43,6 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/s5pc100.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
 #include <plat/ata.h>
@@ -54,6 +53,8 @@
 #include <plat/backlight.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -216,7 +217,7 @@ static struct platform_pwm_backlight_data smdkc100_bl_data = {
 
 static void __init smdkc100_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s5pc100_init_io(NULL, 0);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdkc100_uartcfgs, ARRAY_SIZE(smdkc100_uartcfgs));
 }
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 2fb9a9c..74bcd71 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -20,13 +20,11 @@
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
-#include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
 #include <plat/exynos4.h>
 
 /* table of supported CPUs */
 
-static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
@@ -34,14 +32,6 @@ static const char name_exynos4412[] = "EXYNOS4412";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= S5PC100_CPU_ID,
-		.idmask		= S5PC100_CPU_MASK,
-		.map_io		= s5pc100_map_io,
-		.init_clocks	= s5pc100_init_clocks,
-		.init_uarts	= s5pc100_init_uarts,
-		.init		= s5pc100_init,
-		.name		= name_s5pc100,
-	}, {
 		.idcode		= S5PV210_CPU_ID,
 		.idmask		= S5PV210_CPU_MASK,
 		.map_io		= s5pv210_map_io,
diff --git a/arch/arm/plat-samsung/include/plat/s5pc100.h b/arch/arm/plat-samsung/include/plat/s5pc100.h
deleted file mode 100644
index 9a21aea..0000000
--- a/arch/arm/plat-samsung/include/plat/s5pc100.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s5pc100.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for s5pc100 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S5PC100 related SoCs */
-
-extern void s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s5pc100_register_clocks(void);
-extern void s5pc100_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5PC100
-
-extern  int s5pc100_init(void);
-extern void s5pc100_init_irq(void);
-extern void s5pc100_map_io(void);
-extern void s5pc100_init_clocks(int xtal);
-
-#define s5pc100_init_uarts s5pc100_common_init_uarts
-
-#else
-#define s5pc100_init_clocks NULL
-#define s5pc100_init_uarts NULL
-#define s5pc100_map_io NULL
-#define s5pc100_init NULL
-#endif
-- 
1.7.4.4
