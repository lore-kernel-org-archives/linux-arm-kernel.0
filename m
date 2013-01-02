From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:53 -0800
Subject: [PATCH 16/26] ARM: S3C24XX: make vr1000-cpld.h,
 vr1000-irq.h and vr1000-map.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-17-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h |   18 ----
 arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h  |   26 -----
 arch/arm/mach-s3c24xx/include/mach/vr1000-map.h  |  108 --------------------
 arch/arm/mach-s3c24xx/mach-vr1000.c              |   33 +++---
 arch/arm/mach-s3c24xx/vr1000.h                   |  118 ++++++++++++++++++++++
 5 files changed, 133 insertions(+), 170 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
 create mode 100644 arch/arm/mach-s3c24xx/vr1000.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h
deleted file mode 100644
index e411991..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/vr1000-cpld.h
- *
- * Copyright (c) 2003 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * VR1000 - CPLD control constants
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_VR1000CPLD_H
-#define __ASM_ARCH_VR1000CPLD_H
-
-#define VR1000_CPLD_CTRL2_RAMWEN     (0x04)   /* SRAM Write Enable */
-
-#endif /* __ASM_ARCH_VR1000CPLD_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h
deleted file mode 100644
index 47add13..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/vr1000-irq.h
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Machine VR1000 - IRQ Number definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_VR1000IRQ_H
-#define __ASM_ARCH_VR1000IRQ_H
-
-/* irq numbers to onboard peripherals */
-
-#define IRQ_USBOC	     IRQ_EINT19
-#define IRQ_IDE0	     IRQ_EINT16
-#define IRQ_IDE1	     IRQ_EINT17
-#define IRQ_VR1000_SERIAL    IRQ_EINT12
-#define IRQ_VR1000_DM9000A   IRQ_EINT10
-#define IRQ_VR1000_DM9000N   IRQ_EINT9
-#define IRQ_SMALERT	     IRQ_EINT8
-
-#endif /* __ASM_ARCH_VR1000IRQ_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
deleted file mode 100644
index 5f836a7..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
+++ /dev/null
@@ -1,108 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/vr1000-map.h
- *
- * Copyright (c) 2003-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Machine VR1000 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* needs arch/map.h including with this */
-
-/* ok, we've used up to 0x13000000, now we need to find space for the
- * peripherals that live in the nGCS[x] areas, which are quite numerous
- * in their space. We also have the board's CPLD to find register space
- * for.
- */
-
-#ifndef __ASM_ARCH_VR1000MAP_H
-#define __ASM_ARCH_VR1000MAP_H
-
-#define VR1000_IOADDR(x)	(S3C2410_ADDR((x) + 0x01300000))
-
-/* we put the CPLD registers next, to get them out of the way */
-
-#define VR1000_VA_CTRL1	    VR1000_IOADDR(0x00000000)	 /* 0x01300000 */
-#define VR1000_PA_CTRL1	    (S3C2410_CS5 | 0x7800000)
-
-#define VR1000_VA_CTRL2	    VR1000_IOADDR(0x00100000)	 /* 0x01400000 */
-#define VR1000_PA_CTRL2	    (S3C2410_CS1 | 0x6000000)
-
-#define VR1000_VA_CTRL3	    VR1000_IOADDR(0x00200000)	 /* 0x01500000 */
-#define VR1000_PA_CTRL3	    (S3C2410_CS1 | 0x6800000)
-
-#define VR1000_VA_CTRL4	    VR1000_IOADDR(0x00300000)	 /* 0x01600000 */
-#define VR1000_PA_CTRL4	    (S3C2410_CS1 | 0x7000000)
-
-/* next, we have the PC104 ISA interrupt registers */
-
-#define VR1000_PA_PC104_IRQREQ  (S3C2410_CS5 | 0x6000000) /* 0x01700000 */
-#define VR1000_VA_PC104_IRQREQ  VR1000_IOADDR(0x00400000)
-
-#define VR1000_PA_PC104_IRQRAW  (S3C2410_CS5 | 0x6800000) /* 0x01800000 */
-#define VR1000_VA_PC104_IRQRAW  VR1000_IOADDR(0x00500000)
-
-#define VR1000_PA_PC104_IRQMASK (S3C2410_CS5 | 0x7000000) /* 0x01900000 */
-#define VR1000_VA_PC104_IRQMASK VR1000_IOADDR(0x00600000)
-
-/* 0xE0000000 contains the IO space that is split by speed and
- * whether the access is for 8 or 16bit IO... this ensures that
- * the correct access is made
- *
- * 0x10000000 of space, partitioned as so:
- *
- * 0x00000000 to 0x04000000  8bit,  slow
- * 0x04000000 to 0x08000000  16bit, slow
- * 0x08000000 to 0x0C000000  16bit, net
- * 0x0C000000 to 0x10000000  16bit, fast
- *
- * each of these spaces has the following in:
- *
- * 0x02000000 to 0x02100000 1MB  IDE primary channel
- * 0x02100000 to 0x02200000 1MB  IDE primary channel aux
- * 0x02200000 to 0x02400000 1MB  IDE secondary channel
- * 0x02300000 to 0x02400000 1MB  IDE secondary channel aux
- * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controllers
- * 0x02600000 to 0x02700000 1MB
- *
- * the phyiscal layout of the zones are:
- *  nGCS2 - 8bit, slow
- *  nGCS3 - 16bit, slow
- *  nGCS4 - 16bit, net
- *  nGCS5 - 16bit, fast
- */
-
-#define VR1000_VA_MULTISPACE (0xE0000000)
-
-#define VR1000_VA_ISAIO		   (VR1000_VA_MULTISPACE + 0x00000000)
-#define VR1000_VA_ISAMEM	   (VR1000_VA_MULTISPACE + 0x01000000)
-#define VR1000_VA_IDEPRI	   (VR1000_VA_MULTISPACE + 0x02000000)
-#define VR1000_VA_IDEPRIAUX	   (VR1000_VA_MULTISPACE + 0x02100000)
-#define VR1000_VA_IDESEC	   (VR1000_VA_MULTISPACE + 0x02200000)
-#define VR1000_VA_IDESECAUX	   (VR1000_VA_MULTISPACE + 0x02300000)
-#define VR1000_VA_ASIXNET	   (VR1000_VA_MULTISPACE + 0x02400000)
-#define VR1000_VA_DM9000	   (VR1000_VA_MULTISPACE + 0x02500000)
-#define VR1000_VA_SUPERIO	   (VR1000_VA_MULTISPACE + 0x02600000)
-
-/* physical offset addresses for the peripherals */
-
-#define VR1000_PA_IDEPRI	   (0x02000000)
-#define VR1000_PA_IDEPRIAUX	   (0x02800000)
-#define VR1000_PA_IDESEC	   (0x03000000)
-#define VR1000_PA_IDESECAUX	   (0x03800000)
-#define VR1000_PA_DM9000	   (0x05000000)
-
-#define VR1000_PA_SERIAL	   (0x11800000)
-#define VR1000_VA_SERIAL	   (VR1000_IOADDR(0x00700000))
-
-/* VR1000 ram is in CS1, with A26..A24 = 2_101 */
-#define VR1000_PA_SRAM		   (S3C2410_CS1 | 0x05000000)
-
-/* some configurations for the peripherals */
-
-#define VR1000_DM9000_CS	 VR1000_VAM_CS4
-
-#endif /* __ASM_ARCH_VR1000MAP_H */
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 80cffbf..d4db385 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2410/mach-vr1000.c
- *
+/*
  * Copyright (c) 2003-2008 Simtec Electronics
  *   Ben Dooks <ben@simtec.co.uk>
  *
@@ -32,27 +31,25 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/vr1000-map.h>
-#include <mach/vr1000-irq.h>
-#include <mach/vr1000-cpld.h>
-
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
 #include <linux/platform_data/leds-s3c24xx.h>
+#include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/asoc-s3c24xx_simtec.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/clock.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/asoc-s3c24xx_simtec.h>
+#include <plat/devs.h>
+#include <plat/regs-serial.h>
 
 #include "bast.h"
 #include "common.h"
 #include "simtec.h"
+#include "vr1000.h"
 
 /* macros for virtual address mods for the io space entries */
 #define VA_C5(item) ((unsigned long)(item) + BAST_VAM_CS5)
@@ -143,7 +140,7 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 static struct plat_serial8250_port serial_platform_data[] = {
 	[0] = {
 		.mapbase	= VR1000_SERIAL_MAPBASE(0),
-		.irq		= IRQ_VR1000_SERIAL + 0,
+		.irq		= VR1000_IRQ_SERIAL + 0,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -151,7 +148,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	[1] = {
 		.mapbase	= VR1000_SERIAL_MAPBASE(1),
-		.irq		= IRQ_VR1000_SERIAL + 1,
+		.irq		= VR1000_IRQ_SERIAL + 1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -159,7 +156,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	[2] = {
 		.mapbase	= VR1000_SERIAL_MAPBASE(2),
-		.irq		= IRQ_VR1000_SERIAL + 2,
+		.irq		= VR1000_IRQ_SERIAL + 2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -167,7 +164,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	[3] = {
 		.mapbase	= VR1000_SERIAL_MAPBASE(3),
-		.irq		= IRQ_VR1000_SERIAL + 3,
+		.irq		= VR1000_IRQ_SERIAL + 3,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -189,14 +186,14 @@ static struct platform_device serial_device = {
 static struct resource vr1000_dm9k0_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000, 4),
 	[1] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0x40, 0x40),
-	[2] = DEFINE_RES_NAMED(IRQ_VR1000_DM9000A, 1, NULL, IORESOURCE_IRQ \
+	[2] = DEFINE_RES_NAMED(VR1000_IRQ_DM9000A, 1, NULL, IORESOURCE_IRQ \
 						| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 static struct resource vr1000_dm9k1_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0x80, 4),
 	[1] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0xC0, 0x40),
-	[2] = DEFINE_RES_NAMED(IRQ_VR1000_DM9000N, 1, NULL, IORESOURCE_IRQ \
+	[2] = DEFINE_RES_NAMED(VR1000_IRQ_DM9000N, 1, NULL, IORESOURCE_IRQ \
 						| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
diff --git a/arch/arm/mach-s3c24xx/vr1000.h b/arch/arm/mach-s3c24xx/vr1000.h
new file mode 100644
index 0000000..7fcd2c2
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/vr1000.h
@@ -0,0 +1,118 @@
+
+/* arch/arm/mach-s3c2410/include/mach/vr1000-cpld.h
+ *
+ * Copyright (c) 2003 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * VR1000 - CPLD control constants
+ * Machine VR1000 - IRQ Number definitions
+ * Machine VR1000 - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_S3C24XX_VR1000_H
+#define __MACH_S3C24XX_VR1000_H __FILE__
+
+#define VR1000_CPLD_CTRL2_RAMWEN	(0x04)	/* SRAM Write Enable */
+
+/* irq numbers to onboard peripherals */
+
+#define VR1000_IRQ_USBOC		IRQ_EINT19
+#define VR1000_IRQ_IDE0			IRQ_EINT16
+#define VR1000_IRQ_IDE1			IRQ_EINT17
+#define VR1000_IRQ_SERIAL		IRQ_EINT12
+#define VR1000_IRQ_DM9000A		IRQ_EINT10
+#define VR1000_IRQ_DM9000N		IRQ_EINT9
+#define VR1000_IRQ_SMALERT		IRQ_EINT8
+
+/* map */
+
+#define VR1000_IOADDR(x)		(S3C2410_ADDR((x) + 0x01300000))
+
+/* we put the CPLD registers next, to get them out of the way */
+
+#define VR1000_VA_CTRL1			VR1000_IOADDR(0x00000000) /* 0x01300000 */
+#define VR1000_PA_CTRL1			(S3C2410_CS5 | 0x7800000)
+
+#define VR1000_VA_CTRL2			VR1000_IOADDR(0x00100000) /* 0x01400000 */
+#define VR1000_PA_CTRL2			(S3C2410_CS1 | 0x6000000)
+
+#define VR1000_VA_CTRL3			VR1000_IOADDR(0x00200000) /* 0x01500000 */
+#define VR1000_PA_CTRL3			(S3C2410_CS1 | 0x6800000)
+
+#define VR1000_VA_CTRL4			VR1000_IOADDR(0x00300000) /* 0x01600000 */
+#define VR1000_PA_CTRL4			(S3C2410_CS1 | 0x7000000)
+
+/* next, we have the PC104 ISA interrupt registers */
+
+#define VR1000_PA_PC104_IRQREQ		(S3C2410_CS5 | 0x6000000) /* 0x01700000 */
+#define VR1000_VA_PC104_IRQREQ		VR1000_IOADDR(0x00400000)
+
+#define VR1000_PA_PC104_IRQRAW		(S3C2410_CS5 | 0x6800000) /* 0x01800000 */
+#define VR1000_VA_PC104_IRQRAW		VR1000_IOADDR(0x00500000)
+
+#define VR1000_PA_PC104_IRQMASK		(S3C2410_CS5 | 0x7000000) /* 0x01900000 */
+#define VR1000_VA_PC104_IRQMASK		VR1000_IOADDR(0x00600000)
+
+/*
+ * 0xE0000000 contains the IO space that is split by speed and
+ * whether the access is for 8 or 16bit IO... this ensures that
+ * the correct access is made
+ *
+ * 0x10000000 of space, partitioned as so:
+ *
+ * 0x00000000 to 0x04000000  8bit,  slow
+ * 0x04000000 to 0x08000000  16bit, slow
+ * 0x08000000 to 0x0C000000  16bit, net
+ * 0x0C000000 to 0x10000000  16bit, fast
+ *
+ * each of these spaces has the following in:
+ *
+ * 0x02000000 to 0x02100000 1MB  IDE primary channel
+ * 0x02100000 to 0x02200000 1MB  IDE primary channel aux
+ * 0x02200000 to 0x02400000 1MB  IDE secondary channel
+ * 0x02300000 to 0x02400000 1MB  IDE secondary channel aux
+ * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controllers
+ * 0x02600000 to 0x02700000 1MB
+ *
+ * the phyiscal layout of the zones are:
+ *  nGCS2 - 8bit, slow
+ *  nGCS3 - 16bit, slow
+ *  nGCS4 - 16bit, net
+ *  nGCS5 - 16bit, fast
+ */
+
+#define VR1000_VA_MULTISPACE	(0xE0000000)
+
+#define VR1000_VA_ISAIO		(VR1000_VA_MULTISPACE + 0x00000000)
+#define VR1000_VA_ISAMEM	(VR1000_VA_MULTISPACE + 0x01000000)
+#define VR1000_VA_IDEPRI	(VR1000_VA_MULTISPACE + 0x02000000)
+#define VR1000_VA_IDEPRIAUX	(VR1000_VA_MULTISPACE + 0x02100000)
+#define VR1000_VA_IDESEC	(VR1000_VA_MULTISPACE + 0x02200000)
+#define VR1000_VA_IDESECAUX	(VR1000_VA_MULTISPACE + 0x02300000)
+#define VR1000_VA_ASIXNET	(VR1000_VA_MULTISPACE + 0x02400000)
+#define VR1000_VA_DM9000	(VR1000_VA_MULTISPACE + 0x02500000)
+#define VR1000_VA_SUPERIO	(VR1000_VA_MULTISPACE + 0x02600000)
+
+/* physical offset addresses for the peripherals */
+
+#define VR1000_PA_IDEPRI	(0x02000000)
+#define VR1000_PA_IDEPRIAUX	(0x02800000)
+#define VR1000_PA_IDESEC	(0x03000000)
+#define VR1000_PA_IDESECAUX	(0x03800000)
+#define VR1000_PA_DM9000	(0x05000000)
+
+#define VR1000_PA_SERIAL	(0x11800000)
+#define VR1000_VA_SERIAL	(VR1000_IOADDR(0x00700000))
+
+/* VR1000 ram is in CS1, with A26..A24 = 2_101 */
+#define VR1000_PA_SRAM		(S3C2410_CS1 | 0x05000000)
+
+/* some configurations for the peripherals */
+
+#define VR1000_DM9000_CS	VR1000_VAM_CS4
+
+#endif /* __MACH_S3C24XX_VR1000_H */
-- 
1.7.10.4
