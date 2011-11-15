From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:45 +0100
Subject: [PATCH 12/13] ARM: at91: make aic soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-14-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on all at91 have the Advanced Interrupt Controller starts at address
0xfffff000

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_aic.h    |   46 +++++++++++++++----------
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 arch/arm/mach-at91/include/mach/at91x40.h     |    1 -
 arch/arm/mach-at91/include/mach/entry-macro.S |   10 +++---
 arch/arm/mach-at91/include/mach/hardware.h    |    6 +++
 arch/arm/mach-at91/include/mach/irqs.h        |    2 +-
 arch/arm/mach-at91/irq.c                      |   38 ++++++++++++---------
 13 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
index 0356679..f163bb6 100644
--- a/arch/arm/mach-at91/include/mach/at91_aic.h
+++ b/arch/arm/mach-at91/include/mach/at91_aic.h
@@ -16,7 +16,17 @@
 #ifndef AT91_AIC_H
 #define AT91_AIC_H
 
-#define AT91_AIC_SMR(n)		(AT91_AIC + ((n) * 4))	/* Source Mode Registers 0-31 */
+#ifndef __ASSEMBLY__
+extern void __iomem *at91_aic_base;
+
+#define at91_aic_read(field) \
+	__raw_readl(at91_aic_base + field)
+
+#define at91_aic_write(field, value) \
+	__raw_writel(value, at91_aic_base + field);
+#endif
+
+#define AT91_AIC_SMR(n)		((n) * 4)		/* Source Mode Registers 0-31 */
 #define		AT91_AIC_PRIOR		(7 << 0)		/* Priority Level */
 #define		AT91_AIC_SRCTYPE	(3 << 5)		/* Interrupt Source Type */
 #define			AT91_AIC_SRCTYPE_LOW		(0 << 5)
@@ -24,30 +34,30 @@
 #define			AT91_AIC_SRCTYPE_HIGH		(2 << 5)
 #define			AT91_AIC_SRCTYPE_RISING		(3 << 5)
 
-#define AT91_AIC_SVR(n)		(AT91_AIC + 0x80 + ((n) * 4))	/* Source Vector Registers 0-31 */
-#define AT91_AIC_IVR		(AT91_AIC + 0x100)	/* Interrupt Vector Register */
-#define AT91_AIC_FVR		(AT91_AIC + 0x104)	/* Fast Interrupt Vector Register */
-#define AT91_AIC_ISR		(AT91_AIC + 0x108)	/* Interrupt Status Register */
+#define AT91_AIC_SVR(n)		(0x80 + ((n) * 4))	/* Source Vector Registers 0-31 */
+#define AT91_AIC_IVR		0x100			/* Interrupt Vector Register */
+#define AT91_AIC_FVR		0x104			/* Fast Interrupt Vector Register */
+#define AT91_AIC_ISR		0x108			/* Interrupt Status Register */
 #define		AT91_AIC_IRQID		(0x1f << 0)		/* Current Interrupt Identifier */
 
-#define AT91_AIC_IPR		(AT91_AIC + 0x10c)	/* Interrupt Pending Register */
-#define AT91_AIC_IMR		(AT91_AIC + 0x110)	/* Interrupt Mask Register */
-#define AT91_AIC_CISR		(AT91_AIC + 0x114)	/* Core Interrupt Status Register */
+#define AT91_AIC_IPR		0x10c			/* Interrupt Pending Register */
+#define AT91_AIC_IMR		0x110			/* Interrupt Mask Register */
+#define AT91_AIC_CISR		0x114			/* Core Interrupt Status Register */
 #define		AT91_AIC_NFIQ		(1 << 0)		/* nFIQ Status */
 #define		AT91_AIC_NIRQ		(1 << 1)		/* nIRQ Status */
 
-#define AT91_AIC_IECR		(AT91_AIC + 0x120)	/* Interrupt Enable Command Register */
-#define AT91_AIC_IDCR		(AT91_AIC + 0x124)	/* Interrupt Disable Command Register */
-#define AT91_AIC_ICCR		(AT91_AIC + 0x128)	/* Interrupt Clear Command Register */
-#define AT91_AIC_ISCR		(AT91_AIC + 0x12c)	/* Interrupt Set Command Register */
-#define AT91_AIC_EOICR		(AT91_AIC + 0x130)	/* End of Interrupt Command Register */
-#define AT91_AIC_SPU		(AT91_AIC + 0x134)	/* Spurious Interrupt Vector Register */
-#define AT91_AIC_DCR		(AT91_AIC + 0x138)	/* Debug Control Register */
+#define AT91_AIC_IECR		0x120			/* Interrupt Enable Command Register */
+#define AT91_AIC_IDCR		0x124			/* Interrupt Disable Command Register */
+#define AT91_AIC_ICCR		0x128			/* Interrupt Clear Command Register */
+#define AT91_AIC_ISCR		0x12c			/* Interrupt Set Command Register */
+#define AT91_AIC_EOICR		0x130			/* End of Interrupt Command Register */
+#define AT91_AIC_SPU		0x134			/* Spurious Interrupt Vector Register */
+#define AT91_AIC_DCR		0x138			/* Debug Control Register */
 #define		AT91_AIC_DCR_PROT	(1 << 0)		/* Protection Mode */
 #define		AT91_AIC_DCR_GMSK	(1 << 1)		/* General Mask */
 
-#define AT91_AIC_FFER		(AT91_AIC + 0x140)	/* Fast Forcing Enable Register [SAM9 only] */
-#define AT91_AIC_FFDR		(AT91_AIC + 0x144)	/* Fast Forcing Disable Register [SAM9 only] */
-#define AT91_AIC_FFSR		(AT91_AIC + 0x148)	/* Fast Forcing Status Register [SAM9 only] */
+#define AT91_AIC_FFER		0x140			/* Fast Forcing Enable Register [SAM9 only] */
+#define AT91_AIC_FFDR		0x144			/* Fast Forcing Disable Register [SAM9 only] */
+#define AT91_AIC_FFSR		0x148			/* Fast Forcing Status Register [SAM9 only] */
 
 #endif
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index bca2b54..4c0e2f6 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -82,7 +82,6 @@
 #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 1f767e2..90e92a8 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -79,7 +79,6 @@
 /*
  * System Peripherals (offset from AT91_BASE_SYS)
  */
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index e360d66..f937c47 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -82,7 +82,6 @@
  */
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 2ccc8a53..175604e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -67,7 +67,6 @@
  */
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index aee137b..80c9150 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -77,7 +77,6 @@
 #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 211721b..ac5c471 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -89,7 +89,6 @@
 #define AT91_DDRSDRC1	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 4f7367a..c466e8c 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -71,7 +71,6 @@
  */
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index a152ff8..a57829f 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -40,7 +40,6 @@
 #define AT91_PIOA	(0xffff0000 - AT91_BASE_SYS)	/* PIO Controller A */
 #define AT91_PS		(0xffff4000 - AT91_BASE_SYS)	/* Power Save */
 #define AT91_WD		(0xffff8000 - AT91_BASE_SYS)	/* Watchdog Timer */
-#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
 
 /*
  * The AT91x40 series doesn't have a debug unit like the other AT91 parts.
diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
index 7ab68f9..631f654 100644
--- a/arch/arm/mach-at91/include/mach/entry-macro.S
+++ b/arch/arm/mach-at91/include/mach/entry-macro.S
@@ -17,16 +17,16 @@
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =(AT91_VA_BASE_SYS + AT91_AIC)		@ base virtual address of AIC peripheral
+	ldr	\base, =AT91_IO_P2V(AT91_AIC)		@ base virtual address of AIC peripheral
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqnr, [\base, #(AT91_AIC_IVR - AT91_AIC)]	@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
-	ldr	\irqstat, [\base, #(AT91_AIC_ISR - AT91_AIC)]	@ read interrupt source number
-	teq	\irqstat, #0					@ ISR is 0 when no current interrupt, or spurious interrupt
-	streq	\tmp, [\base, #(AT91_AIC_EOICR - AT91_AIC)]	@ not going to be handled further, then ACK it now.
+	ldr	\irqnr, [\base, #AT91_AIC_IVR]		@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
+	ldr	\irqstat, [\base, #AT91_AIC_ISR]	@ read interrupt source number
+	teq	\irqstat, #0				@ ISR is 0 when no current interrupt, or spurious interrupt
+	streq	\tmp, [\base, #AT91_AIC_EOICR]		@ not going to be handled further, then ACK it now.
 	.endm
 
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 435764e..2d0e4e9 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -58,6 +58,12 @@
 #endif
 
 /*
+ * On all at91 have the Advanced Interrupt Controller starts@address
+ * 0xfffff000
+ */
+#define AT91_AIC	0xfffff000
+
+/*
  * Peripheral identifiers/interrupts.
  */
 #define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index 36bd55f..ac8b7df 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -31,7 +31,7 @@
  * Acknowledge interrupt with AIC after interrupt has been handled.
  *   (by kernel/irq.c)
  */
-#define irq_finish(irq) do { at91_sys_write(AT91_AIC_EOICR, 0); } while (0)
+#define irq_finish(irq) do { at91_aic_write(AT91_AIC_EOICR, 0); } while (0)
 
 
 /*
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index 9665265e..be6b639 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -33,17 +33,18 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
+void __iomem *at91_aic_base;
 
 static void at91_aic_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC */
-	at91_sys_write(AT91_AIC_IDCR, 1 << d->irq);
+	at91_aic_write(AT91_AIC_IDCR, 1 << d->irq);
 }
 
 static void at91_aic_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC */
-	at91_sys_write(AT91_AIC_IECR, 1 << d->irq);
+	at91_aic_write(AT91_AIC_IECR, 1 << d->irq);
 }
 
 unsigned int at91_extern_irq;
@@ -77,8 +78,8 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 	}
 
-	smr = at91_sys_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
-	at91_sys_write(AT91_AIC_SMR(d->irq), smr | srctype);
+	smr = at91_aic_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
+	at91_aic_write(AT91_AIC_SMR(d->irq), smr | srctype);
 	return 0;
 }
 
@@ -102,15 +103,15 @@ static int at91_aic_set_wake(struct irq_data *d, unsigned value)
 
 void at91_irq_suspend(void)
 {
-	backups = at91_sys_read(AT91_AIC_IMR);
-	at91_sys_write(AT91_AIC_IDCR, backups);
-	at91_sys_write(AT91_AIC_IECR, wakeups);
+	backups = at91_aic_read(AT91_AIC_IMR);
+	at91_aic_write(AT91_AIC_IDCR, backups);
+	at91_aic_write(AT91_AIC_IECR, wakeups);
 }
 
 void at91_irq_resume(void)
 {
-	at91_sys_write(AT91_AIC_IDCR, wakeups);
-	at91_sys_write(AT91_AIC_IECR, backups);
+	at91_aic_write(AT91_AIC_IDCR, wakeups);
+	at91_aic_write(AT91_AIC_IECR, backups);
 }
 
 #else
@@ -133,34 +134,39 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 {
 	unsigned int i;
 
+	at91_aic_base = ioremap(AT91_AIC, 512);
+
+	if (!at91_aic_base)
+		panic("Impossible to ioremap AT91_AIC\n");
+
 	/*
 	 * The IVR is used by macro get_irqnr_and_base to read and verify.
 	 * The irq number is NR_AIC_IRQS when a spurious interrupt has occurred.
 	 */
 	for (i = 0; i < NR_AIC_IRQS; i++) {
 		/* Put irq number in Source Vector Register: */
-		at91_sys_write(AT91_AIC_SVR(i), i);
+		at91_aic_write(AT91_AIC_SVR(i), i);
 		/* Active Low interrupt, with the specified priority */
-		at91_sys_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
+		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
 		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 
 		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
 		if (i < 8)
-			at91_sys_write(AT91_AIC_EOICR, 0);
+			at91_aic_write(AT91_AIC_EOICR, 0);
 	}
 
 	/*
 	 * Spurious Interrupt ID in Spurious Vector Register is NR_AIC_IRQS
 	 * When there is no current interrupt, the IRQ Vector Register reads the value stored in AIC_SPU
 	 */
-	at91_sys_write(AT91_AIC_SPU, NR_AIC_IRQS);
+	at91_aic_write(AT91_AIC_SPU, NR_AIC_IRQS);
 
 	/* No debugging in AIC: Debug (Protect) Control Register */
-	at91_sys_write(AT91_AIC_DCR, 0);
+	at91_aic_write(AT91_AIC_DCR, 0);
 
 	/* Disable and clear all interrupts initially */
-	at91_sys_write(AT91_AIC_IDCR, 0xFFFFFFFF);
-	at91_sys_write(AT91_AIC_ICCR, 0xFFFFFFFF);
+	at91_aic_write(AT91_AIC_IDCR, 0xFFFFFFFF);
+	at91_aic_write(AT91_AIC_ICCR, 0xFFFFFFFF);
 }
-- 
1.7.7
