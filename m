From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Aug 2015 09:28:46 +0100
Subject: [PATCH v2 4/4] irqchip: GIC: Don't deactivate interrupts forwarded to
 a guest
In-Reply-To: <1439454526-1185-1-git-send-email-marc.zyngier@arm.com>
References: <1439454526-1185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1439454526-1185-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0a4377de3056 ("genirq: Introduce irq_set_vcpu_affinity() to
target an interrupt to a VCPU") added just what we needed at the
lowest level to allow an interrupt to be deactivated by a guest.

When such a request reaches the GIC, it knows it doesn't need to
perform the deactivation anymore, and can safely leave the guest
do its magic. This of course requires additional support in both
VFIO and KVM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b020c3a..ea691be 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -148,6 +148,34 @@ static inline bool primary_gic_irq(struct irq_data *d)
 	return true;
 }
 
+static inline bool cascading_gic_irq(struct irq_data *d)
+{
+	/*
+	 * If handler_data pointing to one of the secondary GICs, then
+	 * this is the cascading interrupt, and it cannot possibly be
+	 * forwarded.
+	 */
+	if (d->handler_data >= (void *)(gic_data + 1) &&
+	    d->handler_data <  (void *)(gic_data + MAX_GIC_NR))
+		return true;
+
+	return false;
+}
+
+static inline bool forwarded_irq(struct irq_data *d)
+{
+	/*
+	 * A forwarded interrupt:
+	 * - is on the primary GIC
+	 * - has its handler_data set to a value
+	 * - that isn't a secondary GIC
+	 */
+	if (primary_gic_irq(d) && d->handler_data && !cascading_gic_irq(d))
+		return true;
+
+	return false;
+}
+
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
@@ -166,6 +194,18 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 static void gic_mask_irq(struct irq_data *d)
 {
 	gic_poke_irq(d, GIC_DIST_ENABLE_CLEAR);
+	/*
+	 * When masking a forwarded interrupt, make sure it is
+	 * deactivated as well.
+	 *
+	 * This ensures that an interrupt that is getting
+	 * disabled/masked will not get "stuck", because there is
+	 * noone to deactivate it (guest is being terminated).
+	 */
+	if (static_key_true(&supports_deactivate)) {
+		if (forwarded_irq(d))
+			gic_poke_irq(d, GIC_DIST_ACTIVE_CLEAR);
+	}
 }
 
 static void gic_unmask_irq(struct irq_data *d)
@@ -178,6 +218,10 @@ static void gic_eoi_irq(struct irq_data *d)
 	u32 deact_offset = GIC_CPU_EOI;
 
 	if (static_key_true(&supports_deactivate)) {
+		/* Do not deactivate an IRQ forwarded to a vcpu. */
+		if (forwarded_irq(d))
+			return;
+
 		if (primary_gic_irq(d))
 			deact_offset = GIC_CPU_DEACTIVATE;
 	}
@@ -251,6 +295,19 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	return gic_configure_irq(gicirq, type, base, NULL);
 }
 
+static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
+{
+	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
+	if (static_key_true(&supports_deactivate)) {
+		if (primary_gic_irq(d) && !cascading_gic_irq(d)) {
+			d->handler_data = vcpu;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 #ifdef CONFIG_SMP
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
@@ -346,6 +403,7 @@ static struct irq_chip gic_chip = {
 #endif
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
 
-- 
2.1.4
