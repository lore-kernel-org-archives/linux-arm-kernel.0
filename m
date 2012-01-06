From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 Jan 2012 00:26:46 +0100
Subject: [PATCH 5/8] S3C2443: move io-init to SoC specific files
In-Reply-To: <201201070022.40431.heiko@sntech.de>
References: <201201070022.40431.heiko@sntech.de>
Message-ID: <201201070026.46322.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce common.h/common.c to replace calls to s3c24xx_init_io
and make the s3c2443.h header obsolete.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2443/Makefile               |    2 +-
 arch/arm/mach-s3c2443/clock.c                |    3 +-
 arch/arm/mach-s3c2443/common.c               |   70 ++++++++++++++++++++++++++
 arch/arm/mach-s3c2443/common.h               |   31 +++++++++++
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    5 +-
 arch/arm/mach-s3c2443/s3c2443.c              |    3 +-
 arch/arm/plat-s3c24xx/cpu.c                  |   11 ----
 arch/arm/plat-samsung/include/plat/s3c2443.h |   34 ------------
 8 files changed, 109 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-s3c2443/common.c
 create mode 100644 arch/arm/mach-s3c2443/common.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h

diff --git a/arch/arm/mach-s3c2443/Makefile b/arch/arm/mach-s3c2443/Makefile
index d1843c9..4e3cef0 100644
--- a/arch/arm/mach-s3c2443/Makefile
+++ b/arch/arm/mach-s3c2443/Makefile
@@ -9,7 +9,7 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
+obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o common.o
 obj-$(CONFIG_CPU_S3C2443)	+= irq.o
 obj-$(CONFIG_CPU_S3C2443)	+= clock.o
 
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 1c2c088..ac45f58 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -41,11 +41,12 @@
 
 #include <plat/cpu-freq.h>
 
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
 
+#include "common.h"
+
 /* We currently have to assume that the system is running
  * from the XTPll input, and that all ***REFCLKs are being
  * fed from it, as we cannot read the state of OM[4] from
diff --git a/arch/arm/mach-s3c2443/common.c b/arch/arm/mach-s3c2443/common.c
new file mode 100644
index 0000000..674317c
--- /dev/null
+++ b/arch/arm/mach-s3c2443/common.c
@@ -0,0 +1,70 @@
+/*
+ * S3C2443 CPU Support
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *	http://www.simtec.co.uk/products/SWLINUX/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/mach/map.h>
+
+#include <plat/cpu.h>
+
+#include <mach/map.h>
+#include <mach/regs-gpio.h>
+
+#include "common.h"
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
diff --git a/arch/arm/mach-s3c2443/common.h b/arch/arm/mach-s3c2443/common.h
new file mode 100644
index 0000000..4f94da4
--- /dev/null
+++ b/arch/arm/mach-s3c2443/common.h
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
+#ifndef __ARCH_ARM_MACH_S3C2443_COMMON_H
+#define __ARCH_ARM_MACH_S3C2443_COMMON_H
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
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 2092369..113643b 100644
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
 
+#include "common.h"
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
index 45e7280..ecc1249 100644
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
@@ -43,6 +42,8 @@
 #include <plat/adc-core.h>
 #include <plat/rtc-core.h>
 
+#include "common.h"
+
 static struct map_desc s3c2443_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 7532026..742fa03 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -48,7 +48,6 @@
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
 #include <plat/s3c244x.h>
-#include <plat/s3c2443.h>
 
 /* table of supported CPUs */
 
@@ -57,7 +56,6 @@ static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
 static const char name_s3c2442b[]  = "S3C2442B";
-static const char name_s3c2443[]  = "S3C2443";
 static const char name_s3c2410a[] = "S3C2410A";
 static const char name_s3c2440a[] = "S3C2440A";
 
@@ -134,15 +132,6 @@ static struct cpu_table cpu_ids[] __initdata = {
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
1.7.5.4
