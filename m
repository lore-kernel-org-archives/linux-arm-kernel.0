From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Jul 2015 14:19:10 +0100
Subject: [PATCH 5/6] irqchip: GICv3: Don't deactivate interrupts forwarded to
 a guest
In-Reply-To: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436447951-22357-6-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e02592b..a1ca9e6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -70,6 +70,11 @@ static inline int gic_irq_in_rdist(struct irq_data *d)
 	return gic_irq(d) < 32;
 }
 
+static inline bool forwarded_irq(struct irq_data *d)
+{
+	return d->handler_data != NULL;
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	if (gic_irq_in_rdist(d))	/* SGI+PPI -> SGI_base for this CPU */
@@ -231,6 +236,12 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
 static void gic_mask_irq(struct irq_data *d)
 {
 	gic_poke_irq(d, GICD_ICENABLER);
+	/*
+	 * When masking a forwarded interrupt, make sure it is
+	 * deactivated as well.
+	 */
+	if (static_key_true(&supports_deactivate) && forwarded_irq(d))
+		gic_poke_irq(d, GICD_ICACTIVER);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
@@ -296,8 +307,11 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 static void gic_eoi_irq(struct irq_data *d)
 {
 	if (static_key_true(&supports_deactivate)) {
-		/* No need to deactivate an LPI */
-		if (gic_irq(d) >= 8192)
+		/*
+		 * No need to deactivate an LPI, or an interrupt that
+		 * is is getting forwarded to a vcpu.
+		 */
+		if (gic_irq(d) >= 8192 || forwarded_irq(d))
 			return;
 		gic_write_dir(gic_irq(d));
 	} else {
@@ -331,6 +345,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	return gic_configure_irq(irq, type, base, rwp_wait);
 }
 
+static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
+{
+	if (static_key_true(&supports_deactivate)) {
+		d->handler_data = vcpu;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static u64 gic_mpidr_to_affinity(u64 mpidr)
 {
 	u64 aff;
@@ -678,6 +702,7 @@ static struct irq_chip gic_chip = {
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
 
-- 
2.1.4
