From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:16:06 +0100
Subject: [PATCH 7/8] S3C2412: move io-init to SoC specific files
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172216.06542.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c2412 specific code from s3c24xx_init_io to s3c2412.c
and make the s3c2412.h header obsolete.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2412/clock.c                |    3 +-
 arch/arm/mach-s3c2412/mach-jive.c            |    5 ++-
 arch/arm/mach-s3c2412/mach-smdk2413.c        |    6 ++--
 arch/arm/mach-s3c2412/mach-vstms.c           |    5 +--
 arch/arm/mach-s3c2412/pm.c                   |    2 +-
 arch/arm/mach-s3c2412/s3c2412.c              |   49 +++++++++++++++++++++++++-
 arch/arm/mach-s3c2412/s3c2412.h              |   30 ++++++++++++++++
 arch/arm/plat-s3c24xx/cpu.c                  |   35 +------------------
 arch/arm/plat-samsung/include/plat/s3c2412.h |   32 -----------------
 9 files changed, 90 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/mach-s3c2412/s3c2412.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h

diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c2412/clock.c
index d10b695..408207d 100644
--- a/arch/arm/mach-s3c2412/clock.c
+++ b/arch/arm/mach-s3c2412/clock.c
@@ -41,10 +41,11 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
+#include "s3c2412.h"
+
 /* We currently have to assume that the system is running
  * from the XTPll input, and that all ***REFCLKs are being
  * fed from it, as we cannot read the state of OM[4] from
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index ae73ba3..ad63ba5 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -48,7 +48,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/s3c2412.h>
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
@@ -56,6 +55,8 @@
 #include <plat/pm.h>
 #include <plat/udc.h>
 
+#include "s3c2412.h"
+
 static struct map_desc jive_iodesc[] __initdata = {
 };
 
@@ -503,7 +504,7 @@ static struct syscore_ops jive_pm_syscore_ops = {
 
 static void __init jive_map_io(void)
 {
-	s3c24xx_init_io(jive_iodesc, ARRAY_SIZE(jive_iodesc));
+	s3c2412_init_io(jive_iodesc, ARRAY_SIZE(jive_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(jive_uartcfgs, ARRAY_SIZE(jive_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index b11451b..a2804ab 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -42,14 +42,14 @@
 #include <plat/iic.h>
 #include <mach/fb.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
 #include <plat/common-smdk.h>
 
+#include "s3c2412.h"
+
 static struct map_desc smdk2413_iodesc[] __initdata = {
 };
 
@@ -104,7 +104,7 @@ static void __init smdk2413_fixup(struct tag *tags, char **cmdline,
 
 static void __init smdk2413_map_io(void)
 {
-	s3c24xx_init_io(smdk2413_iodesc, ARRAY_SIZE(smdk2413_iodesc));
+	s3c2412_init_io(smdk2413_iodesc, ARRAY_SIZE(smdk2413_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk2413_uartcfgs, ARRAY_SIZE(smdk2413_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 94bfaa1..b4cb265 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -42,12 +42,11 @@
 #include <plat/iic.h>
 #include <plat/nand.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
+#include "s3c2412.h"
 
 static struct map_desc vstms_iodesc[] __initdata = {
 };
@@ -141,7 +140,7 @@ static void __init vstms_fixup(struct tag *tags, char **cmdline,
 
 static void __init vstms_map_io(void)
 {
-	s3c24xx_init_io(vstms_iodesc, ARRAY_SIZE(vstms_iodesc));
+	s3c2412_init_io(vstms_iodesc, ARRAY_SIZE(vstms_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(vstms_uartcfgs, ARRAY_SIZE(vstms_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2412/pm.c b/arch/arm/mach-s3c2412/pm.c
index d1adfa6..419597f 100644
--- a/arch/arm/mach-s3c2412/pm.c
+++ b/arch/arm/mach-s3c2412/pm.c
@@ -33,7 +33,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include <plat/s3c2412.h>
+#include "s3c2412.h"
 
 extern void s3c2412_sleep_enter(void);
 
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index aff6e85..a7d0f47 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -45,7 +45,6 @@
 #include <plat/regs-spi.h>
 #include <mach/regs-s3c2412.h>
 
-#include <plat/s3c2412.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
@@ -53,6 +52,54 @@
 #include <plat/pll.h>
 #include <plat/nand-core.h>
 
+#include "s3c2412.h"
+
+/* table of supported CPUs */
+
+static const char name_s3c2412[]  = "S3C2412";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x32412001,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2412_map_io,
+		.init_clocks	= s3c2412_init_clocks,
+		.init_uarts	= s3c2412_init_uarts,
+		.init		= s3c2412_init,
+		.name		= name_s3c2412,
+	},
+	{			/* a newer version of the s3c2412 */
+		.idcode		= 0x32412003,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2412_map_io,
+		.init_clocks	= s3c2412_init_clocks,
+		.init_uarts	= s3c2412_init_uarts,
+		.init		= s3c2412_init,
+		.name		= name_s3c2412,
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
+void __init s3c2412_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialise the io descriptors we need for initialisation */
+	iotable_init(mach_desc, size);
+	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
+
+	samsung_cpu_id = __raw_readl(S3C2412_GSTATUS1);
+	s3c24xx_init_cpu();
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
 #ifndef CONFIG_CPU_S3C2412_ONLY
 void __iomem *s3c24xx_va_gpio2 = S3C24XX_VA_GPIO;
 
diff --git a/arch/arm/mach-s3c2412/s3c2412.h b/arch/arm/mach-s3c2412/s3c2412.h
new file mode 100644
index 0000000..aeb85ee
--- /dev/null
+++ b/arch/arm/mach-s3c2412/s3c2412.h
@@ -0,0 +1,30 @@
+/* linux/arch/arm/plat-samsung/include/plat/s3c2412.h
+ *
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for s3c2412 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ARCH_ARM_MACH_S3C2412_S3C2412_H
+#define __ARCH_ARM_MACH_S3C2412_S3C2412_H
+
+extern  int s3c2412_init(void);
+
+extern void s3c2412_map_io(void);
+
+extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2412_init_clocks(int xtal);
+
+extern  int s3c2412_baseclk_add(void);
+
+extern void s3c2412_restart(char mode, const char *cmd);
+
+extern void s3c2412_init_io(struct map_desc *mach_desc, int size);
+
+#endif
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 316203e..a0eb4d0 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -45,12 +45,10 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
 
 /* table of supported CPUs */
 
 static const char name_s3c2410[]  = "S3C2410";
-static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2410a[] = "S3C2410A";
 
 static struct cpu_table cpu_ids[] __initdata = {
@@ -72,24 +70,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2410a_init,
 		.name		= name_s3c2410a
 	},
-	{
-		.idcode		= 0x32412001,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2412_map_io,
-		.init_clocks	= s3c2412_init_clocks,
-		.init_uarts	= s3c2412_init_uarts,
-		.init		= s3c2412_init,
-		.name		= name_s3c2412,
-	},
-	{			/* a newer version of the s3c2412 */
-		.idcode		= 0x32412003,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2412_map_io,
-		.init_clocks	= s3c2412_init_clocks,
-		.init_uarts	= s3c2412_init_uarts,
-		.init		= s3c2412_init,
-		.name		= name_s3c2412,
-	},
 };
 
 /* minimal IO mapping */
@@ -103,15 +83,6 @@ static struct map_desc s3c_iodesc[] __initdata = {
 
 /* read cpu identificaiton code */
 
-static unsigned long s3c24xx_read_idcode_v5(void)
-{
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
-	return __raw_readl(S3C2412_GSTATUS1);
-#else
-	return 1UL;	/* don't look like an 2400 */
-#endif
-}
-
 static unsigned long s3c24xx_read_idcode_v4(void)
 {
 	return __raw_readl(S3C2410_GSTATUS1);
@@ -123,11 +94,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	iotable_init(mach_desc, size);
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 
-	if (cpu_architecture() >= CPU_ARCH_ARMv5) {
-		samsung_cpu_id = s3c24xx_read_idcode_v5();
-	} else {
-		samsung_cpu_id = s3c24xx_read_idcode_v4();
-	}
+	samsung_cpu_id = s3c24xx_read_idcode_v4();
 	s3c24xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
diff --git a/arch/arm/plat-samsung/include/plat/s3c2412.h b/arch/arm/plat-samsung/include/plat/s3c2412.h
deleted file mode 100644
index cbae50d..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2412.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2412.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2412 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2412
-
-extern  int s3c2412_init(void);
-
-extern void s3c2412_map_io(void);
-
-extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2412_init_clocks(int xtal);
-
-extern  int s3c2412_baseclk_add(void);
-
-extern void s3c2412_restart(char mode, const char *cmd);
-#else
-#define s3c2412_init_clocks NULL
-#define s3c2412_init_uarts NULL
-#define s3c2412_map_io NULL
-#define s3c2412_init NULL
-#define s3c2412_restart NULL
-#endif
-- 
1.7.2.3
