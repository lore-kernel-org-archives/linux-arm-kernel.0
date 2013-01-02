From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:48 -0800
Subject: [PATCH 11/26] ARM: S3C24XX: make bast-cpld.h,
 bast-irq.h and bast-map.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/bast-ide.c                |   18 +--
 arch/arm/mach-s3c24xx/bast-irq.c                |   19 +--
 arch/arm/mach-s3c24xx/bast.h                    |  197 +++++++++++++++++++++++
 arch/arm/mach-s3c24xx/include/mach/bast-cpld.h  |   53 ------
 arch/arm/mach-s3c24xx/include/mach/bast-irq.h   |   29 ----
 arch/arm/mach-s3c24xx/include/mach/bast-map.h   |  146 -----------------
 arch/arm/mach-s3c24xx/include/mach/vr1000-map.h |    4 +-
 arch/arm/mach-s3c24xx/mach-bast.c               |   52 +++---
 arch/arm/mach-s3c24xx/mach-vr1000.c             |    4 +-
 arch/arm/mach-s3c24xx/simtec-audio.c            |    5 +-
 arch/arm/mach-s3c24xx/simtec-nor.c              |    3 +-
 arch/arm/mach-s3c24xx/simtec-usb.c              |    8 +-
 12 files changed, 242 insertions(+), 296 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/bast.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/bast-cpld.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/bast-irq.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/bast-map.h

diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
index ba02cf8..3f0288f 100644
--- a/arch/arm/mach-s3c24xx/bast-ide.c
+++ b/arch/arm/mach-s3c24xx/bast-ide.c
@@ -25,8 +25,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/map.h>
-#include <mach/bast-map.h>
-#include <mach/bast-irq.h>
+
+#include "bast.h"
 
 /* IDE ports */
 
@@ -34,12 +34,10 @@ static struct pata_platform_info bast_ide_platdata = {
 	.ioport_shift	= 5,
 };
 
-#define IDE_CS	S3C2410_CS5
-
 static struct resource bast_ide0_resource[] = {
-	[0] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDEPRI, 8 * 0x20),
-	[1] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDEPRIAUX + (6 * 0x20), 0x20),
-	[2] = DEFINE_RES_IRQ(IRQ_IDE0),
+	[0] = DEFINE_RES_MEM(BAST_IDE_CS + BAST_PA_IDEPRI, 8 * 0x20),
+	[1] = DEFINE_RES_MEM(BAST_IDE_CS + BAST_PA_IDEPRIAUX + (6 * 0x20), 0x20),
+	[2] = DEFINE_RES_IRQ(BAST_IRQ_IDE0),
 };
 
 static struct platform_device bast_device_ide0 = {
@@ -55,9 +53,9 @@ static struct platform_device bast_device_ide0 = {
 };
 
 static struct resource bast_ide1_resource[] = {
-	[0] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDESEC, 8 * 0x20),
-	[1] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDESECAUX + (6 * 0x20), 0x20),
-	[2] = DEFINE_RES_IRQ(IRQ_IDE1),
+	[0] = DEFINE_RES_MEM(BAST_IDE_CS + BAST_PA_IDESEC, 8 * 0x20),
+	[1] = DEFINE_RES_MEM(BAST_IDE_CS + BAST_PA_IDESECAUX + (6 * 0x20), 0x20),
+	[2] = DEFINE_RES_IRQ(BAST_IRQ_IDE1),
 };
 
 static struct platform_device bast_device_ide1 = {
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index ac7b2ad..c0daa95 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -27,27 +27,20 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include <asm/mach-types.h>
-
-#include <mach/hardware.h>
 #include <asm/irq.h>
-
+#include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
+#include <mach/hardware.h>
 #include <mach/regs-irq.h>
-#include <mach/bast-map.h>
-#include <mach/bast-irq.h>
 
 #include <plat/irq.h>
 
-#if 0
-#include <asm/debug-ll.h>
-#endif
+#include "bast.h"
 
 #define irqdbf(x...)
 #define irqdbf2(x...)
 
-
 /* handle PC104 ISA interrupts from the system CPLD */
 
 /* table of ISA irq nos to the relevant mask... zero means
@@ -87,7 +80,7 @@ bast_pc104_mask(struct irq_data *data)
 static void
 bast_pc104_maskack(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_desc + IRQ_ISA;
+	struct irq_desc *desc = irq_desc + BAST_IRQ_ISA;
 
 	bast_pc104_mask(data);
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -122,7 +115,7 @@ bast_irq_pc104_demux(unsigned int irq,
 	if (unlikely(stat == 0)) {
 		/* ack if we get an irq with nothing (ie, startup) */
 
-		desc = irq_desc + IRQ_ISA;
+		desc = irq_desc + BAST_IRQ_ISA;
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 	} else {
 		/* handle the IRQ */
@@ -147,7 +140,7 @@ static __init int bast_irq_init(void)
 
 		__raw_writeb(0x0, BAST_VA_PC104_IRQMASK);
 
-		irq_set_chained_handler(IRQ_ISA, bast_irq_pc104_demux);
+		irq_set_chained_handler(BAST_IRQ_ISA, bast_irq_pc104_demux);
 
 		/* register our IRQs */
 
diff --git a/arch/arm/mach-s3c24xx/bast.h b/arch/arm/mach-s3c24xx/bast.h
new file mode 100644
index 0000000..5c7534b
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/bast.h
@@ -0,0 +1,197 @@
+/*
+ * Copyright (c) 2003-2004 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * BAST - CPLD control constants
+ * BAST - IRQ Number definitions
+ * BAST - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_S3C24XX_BAST_H
+#define __MACH_S3C24XX_BAST_H __FILE__
+
+/* CTRL1 - Audio LR routing */
+
+#define BAST_CPLD_CTRL1_LRCOFF		(0x00)
+#define BAST_CPLD_CTRL1_LRCADC		(0x01)
+#define BAST_CPLD_CTRL1_LRCDAC		(0x02)
+#define BAST_CPLD_CTRL1_LRCARM		(0x03)
+#define BAST_CPLD_CTRL1_LRMASK		(0x03)
+
+/* CTRL2 - NAND WP control, IDE Reset assert/check */
+
+#define BAST_CPLD_CTRL2_WNAND		(0x04)
+#define BAST_CPLD_CTLR2_IDERST		(0x08)
+
+/* CTRL3 - rom write control, CPLD identity */
+
+#define BAST_CPLD_CTRL3_IDMASK		(0x0e)
+#define BAST_CPLD_CTRL3_ROMWEN		(0x01)
+
+/* CTRL4 - 8bit LCD interface control/status */
+
+#define BAST_CPLD_CTRL4_LLAT		(0x01)
+#define BAST_CPLD_CTRL4_LCDRW		(0x02)
+#define BAST_CPLD_CTRL4_LCDCMD		(0x04)
+#define BAST_CPLD_CTRL4_LCDE2		(0x01)
+
+/* CTRL5 - DMA routing */
+
+#define BAST_CPLD_DMA0_PRIIDE		(0)
+#define BAST_CPLD_DMA0_SECIDE		(1)
+#define BAST_CPLD_DMA0_ISA15		(2)
+#define BAST_CPLD_DMA0_ISA36		(3)
+
+#define BAST_CPLD_DMA1_PRIIDE		(0 << 2)
+#define BAST_CPLD_DMA1_SECIDE		(1 << 2)
+#define BAST_CPLD_DMA1_ISA15		(2 << 2)
+#define BAST_CPLD_DMA1_ISA36		(3 << 2)
+
+/* irq numbers to onboard peripherals */
+
+#define BAST_IRQ_USBOC			IRQ_EINT18
+#define BAST_IRQ_IDE0			IRQ_EINT16
+#define BAST_IRQ_IDE1			IRQ_EINT17
+#define BAST_IRQ_PCSERIAL1		IRQ_EINT15
+#define BAST_IRQ_PCSERIAL2		IRQ_EINT14
+#define BAST_IRQ_PCPARALLEL		IRQ_EINT13
+#define BAST_IRQ_ASIX			IRQ_EINT11
+#define BAST_IRQ_DM9000			IRQ_EINT10
+#define BAST_IRQ_ISA			IRQ_EINT9
+#define BAST_IRQ_SMALERT		IRQ_EINT8
+
+/* map */
+
+/*
+ * ok, we've used up to 0x13000000, now we need to find space for the
+ * peripherals that live in the nGCS[x] areas, which are quite numerous
+ * in their space. We also have the board's CPLD to find register space
+ * for.
+ */
+
+#define BAST_IOADDR(x)			(S3C2410_ADDR((x) + 0x01300000))
+
+/* we put the CPLD registers next, to get them out of the way */
+
+#define BAST_VA_CTRL1			BAST_IOADDR(0x00000000)
+#define BAST_PA_CTRL1			(S3C2410_CS5 | 0x7800000)
+
+#define BAST_VA_CTRL2			BAST_IOADDR(0x00100000)
+#define BAST_PA_CTRL2			(S3C2410_CS1 | 0x6000000)
+
+#define BAST_VA_CTRL3			BAST_IOADDR(0x00200000)
+#define BAST_PA_CTRL3			(S3C2410_CS1 | 0x6800000)
+
+#define BAST_VA_CTRL4			BAST_IOADDR(0x00300000)
+#define BAST_PA_CTRL4			(S3C2410_CS1 | 0x7000000)
+
+/* next, we have the PC104 ISA interrupt registers */
+
+#define BAST_PA_PC104_IRQREQ		(S3C2410_CS5 | 0x6000000)
+#define BAST_VA_PC104_IRQREQ		BAST_IOADDR(0x00400000)
+
+#define BAST_PA_PC104_IRQRAW		(S3C2410_CS5 | 0x6800000)
+#define BAST_VA_PC104_IRQRAW		BAST_IOADDR(0x00500000)
+
+#define BAST_PA_PC104_IRQMASK		(S3C2410_CS5 | 0x7000000)
+#define BAST_VA_PC104_IRQMASK		BAST_IOADDR(0x00600000)
+
+#define BAST_PA_LCD_RCMD1		(0x8800000)
+#define BAST_VA_LCD_RCMD1		BAST_IOADDR(0x00700000)
+
+#define BAST_PA_LCD_WCMD1		(0x8000000)
+#define BAST_VA_LCD_WCMD1		BAST_IOADDR(0x00800000)
+
+#define BAST_PA_LCD_RDATA1		(0x9800000)
+#define BAST_VA_LCD_RDATA1		BAST_IOADDR(0x00900000)
+
+#define BAST_PA_LCD_WDATA1		(0x9000000)
+#define BAST_VA_LCD_WDATA1		BAST_IOADDR(0x00A00000)
+
+#define BAST_PA_LCD_RCMD2		(0xA800000)
+#define BAST_VA_LCD_RCMD2		BAST_IOADDR(0x00B00000)
+
+#define BAST_PA_LCD_WCMD2		(0xA000000)
+#define BAST_VA_LCD_WCMD2		BAST_IOADDR(0x00C00000)
+
+#define BAST_PA_LCD_RDATA2		(0xB800000)
+#define BAST_VA_LCD_RDATA2		BAST_IOADDR(0x00D00000)
+
+#define BAST_PA_LCD_WDATA2		(0xB000000)
+#define BAST_VA_LCD_WDATA2		BAST_IOADDR(0x00E00000)
+
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
+ * 0x00000000 to 0x01000000 16MB ISA IO space
+ * 0x01000000 to 0x02000000 16MB ISA memory space
+ * 0x02000000 to 0x02100000 1MB  IDE primary channel
+ * 0x02100000 to 0x02200000 1MB  IDE primary channel aux
+ * 0x02200000 to 0x02400000 1MB  IDE secondary channel
+ * 0x02300000 to 0x02400000 1MB  IDE secondary channel aux
+ * 0x02400000 to 0x02500000 1MB  ASIX ethernet controller
+ * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controller
+ * 0x02600000 to 0x02700000 1MB  PC SuperIO controller
+ *
+ * the phyiscal layout of the zones are:
+ *  nGCS2 - 8bit, slow
+ *  nGCS3 - 16bit, slow
+ *  nGCS4 - 16bit, net
+ *  nGCS5 - 16bit, fast
+ */
+
+#define BAST_VA_MULTISPACE		(0xE0000000)
+
+#define BAST_VA_ISAIO			(BAST_VA_MULTISPACE + 0x00000000)
+#define BAST_VA_ISAMEM			(BAST_VA_MULTISPACE + 0x01000000)
+#define BAST_VA_IDEPRI			(BAST_VA_MULTISPACE + 0x02000000)
+#define BAST_VA_IDEPRIAUX		(BAST_VA_MULTISPACE + 0x02100000)
+#define BAST_VA_IDESEC			(BAST_VA_MULTISPACE + 0x02200000)
+#define BAST_VA_IDESECAUX		(BAST_VA_MULTISPACE + 0x02300000)
+#define BAST_VA_ASIXNET			(BAST_VA_MULTISPACE + 0x02400000)
+#define BAST_VA_DM9000			(BAST_VA_MULTISPACE + 0x02500000)
+#define BAST_VA_SUPERIO			(BAST_VA_MULTISPACE + 0x02600000)
+
+#define BAST_VAM_CS2			(0x00000000)
+#define BAST_VAM_CS3			(0x04000000)
+#define BAST_VAM_CS4			(0x08000000)
+#define BAST_VAM_CS5			(0x0C000000)
+
+/* physical offset addresses for the peripherals */
+
+#define BAST_PA_ISAIO			(0x00000000)
+#define BAST_PA_ASIXNET			(0x01000000)
+#define BAST_PA_SUPERIO			(0x01800000)
+#define BAST_PA_IDEPRI			(0x02000000)
+#define BAST_PA_IDEPRIAUX		(0x02800000)
+#define BAST_PA_IDESEC			(0x03000000)
+#define BAST_PA_IDESECAUX		(0x03800000)
+#define BAST_PA_ISAMEM			(0x04000000)
+#define BAST_PA_DM9000			(0x05000000)
+
+/* some configurations for the peripherals */
+
+#define BAST_PCSIO			(BAST_VA_SUPERIO + BAST_VAM_CS2)
+
+#define BAST_ASIXNET_CS			BAST_VAM_CS5
+#define BAST_DM9000_CS			BAST_VAM_CS4
+
+#define BAST_IDE_CS	S3C2410_CS5
+
+#endif /* __MACH_S3C24XX_BAST_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/bast-cpld.h b/arch/arm/mach-s3c24xx/include/mach/bast-cpld.h
deleted file mode 100644
index bee2a7a..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/bast-cpld.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/bast-cpld.h
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * BAST - CPLD control constants
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_BASTCPLD_H
-#define __ASM_ARCH_BASTCPLD_H
-
-/* CTRL1 - Audio LR routing */
-
-#define BAST_CPLD_CTRL1_LRCOFF	    (0x00)
-#define BAST_CPLD_CTRL1_LRCADC	    (0x01)
-#define BAST_CPLD_CTRL1_LRCDAC	    (0x02)
-#define BAST_CPLD_CTRL1_LRCARM	    (0x03)
-#define BAST_CPLD_CTRL1_LRMASK	    (0x03)
-
-/* CTRL2 - NAND WP control, IDE Reset assert/check */
-
-#define BAST_CPLD_CTRL2_WNAND       (0x04)
-#define BAST_CPLD_CTLR2_IDERST      (0x08)
-
-/* CTRL3 - rom write control, CPLD identity */
-
-#define BAST_CPLD_CTRL3_IDMASK      (0x0e)
-#define BAST_CPLD_CTRL3_ROMWEN      (0x01)
-
-/* CTRL4 - 8bit LCD interface control/status */
-
-#define BAST_CPLD_CTRL4_LLAT	    (0x01)
-#define BAST_CPLD_CTRL4_LCDRW	    (0x02)
-#define BAST_CPLD_CTRL4_LCDCMD	    (0x04)
-#define BAST_CPLD_CTRL4_LCDE2	    (0x01)
-
-/* CTRL5 - DMA routing */
-
-#define BAST_CPLD_DMA0_PRIIDE      (0<<0)
-#define BAST_CPLD_DMA0_SECIDE      (1<<0)
-#define BAST_CPLD_DMA0_ISA15       (2<<0)
-#define BAST_CPLD_DMA0_ISA36       (3<<0)
-
-#define BAST_CPLD_DMA1_PRIIDE      (0<<2)
-#define BAST_CPLD_DMA1_SECIDE      (1<<2)
-#define BAST_CPLD_DMA1_ISA15       (2<<2)
-#define BAST_CPLD_DMA1_ISA36       (3<<2)
-
-#endif /* __ASM_ARCH_BASTCPLD_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/bast-irq.h b/arch/arm/mach-s3c24xx/include/mach/bast-irq.h
deleted file mode 100644
index cac428c..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/bast-irq.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/bast-irq.h
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Machine BAST - IRQ Number definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_BASTIRQ_H
-#define __ASM_ARCH_BASTIRQ_H
-
-/* irq numbers to onboard peripherals */
-
-#define IRQ_USBOC      IRQ_EINT18
-#define IRQ_IDE0       IRQ_EINT16
-#define IRQ_IDE1       IRQ_EINT17
-#define IRQ_PCSERIAL1  IRQ_EINT15
-#define IRQ_PCSERIAL2  IRQ_EINT14
-#define IRQ_PCPARALLEL IRQ_EINT13
-#define IRQ_ASIX       IRQ_EINT11
-#define IRQ_DM9000     IRQ_EINT10
-#define IRQ_ISA	       IRQ_EINT9
-#define IRQ_SMALERT    IRQ_EINT8
-
-#endif /* __ASM_ARCH_BASTIRQ_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/bast-map.h b/arch/arm/mach-s3c24xx/include/mach/bast-map.h
deleted file mode 100644
index eecea2a..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/bast-map.h
+++ /dev/null
@@ -1,146 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/bast-map.h
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Machine BAST - Memory map definitions
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
-#ifndef __ASM_ARCH_BASTMAP_H
-#define __ASM_ARCH_BASTMAP_H
-
-#define BAST_IOADDR(x)	   (S3C2410_ADDR((x) + 0x01300000))
-
-/* we put the CPLD registers next, to get them out of the way */
-
-#define BAST_VA_CTRL1	    BAST_IOADDR(0x00000000)	 /* 0x01300000 */
-#define BAST_PA_CTRL1	    (S3C2410_CS5 | 0x7800000)
-
-#define BAST_VA_CTRL2	    BAST_IOADDR(0x00100000)	 /* 0x01400000 */
-#define BAST_PA_CTRL2	    (S3C2410_CS1 | 0x6000000)
-
-#define BAST_VA_CTRL3	    BAST_IOADDR(0x00200000)	 /* 0x01500000 */
-#define BAST_PA_CTRL3	    (S3C2410_CS1 | 0x6800000)
-
-#define BAST_VA_CTRL4	    BAST_IOADDR(0x00300000)	 /* 0x01600000 */
-#define BAST_PA_CTRL4	    (S3C2410_CS1 | 0x7000000)
-
-/* next, we have the PC104 ISA interrupt registers */
-
-#define BAST_PA_PC104_IRQREQ  (S3C2410_CS5 | 0x6000000) /* 0x01700000 */
-#define BAST_VA_PC104_IRQREQ  BAST_IOADDR(0x00400000)
-
-#define BAST_PA_PC104_IRQRAW  (S3C2410_CS5 | 0x6800000) /* 0x01800000 */
-#define BAST_VA_PC104_IRQRAW  BAST_IOADDR(0x00500000)
-
-#define BAST_PA_PC104_IRQMASK (S3C2410_CS5 | 0x7000000) /* 0x01900000 */
-#define BAST_VA_PC104_IRQMASK BAST_IOADDR(0x00600000)
-
-#define BAST_PA_LCD_RCMD1     (0x8800000)
-#define BAST_VA_LCD_RCMD1     BAST_IOADDR(0x00700000)
-
-#define BAST_PA_LCD_WCMD1     (0x8000000)
-#define BAST_VA_LCD_WCMD1     BAST_IOADDR(0x00800000)
-
-#define BAST_PA_LCD_RDATA1    (0x9800000)
-#define BAST_VA_LCD_RDATA1    BAST_IOADDR(0x00900000)
-
-#define BAST_PA_LCD_WDATA1    (0x9000000)
-#define BAST_VA_LCD_WDATA1    BAST_IOADDR(0x00A00000)
-
-#define BAST_PA_LCD_RCMD2     (0xA800000)
-#define BAST_VA_LCD_RCMD2     BAST_IOADDR(0x00B00000)
-
-#define BAST_PA_LCD_WCMD2     (0xA000000)
-#define BAST_VA_LCD_WCMD2     BAST_IOADDR(0x00C00000)
-
-#define BAST_PA_LCD_RDATA2    (0xB800000)
-#define BAST_VA_LCD_RDATA2    BAST_IOADDR(0x00D00000)
-
-#define BAST_PA_LCD_WDATA2    (0xB000000)
-#define BAST_VA_LCD_WDATA2    BAST_IOADDR(0x00E00000)
-
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
- * 0x00000000 to 0x01000000 16MB ISA IO space
- * 0x01000000 to 0x02000000 16MB ISA memory space
- * 0x02000000 to 0x02100000 1MB  IDE primary channel
- * 0x02100000 to 0x02200000 1MB  IDE primary channel aux
- * 0x02200000 to 0x02400000 1MB  IDE secondary channel
- * 0x02300000 to 0x02400000 1MB  IDE secondary channel aux
- * 0x02400000 to 0x02500000 1MB  ASIX ethernet controller
- * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controller
- * 0x02600000 to 0x02700000 1MB  PC SuperIO controller
- *
- * the phyiscal layout of the zones are:
- *  nGCS2 - 8bit, slow
- *  nGCS3 - 16bit, slow
- *  nGCS4 - 16bit, net
- *  nGCS5 - 16bit, fast
- */
-
-#define BAST_VA_MULTISPACE (0xE0000000)
-
-#define BAST_VA_ISAIO	   (BAST_VA_MULTISPACE + 0x00000000)
-#define BAST_VA_ISAMEM	   (BAST_VA_MULTISPACE + 0x01000000)
-#define BAST_VA_IDEPRI	   (BAST_VA_MULTISPACE + 0x02000000)
-#define BAST_VA_IDEPRIAUX  (BAST_VA_MULTISPACE + 0x02100000)
-#define BAST_VA_IDESEC	   (BAST_VA_MULTISPACE + 0x02200000)
-#define BAST_VA_IDESECAUX  (BAST_VA_MULTISPACE + 0x02300000)
-#define BAST_VA_ASIXNET	   (BAST_VA_MULTISPACE + 0x02400000)
-#define BAST_VA_DM9000	   (BAST_VA_MULTISPACE + 0x02500000)
-#define BAST_VA_SUPERIO	   (BAST_VA_MULTISPACE + 0x02600000)
-
-#define BAST_VA_MULTISPACE (0xE0000000)
-
-#define BAST_VAM_CS2 (0x00000000)
-#define BAST_VAM_CS3 (0x04000000)
-#define BAST_VAM_CS4 (0x08000000)
-#define BAST_VAM_CS5 (0x0C000000)
-
-/* physical offset addresses for the peripherals */
-
-#define BAST_PA_ISAIO	  (0x00000000)
-#define BAST_PA_ASIXNET	  (0x01000000)
-#define BAST_PA_SUPERIO	  (0x01800000)
-#define BAST_PA_IDEPRI	  (0x02000000)
-#define BAST_PA_IDEPRIAUX (0x02800000)
-#define BAST_PA_IDESEC	  (0x03000000)
-#define BAST_PA_IDESECAUX (0x03800000)
-#define BAST_PA_ISAMEM	  (0x04000000)
-#define BAST_PA_DM9000	  (0x05000000)
-
-/* some configurations for the peripherals */
-
-#define BAST_PCSIO (BAST_VA_SUPERIO + BAST_VAM_CS2)
-/*  */
-
-#define BAST_ASIXNET_CS  BAST_VAM_CS5
-#define BAST_IDE_CS	 BAST_VAM_CS5
-#define BAST_DM9000_CS	 BAST_VAM_CS4
-
-#endif /* __ASM_ARCH_BASTMAP_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
index 28376e5..5f836a7 100644
--- a/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
@@ -21,9 +21,7 @@
 #ifndef __ASM_ARCH_VR1000MAP_H
 #define __ASM_ARCH_VR1000MAP_H
 
-#include <mach/bast-map.h>
-
-#define VR1000_IOADDR(x) BAST_IOADDR(x)
+#define VR1000_IOADDR(x)	(S3C2410_ADDR((x) + 0x01300000))
 
 /* we put the CPLD registers next, to get them out of the way */
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 6a30ce7..1ed29b4 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -24,48 +24,42 @@
 #include <linux/ata_platform.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
+#include <linux/serial_8250.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+
+#include <linux/platform_data/asoc-s3c24xx_simtec.h>
+#include <linux/platform_data/hwmon-s3c.h>
+#include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/mtd-nand-s3c2410.h>
 
 #include <net/ax88796.h>
 
+#include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-
-#include <mach/bast-map.h>
-#include <mach/bast-irq.h>
-#include <mach/bast-cpld.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
 #include <asm/mach-types.h>
 
-//#include <asm/debug-ll.h>
-#include <plat/regs-serial.h>
+#include <mach/fb.h>
+#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-
-#include <linux/platform_data/hwmon-s3c.h>
-#include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/fb.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/partitions.h>
-
-#include <linux/serial_8250.h>
+#include <mach/regs-mem.h>
 
 #include <plat/clock.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/cpu-freq.h>
+#include <plat/devs.h>
 #include <plat/gpio-cfg.h>
-#include <linux/platform_data/asoc-s3c24xx_simtec.h>
+#include <plat/regs-serial.h>
 
-#include "simtec.h"
+#include "bast.h"
 #include "common.h"
+#include "simtec.h"
 
 #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
 
@@ -312,7 +306,7 @@ static struct s3c2410_platform_nand __initdata bast_nand_info = {
 static struct resource bast_dm9k_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_DM9000, 4),
 	[1] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_DM9000 + 0x40, 0x40),
-	[2] = DEFINE_RES_NAMED(IRQ_DM9000 , 1, NULL, IORESOURCE_IRQ \
+	[2] = DEFINE_RES_NAMED(BAST_IRQ_DM9000 , 1, NULL, IORESOURCE_IRQ \
 					| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
@@ -343,7 +337,7 @@ static struct platform_device bast_device_dm9k = {
 static struct plat_serial8250_port bast_sio_data[] = {
 	[0] = {
 		.mapbase	= SERIAL_BASE + 0x2f8,
-		.irq		= IRQ_PCSERIAL1,
+		.irq		= BAST_IRQ_PCSERIAL1,
 		.flags		= SERIAL_FLAGS,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -351,7 +345,7 @@ static struct plat_serial8250_port bast_sio_data[] = {
 	},
 	[1] = {
 		.mapbase	= SERIAL_BASE + 0x3f8,
-		.irq		= IRQ_PCSERIAL2,
+		.irq		= BAST_IRQ_PCSERIAL2,
 		.flags		= SERIAL_FLAGS,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
@@ -390,7 +384,7 @@ static struct ax_plat_data bast_asix_platdata = {
 static struct resource bast_asix_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_ASIXNET, 0x18 * 0x20),
 	[1] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_ASIXNET + (0x1f * 0x20), 1),
-	[2] = DEFINE_RES_IRQ(IRQ_ASIX),
+	[2] = DEFINE_RES_IRQ(BAST_IRQ_ASIX),
 };
 
 static struct platform_device bast_device_asix = {
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 14d5b12..80cffbf 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -32,7 +32,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/bast-map.h>
 #include <mach/vr1000-map.h>
 #include <mach/vr1000-irq.h>
 #include <mach/vr1000-cpld.h>
@@ -51,8 +50,9 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 
-#include "simtec.h"
+#include "bast.h"
 #include "common.h"
+#include "simtec.h"
 
 /* macros for virtual address mods for the io space entries */
 #define VA_C5(item) ((unsigned long)(item) + BAST_VAM_CS5)
diff --git a/arch/arm/mach-s3c24xx/simtec-audio.c b/arch/arm/mach-s3c24xx/simtec-audio.c
index fd0ef05..67cb512 100644
--- a/arch/arm/mach-s3c24xx/simtec-audio.c
+++ b/arch/arm/mach-s3c24xx/simtec-audio.c
@@ -17,16 +17,13 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include <mach/bast-map.h>
-#include <mach/bast-irq.h>
-#include <mach/bast-cpld.h>
-
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 #include <plat/devs.h>
 
+#include "bast.h"
 #include "simtec.h"
 
 /* platform ops for audio */
diff --git a/arch/arm/mach-s3c24xx/simtec-nor.c b/arch/arm/mach-s3c24xx/simtec-nor.c
index 029744f..8884bff 100644
--- a/arch/arm/mach-s3c24xx/simtec-nor.c
+++ b/arch/arm/mach-s3c24xx/simtec-nor.c
@@ -27,9 +27,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/map.h>
-#include <mach/bast-map.h>
-#include <mach/bast-cpld.h>
 
+#include "bast.h"
 #include "simtec.h"
 
 static void simtec_nor_vpp(struct platform_device *pdev, int vpp)
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index ddf7a3c..2ed2e32 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -28,15 +28,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/bast-map.h>
-#include <mach/bast-irq.h>
-
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/devs.h>
 
+#include "bast.h"
 #include "simtec.h"
 
 /* control power and monitor over-current events on various Simtec
@@ -79,7 +77,7 @@ static void usb_simtec_enableoc(struct s3c2410_hcd_info *info, int on)
 	int ret;
 
 	if (on) {
-		ret = request_irq(IRQ_USBOC, usb_simtec_ocirq,
+		ret = request_irq(BAST_IRQ_USBOC, usb_simtec_ocirq,
 				  IRQF_DISABLED | IRQF_TRIGGER_RISING |
 				   IRQF_TRIGGER_FALLING,
 				  "USB Over-current", info);
@@ -87,7 +85,7 @@ static void usb_simtec_enableoc(struct s3c2410_hcd_info *info, int on)
 			printk(KERN_ERR "failed to request usb oc irq\n");
 		}
 	} else {
-		free_irq(IRQ_USBOC, info);
+		free_irq(BAST_IRQ_USBOC, info);
 	}
 }
 
-- 
1.7.10.4
