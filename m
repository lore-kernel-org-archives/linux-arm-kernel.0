From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:15:25 +0100
Subject: [PATCH 6/8] S3C2440: move io-init to SoC specific files
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172215.25801.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c244x specific code from s3c24xx_init_io to s3c244x.c
and make the s3c244x.h header obsolete.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2440/common.h               |   17 ------
 arch/arm/mach-s3c2440/dsc.c                  |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c          |    4 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c       |    4 +-
 arch/arm/mach-s3c2440/mach-gta02.c           |    4 +-
 arch/arm/mach-s3c2440/mach-mini2440.c        |    4 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c        |    5 +-
 arch/arm/mach-s3c2440/mach-osiris.c          |    4 +-
 arch/arm/mach-s3c2440/mach-rx1950.c          |    4 +-
 arch/arm/mach-s3c2440/mach-rx3715.c          |    4 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c        |    5 +-
 arch/arm/mach-s3c2440/s3c2440.c              |    3 +-
 arch/arm/mach-s3c2440/s3c2442.c              |    3 +-
 arch/arm/mach-s3c2440/s3c244x.c              |   70 +++++++++++++++++++++++++-
 arch/arm/mach-s3c2440/s3c244x.h              |   37 ++++++++++++++
 arch/arm/plat-s3c24xx/cpu.c                  |   41 ---------------
 arch/arm/plat-samsung/include/plat/s3c244x.h |   42 ---------------
 17 files changed, 129 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2440/common.h
 create mode 100644 arch/arm/mach-s3c2440/s3c244x.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h

diff --git a/arch/arm/mach-s3c2440/common.h b/arch/arm/mach-s3c2440/common.h
deleted file mode 100644
index db8a98a..0000000
--- a/arch/arm/mach-s3c2440/common.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Common Header for S3C2440 machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_S3C2440_COMMON_H
-#define __ARCH_ARM_MACH_S3C2440_COMMON_H
-
-void s3c2440_restart(char mode, const char *cmd);
-
-#endif /* __ARCH_ARM_MACH_S3C2440_COMMON_H */
diff --git a/arch/arm/mach-s3c2440/dsc.c b/arch/arm/mach-s3c2440/dsc.c
index 9ea66e3..62595ae 100644
--- a/arch/arm/mach-s3c2440/dsc.c
+++ b/arch/arm/mach-s3c2440/dsc.c
@@ -28,7 +28,7 @@
 #include <mach/regs-dsc.h>
 
 #include <plat/cpu.h>
-#include <plat/s3c244x.h>
+#include "s3c244x.h"
 
 int s3c2440_set_dsc(unsigned int pin, unsigned int value)
 {
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index 2456955..815ad9f 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -55,7 +55,7 @@
 #include <plat/cpu.h>
 #include <plat/audio-simtec.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
 
@@ -450,7 +450,7 @@ static void __init anubis_map_io(void)
 
 	s3c24xx_register_clocks(anubis_clocks, ARRAY_SIZE(anubis_clocks));
 
-	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
+	s3c244x_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
 
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index d6a9763..c027eff 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -49,7 +49,7 @@
 #include <plat/cpu.h>
 #include <plat/mci.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 static struct map_desc at2440evb_iodesc[] __initdata = {
 	/* Nothing here */
@@ -200,7 +200,7 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 
 static void __init at2440evb_map_io(void)
 {
-	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
+	s3c244x_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
 	s3c24xx_init_clocks(16934400);
 	s3c24xx_init_uarts(at2440evb_uartcfgs, ARRAY_SIZE(at2440evb_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 5859e60..37c8b40 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -90,7 +90,7 @@
 #include <plat/iic.h>
 #include <plat/ts.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 static struct pcf50633 *gta02_pcf;
 
@@ -508,7 +508,7 @@ static struct platform_device gta02_buttons_device = {
 
 static void __init gta02_map_io(void)
 {
-	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
+	s3c244x_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(gta02_uartcfgs, ARRAY_SIZE(gta02_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index adbbb85..4bfea5f 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -60,7 +60,7 @@
 
 #include <sound/s3c24xx_uda134x.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 #define MACH_MINI2440_DM9K_BASE (S3C2410_CS4 + 0x300)
 
@@ -535,7 +535,7 @@ static struct platform_device *mini2440_devices[] __initdata = {
 
 static void __init mini2440_map_io(void)
 {
-	s3c24xx_init_io(mini2440_iodesc, ARRAY_SIZE(mini2440_iodesc));
+	s3c244x_init_io(mini2440_iodesc, ARRAY_SIZE(mini2440_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(mini2440_uartcfgs, ARRAY_SIZE(mini2440_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 40eaf84..0e6f8c0 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -42,12 +42,11 @@
 
 #include <plat/gpio-cfg.h>
 #include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 static struct map_desc nexcoder_iodesc[] __initdata = {
 	/* nothing here yet */
@@ -138,7 +137,7 @@ static void __init nexcoder_sensorboard_init(void)
 
 static void __init nexcoder_map_io(void)
 {
-	s3c24xx_init_io(nexcoder_iodesc, ARRAY_SIZE(nexcoder_iodesc));
+	s3c244x_init_io(nexcoder_iodesc, ARRAY_SIZE(nexcoder_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(nexcoder_uartcfgs, ARRAY_SIZE(nexcoder_uartcfgs));
 
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 4c480ef..1ad68d9 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -54,7 +54,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 /* onboard perihperal map */
 
@@ -391,7 +391,7 @@ static void __init osiris_map_io(void)
 
 	s3c24xx_register_clocks(osiris_clocks, ARRAY_SIZE(osiris_clocks));
 
-	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
+	s3c244x_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
 
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 80077f6..f70f1e3 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -62,7 +62,7 @@
 
 #include <sound/uda1380.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 #define LCD_PWM_PERIOD 192960
 #define LCD_PWM_DUTY 127353
@@ -746,7 +746,7 @@ static void __init rx1950_map_io(void)
 
 	s3c24xx_register_clocks(rx1950_clocks, ARRAY_SIZE(rx1950_clocks));
 
-	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
+	s3c244x_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
 	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
 
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 20103ba..aa815e8 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -51,7 +51,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 static struct map_desc rx3715_iodesc[] __initdata = {
 	/* dump ISA space somewhere unused */
@@ -176,7 +176,7 @@ static struct platform_device *rx3715_devices[] __initdata = {
 
 static void __init rx3715_map_io(void)
 {
-	s3c24xx_init_io(rx3715_iodesc, ARRAY_SIZE(rx3715_iodesc));
+	s3c244x_init_io(rx3715_iodesc, ARRAY_SIZE(rx3715_iodesc));
 	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx3715_uartcfgs, ARRAY_SIZE(rx3715_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 1deb60d..7c13e6e 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -40,14 +40,13 @@
 #include <plat/iic.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
 #include <plat/common-smdk.h>
 
-#include "common.h"
+#include "s3c244x.h"
 
 static struct map_desc smdk2440_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
@@ -161,7 +160,7 @@ static struct platform_device *smdk2440_devices[] __initdata = {
 
 static void __init smdk2440_map_io(void)
 {
-	s3c24xx_init_io(smdk2440_iodesc, ARRAY_SIZE(smdk2440_iodesc));
+	s3c244x_init_io(smdk2440_iodesc, ARRAY_SIZE(smdk2440_iodesc));
 	s3c24xx_init_clocks(16934400);
 	s3c24xx_init_uarts(smdk2440_uartcfgs, ARRAY_SIZE(smdk2440_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index 517623a..c27b91c 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -33,7 +33,6 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/s3c244x.h>
 #include <plat/pm.h>
 #include <plat/watchdog-reset.h>
 
@@ -41,6 +40,8 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "s3c244x.h"
+
 static struct device s3c2440_dev = {
 	.bus		= &s3c2440_subsys,
 };
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
index 8004e04..16fa855 100644
--- a/arch/arm/mach-s3c2440/s3c2442.c
+++ b/arch/arm/mach-s3c2440/s3c2442.c
@@ -44,13 +44,14 @@
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
-#include <plat/s3c244x.h>
 #include <plat/pm.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "s3c244x.h"
+
 /* S3C2442 extended clock support */
 
 static unsigned long s3c2442_camif_upll_round(struct clk *clk,
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 36bc60f..078bfcd 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -39,7 +39,6 @@
 #include <mach/regs-dsc.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -47,6 +46,75 @@
 #include <plat/pll.h>
 #include <plat/nand-core.h>
 
+#include "s3c244x.h"
+
+/* table of supported CPUs */
+
+static const char name_s3c2440[]  = "S3C2440";
+static const char name_s3c2442[]  = "S3C2442";
+static const char name_s3c2442b[]  = "S3C2442B";
+static const char name_s3c2440a[] = "S3C2440A";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x32440000,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2440_map_io,
+		.init_clocks	= s3c244x_init_clocks,
+		.init_uarts	= s3c244x_init_uarts,
+		.init		= s3c2440_init,
+		.name		= name_s3c2440
+	},
+	{
+		.idcode		= 0x32440001,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2440_map_io,
+		.init_clocks	= s3c244x_init_clocks,
+		.init_uarts	= s3c244x_init_uarts,
+		.init		= s3c2440_init,
+		.name		= name_s3c2440a
+	},
+	{
+		.idcode		= 0x32440aaa,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2442_map_io,
+		.init_clocks	= s3c244x_init_clocks,
+		.init_uarts	= s3c244x_init_uarts,
+		.init		= s3c2442_init,
+		.name		= name_s3c2442
+	},
+	{
+		.idcode		= 0x32440aab,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2442_map_io,
+		.init_clocks	= s3c244x_init_clocks,
+		.init_uarts	= s3c244x_init_uarts,
+		.init		= s3c2442_init,
+		.name		= name_s3c2442b
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
+void __init s3c244x_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialise the io descriptors we need for initialisation */
+	iotable_init(mach_desc, size);
+	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
+
+	samsung_cpu_id = __raw_readl(S3C2410_GSTATUS1);
+	s3c24xx_init_cpu();
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
 static struct map_desc s3c244x_iodesc[] __initdata = {
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
diff --git a/arch/arm/mach-s3c2440/s3c244x.h b/arch/arm/mach-s3c2440/s3c244x.h
new file mode 100644
index 0000000..7659391
--- /dev/null
+++ b/arch/arm/mach-s3c2440/s3c244x.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S3C2440 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S3C2440_S3C244X_H
+#define __ARCH_ARM_MACH_S3C2440_S3C244X_H
+
+extern void s3c244x_map_io(void);
+
+extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c244x_init_clocks(int xtal);
+
+void s3c2440_restart(char mode, const char *cmd);
+
+extern void s3c244x_init_io(struct map_desc *mach_desc, int size);
+
+#ifdef CONFIG_CPU_S3C2440
+extern  int s3c2440_init(void);
+
+extern void s3c2440_map_io(void);
+#endif
+
+#ifdef CONFIG_CPU_S3C2442
+extern  int s3c2442_init(void);
+
+extern void s3c2442_map_io(void);
+#endif
+
+#endif /* __ARCH_ARM_MACH_S3C2440_S3C244X_H */
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index cadd1da..316203e 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -46,17 +46,12 @@
 #include <plat/clock.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
-#include <plat/s3c244x.h>
 
 /* table of supported CPUs */
 
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
-static const char name_s3c2440[]  = "S3C2440";
-static const char name_s3c2442[]  = "S3C2442";
-static const char name_s3c2442b[]  = "S3C2442B";
 static const char name_s3c2410a[] = "S3C2410A";
-static const char name_s3c2440a[] = "S3C2440A";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -78,42 +73,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.name		= name_s3c2410a
 	},
 	{
-		.idcode		= 0x32440000,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2440_map_io,
-		.init_clocks	= s3c244x_init_clocks,
-		.init_uarts	= s3c244x_init_uarts,
-		.init		= s3c2440_init,
-		.name		= name_s3c2440
-	},
-	{
-		.idcode		= 0x32440001,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2440_map_io,
-		.init_clocks	= s3c244x_init_clocks,
-		.init_uarts	= s3c244x_init_uarts,
-		.init		= s3c2440_init,
-		.name		= name_s3c2440a
-	},
-	{
-		.idcode		= 0x32440aaa,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2442_map_io,
-		.init_clocks	= s3c244x_init_clocks,
-		.init_uarts	= s3c244x_init_uarts,
-		.init		= s3c2442_init,
-		.name		= name_s3c2442
-	},
-	{
-		.idcode		= 0x32440aab,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2442_map_io,
-		.init_clocks	= s3c244x_init_clocks,
-		.init_uarts	= s3c244x_init_uarts,
-		.init		= s3c2442_init,
-		.name		= name_s3c2442b
-	},
-	{
 		.idcode		= 0x32412001,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2412_map_io,
diff --git a/arch/arm/plat-samsung/include/plat/s3c244x.h b/arch/arm/plat-samsung/include/plat/s3c244x.h
deleted file mode 100644
index ea0c961..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c244x.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c244x.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C2440 and S3C2442 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
-
-extern void s3c244x_map_io(void);
-
-extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c244x_init_clocks(int xtal);
-
-#else
-#define s3c244x_init_clocks NULL
-#define s3c244x_init_uarts NULL
-#endif
-
-#ifdef CONFIG_CPU_S3C2440
-extern  int s3c2440_init(void);
-
-extern void s3c2440_map_io(void);
-#else
-#define s3c2440_init NULL
-#define s3c2440_map_io NULL
-#endif
-
-#ifdef CONFIG_CPU_S3C2442
-extern  int s3c2442_init(void);
-
-extern void s3c2442_map_io(void);
-#else
-#define s3c2442_init NULL
-#define s3c2442_map_io NULL
-#endif
-- 
1.7.2.3
