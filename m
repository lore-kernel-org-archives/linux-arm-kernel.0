From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:47 -0800
Subject: [PATCH 10/26] ARM: S3C24XX: make anubis-cpld,
 anubis-irq and anubis-map local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/anubis.h                   |   53 ++++++++++++++++++++++
 arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h |   25 ----------
 arch/arm/mach-s3c24xx/include/mach/anubis-irq.h  |   21 ---------
 arch/arm/mach-s3c24xx/include/mach/anubis-map.h  |   38 ----------------
 arch/arm/mach-s3c24xx/mach-anubis.c              |   13 ++----
 5 files changed, 58 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/anubis.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/anubis-irq.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/anubis-map.h

diff --git a/arch/arm/mach-s3c24xx/anubis.h b/arch/arm/mach-s3c24xx/anubis.h
new file mode 100644
index 0000000..2691665
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/anubis.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (c) 2005 Simtec Electronics
+ *	http://www.simtec.co.uk/products/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * ANUBIS - CPLD control constants
+ * ANUBIS - IRQ Number definitions
+ * ANUBIS - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_S3C24XX_ANUBIS_H
+#define __MACH_S3C24XX_ANUBIS_H __FILE__
+
+/* CTRL2 - NAND WP control, IDE Reset assert/check */
+
+#define ANUBIS_CTRL1_NANDSEL		(0x3)
+
+/* IDREG - revision */
+
+#define ANUBIS_IDREG_REVMASK		(0x7)
+
+/* irq */
+
+#define ANUBIS_IRQ_IDE0			IRQ_EINT2
+#define ANUBIS_IRQ_IDE1			IRQ_EINT3
+#define ANUBIS_IRQ_ASIX			IRQ_EINT1
+
+/* map */
+
+/* start peripherals off after the S3C2410 */
+
+#define ANUBIS_IOADDR(x)		(S3C2410_ADDR((x) + 0x01800000))
+
+#define ANUBIS_PA_CPLD			(S3C2410_CS1 | (1<<26))
+
+/* we put the CPLD registers next, to get them out of the way */
+
+#define ANUBIS_VA_CTRL1			ANUBIS_IOADDR(0x00000000)
+#define ANUBIS_PA_CTRL1			ANUBIS_PA_CPLD
+
+#define ANUBIS_VA_IDREG			ANUBIS_IOADDR(0x00300000)
+#define ANUBIS_PA_IDREG			(ANUBIS_PA_CPLD + (3 << 23))
+
+#define ANUBIS_IDEPRI			ANUBIS_IOADDR(0x01000000)
+#define ANUBIS_IDEPRIAUX		ANUBIS_IOADDR(0x01100000)
+#define ANUBIS_IDESEC			ANUBIS_IOADDR(0x01200000)
+#define ANUBIS_IDESECAUX		ANUBIS_IOADDR(0x01300000)
+
+#endif /* __MACH_S3C24XX_ANUBIS_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h b/arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h
deleted file mode 100644
index 1b614d5..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/anubis-cpld.h
- *
- * Copyright (c) 2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * ANUBIS - CPLD control constants
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_ANUBISCPLD_H
-#define __ASM_ARCH_ANUBISCPLD_H
-
-/* CTRL2 - NAND WP control, IDE Reset assert/check */
-
-#define ANUBIS_CTRL1_NANDSEL		(0x3)
-
-/* IDREG - revision */
-
-#define ANUBIS_IDREG_REVMASK		(0x7)
-
-#endif /* __ASM_ARCH_ANUBISCPLD_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/anubis-irq.h b/arch/arm/mach-s3c24xx/include/mach/anubis-irq.h
deleted file mode 100644
index a2a3281..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/anubis-irq.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/anubis-irq.h
- *
- * Copyright (c) 2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  ANUBIS - IRQ Number definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_ANUBISIRQ_H
-#define __ASM_ARCH_ANUBISIRQ_H
-
-#define IRQ_IDE0       IRQ_EINT2
-#define IRQ_IDE1       IRQ_EINT3
-#define IRQ_ASIX       IRQ_EINT1
-
-#endif /* __ASM_ARCH_ANUBISIRQ_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/anubis-map.h b/arch/arm/mach-s3c24xx/include/mach/anubis-map.h
deleted file mode 100644
index c9deb3a..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/anubis-map.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/anubis-map.h
- *
- * Copyright (c) 2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * ANUBIS - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* needs arch/map.h including with this */
-
-#ifndef __ASM_ARCH_ANUBISMAP_H
-#define __ASM_ARCH_ANUBISMAP_H
-
-/* start peripherals off after the S3C2410 */
-
-#define ANUBIS_IOADDR(x)	(S3C2410_ADDR((x) + 0x01800000))
-
-#define ANUBIS_PA_CPLD		(S3C2410_CS1 | (1<<26))
-
-/* we put the CPLD registers next, to get them out of the way */
-
-#define ANUBIS_VA_CTRL1	    ANUBIS_IOADDR(0x00000000)	 /* 0x01800000 */
-#define ANUBIS_PA_CTRL1	    (ANUBIS_PA_CPLD)
-
-#define ANUBIS_VA_IDREG	    ANUBIS_IOADDR(0x00300000)	 /* 0x01B00000 */
-#define ANUBIS_PA_IDREG	    (ANUBIS_PA_CPLD + (3<<23))
-
-#define ANUBIS_IDEPRI	    ANUBIS_IOADDR(0x01000000)
-#define ANUBIS_IDEPRIAUX    ANUBIS_IOADDR(0x01100000)
-#define ANUBIS_IDESEC	    ANUBIS_IOADDR(0x01200000)
-#define ANUBIS_IDESECAUX    ANUBIS_IOADDR(0x01300000)
-
-#endif /* __ASM_ARCH_ANUBISMAP_H */
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 1ee8c46..113304c 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -28,10 +28,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/anubis-map.h>
-#include <mach/anubis-irq.h>
-#include <mach/anubis-cpld.h>
-
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -55,8 +51,9 @@
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 
-#include "simtec.h"
+#include "anubis.h"
 #include "common.h"
+#include "simtec.h"
 
 #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
 
@@ -237,7 +234,7 @@ static struct pata_platform_info anubis_ide_platdata = {
 static struct resource anubis_ide0_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS3, 8 * 32),
 	[2] = DEFINE_RES_MEM(S3C2410_CS3 + (1 << 26) + (6 * 32), 32),
-	[3] = DEFINE_RES_IRQ(IRQ_IDE0),
+	[3] = DEFINE_RES_IRQ(ANUBIS_IRQ_IDE0),
 };
 
 static struct platform_device anubis_device_ide0 = {
@@ -254,7 +251,7 @@ static struct platform_device anubis_device_ide0 = {
 static struct resource anubis_ide1_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS4, 8 * 32),
 	[1] = DEFINE_RES_MEM(S3C2410_CS4 + (1 << 26) + (6 * 32), 32),
-	[2] = DEFINE_RES_IRQ(IRQ_IDE0),
+	[2] = DEFINE_RES_IRQ(ANUBIS_IRQ_IDE0),
 };
 
 static struct platform_device anubis_device_ide1 = {
@@ -279,7 +276,7 @@ static struct ax_plat_data anubis_asix_platdata = {
 
 static struct resource anubis_asix_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS5, 0x20 * 0x20),
-	[1] = DEFINE_RES_IRQ(IRQ_ASIX),
+	[1] = DEFINE_RES_IRQ(ANUBIS_IRQ_ASIX),
 };
 
 static struct platform_device anubis_device_asix = {
-- 
1.7.10.4
