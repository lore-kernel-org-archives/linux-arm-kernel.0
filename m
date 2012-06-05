From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 5 Jun 2012 16:47:44 +0200
Subject: [PATCH 4/4] ARM: at91: add AIC5 support
In-Reply-To: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
References: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1338907664-24646-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The number of lines of AIC5 has increased from 32 to 128. Due to this
increase, a source select register has been introduced for the interrupt
line selection. Moreover, register mapping has been changed. For that reasons,
we need some dedicated callbacks for AIC5.
Power management is also concerned by these changes. On suspend, we can't get
the whole interrupt mask register as before, we have to read this register 128
times. To reduce this overhead, a snapshot of the whole IMR is maintained.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/generic.h               |    2 +
 arch/arm/mach-at91/include/mach/at91_aic.h |   24 ++
 arch/arm/mach-at91/include/mach/irqs.h     |    2 +
 arch/arm/mach-at91/irq.c                   |  357 +++++++++++++++++++++++-----
 4 files changed, 331 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0a60bf8..f496506 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -29,6 +29,8 @@ extern void __init at91x40_init_interrupts(unsigned int priority[]);
 extern void __init at91_aic_init(unsigned int priority[]);
 extern int  __init at91_aic_of_init(struct device_node *node,
 				    struct device_node *parent);
+extern int  __init at91_aic5_of_init(struct device_node *node,
+				    struct device_node *parent);
 
 
  /* Timer */
diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
index c1413ed..a014807 100644
--- a/arch/arm/mach-at91/include/mach/at91_aic.h
+++ b/arch/arm/mach-at91/include/mach/at91_aic.h
@@ -28,7 +28,11 @@ extern void __iomem *at91_aic_base;
 .extern at91_aic_base
 #endif
 
+#define AT91_AIC5_SSR		0x0			/* Source Select Register [AIC5] */
+#define 	AT91_AIC5_INTSEL_MSK	(0x7f << 0)		/* Interrupt Line Selection Mask */
+
 #define AT91_AIC_SMR(n)		((n) * 4)		/* Source Mode Registers 0-31 */
+#define AT91_AIC5_SMR		0x4			/* Source Mode Register [AIC5] */
 #define		AT91_AIC_PRIOR		(7 << 0)		/* Priority Level */
 #define		AT91_AIC_SRCTYPE	(3 << 5)		/* Interrupt Source Type */
 #define			AT91_AIC_SRCTYPE_LOW		(0 << 5)
@@ -37,29 +41,49 @@ extern void __iomem *at91_aic_base;
 #define			AT91_AIC_SRCTYPE_RISING		(3 << 5)
 
 #define AT91_AIC_SVR(n)		(0x80 + ((n) * 4))	/* Source Vector Registers 0-31 */
+#define AT91_AIC5_SVR		0x8			/* Source Vector Register [AIC5] */
 #define AT91_AIC_IVR		0x100			/* Interrupt Vector Register */
+#define AT91_AIC5_IVR		0x10			/* Interrupt Vector Register [AIC5] */
 #define AT91_AIC_FVR		0x104			/* Fast Interrupt Vector Register */
+#define AT91_AIC5_FVR		0x14			/* Fast Interrupt Vector Register [AIC5] */
 #define AT91_AIC_ISR		0x108			/* Interrupt Status Register */
+#define AT91_AIC5_ISR		0x18			/* Interrupt Status Register [AIC5] */
 #define		AT91_AIC_IRQID		(0x1f << 0)		/* Current Interrupt Identifier */
 
 #define AT91_AIC_IPR		0x10c			/* Interrupt Pending Register */
+#define AT91_AIC5_IPR0		0x20			/* Interrupt Pending Register 0 [AIC5] */
+#define AT91_AIC5_IPR1		0x24			/* Interrupt Pending Register 1 [AIC5] */
+#define AT91_AIC5_IPR2		0x28			/* Interrupt Pending Register 2 [AIC5] */
+#define AT91_AIC5_IPR3		0x2c			/* Interrupt Pending Register 3 [AIC5] */
 #define AT91_AIC_IMR		0x110			/* Interrupt Mask Register */
+#define AT91_AIC5_IMR		0x30			/* Interrupt Mask Register [AIC5] */
 #define AT91_AIC_CISR		0x114			/* Core Interrupt Status Register */
+#define AT91_AIC5_CISR		0x34			/* Core Interrupt Status Register [AIC5] */
 #define		AT91_AIC_NFIQ		(1 << 0)		/* nFIQ Status */
 #define		AT91_AIC_NIRQ		(1 << 1)		/* nIRQ Status */
 
 #define AT91_AIC_IECR		0x120			/* Interrupt Enable Command Register */
+#define AT91_AIC5_IECR		0x40			/* Interrupt Enable Command Register [AIC5] */
 #define AT91_AIC_IDCR		0x124			/* Interrupt Disable Command Register */
+#define AT91_AIC5_IDCR		0x44			/* Interrupt Disable Command Register [AIC5] */
 #define AT91_AIC_ICCR		0x128			/* Interrupt Clear Command Register */
+#define AT91_AIC5_ICCR		0x48			/* Interrupt Clear Command Register [AIC5] */
 #define AT91_AIC_ISCR		0x12c			/* Interrupt Set Command Register */
+#define AT91_AIC5_ISCR		0x4c			/* Interrupt Set Command Register [AIC5] */
 #define AT91_AIC_EOICR		0x130			/* End of Interrupt Command Register */
+#define AT91_AIC5_EOICR		0x38			/* End of Interrupt Command Register [AIC5] */
 #define AT91_AIC_SPU		0x134			/* Spurious Interrupt Vector Register */
+#define AT91_AIC5_SPU		0x3c			/* Spurious Interrupt Vector Register [AIC5] */
 #define AT91_AIC_DCR		0x138			/* Debug Control Register */
+#define AT91_AIC5_DCR		0x6c			/* Debug Control Register [AIC5] */
 #define		AT91_AIC_DCR_PROT	(1 << 0)		/* Protection Mode */
 #define		AT91_AIC_DCR_GMSK	(1 << 1)		/* General Mask */
 
 #define AT91_AIC_FFER		0x140			/* Fast Forcing Enable Register [SAM9 only] */
+#define AT91_AIC5_FFER		0x50			/* Fast Forcing Enable Register [AIC5] */
 #define AT91_AIC_FFDR		0x144			/* Fast Forcing Disable Register [SAM9 only] */
+#define AT91_AIC5_FFDR		0x54			/* Fast Forcing Disable Register [AIC5] */
 #define AT91_AIC_FFSR		0x148			/* Fast Forcing Status Register [SAM9 only] */
+#define AT91_AIC5_FFSR		0x58			/* Fast Forcing Status Register [AIC5] */
 
 #endif
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index 5164dc1..fc0b8a9 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -25,6 +25,7 @@
 #include <mach/at91_aic.h>
 
 #define NR_AIC_IRQS 	32
+#define NR_AIC5_IRQS 	128
 #define NR_GPIO_IRQS	(5 * 32)
 
 /*
@@ -41,5 +42,6 @@
 #define FIQ_START AT91_ID_FIQ
 
 void at91_aic_handle_irq(struct pt_regs *regs);
+void at91_aic5_handle_irq(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index b0f83e2..75f8efa 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -21,8 +21,10 @@
  */
 
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/bitmap.h>
 #include <linux/types.h>
 #include <linux/irq.h>
 #include <linux/of.h>
@@ -30,6 +32,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -44,8 +47,115 @@
 void __iomem *at91_aic_base;
 static struct irq_domain *at91_aic_domain;
 static struct device_node *at91_aic_np;
+static unsigned int n_irqs = NR_AIC_IRQS;
+static unsigned long at91_aic_caps = 0;
 
-asmlinkage void __exception_irq_entry at91_aic_handle_irq(struct pt_regs *regs)
+/* AIC5 introduces a Source Select Register */
+#define AT91_AIC_CAP_AIC5	(1 << 0)
+#define has_aic5()		(at91_aic_caps & AT91_AIC_CAP_AIC5)
+
+#ifdef CONFIG_PM
+
+static unsigned long *wakeups;
+static unsigned long *backups;
+
+#define set_backup(bit) set_bit(bit, backups)
+#define clear_backup(bit) clear_bit(bit, backups)
+
+static int at91_aic_pm_init(void)
+{
+	backups = kzalloc(BITS_TO_LONGS(n_irqs) * sizeof(*backups), GFP_KERNEL);
+	if (!backups)
+		return -ENOMEM;
+
+	wakeups = kzalloc(BITS_TO_LONGS(n_irqs) * sizeof(*backups), GFP_KERNEL);
+	if (!wakeups) {
+		kfree(backups);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int at91_aic_set_wake(struct irq_data *d, unsigned value)
+{
+	if (unlikely(d->hwirq >= n_irqs))
+		return -EINVAL;
+
+	if (value)
+		set_bit(d->hwirq, wakeups);
+	else
+		clear_bit(d->hwirq, wakeups);
+
+	return 0;
+}
+
+void at91_irq_suspend(void)
+{
+	int i = 0, bit;
+
+	if (has_aic5()) {
+		/* disable enabled irqs */
+		while ((bit = find_next_bit(backups, n_irqs, i)) < n_irqs) {
+			at91_aic_write(AT91_AIC5_SSR,
+			               bit & AT91_AIC5_INTSEL_MSK);
+			at91_aic_write(AT91_AIC5_IDCR, 1);
+			i = bit;
+		}
+		/* enable wakeup irqs */
+		i = 0;
+		while ((bit = find_next_bit(wakeups, n_irqs, i)) < n_irqs) {
+			at91_aic_write(AT91_AIC5_SSR,
+			               bit & AT91_AIC5_INTSEL_MSK);
+			at91_aic_write(AT91_AIC5_IECR, 1);
+			i = bit;
+		}
+	} else {
+		at91_aic_write(AT91_AIC_IDCR, *backups);
+		at91_aic_write(AT91_AIC_IECR, *wakeups);
+	}
+}
+
+void at91_irq_resume(void)
+{
+	int i = 0, bit;
+
+	if (has_aic5()) {
+		/* disable wakeup irqs */
+		while ((bit = find_next_bit(wakeups, n_irqs, i)) < n_irqs) {
+			at91_aic_write(AT91_AIC5_SSR,
+			               bit & AT91_AIC5_INTSEL_MSK);
+			at91_aic_write(AT91_AIC5_IDCR, 1);
+			i = bit;
+		}
+		/* enable irqs disabled for suspend */
+		i = 0;
+		while ((bit = find_next_bit(backups, n_irqs, i)) < n_irqs) {
+			at91_aic_write(AT91_AIC5_SSR,
+			               bit & AT91_AIC5_INTSEL_MSK);
+			at91_aic_write(AT91_AIC5_IECR, 1);
+			i = bit;
+		}
+	} else {
+		at91_aic_write(AT91_AIC_IDCR, *wakeups);
+		at91_aic_write(AT91_AIC_IECR, *backups);
+	}
+}
+
+#else
+static int at91_aic_pm_init(void)
+{
+	return 0;
+}
+
+#define set_backup(bit)
+#define clear_backup(bit)
+#define at91_aic_set_wake	NULL
+
+#endif /* CONFIG_PM */
+
+asmlinkage void __exception_irq_entry
+at91_aic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 	u32 irqstat;
@@ -63,16 +173,53 @@ asmlinkage void __exception_irq_entry at91_aic_handle_irq(struct pt_regs *regs)
 		handle_IRQ(irqnr, regs);
 }
 
+asmlinkage void __exception_irq_entry
+at91_aic5_handle_irq(struct pt_regs *regs)
+{
+	u32 irqnr;
+	u32 irqstat;
+
+	irqnr = at91_aic_read(AT91_AIC5_IVR);
+	irqstat = at91_aic_read(AT91_AIC5_ISR);
+
+	if (!irqstat)
+		at91_aic_write(AT91_AIC5_EOICR, 0);
+	else
+		handle_IRQ(irqnr, regs);
+}
+
 static void at91_aic_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC */
 	at91_aic_write(AT91_AIC_IDCR, 1 << d->hwirq);
+	/* Update ISR cache */
+	clear_backup(d->hwirq);
+}
+
+static void at91_aic5_mask_irq(struct irq_data *d)
+{
+	/* Disable interrupt on AIC5 */
+	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
+	at91_aic_write(AT91_AIC5_IDCR, 1);
+	/* Update ISR cache */
+	clear_backup(d->hwirq);
 }
 
 static void at91_aic_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC */
 	at91_aic_write(AT91_AIC_IECR, 1 << d->hwirq);
+	/* Update ISR cache */
+	set_backup(d->hwirq);
+}
+
+static void at91_aic5_unmask_irq(struct irq_data *d)
+{
+	/* Enable interrupt on AIC5 */
+	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
+	at91_aic_write(AT91_AIC5_IECR, 1);
+	/* Update ISR cache */
+	set_backup(d->hwirq);
 }
 
 static void at91_aic_eoi(struct irq_data *d)
@@ -84,13 +231,18 @@ static void at91_aic_eoi(struct irq_data *d)
 	at91_aic_write(AT91_AIC_EOICR, 0);
 }
 
-unsigned int at91_extern_irq;
+static void at91_aic5_eoi(struct irq_data *d)
+{
+	at91_aic_write(AT91_AIC5_EOICR, 0);
+}
 
-#define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
+unsigned long *at91_extern_irq;
 
-static int at91_aic_set_type(struct irq_data *d, unsigned type)
+#define is_extern_irq(hwirq) test_bit(hwirq, at91_extern_irq)
+
+static int at91_aic_compute_srctype(struct irq_data *d, unsigned type)
 {
-	unsigned int smr, srctype;
+	int srctype;
 
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -103,58 +255,44 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		if ((d->hwirq == AT91_ID_FIQ) || is_extern_irq(d->hwirq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_LOW;
 		else
-			return -EINVAL;
+			srctype = -EINVAL;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		if ((d->hwirq == AT91_ID_FIQ) || is_extern_irq(d->hwirq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_FALLING;
 		else
-			return -EINVAL;
+			srctype = -EINVAL;
 		break;
 	default:
-		return -EINVAL;
+		srctype = -EINVAL;
 	}
 
-	smr = at91_aic_read(AT91_AIC_SMR(d->hwirq)) & ~AT91_AIC_SRCTYPE;
-	at91_aic_write(AT91_AIC_SMR(d->hwirq), smr | srctype);
-	return 0;
+	return srctype;
 }
 
-#ifdef CONFIG_PM
-
-static u32 wakeups;
-static u32 backups;
-
-static int at91_aic_set_wake(struct irq_data *d, unsigned value)
+static int at91_aic_set_type(struct irq_data *d, unsigned type)
 {
-	if (unlikely(d->hwirq >= NR_AIC_IRQS))
-		return -EINVAL;
-
-	if (value)
-		wakeups |= (1 << d->hwirq);
-	else
-		wakeups &= ~(1 << d->hwirq);
+	unsigned int smr;
+	int srctype;
+
+	srctype = at91_aic_compute_srctype(d, type);
+	if (srctype < 0)
+		return srctype;
+
+	if (has_aic5()) {
+		at91_aic_write(AT91_AIC5_SSR,
+		               d->hwirq & AT91_AIC5_INTSEL_MSK);
+		smr = at91_aic_read(AT91_AIC5_SMR) & ~AT91_AIC_SRCTYPE;
+		at91_aic_write(AT91_AIC5_SMR, smr | srctype);
+	} else {
+		smr = at91_aic_read(AT91_AIC_SMR(d->hwirq))
+		      & ~AT91_AIC_SRCTYPE;
+		at91_aic_write(AT91_AIC_SMR(d->hwirq), smr | srctype);
+	}
 
 	return 0;
 }
 
-void at91_irq_suspend(void)
-{
-	backups = at91_aic_read(AT91_AIC_IMR);
-	at91_aic_write(AT91_AIC_IDCR, backups);
-	at91_aic_write(AT91_AIC_IECR, wakeups);
-}
-
-void at91_irq_resume(void)
-{
-	at91_aic_write(AT91_AIC_IDCR, wakeups);
-	at91_aic_write(AT91_AIC_IECR, backups);
-}
-
-#else
-#define at91_aic_set_wake	NULL
-#endif
-
 static struct irq_chip at91_aic_chip = {
 	.name		= "AIC",
 	.irq_mask	= at91_aic_mask_irq,
@@ -190,6 +328,35 @@ static void __init at91_aic_hw_init(unsigned int spu_vector)
 	at91_aic_write(AT91_AIC_ICCR, 0xFFFFFFFF);
 }
 
+static void __init at91_aic5_hw_init(unsigned int spu_vector)
+{
+	int i;
+
+	/*
+	 * Perform 8 End Of Interrupt Command to make sure AIC
+	 * will not Lock out nIRQ
+	 */
+	for (i = 0; i < 8; i++)
+		at91_aic_write(AT91_AIC5_EOICR, 0);
+
+	/*
+	 * Spurious Interrupt ID in Spurious Vector Register.
+	 * When there is no current interrupt, the IRQ Vector Register
+	 * reads the value stored in AIC_SPU
+	 */
+	at91_aic_write(AT91_AIC5_SPU, spu_vector);
+
+	/* No debugging in AIC: Debug (Protect) Control Register */
+	at91_aic_write(AT91_AIC5_DCR, 0);
+
+	/* Disable and clear all interrupts initially */
+	for (i = 0; i < n_irqs; i++) {
+		at91_aic_write(AT91_AIC5_SSR, i & AT91_AIC5_INTSEL_MSK);
+		at91_aic_write(AT91_AIC5_IDCR, 1);
+		at91_aic_write(AT91_AIC5_ICCR, 1);
+	}
+}
+
 #if defined(CONFIG_OF)
 static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
 							irq_hw_number_t hw)
@@ -206,6 +373,23 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
+static int at91_aic5_irq_map(struct irq_domain *h, unsigned int virq,
+		irq_hw_number_t hw)
+{
+	at91_aic_write(AT91_AIC5_SSR, hw & AT91_AIC5_INTSEL_MSK);
+
+	/* Put virq number in Source Vector Register */
+	at91_aic_write(AT91_AIC5_SVR, virq);
+
+	/* Active Low interrupt, without priority */
+	at91_aic_write(AT91_AIC5_SMR, AT91_AIC_SRCTYPE_LOW);
+
+	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_fasteoi_irq);
+	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
 static struct irq_domain_ops at91_aic_irq_ops = {
 	.map	= at91_aic_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
@@ -230,34 +414,100 @@ static void __init at91_aic_of_priority(struct device_node *node)
 		pr_warn("AIC: no valid default irqs priorities\n");
 }
 
-int __init at91_aic_of_init(struct device_node *node,
-				     struct device_node *parent)
+static void __init at91_aic5_of_priority(struct device_node *node)
 {
 	struct property *prop;
 	const __be32 *p;
 	u32 val;
+	int i = 0;
+
+	of_property_for_each_u32(node, "atmel,default-irq-priorities", prop, p, val) {
+		at91_aic_write(AT91_AIC5_SSR, i & AT91_AIC5_INTSEL_MSK);
+		/* Put hardware irq number in Source Vector Register: */
+		at91_aic_write(AT91_AIC5_SVR, i);
+		/* Active Low interrupt, with the specified priority */
+		at91_aic_write(AT91_AIC5_SMR, AT91_AIC_SRCTYPE_LOW | val);
+		i++;
+	}
+
+	if (i < 1)
+		pr_warn("AIC: no valid default irqs priorities\n");
+}
+
+int __init at91_aic_of_common_init(struct device_node *node,
+                                   struct device_node *parent)
+{
+	struct property *prop;
+	const __be32 *p;
+	u32 val;
+
+	at91_extern_irq = kzalloc(BITS_TO_LONGS(n_irqs)
+	                          * sizeof(*at91_extern_irq), GFP_KERNEL);
+	if (!at91_extern_irq)
+		return -ENOMEM;
+
+	if (at91_aic_pm_init()) {
+		kfree(at91_extern_irq);
+		return -ENOMEM;
+	}
 
 	at91_aic_base = of_iomap(node, 0);
 	at91_aic_np = node;
 
-	at91_aic_domain = irq_domain_add_linear(at91_aic_np, NR_AIC_IRQS,
+	at91_aic_domain = irq_domain_add_linear(at91_aic_np, n_irqs,
 						&at91_aic_irq_ops, NULL);
 	if (!at91_aic_domain)
 		panic("Unable to add AIC irq domain (DT)\n");
 
-	at91_extern_irq = 0;
 	of_property_for_each_u32(node, "atmel,external-irqs", prop, p, val) {
-		if (val > 31)
-			pr_warn("AIC: external irq %d > 31 skip it\n", val);
+		if (val >= n_irqs)
+			pr_warn("AIC: external irq %d >= %d skip it\n",
+			        val, n_irqs);
 		else
-			at91_extern_irq |= (1 << val);
+			set_bit(val, at91_extern_irq);
 	}
 
+	irq_set_default_host(at91_aic_domain);
+
+	return 0;
+}
+
+int __init at91_aic_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	int err;
+
+	err = at91_aic_of_common_init(node, parent);
+	if (err)
+		return err;
+
 	at91_aic_of_priority(node);
 
-	irq_set_default_host(at91_aic_domain);
+	at91_aic_hw_init(n_irqs);
 
-	at91_aic_hw_init(NR_AIC_IRQS);
+	return 0;
+}
+
+int __init at91_aic5_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	int err;
+
+	at91_aic_caps |= AT91_AIC_CAP_AIC5;
+	n_irqs = NR_AIC5_IRQS;
+	at91_aic_chip.irq_ack           = at91_aic5_mask_irq;
+	at91_aic_chip.irq_mask		= at91_aic5_mask_irq;
+	at91_aic_chip.irq_unmask	= at91_aic5_unmask_irq;
+	at91_aic_chip.irq_eoi		= at91_aic5_eoi;
+	at91_aic_irq_ops.map		= at91_aic5_irq_map;
+
+	err = at91_aic_of_common_init(node, parent);
+	if (err)
+		return err;
+
+	at91_aic5_of_priority(node);
+
+	at91_aic5_hw_init(n_irqs);
 
 	return 0;
 }
@@ -266,7 +516,7 @@ int __init at91_aic_of_init(struct device_node *node,
 /*
  * Initialize the AIC interrupt controller.
  */
-void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
+void __init at91_aic_init(unsigned int *priority)
 {
 	unsigned int i;
 	int irq_base;
@@ -294,15 +544,14 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 	 * The IVR is used by macro get_irqnr_and_base to read and verify.
 	 * The irq number is NR_AIC_IRQS when a spurious interrupt has occurred.
 	 */
-	for (i = 0; i < NR_AIC_IRQS; i++) {
+	for (i = 0; i < n_irqs; i++) {
 		/* Put hardware irq number in Source Vector Register: */
 		at91_aic_write(AT91_AIC_SVR(i), i);
 		/* Active Low interrupt, with the specified priority */
 		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
-
 		irq_set_chip_and_handler(i, &at91_aic_chip, handle_fasteoi_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 
-	at91_aic_hw_init(NR_AIC_IRQS);
+	at91_aic_hw_init(n_irqs);
 }
-- 
1.7.5.4
