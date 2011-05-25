From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2011 17:49:56 +0100
Subject: [RFC PATCH v3 01/13] ARM: gic: add per-cpu interrupt multiplexer
In-Reply-To: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
References: <1306342208-32754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306342208-32754-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel doesn't handle very well the concept of per-cpu interrupt
as implemented by the ARM architecture (the same interrupt level is
exposed on each core).

To work around the problem, add another irq_chip to handle PPIs and
remap them so that a single interrupt number is only used on a given
CPU (for example, IRQ 29 and 30 get exposed as IRQ 128 and 129 on
core 0, 130 and 131 on core 1...).

A helper function gic_ppi_to_vppi() is used to convert the PPI number
to the per-processor IRQ.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/Kconfig                         |    5 +
 arch/arm/common/gic.c                           |  133 ++++++++++++++++++++++-
 arch/arm/include/asm/entry-macro-multi.S        |    2 +-
 arch/arm/include/asm/hardware/entry-macro-gic.S |   19 ++--
 arch/arm/include/asm/hardware/gic.h             |   11 ++
 arch/arm/kernel/irq.c                           |    8 ++-
 6 files changed, 165 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index ea5ee4d..020a531 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,6 +1,11 @@
 config ARM_GIC
 	bool
 
+config ARM_GIC_VPPI
+	depends on ARM_GIC
+	select SPARSE_IRQ
+        bool
+
 config ARM_VIC
 	bool
 
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4ddd0a6..2146d5e 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -42,6 +42,12 @@ struct gic_chip_data {
 	unsigned int irq_offset;
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
+#ifdef CONFIG_ARM_GIC_VPPI
+	/* These fields must be 0 on secondary GICs */
+	int	     ppi_base;
+	int	     vppi_base;
+	u16	     nrppis;
+#endif
 };
 
 /*
@@ -262,12 +268,88 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	irq_set_chained_handler(irq, gic_handle_cascade_irq);
 }
 
+#ifdef CONFIG_ARM_GIC_VPPI
+unsigned int gic_ppi_to_vppi(unsigned int irq)
+{
+	struct gic_chip_data *chip_data = irq_get_chip_data(irq);
+	unsigned int vppi_irq;
+	unsigned int ppi;
+
+	WARN_ON(!chip_data->vppi_base);
+
+	ppi = irq - chip_data->ppi_base;
+	vppi_irq = ppi + chip_data->nrppis * smp_processor_id();
+	vppi_irq += chip_data->vppi_base;
+
+	return vppi_irq;
+}
+
+static void gic_handle_ppi(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int vppi_irq;
+
+	vppi_irq = gic_ppi_to_vppi(irq);
+	generic_handle_irq(vppi_irq);
+}
+
+static struct irq_data *gic_vppi_to_ppi(struct irq_data *d)
+{
+	struct gic_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	unsigned int ppi_irq;
+
+	ppi_irq = d->irq - chip_data->vppi_base - chip_data->nrppis * smp_processor_id();
+	ppi_irq += chip_data->ppi_base;
+
+	return irq_get_irq_data(ppi_irq);
+}
+
+static void gic_ppi_eoi_irq(struct irq_data *d)
+{
+	gic_eoi_irq(gic_vppi_to_ppi(d));
+}
+
+static void gic_ppi_mask_irq(struct irq_data *d)
+{
+	gic_mask_irq(gic_vppi_to_ppi(d));
+}
+
+static void gic_ppi_unmask_irq(struct irq_data *d)
+{
+	gic_unmask_irq(gic_vppi_to_ppi(d));
+}
+
+static int gic_ppi_set_type(struct irq_data *d, unsigned int type)
+{
+	return gic_set_type(gic_vppi_to_ppi(d), type);
+}
+
+static int gic_ppi_set_wake(struct irq_data *d, unsigned int on)
+{
+	return gic_set_wake(gic_vppi_to_ppi(d), on);
+}
+
+static int __init gic_irq_is_ppi(struct gic_chip_data *gic, unsigned int irq)
+{
+	return (irq >= (gic->irq_offset + 16) && irq <= (gic->irq_offset + 31));
+}
+
+static struct irq_chip gic_ppi_chip = {
+	.name			= "GIC-PPI",
+	.irq_eoi		= gic_ppi_eoi_irq,
+	.irq_mask		= gic_ppi_mask_irq,
+	.irq_unmask		= gic_ppi_unmask_irq,
+	.irq_set_type		= gic_ppi_set_type,
+	.irq_set_wake		= gic_ppi_set_wake,
+};
+#endif
+
 static void __init gic_dist_init(struct gic_chip_data *gic,
 	unsigned int irq_start)
 {
-	unsigned int gic_irqs, irq_limit, i;
+	unsigned int gic_irqs, irq_limit, i, nrvppis = 0;
 	void __iomem *base = gic->dist_base;
 	u32 cpumask = 1 << smp_processor_id();
+	u32 dist_ctr, nrcpus;
 
 	cpumask |= cpumask << 8;
 	cpumask |= cpumask << 16;
@@ -278,11 +360,32 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources.
 	 */
-	gic_irqs = readl_relaxed(base + GIC_DIST_CTR) & 0x1f;
-	gic_irqs = (gic_irqs + 1) * 32;
+	dist_ctr = readl_relaxed(base + GIC_DIST_CTR);
+	gic_irqs = ((dist_ctr & 0x1f) + 1) * 32;
 	if (gic_irqs > 1020)
 		gic_irqs = 1020;
 
+	/* Find out how many CPUs are supported (8 max). */
+	nrcpus = ((dist_ctr >> 5) & 7) + 1;
+
+#ifdef CONFIG_ARM_GIC_VPPI
+	/*
+	 * Nobody would be insane enough to use PPIs on a secondary
+	 * GIC, right?
+	 */
+	if (gic == &gic_data[0]) {
+		gic->nrppis = 16 - (irq_start % 16);
+		gic->ppi_base = gic->irq_offset + 32 - gic->nrppis;
+		nrvppis = gic->nrppis * nrcpus;
+	} else {
+		gic->ppi_base = 0;
+		gic->vppi_base = 0;
+	}
+#endif
+
+	pr_info("Configuring GIC with %d sources (%d additional PPIs)\n",
+		gic_irqs, nrvppis);
+
 	/*
 	 * Set all global interrupts to be level triggered, active low.
 	 */
@@ -319,10 +422,32 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	 * Setup the Linux IRQ subsystem.
 	 */
 	for (i = irq_start; i < irq_limit; i++) {
-		irq_set_chip_and_handler(i, &gic_chip, handle_fasteoi_irq);
+#ifdef CONFIG_ARM_GIC_VPPI
+		if (nrvppis && gic_irq_is_ppi(gic, i))
+			irq_set_chip_and_handler(i, &gic_chip, gic_handle_ppi);
+		else
+#endif
+		{
+			irq_set_chip_and_handler(i, &gic_chip,
+						 handle_fasteoi_irq);
+			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		}
+		irq_set_chip_data(i, gic);
+	}
+
+#ifdef CONFIG_ARM_GIC_VPPI
+	if (!nrvppis)
+		goto out;
+	gic->vppi_base = irq_alloc_descs(-1, 0, nrvppis, 0);
+	if (WARN_ON(gic->vppi_base < 0))
+		goto out;
+	for (i = gic->vppi_base; i < (gic->vppi_base + nrvppis); i++) {
+		irq_set_chip_and_handler(i, &gic_ppi_chip, handle_percpu_irq);
 		irq_set_chip_data(i, gic);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
+out:
+#endif
 
 	writel_relaxed(1, base + GIC_DIST_CTRL);
 }
diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index ec0bbf7..c599795 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -24,7 +24,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
 
-#ifdef CONFIG_LOCAL_TIMERS
+#if defined(CONFIG_LOCAL_TIMERS) && !defined(CONFIG_ARM_GIC_VPPI)
 	test_for_ltirq r0, r6, r5, lr
 	movne	r0, sp
 	adrne	lr, BSYM(1b)
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index c115b82..14a3363 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -17,23 +17,26 @@
 	.endm
 #endif
 
+#ifdef CONFIG_ARM_GIC_VPPI
+#define DO_IRQ_BASE	16
+#else
+#define DO_IRQ_BASE	30
+#endif
+
 /*
  * The interrupt numbering scheme is defined in the
  * interrupt controller spec.  To wit:
  *
  * Interrupts 0-15 are IPI
- * 16-28 are reserved
- * 29-31 are local.  We allow 30 to be used for the watchdog.
+ * 16-31 are local.  We allow 30 to be used for the watchdog.
  * 32-1020 are global
  * 1021-1022 are reserved
  * 1023 is "spurious" (no interrupt)
  *
- * For now, we ignore all local interrupts so only return an interrupt if it's
- * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
- *
  * A simple read from the controller will tell us the number of the highest
  * priority enabled interrupt.  We then just need to check whether it is in the
- * valid range for an IRQ (30-1020 inclusive).
+ * valid range for an IRQ (30-1020 inclusive). If CONFIG_ARM_GIC_VPPI is
+ * enabled, local interrupts are handled the same way as global ones.
  */
 
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
@@ -43,7 +46,7 @@
 
 	ldr	\tmp, =1021
 	bic     \irqnr, \irqstat, #0x1c00
-	cmp     \irqnr, #29
+	cmp     \irqnr, #(DO_IRQ_BASE - 1)
 	cmpcc	\irqnr, \irqnr
 	cmpne	\irqnr, \tmp
 	cmpcs	\irqnr, \irqnr
@@ -63,6 +66,7 @@
 	cmpcs	\irqnr, \irqnr
 	.endm
 
+#ifndef CONFIG_ARM_GIC_VPPI
 /* As above, this assumes that irqstat and base are preserved.. */
 
 	.macro test_for_ltirq, irqnr, irqstat, base, tmp
@@ -73,3 +77,4 @@
 	streq	\irqstat, [\base, #GIC_CPU_EOI]
 	cmp	\tmp, #0
 	.endm
+#endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 0691f9d..9dbffed 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,6 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
+#include <linux/cpumask.h>
+
 extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
@@ -41,6 +43,15 @@ void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 void gic_enable_ppi(unsigned int);
+#ifdef CONFIG_ARM_GIC_VPPI
+unsigned int gic_ppi_to_vppi(unsigned int irq);
+#else
+static inline unsigned int gic_ppi_to_vppi(unsigned int irq)
+{
+	return irq;
+}
+#endif
+
 #endif
 
 #endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 83bbad0..237959f 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -124,8 +124,14 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
+	int initcnt;
+
 	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	initcnt = nr_irqs;
+#ifdef CONFIG_ARM_GIC_VPPI
+	nr_irqs += 16 * 8;	/* 16 PPIs, 8 CPUs */
+#endif
+	return initcnt;
 }
 #endif
 
-- 
1.7.0.4
