From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:16:42 +0100
Subject: [PATCH 8/8] S3C2410: move io-init to SoC specific files
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172216.42748.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c2410 specific code from s3c24xx_init_io to s3c2410.c
and make the s3c2410.h header obsolete.

This also removes unnecessary references to s3c2410.h that were
still present in s3c2440 and s3c2443.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2410/common.h               |   17 -----
 arch/arm/mach-s3c2410/mach-amlm5900.c        |    4 +-
 arch/arm/mach-s3c2410/mach-bast.c            |    4 +-
 arch/arm/mach-s3c2410/mach-h1940.c           |    4 +-
 arch/arm/mach-s3c2410/mach-n30.c             |    5 +-
 arch/arm/mach-s3c2410/mach-otom.c            |    5 +-
 arch/arm/mach-s3c2410/mach-qt2410.c          |    4 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c        |    4 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c      |    4 +-
 arch/arm/mach-s3c2410/mach-vr1000.c          |    4 +-
 arch/arm/mach-s3c2410/s3c2410.c              |   50 +++++++++++++-
 arch/arm/mach-s3c2410/s3c2410.h              |   28 +++++++
 arch/arm/mach-s3c2440/mach-nexcoder.c        |    1 -
 arch/arm/mach-s3c2440/mach-smdk2440.c        |    1 -
 arch/arm/mach-s3c2440/s3c244x.c              |    1 -
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    1 -
 arch/arm/plat-s3c24xx/Makefile               |    1 -
 arch/arm/plat-s3c24xx/cpu.c                  |  101 --------------------------
 arch/arm/plat-s3c24xx/s3c2410-clock.c        |    1 -
 arch/arm/plat-samsung/include/plat/cpu.h     |    2 -
 arch/arm/plat-samsung/include/plat/s3c2410.h |   31 --------
 21 files changed, 95 insertions(+), 178 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/common.h
 create mode 100644 arch/arm/mach-s3c2410/s3c2410.h
 delete mode 100644 arch/arm/plat-s3c24xx/cpu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h

diff --git a/arch/arm/mach-s3c2410/common.h b/arch/arm/mach-s3c2410/common.h
deleted file mode 100644
index f65dc80..0000000
--- a/arch/arm/mach-s3c2410/common.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Common Header for S3C2410 machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_S3C2410_COMMON_H
-#define __ARCH_ARM_MACH_S3C2410_COMMON_H
-
-void s3c2410_restart(char mode, const char *cmd);
-
-#endif /* __ARCH_ARM_MACH_S3C2410_COMMON_H */
diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 4220cc6..242bc50 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -63,7 +63,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct resource amlm5900_nor_resource = {
 		.start = 0x00000000,
@@ -162,7 +162,7 @@ static struct platform_device *amlm5900_devices[] __initdata = {
 
 static void __init amlm5900_map_io(void)
 {
-	s3c24xx_init_io(amlm5900_iodesc, ARRAY_SIZE(amlm5900_iodesc));
+	s3c2410_init_io(amlm5900_iodesc, ARRAY_SIZE(amlm5900_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(amlm5900_uartcfgs, ARRAY_SIZE(amlm5900_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index feeaf73..54b6415 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -66,7 +66,7 @@
 
 #include "usb-simtec.h"
 #include "nor-simtec.h"
-#include "common.h"
+#include "s3c2410.h"
 
 #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
 
@@ -608,7 +608,7 @@ static void __init bast_map_io(void)
 
 	s3c_hwmon_set_platdata(&bast_hwmon_info);
 
-	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
+	s3c2410_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(bast_uartcfgs, ARRAY_SIZE(bast_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 41245a6..7854508 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -70,7 +70,7 @@
 
 #include <sound/uda1380.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 #define H1940_LATCH		((void __force __iomem *)0xF8000000)
 
@@ -654,7 +654,7 @@ static struct platform_device *h1940_devices[] __initdata = {
 
 static void __init h1940_map_io(void)
 {
-	s3c24xx_init_io(h1940_iodesc, ARRAY_SIZE(h1940_iodesc));
+	s3c2410_init_io(h1940_iodesc, ARRAY_SIZE(h1940_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(h1940_uartcfgs, ARRAY_SIZE(h1940_uartcfgs));
 
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 383d00c..5dac621 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -48,10 +48,9 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/mci.h>
-#include <plat/s3c2410.h>
 #include <plat/udc.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct map_desc n30_iodesc[] __initdata = {
 	/* nothing here yet */
@@ -532,7 +531,7 @@ static void __init n30_hwinit(void)
 
 static void __init n30_map_io(void)
 {
-	s3c24xx_init_io(n30_iodesc, ARRAY_SIZE(n30_iodesc));
+	s3c2410_init_io(n30_iodesc, ARRAY_SIZE(n30_iodesc));
 	n30_hwinit();
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(n30_uartcfgs, ARRAY_SIZE(n30_uartcfgs));
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index 5f1e0ee..f05ea2c 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -32,13 +32,12 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/iic.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct map_desc otom11_iodesc[] __initdata = {
   /* Device area */
@@ -105,7 +104,7 @@ static struct platform_device *otom11_devices[] __initdata = {
 
 static void __init otom11_map_io(void)
 {
-	s3c24xx_init_io(otom11_iodesc, ARRAY_SIZE(otom11_iodesc));
+	s3c2410_init_io(otom11_iodesc, ARRAY_SIZE(otom11_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(otom11_uartcfgs, ARRAY_SIZE(otom11_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 91c16d9..f399d42 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -62,7 +62,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct map_desc qt2410_iodesc[] __initdata = {
 	{ 0xe0000000, __phys_to_pfn(S3C2410_CS3+0x01000000), SZ_1M, MT_DEVICE }
@@ -310,7 +310,7 @@ __setup("tft=", qt2410_tft_setup);
 
 static void __init qt2410_map_io(void)
 {
-	s3c24xx_init_io(qt2410_iodesc, ARRAY_SIZE(qt2410_iodesc));
+	s3c2410_init_io(qt2410_iodesc, ARRAY_SIZE(qt2410_iodesc));
 	s3c24xx_init_clocks(12*1000*1000);
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index bdc27e7..ec69bee 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -54,7 +54,7 @@
 
 #include <plat/common-smdk.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct map_desc smdk2410_iodesc[] __initdata = {
   /* nothing here yet */
@@ -98,7 +98,7 @@ static struct platform_device *smdk2410_devices[] __initdata = {
 
 static void __init smdk2410_map_io(void)
 {
-	s3c24xx_init_io(smdk2410_iodesc, ARRAY_SIZE(smdk2410_iodesc));
+	s3c2410_init_io(smdk2410_iodesc, ARRAY_SIZE(smdk2410_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index 1114666..2a626c9 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -54,7 +54,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include "common.h"
+#include "s3c2410.h"
 
 static struct resource tct_hammer_nor_resource = {
 		.start = 0x00000000,
@@ -136,7 +136,7 @@ static struct platform_device *tct_hammer_devices[] __initdata = {
 
 static void __init tct_hammer_map_io(void)
 {
-	s3c24xx_init_io(tct_hammer_iodesc, ARRAY_SIZE(tct_hammer_iodesc));
+	s3c2410_init_io(tct_hammer_iodesc, ARRAY_SIZE(tct_hammer_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(tct_hammer_uartcfgs, ARRAY_SIZE(tct_hammer_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index dbe668a..4e984c9 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -53,7 +53,7 @@
 
 #include "usb-simtec.h"
 #include "nor-simtec.h"
-#include "common.h"
+#include "s3c2410.h"
 
 /* macros for virtual address mods for the io space entries */
 #define VA_C5(item) ((unsigned long)(item) + BAST_VAM_CS5)
@@ -356,7 +356,7 @@ static void __init vr1000_map_io(void)
 
 	pm_power_off = vr1000_power_off;
 
-	s3c24xx_init_io(vr1000_iodesc, ARRAY_SIZE(vr1000_iodesc));
+	s3c2410_init_io(vr1000_iodesc, ARRAY_SIZE(vr1000_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(vr1000_uartcfgs, ARRAY_SIZE(vr1000_uartcfgs));
 }
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
index 061b6bb..4e9fd9b 100644
--- a/arch/arm/mach-s3c2410/s3c2410.c
+++ b/arch/arm/mach-s3c2410/s3c2410.c
@@ -36,7 +36,6 @@
 #include <mach/regs-clock.h>
 #include <plat/regs-serial.h>
 
-#include <plat/s3c2410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
@@ -48,6 +47,55 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "s3c2410.h"
+
+/* table of supported CPUs */
+
+static const char name_s3c2410[]  = "S3C2410";
+static const char name_s3c2410a[] = "S3C2410A";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x32410000,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2410_map_io,
+		.init_clocks	= s3c2410_init_clocks,
+		.init_uarts	= s3c2410_init_uarts,
+		.init		= s3c2410_init,
+		.name		= name_s3c2410
+	},
+	{
+		.idcode		= 0x32410002,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2410_map_io,
+		.init_clocks	= s3c2410_init_clocks,
+		.init_uarts	= s3c2410_init_uarts,
+		.init		= s3c2410a_init,
+		.name		= name_s3c2410a
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
+void __init s3c2410_init_io(struct map_desc *mach_desc, int size)
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
 /* Initial IO mappings */
 
 static struct map_desc s3c2410_iodesc[] __initdata = {
diff --git a/arch/arm/mach-s3c2410/s3c2410.h b/arch/arm/mach-s3c2410/s3c2410.h
new file mode 100644
index 0000000..26b8688
--- /dev/null
+++ b/arch/arm/mach-s3c2410/s3c2410.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S3C2410 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S3C2410_S3C2410_H
+#define __ARCH_ARM_MACH_S3C2410_S3C2410_H
+
+extern  int s3c2410_init(void);
+extern  int s3c2410a_init(void);
+
+extern void s3c2410_map_io(void);
+
+extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2410_init_clocks(int xtal);
+
+void s3c2410_restart(char mode, const char *cmd);
+
+extern void s3c2410_init_io(struct map_desc *mach_desc, int size);
+
+#endif /* __ARCH_ARM_MACH_S3C2410_COMMON_H */
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 0e6f8c0..176db97 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -41,7 +41,6 @@
 #include <plat/iic.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 7c13e6e..8bb79c8 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -39,7 +39,6 @@
 #include <mach/fb.h>
 #include <plat/iic.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 078bfcd..de1279f 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -38,7 +38,6 @@
 #include <mach/regs-gpioj.h>
 #include <mach/regs-dsc.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 261582a..1b7373f 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -39,7 +39,6 @@
 #include <mach/fb.h>
 #include <plat/iic.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index b2b0112..419d622 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= cpu.o
 obj-y				+= irq.o
 obj-y				+= dev-uart.o
 obj-y				+= clock.o
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
deleted file mode 100644
index a0eb4d0..0000000
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/cpu.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/SWLINUX/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX CPU Support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/cacheflush.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/regs-gpio.h>
-#include <plat/regs-serial.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-#include <plat/s3c2410.h>
-
-/* table of supported CPUs */
-
-static const char name_s3c2410[]  = "S3C2410";
-static const char name_s3c2410a[] = "S3C2410A";
-
-static struct cpu_table cpu_ids[] __initdata = {
-	{
-		.idcode		= 0x32410000,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2410_map_io,
-		.init_clocks	= s3c2410_init_clocks,
-		.init_uarts	= s3c2410_init_uarts,
-		.init		= s3c2410_init,
-		.name		= name_s3c2410
-	},
-	{
-		.idcode		= 0x32410002,
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2410_map_io,
-		.init_clocks	= s3c2410_init_clocks,
-		.init_uarts	= s3c2410_init_uarts,
-		.init		= s3c2410a_init,
-		.name		= name_s3c2410a
-	},
-};
-
-/* minimal IO mapping */
-
-static struct map_desc s3c_iodesc[] __initdata = {
-	IODESC_ENT(GPIO),
-	IODESC_ENT(IRQ),
-	IODESC_ENT(MEMCTRL),
-	IODESC_ENT(UART)
-};
-
-/* read cpu identificaiton code */
-
-static unsigned long s3c24xx_read_idcode_v4(void)
-{
-	return __raw_readl(S3C2410_GSTATUS1);
-}
-
-void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
-{
-	/* initialise the io descriptors we need for initialisation */
-	iotable_init(mach_desc, size);
-	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
-
-	samsung_cpu_id = s3c24xx_read_idcode_v4();
-	s3c24xx_init_cpu();
-
-	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
-}
diff --git a/arch/arm/plat-s3c24xx/s3c2410-clock.c b/arch/arm/plat-s3c24xx/s3c2410-clock.c
index 25dc4d4..92c8822 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2410-clock.c
@@ -41,7 +41,6 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 73cb3cf..8bbb530 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -154,8 +154,6 @@ extern void s3c_init_cpu(unsigned long idcode,
 extern void s3c24xx_init_irq(void);
 extern void s5p_init_irq(u32 *vic, u32 num_vic);
 
-extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
-
 extern void s3c24xx_init_cpu(void);
 extern void s3c64xx_init_cpu(void);
 extern void s5p_init_cpu(void __iomem *cpuid_addr);
diff --git a/arch/arm/plat-samsung/include/plat/s3c2410.h b/arch/arm/plat-samsung/include/plat/s3c2410.h
deleted file mode 100644
index 55b0e5f..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2410.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2410.h
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2410 machine directory
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#ifdef CONFIG_CPU_S3C2410
-
-extern  int s3c2410_init(void);
-extern  int s3c2410a_init(void);
-
-extern void s3c2410_map_io(void);
-
-extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2410_init_clocks(int xtal);
-
-#else
-#define s3c2410_init_clocks NULL
-#define s3c2410_init_uarts NULL
-#define s3c2410_map_io NULL
-#define s3c2410_init NULL
-#define s3c2410a_init NULL
-#endif
-- 
1.7.2.3
