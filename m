From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:54 +0100
Subject: [PATCH 03/15] ARM: S3C2416: Add S3C2416-specific registers definitions
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Add macros for S3C2416 SoC support.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
[ben-linux at fluff.org: removed files that need changing]
[ben-linux at fluff.org: Fix S3C2416_GPH0_TXD0 definition]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/dma.h           |    2 +-
 arch/arm/mach-s3c2410/include/mach/irqs.h          |   22 +++++++++++-
 arch/arm/mach-s3c2410/include/mach/regs-dsc.h      |   36 ++++++++++++++++++++
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |   28 +++++++++++++++
 arch/arm/mach-s3c2410/include/mach/regs-irq.h      |   10 +++++
 .../mach-s3c2410/include/mach/regs-s3c2416-mem.h   |   30 ++++++++++++++++
 arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h  |   24 +++++++++++++
 7 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
 create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index 08ac5f9..cf68136 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -54,7 +54,7 @@ enum dma_ch {
 #define DMACH_LOW_LEVEL	(1<<28)	/* use this to specifiy hardware ch no */
 
 /* we have 4 dma channels */
-#ifndef CONFIG_CPU_S3C2443
+#if !defined(CONFIG_CPU_S3C2443) && !defined(CONFIG_CPU_S3C2416)
 #define S3C_DMA_CHANNELS		(4)
 #else
 #define S3C_DMA_CHANNELS		(6)
diff --git a/arch/arm/mach-s3c2410/include/mach/irqs.h b/arch/arm/mach-s3c2410/include/mach/irqs.h
index 6c12c63..c1b8ec0 100644
--- a/arch/arm/mach-s3c2410/include/mach/irqs.h
+++ b/arch/arm/mach-s3c2410/include/mach/irqs.h
@@ -115,6 +115,26 @@
 #define IRQ_S3C2412_SDI		S3C2410_IRQSUB(13)
 #define IRQ_S3C2412_CF		S3C2410_IRQSUB(14)
 
+
+#define IRQ_S3C2416_EINT8t15	S3C2410_IRQ(5)
+#define IRQ_S3C2416_DMA		S3C2410_IRQ(17)
+#define IRQ_S3C2416_UART3	S3C2410_IRQ(18)
+#define IRQ_S3C2416_SDI1	S3C2410_IRQ(20)
+#define IRQ_S3C2416_SDI0	S3C2410_IRQ(21)
+
+#define IRQ_S3C2416_LCD2	S3C2410_IRQSUB(15)
+#define IRQ_S3C2416_LCD3	S3C2410_IRQSUB(16)
+#define IRQ_S3C2416_LCD4	S3C2410_IRQSUB(17)
+#define IRQ_S3C2416_DMA0	S3C2410_IRQSUB(18)
+#define IRQ_S3C2416_DMA1	S3C2410_IRQSUB(19)
+#define IRQ_S3C2416_DMA2	S3C2410_IRQSUB(20)
+#define IRQ_S3C2416_DMA3	S3C2410_IRQSUB(21)
+#define IRQ_S3C2416_DMA4	S3C2410_IRQSUB(22)
+#define IRQ_S3C2416_DMA5	S3C2410_IRQSUB(23)
+#define IRQ_S32416_WDT		S3C2410_IRQSUB(27)
+#define IRQ_S32416_AC97		S3C2410_IRQSUB(28)
+
+
 /* extra irqs for s3c2440 */
 
 #define IRQ_S3C2440_CAM_C	S3C2410_IRQSUB(11)	/* S3C2443 too */
@@ -152,7 +172,7 @@
 #define IRQ_S3C2443_WDT		S3C2410_IRQSUB(27)
 #define IRQ_S3C2443_AC97	S3C2410_IRQSUB(28)
 
-#ifdef CONFIG_CPU_S3C2443
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 #define NR_IRQS (IRQ_S3C2443_AC97+1)
 #else
 #define NR_IRQS (IRQ_S3C2440_AC97+1)
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-dsc.h b/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
index 3c3853c..98fd4a0 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
@@ -19,6 +19,42 @@
 #define S3C2412_DSC1	   S3C2410_GPIOREG(0xe0)
 #endif
 
+#if defined(CONFIG_CPU_S3C2416)
+#define S3C2416_DSC0	   S3C2410_GPIOREG(0xc0)
+#define S3C2416_DSC1	   S3C2410_GPIOREG(0xc4)
+#define S3C2416_DSC2	   S3C2410_GPIOREG(0xc8)
+#define S3C2416_DSC3	   S3C2410_GPIOREG(0x110)
+
+#define S3C2416_SELECT_DSC0	(0 << 30)
+#define S3C2416_SELECT_DSC1	(1 << 30)
+#define S3C2416_SELECT_DSC2	(2 << 30)
+#define S3C2416_SELECT_DSC3	(3 << 30)
+
+#define S3C2416_DSC_GETSHIFT(x)	(x & 30)
+
+#define S3C2416_DSC0_CF		(S3C2416_SELECT_DSC0 | 28)
+#define	S3C2416_DSC0_CF_5mA	(0 << 28)
+#define	S3C2416_DSC0_CF_10mA	(1 << 28)
+#define	S3C2416_DSC0_CF_15mA	(2 << 28)
+#define	S3C2416_DSC0_CF_21mA	(3 << 28)
+#define	S3C2416_DSC0_CF_MASK	(3 << 28)
+
+#define S3C2416_DSC0_nRBE	(S3C2416_SELECT_DSC0 | 26)
+#define	S3C2416_DSC0_nRBE_5mA	(0 << 26)
+#define	S3C2416_DSC0_nRBE_10mA	(1 << 26)
+#define	S3C2416_DSC0_nRBE_15mA	(2 << 26)
+#define	S3C2416_DSC0_nRBE_21mA	(3 << 26)
+#define	S3C2416_DSC0_nRBE_MASK	(3 << 26)
+
+#define S3C2416_DSC0_nROE	(S3C2416_SELECT_DSC0 | 24)
+#define	S3C2416_DSC0_nROE_5mA	(0 << 24)
+#define	S3C2416_DSC0_nROE_10mA	(1 << 24)
+#define	S3C2416_DSC0_nROE_15mA	(2 << 24)
+#define	S3C2416_DSC0_nROE_21mA	(3 << 24)
+#define	S3C2416_DSC0_nROE_MASK	(3 << 24)
+
+#endif
+
 #if defined(CONFIG_CPU_S3C244X)
 
 #define S3C2440_DSC0	   S3C2410_GPIOREG(0xc4)
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
index 821b966..a638423 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
@@ -610,29 +610,50 @@
 #define S3C2410_GPHUP	   S3C2410_GPIOREG(0x78)
 
 #define S3C2410_GPH0_nCTS0  (0x02 << 0)
+#define S3C2416_GPH0_TXD0  (0x02 << 0)
 
 #define S3C2410_GPH1_nRTS0  (0x02 << 2)
+#define S3C2416_GPH1_RXD0  (0x02 << 2)
 
 #define S3C2410_GPH2_TXD0   (0x02 << 4)
+#define S3C2416_GPH2_TXD1   (0x02 << 4)
 
 #define S3C2410_GPH3_RXD0   (0x02 << 6)
+#define S3C2416_GPH3_RXD1   (0x02 << 6)
 
 #define S3C2410_GPH4_TXD1   (0x02 << 8)
+#define S3C2416_GPH4_TXD2   (0x02 << 8)
 
 #define S3C2410_GPH5_RXD1   (0x02 << 10)
+#define S3C2416_GPH5_RXD2   (0x02 << 10)
 
 #define S3C2410_GPH6_TXD2   (0x02 << 12)
+#define S3C2416_GPH6_TXD3   (0x02 << 12)
 #define S3C2410_GPH6_nRTS1  (0x03 << 12)
+#define S3C2416_GPH6_nRTS2  (0x03 << 12)
 
 #define S3C2410_GPH7_RXD2   (0x02 << 14)
+#define S3C2416_GPH7_RXD3   (0x02 << 14)
 #define S3C2410_GPH7_nCTS1  (0x03 << 14)
+#define S3C2416_GPH7_nCTS2  (0x03 << 14)
 
 #define S3C2410_GPH8_UCLK   (0x02 << 16)
+#define S3C2416_GPH8_nCTS0  (0x02 << 16)
 
 #define S3C2410_GPH9_CLKOUT0  (0x02 << 18)
 #define S3C2442_GPH9_nSPICS0  (0x03 << 18)
+#define S3C2416_GPH9_nRTS0    (0x02 << 18)
 
 #define S3C2410_GPH10_CLKOUT1 (0x02 << 20)
+#define S3C2416_GPH10_nCTS1   (0x02 << 20)
+
+#define S3C2416_GPH11_nRTS1   (0x02 << 22)
+
+#define S3C2416_GPH12_EXTUARTCLK (0x02 << 24)
+
+#define S3C2416_GPH13_CLKOUT0 (0x02 << 26)
+
+#define S3C2416_GPH14_CLKOUT1 (0x02 << 28)
 
 /* The S3C2412 and S3C2413 move the GPJ register set to after
  * GPH, which means all registers after 0x80 are now offset by 0x10
@@ -703,6 +724,7 @@
 #define S3C2412_MISCCR_CLK1_CLKsrc  (0<<8)
 
 #define S3C2410_MISCCR_USBSUSPND0   (1<<12)
+#define S3C2416_MISCCR_SEL_SUSPND   (1<<12)
 #define S3C2410_MISCCR_USBSUSPND1   (1<<13)
 
 #define S3C2410_MISCCR_nRSTCON	    (1<<16)
@@ -712,6 +734,9 @@
 #define S3C2410_MISCCR_nEN_SCLKE    (1<<19)	/* not 2412 */
 #define S3C2410_MISCCR_SDSLEEP	    (7<<17)
 
+#define S3C2416_MISCCR_FLT_I2C      (1<<24)
+#define S3C2416_MISCCR_HSSPI_EN2    (1<<31)
+
 /* external interrupt control... */
 /* S3C2410_EXTINT0 -> irq sense control for EINT0..EINT7
  * S3C2410_EXTINT1 -> irq sense control for EINT8..EINT15
@@ -779,8 +804,11 @@
 #define S3C2410_GSTATUS1_IDMASK	   (0xffff0000)
 #define S3C2410_GSTATUS1_2410	   (0x32410000)
 #define S3C2410_GSTATUS1_2412	   (0x32412001)
+#define S3C2410_GSTATUS1_2416	   (0x32416003)
 #define S3C2410_GSTATUS1_2440	   (0x32440000)
 #define S3C2410_GSTATUS1_2442	   (0x32440aaa)
+/* some 2416 CPUs report this value also */
+#define S3C2410_GSTATUS1_2450	   (0x32450003)
 
 #define S3C2410_GSTATUS2_WTRESET   (1<<2)
 #define S3C2410_GSTATUS2_OFFRESET  (1<<1)
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-irq.h b/arch/arm/mach-s3c2410/include/mach/regs-irq.h
index de86ee8..0f07ba3 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-irq.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-irq.h
@@ -27,6 +27,16 @@
 #define S3C2410_SUBSRCPND      S3C2410_IRQREG(0x018)
 #define S3C2410_INTSUBMSK      S3C2410_IRQREG(0x01C)
 
+#define S3C2416_PRIORITY_MODE1		S3C2410_IRQREG(0x030)
+#define S3C2416_PRIORITY_UPDATE1	S3C2410_IRQREG(0x034)
+#define S3C2416_SRCPND2			S3C2410_IRQREG(0x040)
+#define S3C2416_INTMOD2			S3C2410_IRQREG(0x044)
+#define S3C2416_INTMSK2			S3C2410_IRQREG(0x048)
+#define S3C2416_INTPND2			S3C2410_IRQREG(0x050)
+#define S3C2416_INTOFFSET2		S3C2410_IRQREG(0x054)
+#define S3C2416_PRIORITY_MODE2		S3C2410_IRQREG(0x070)
+#define S3C2416_PRIORITY_UPDATE2	S3C2410_IRQREG(0x074)
+
 /* mask: 0=enable, 1=disable
  * 1 bit EINT, 4=EINT4, 23=EINT23
  * EINT0,1,2,3 are not handled here.
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
new file mode 100644
index 0000000..2f31b74
--- /dev/null
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
@@ -0,0 +1,30 @@
+/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+ *	as part of OpenInkpot project
+ * Copyright (c) 2009 Promwad Innovation Company
+ *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2416 memory register definitions
+*/
+
+#ifndef __ASM_ARM_REGS_S3C2416_MEM
+#define __ASM_ARM_REGS_S3C2416_MEM
+
+#ifndef S3C2416_MEMREG
+#define S3C2416_MEMREG(x) (S3C24XX_VA_MEMCTRL + (x))
+#endif
+
+#define S3C2416_BANKCFG			S3C2416_MEMREG(0x00)
+#define S3C2416_BANKCON1		S3C2416_MEMREG(0x04)
+#define S3C2416_BANKCON2		S3C2416_MEMREG(0x08)
+#define S3C2416_BANKCON3		S3C2416_MEMREG(0x0C)
+
+#define S3C2416_REFRESH			S3C2416_MEMREG(0x10)
+#define S3C2416_TIMEOUT			S3C2416_MEMREG(0x14)
+
+#endif /*  __ASM_ARM_REGS_S3C2416_MEM */
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
new file mode 100644
index 0000000..e443167
--- /dev/null
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
@@ -0,0 +1,24 @@
+/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+ *	as part of OpenInkpot project
+ * Copyright (c) 2009 Promwad Innovation Company
+ *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2416 specific register definitions
+*/
+
+#ifndef __ASM_ARCH_REGS_S3C2416_H
+#define __ASM_ARCH_REGS_S3C2416_H "s3c2416"
+
+#define S3C2416_SWRST		(S3C24XX_VA_CLKPWR + 0x44)
+#define S3C2416_SWRST_RESET	(0x533C2416)
+
+/* see regs-power.h for the other registers in the power block. */
+
+#endif	/* __ASM_ARCH_REGS_S3C2416_H */
+
-- 
1.6.3.3
