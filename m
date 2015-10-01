From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 01 Oct 2015 15:00:16 +0200
Subject: [patch 1/1] iop32x: increase irq numbers by 1
References: <20151001130015.092991764@rtp-net.org>
Message-ID: <20151001130025.814797537@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On recent kernels, IRQ0 is not valid. Given that irqs on iop32x are
starting at 0, as soon as irq0 (iop-adma) is used, the board will
hang.
As a simple solution, I'm just increasing the numbers by 1

[ Tested on a ss4000e/em7210 platform with a 4.1 ]

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: linux-next/arch/arm/mach-iop32x/include/mach/irqs.h
===================================================================
--- linux-next.orig/arch/arm/mach-iop32x/include/mach/irqs.h	2015-10-01 14:38:50.190495924 +0200
+++ linux-next/arch/arm/mach-iop32x/include/mach/irqs.h	2015-10-01 14:38:50.182495760 +0200
@@ -15,36 +15,36 @@
 /*
  * IOP80321 chipset interrupts
  */
-#define IRQ_IOP32X_DMA0_EOT	0
-#define IRQ_IOP32X_DMA0_EOC	1
-#define IRQ_IOP32X_DMA1_EOT	2
-#define IRQ_IOP32X_DMA1_EOC	3
-#define IRQ_IOP32X_AA_EOT	6
-#define IRQ_IOP32X_AA_EOC	7
-#define IRQ_IOP32X_CORE_PMON	8
-#define IRQ_IOP32X_TIMER0	9
-#define IRQ_IOP32X_TIMER1	10
-#define IRQ_IOP32X_I2C_0	11
-#define IRQ_IOP32X_I2C_1	12
-#define IRQ_IOP32X_MESSAGING	13
-#define IRQ_IOP32X_ATU_BIST	14
-#define IRQ_IOP32X_PERFMON	15
-#define IRQ_IOP32X_CORE_PMU	16
-#define IRQ_IOP32X_BIU_ERR	17
-#define IRQ_IOP32X_ATU_ERR	18
-#define IRQ_IOP32X_MCU_ERR	19
-#define IRQ_IOP32X_DMA0_ERR	20
-#define IRQ_IOP32X_DMA1_ERR	21
-#define IRQ_IOP32X_AA_ERR	23
-#define IRQ_IOP32X_MSG_ERR	24
-#define IRQ_IOP32X_SSP		25
-#define IRQ_IOP32X_XINT0	27
-#define IRQ_IOP32X_XINT1	28
-#define IRQ_IOP32X_XINT2	29
-#define IRQ_IOP32X_XINT3	30
-#define IRQ_IOP32X_HPI		31
+#define IRQ_IOP32X_DMA0_EOT	(1+0)
+#define IRQ_IOP32X_DMA0_EOC	(1+1)
+#define IRQ_IOP32X_DMA1_EOT	(1+2)
+#define IRQ_IOP32X_DMA1_EOC	(1+3)
+#define IRQ_IOP32X_AA_EOT	(1+6)
+#define IRQ_IOP32X_AA_EOC	(1+7)
+#define IRQ_IOP32X_CORE_PMON	(1+8)
+#define IRQ_IOP32X_TIMER0	(1+9)
+#define IRQ_IOP32X_TIMER1	(1+10)
+#define IRQ_IOP32X_I2C_0	(1+11)
+#define IRQ_IOP32X_I2C_1	(1+12)
+#define IRQ_IOP32X_MESSAGING	(1+13)
+#define IRQ_IOP32X_ATU_BIST	(1+14)
+#define IRQ_IOP32X_PERFMON	(1+15)
+#define IRQ_IOP32X_CORE_PMU	(1+16)
+#define IRQ_IOP32X_BIU_ERR	(1+17)
+#define IRQ_IOP32X_ATU_ERR	(1+18)
+#define IRQ_IOP32X_MCU_ERR	(1+19)
+#define IRQ_IOP32X_DMA0_ERR	(1+20)
+#define IRQ_IOP32X_DMA1_ERR	(1+21)
+#define IRQ_IOP32X_AA_ERR	(1+23)
+#define IRQ_IOP32X_MSG_ERR	(1+24)
+#define IRQ_IOP32X_SSP		(1+25)
+#define IRQ_IOP32X_XINT0	(1+27)
+#define IRQ_IOP32X_XINT1	(1+28)
+#define IRQ_IOP32X_XINT2	(1+29)
+#define IRQ_IOP32X_XINT3	(1+30)
+#define IRQ_IOP32X_HPI		(1+31)
 
-#define NR_IRQS			32
+#define NR_IRQS			(1+32)
 
 
 #endif
Index: linux-next/arch/arm/mach-iop32x/irq.c
===================================================================
--- linux-next.orig/arch/arm/mach-iop32x/irq.c	2015-10-01 14:38:50.190495924 +0200
+++ linux-next/arch/arm/mach-iop32x/irq.c	2015-10-01 14:38:50.182495760 +0200
@@ -34,14 +34,14 @@ static void intstr_write(u32 val)
 static void
 iop32x_irq_mask(struct irq_data *d)
 {
-	iop32x_mask &= ~(1 << d->irq);
+	iop32x_mask &= ~(1 << (d->irq-1));
 	intctl_write(iop32x_mask);
 }
 
 static void
 iop32x_irq_unmask(struct irq_data *d)
 {
-	iop32x_mask |= 1 << d->irq;
+	iop32x_mask |= 1 << (d->irq-1);
 	intctl_write(iop32x_mask);
 }
 
@@ -67,7 +67,7 @@ void __init iop32x_init_irq(void)
 	    machine_is_em7210())
 		*IOP3XX_PCIIRSR = 0x0f;
 
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = IRQ_IOP32X_DMA0_EOT; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &ext_chip, handle_level_irq);
 		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
Index: linux-next/arch/arm/mach-iop32x/include/mach/entry-macro.S
===================================================================
--- linux-next.orig/arch/arm/mach-iop32x/include/mach/entry-macro.S	2015-10-01 14:38:50.190495924 +0200
+++ linux-next/arch/arm/mach-iop32x/include/mach/entry-macro.S	2015-10-01 14:38:50.182495760 +0200
@@ -23,6 +23,7 @@
 	cmp     \irqstat, #0
 	clzne   \irqnr, \irqstat
 	rsbne   \irqnr, \irqnr, #31
+	add     \irqnr, \irqnr, #1
 	.endm
 
 	.macro arch_ret_to_user, tmp1, tmp2
