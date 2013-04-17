From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:57 +0200 (CEST)
Subject: [PATCH 10/10] LPC32XX: 010-fiq.1: Enable FIQ interrupts for the
 LPC32xx controllers
Message-ID: <mailman.20.1366231479.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---
The LPC32xx controller has fully-working FIQ interrupts, enable then.

Index: arch/arm/Kconfig
===================================================================
--- arch/arm/Kconfig	(revision 1688)
+++ arch/arm/Kconfig	(revision 1736)
@@ -658,6 +658,7 @@
 	select HAVE_PWM
 	select USB_ARCH_HAS_OHCI
 	select USE_OF
+	select FIQ
 	help
 	  Support for the NXP LPC32XX family of processors
 
Index: arch/arm/mach-lpc32xx/irq.c
===================================================================
--- arch/arm/mach-lpc32xx/irq.c	(revision 1688)
+++ arch/arm/mach-lpc32xx/irq.c	(revision 1736)
@@ -374,6 +374,9 @@
 {
 	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC1_BASE));
 
+	/* ignore irqs which are in FIQ mode */
+	ints &= ~__raw_readl(LPC32XX_INTC_TYPE(LPC32XX_SIC1_BASE));
+
 	while (ints != 0) {
 		int irqno = fls(ints) - 1;
 
@@ -387,6 +390,9 @@
 {
 	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC2_BASE));
 
+	/* ignore irqs which are in FIQ mode */
+	ints &= ~__raw_readl(LPC32XX_INTC_TYPE(LPC32XX_SIC2_BASE));
+
 	while (ints != 0) {
 		int irqno = fls(ints) - 1;
 
Index: arch/arm/mach-lpc32xx/include/mach/entry-macro.S
===================================================================
--- arch/arm/mach-lpc32xx/include/mach/entry-macro.S	(revision 1688)
+++ arch/arm/mach-lpc32xx/include/mach/entry-macro.S	(revision 1736)
@@ -20,6 +20,7 @@
 #include <mach/platform.h>
 
 #define LPC32XX_INTC_MASKED_STATUS_OFS	0x8
+#define LPC32XX_INTC_FIQ_MASK		0x14
 
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
@@ -31,6 +32,11 @@
  */
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\irqstat, [\base, #LPC32XX_INTC_MASKED_STATUS_OFS]
+
+	/* ignore irqs which are in FIQ mode */
+	ldr	\irqnr, [\base, #LPC32XX_INTC_FIQ_MASK]
+	bic	\irqstat, \irqstat, \irqnr
+
 	clz	\irqnr, \irqstat
 	rsb	\irqnr, \irqnr, #31
 	teq	\irqstat, #0
