From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:14:23 +0100
Subject: [PATCH 5/8] S3C2443: move io-init to SoC specific files
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172214.23765.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c2443 specific code from s3c24xx_init_io to s3c2443.c
and make the s3c2443.h header obsolete.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2443/clock.c                |    3 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    5 ++-
 arch/arm/mach-s3c2443/s3c2443.c              |   40 +++++++++++++++++++++++++-
 arch/arm/mach-s3c2443/s3c2443.h              |   31 ++++++++++++++++++++
 arch/arm/plat-s3c24xx/cpu.c                  |   11 -------
 arch/arm/plat-samsung/include/plat/s3c2443.h |   34 ----------------------
 6 files changed, 75 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-s3c2443/s3c2443.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h

diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 6dde269..251929f 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -41,11 +41,12 @@
 
 #include <plat/cpu-freq.h>
 
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
 
+#include "s3c2443.h"
+
 /* We currently have to assume that the system is running
  * from the XTPll input, and that all ***REFCLKs are being
  * fed from it, as we cannot read the state of OM[4] from
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 2092369..261582a 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -40,13 +40,14 @@
 #include <plat/iic.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
 #include <plat/common-smdk.h>
 
+#include "s3c2443.h"
+
 static struct map_desc smdk2443_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
@@ -120,7 +121,7 @@ static struct platform_device *smdk2443_devices[] __initdata = {
 
 static void __init smdk2443_map_io(void)
 {
-	s3c24xx_init_io(smdk2443_iodesc, ARRAY_SIZE(smdk2443_iodesc));
+	s3c2443_init_io(smdk2443_iodesc, ARRAY_SIZE(smdk2443_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk2443_uartcfgs, ARRAY_SIZE(smdk2443_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index b7778a9..6427909 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -35,7 +35,6 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/s3c2443.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb-core.h>
@@ -43,6 +42,45 @@
 #include <plat/adc-core.h>
 #include <plat/rtc-core.h>
 
+#include "s3c2443.h"
+
+/* table of supported CPUs */
+
+static const char name_s3c2443[]  = "S3C2443";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x32443001,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2443_map_io,
+		.init_clocks	= s3c2443_init_clocks,
+		.init_uarts	= s3c2443_init_uarts,
+		.init		= s3c2443_init,
+		.name		= name_s3c2443,
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
+void __init s3c2443_init_io(struct map_desc *mach_desc, int size)
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
 static struct map_desc s3c2443_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
diff --git a/arch/arm/mach-s3c2443/s3c2443.h b/arch/arm/mach-s3c2443/s3c2443.h
new file mode 100644
index 0000000..45b6a36
--- /dev/null
+++ b/arch/arm/mach-s3c2443/s3c2443.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for s3c2443 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ARCH_ARM_MACH_S3C2443_S3C2443_H
+#define __ARCH_ARM_MACH_S3C2443_S3C2443_H
+
+struct s3c2410_uartcfg;
+
+extern  int s3c2443_init(void);
+
+extern void s3c2443_map_io(void);
+
+extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2443_init_clocks(int xtal);
+
+extern  int s3c2443_baseclk_add(void);
+
+extern void s3c2443_restart(char mode, const char *cmd);
+
+extern void s3c2443_init_io(struct map_desc *mach_desc, int size);
+
+#endif
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 2dccf39..cadd1da 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -47,7 +47,6 @@
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
 #include <plat/s3c244x.h>
-#include <plat/s3c2443.h>
 
 /* table of supported CPUs */
 
@@ -56,7 +55,6 @@ static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
 static const char name_s3c2442b[]  = "S3C2442B";
-static const char name_s3c2443[]  = "S3C2443";
 static const char name_s3c2410a[] = "S3C2410A";
 static const char name_s3c2440a[] = "S3C2440A";
 
@@ -133,15 +131,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2412_init,
 		.name		= name_s3c2412,
 	},
-	{
-		.idcode		= 0x32443001,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2443_map_io,
-		.init_clocks	= s3c2443_init_clocks,
-		.init_uarts	= s3c2443_init_uarts,
-		.init		= s3c2443_init,
-		.name		= name_s3c2443,
-	},
 };
 
 /* minimal IO mapping */
diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
deleted file mode 100644
index a5b794f..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2443.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2443 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2443
-
-struct s3c2410_uartcfg;
-
-extern  int s3c2443_init(void);
-
-extern void s3c2443_map_io(void);
-
-extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2443_init_clocks(int xtal);
-
-extern  int s3c2443_baseclk_add(void);
-
-extern void s3c2443_restart(char mode, const char *cmd);
-#else
-#define s3c2443_init_clocks NULL
-#define s3c2443_init_uarts NULL
-#define s3c2443_map_io NULL
-#define s3c2443_init NULL
-#define s3c2443_restart NULL
-#endif
-- 
1.7.2.3
