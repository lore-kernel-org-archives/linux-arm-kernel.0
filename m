From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Nov 2014 18:53:06 +0000
Subject: [PATCH v2 11/13] irqchip: GICv3: ITS: plug ITS init into main GICv3
 code
In-Reply-To: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
References: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416336788-22634-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ITS is always a subsystem if GICv3, its probing/init is
driven by the main GICv3 code.

Plug that code in (guarded by a config option).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c       | 41 ++++++++++++++++++++++++++++++++------
 include/linux/irqchip/arm-gic-v3.h |  5 +++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 48f3f72..3c04389 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -76,9 +76,6 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 	if (d->hwirq <= 1023)		/* SPI -> dist_base */
 		return gic_data.dist_base;
 
-	if (d->hwirq >= 8192)
-		BUG();		/* LPI Detected!!! */
-
 	return NULL;
 }
 
@@ -276,11 +273,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	do {
 		irqnr = gic_read_iar();
 
-		if (likely(irqnr > 15 && irqnr < 1020)) {
+		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 			int err;
 			err = handle_domain_irq(gic_data.domain, irqnr, regs);
 			if (err) {
-				WARN_ONCE(true, "Unexpected SPI received!\n");
+				WARN_ONCE(true, "Unexpected interrupt received!\n");
 				gic_write_eoir(irqnr);
 			}
 			continue;
@@ -393,6 +390,11 @@ static void gic_cpu_sys_reg_init(void)
 	gic_write_grpen1(1);
 }
 
+static int gic_dist_supports_lpis(void)
+{
+	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
+}
+
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
@@ -407,6 +409,10 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
+	/* Give LPIs a spin */
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+		its_cpu_init();
+
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -593,12 +599,21 @@ static struct irq_chip gic_chip = {
 	.irq_set_affinity	= gic_set_affinity,
 };
 
+#define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
+
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	/* SGIs are private to the core kernel */
 	if (hw < 16)
 		return -EPERM;
+	/* Nothing here */
+	if (hw >= gic_data.irq_nr && hw < 8192)
+		return -EPERM;
+	/* Off limits */
+	if (hw >= GIC_ID_NR)
+		return -EPERM;
+
 	/* PPIs */
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
@@ -612,7 +627,15 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
-	irq_set_chip_data(irq, d->host_data);
+	/* LPIs */
+	if (hw >= 8192 && hw < GIC_ID_NR) {
+		if (!gic_dist_supports_lpis())
+			return -EPERM;
+		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
+				    handle_fasteoi_irq, NULL, NULL);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
 	return 0;
 }
 
@@ -633,6 +656,9 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 	case 1:			/* PPI */
 		*out_hwirq = intspec[1] + 16;
 		break;
+	case GIC_IRQ_TYPE_LPI:	/* LPI */
+		*out_hwirq = intspec[1];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -759,6 +785,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	set_handle_irq(gic_handle_irq);
 
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+		its_init(node, &gic_data.rdists, gic_data.domain);
+
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 0ed30d7..1e8b0cf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -318,6 +318,11 @@ static inline void gic_write_eoir(u64 irq)
 	isb();
 }
 
+struct irq_domain;
+int its_cpu_init(void);
+int its_init(struct device_node *node, struct rdists *rdists,
+	     struct irq_domain *domain);
+
 #endif
 
 #endif
-- 
2.1.3
