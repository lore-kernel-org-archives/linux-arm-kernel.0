From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:13:26 +0100
Subject: [PATCH 4/8] S3C2416: move io-init to SoC specific files
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172213.26769.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c2416 specific code from s3c24xx_init_io to s3c2416.c
and make the s3c2416.h header obsolete.

This also removes a cpu-specific ifdef in the common init function.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c                |    3 +-
 arch/arm/mach-s3c2416/mach-smdk2416.c        |    6 ++-
 arch/arm/mach-s3c2416/s3c2416.c              |   40 +++++++++++++++++++++++++-
 arch/arm/mach-s3c2416/s3c2416.h              |   30 +++++++++++++++++++
 arch/arm/plat-s3c24xx/cpu.c                  |   21 -------------
 arch/arm/plat-samsung/include/plat/s3c2416.h |   33 ---------------------
 6 files changed, 75 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/mach-s3c2416/s3c2416.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 5e36905..23b83f4 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 
-#include <plat/s3c2416.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
@@ -27,6 +26,8 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-s3c2443-clock.h>
 
+#include "s3c2416.h"
+
 /* armdiv
  *
  * this clock is sourced from msysclk and can have a number of
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index eebe1e7..6a7f934 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -42,7 +42,6 @@
 #include <mach/leds-gpio.h>
 #include <plat/iic.h>
 
-#include <plat/s3c2416.h>
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
@@ -57,6 +56,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "s3c2416.h"
+
 static struct map_desc smdk2416_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
@@ -216,7 +217,8 @@ static struct platform_device *smdk2416_devices[] __initdata = {
 
 static void __init smdk2416_map_io(void)
 {
-	s3c24xx_init_io(smdk2416_iodesc, ARRAY_SIZE(smdk2416_iodesc));
+	s3c2416_init_io(smdk2416_iodesc, ARRAY_SIZE(smdk2416_iodesc));
+
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk2416_uartcfgs, ARRAY_SIZE(smdk2416_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 5536392..8e927e8 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -50,7 +50,6 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/s3c2416.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/sdhci.h>
@@ -62,6 +61,45 @@
 #include <plat/adc-core.h>
 #include <plat/rtc-core.h>
 
+#include "s3c2416.h"
+
+/* table of supported CPUs */
+
+static const char name_s3c2416[]  = "S3C2416/S3C2450";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{			/* a strange version of the s3c2416 */
+		.idcode		= 0x32450003,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2416_map_io,
+		.init_clocks	= s3c2416_init_clocks,
+		.init_uarts	= s3c2416_init_uarts,
+		.init		= s3c2416_init,
+		.name		= name_s3c2416,
+	},
+};
+
+/* minimal IO mapping */
+
+static struct map_desc s3c_iodesc[] __initdata = {
+	IODESC_ENT(GPIO),
+	IODESC_ENT(IRQ),
+	IODESC_ENT(MEMCTRL),
+	IODESC_ENT(UART)
+};
+
+void __init s3c2416_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialise the io descriptors we need for initialisation */
+	iotable_init(mach_desc, size);
+	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
+
+	samsung_cpu_id = __raw_readl(S3C24XX_GSTATUS1);
+	s3c24xx_init_cpu();
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
diff --git a/arch/arm/mach-s3c2416/s3c2416.h b/arch/arm/mach-s3c2416/s3c2416.h
new file mode 100644
index 0000000..0f4cd4f
--- /dev/null
+++ b/arch/arm/mach-s3c2416/s3c2416.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>
+ *
+ * Header file for s3c2416 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ARCH_ARM_MACH_S3C2416_S3C2416_H
+#define __ARCH_ARM_MACH_S3C2416_S3C2416_H
+
+struct s3c2410_uartcfg;
+
+extern  int s3c2416_init(void);
+
+extern void s3c2416_map_io(void);
+
+extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2416_init_clocks(int xtal);
+
+extern  int s3c2416_baseclk_add(void);
+
+extern void s3c2416_restart(char mode, const char *cmd);
+
+extern void s3c2416_init_io(struct map_desc *mach_desc, int size);
+
+#endif
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 21f1fda..2dccf39 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -46,7 +46,6 @@
 #include <plat/clock.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
-#include <plat/s3c2416.h>
 #include <plat/s3c244x.h>
 #include <plat/s3c2443.h>
 
@@ -54,7 +53,6 @@
 
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
-static const char name_s3c2416[]  = "S3C2416/S3C2450";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
 static const char name_s3c2442b[]  = "S3C2442B";
@@ -135,15 +133,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2412_init,
 		.name		= name_s3c2412,
 	},
-	{			/* a strange version of the s3c2416 */
-		.idcode		= 0x32450003,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2416_map_io,
-		.init_clocks	= s3c2416_init_clocks,
-		.init_uarts	= s3c2416_init_uarts,
-		.init		= s3c2416_init,
-		.name		= name_s3c2416,
-	},
 	{
 		.idcode		= 0x32443001,
 		.idmask		= 0xffffffff,
@@ -168,16 +157,6 @@ static struct map_desc s3c_iodesc[] __initdata = {
 
 static unsigned long s3c24xx_read_idcode_v5(void)
 {
-#if defined(CONFIG_CPU_S3C2416)
-	/* s3c2416 is v5, with S3C24XX_GSTATUS1 instead of S3C2412_GSTATUS1 */
-
-	u32 gs = __raw_readl(S3C24XX_GSTATUS1);
-
-	/* test for s3c2416 or similar device */
-	if ((gs >> 16) == 0x3245)
-		return gs;
-#endif
-
 #if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
 	return __raw_readl(S3C2412_GSTATUS1);
 #else
diff --git a/arch/arm/plat-samsung/include/plat/s3c2416.h b/arch/arm/plat-samsung/include/plat/s3c2416.h
deleted file mode 100644
index de2b5bd..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2416.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2416.h
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>
- *
- * Header file for s3c2416 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2416
-
-struct s3c2410_uartcfg;
-
-extern  int s3c2416_init(void);
-
-extern void s3c2416_map_io(void);
-
-extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2416_init_clocks(int xtal);
-
-extern  int s3c2416_baseclk_add(void);
-
-extern void s3c2416_restart(char mode, const char *cmd);
-#else
-#define s3c2416_init_clocks NULL
-#define s3c2416_init_uarts NULL
-#define s3c2416_map_io NULL
-#define s3c2416_init NULL
-#define s3c2416_restart NULL
-#endif
-- 
1.7.2.3
