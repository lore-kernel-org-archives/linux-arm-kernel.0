From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 19:12:53 +0100
Subject: [RFC 4/4] KVM: arm: vgic: handle irqfd forwarded IRQ injection before
 vgic readiness
In-Reply-To: <1416766373-13569-1-git-send-email-eric.auger@linaro.org>
References: <1416766373-13569-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416766373-13569-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch handles the case where irqfd attempts to inject
a forwarded IRQ before the vgic is ready to accept it. We
cannot simply return pretending nothing happened since the IRQ
will never be deactivated by the guest. Indeed, the corresponding
virtual IRQ cannot be injected into the guest and the host
must deactivate it.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 21419ac..27394b0 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2672,6 +2672,13 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id,
 		u32 irq, int level, bool line_status)
 {
 	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
+	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, 0);
+	int phys_irq =  vgic_get_phys_irq(vcpu, spi);
+	bool is_forwarded = (phys_irq >= 0);
+	unsigned long flags;
+	struct irq_desc *desc;
+	struct irq_data *d;
+	struct irq_chip *chip;
 
 	kvm_debug("irqfd sets vIRQ %d to %d\n", irq, level);
 
@@ -2679,6 +2686,19 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id,
 		if (spi > kvm->arch.vgic.nr_irqs)
 			return -EINVAL;
 		return kvm_vgic_inject_irq(kvm, 0, spi, level);
+	}
+
+	if (level && is_forwarded) {
+		/*
+		 * the virtual IRQ never is injected into the guest
+		 * it must be manually completed on host side.
+		 */
+		desc = irq_to_desc(phys_irq);
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		d = &desc->irq_data;
+		chip = desc->irq_data.chip;
+		chip->irq_eoi(d);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	} else if (level && kvm_irq_has_notifier(kvm, 0, irq)) {
 		/*
 		 * any IRQ injected before vgic readiness is
-- 
1.9.1
