From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:37 +0100
Subject: [PATCH v5 27/27] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-28-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement NMI callbacks for GICv3 irqchip. Install NMI safe handlers
when setting up interrupt line as NMI.

Only SPIs and PPIs are allowed to be set up as NMI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1af2fcc..b1b255a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -311,6 +311,70 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int gic_irq_set_irqchip_prio(struct irq_data *d, u8 prio)
+{
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	/* Number of CPUs having PPI (idx + 16) setup as NMI */
+	static uint32_t nb_ppinmi_refs[16] = { 0 };
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return -EINVAL;
+	}
+
+	/*
+	 * A secondary irq_chip should be in charge of LPI request,
+	 * it should not be possible to get there
+	 */
+	if (WARN_ON(gic_irq(d) >= 8192))
+		return -EINVAL;
+
+	/* desc lock should already be held */
+	if (prio == GICD_INT_NMI_PRI) {
+		if (gic_irq(d) < 32) {
+			/* Setting up NMI, only switch handler for first NMI */
+			if (nb_ppinmi_refs[gic_irq(d) - 16] == 0)
+				desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
+
+			nb_ppinmi_refs[gic_irq(d) - 16]++;
+		} else {
+			desc->handle_irq = handle_fasteoi_nmi;
+		}
+	} else if (prio == GICD_INT_DEF_PRI) {
+		if (gic_irq(d) < 32) {
+			/* Tearing down NMI, only switch handler for last NMI */
+			if (nb_ppinmi_refs[gic_irq(d) - 16] == 1)
+				desc->handle_irq = handle_percpu_devid_irq;
+
+			nb_ppinmi_refs[gic_irq(d) - 16]--;
+		} else {
+			desc->handle_irq = handle_fasteoi_irq;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), prio);
+
+	return 0;
+}
+
+static int gic_irq_nmi_setup(struct irq_data *d)
+{
+	if (!gic_supports_nmi())
+		return -EINVAL;
+
+	return gic_irq_set_irqchip_prio(d, GICD_INT_NMI_PRI);
+}
+
+static void gic_irq_nmi_teardown(struct irq_data *d)
+{
+	if (WARN_ON(!gic_supports_nmi()))
+		return;
+
+	gic_irq_set_irqchip_prio(d, GICD_INT_DEF_PRI);
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	gic_write_eoir(gic_irq(d));
@@ -937,6 +1001,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -952,6 +1018,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1147,6 +1215,11 @@ static int partition_domain_translate(struct irq_domain *d,
 static void gic_enable_nmi_support(void)
 {
 	static_branch_enable(&have_non_secure_prio_view);
+
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_eoimode1_chip.flags |= IRQCHIP_SUPPORTS_NMI;
+	else
+		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
 static int __init gic_init_bases(void __iomem *dist_base,
-- 
1.9.1
