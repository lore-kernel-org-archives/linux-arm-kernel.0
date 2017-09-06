From: cdall@linaro.org (Christoffer Dall)
Date: Wed,  6 Sep 2017 14:26:12 +0200
Subject: [PATCH v3 5/5] KVM: arm/arm64: Provide a vgic interrupt line level
 sample function
In-Reply-To: <20170906122612.18050-1-cdall@linaro.org>
References: <20170906122612.18050-1-cdall@linaro.org>
Message-ID: <20170906122612.18050-6-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC sometimes need to sample the physical line of a mapped
interrupt.  As we know this to be notoriously slow, provide a callback
function for devices (such as the timer) which can do this much faster
than talking to the distributor, for example by comparing a few
in-memory values.  Fall back to the good old method of poking the
physical GIC if no callback is provided.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h    | 13 ++++++++++++-
 virt/kvm/arm/arch_timer.c | 16 +++++++++++++++-
 virt/kvm/arm/vgic/vgic.c  | 12 +++++++++---
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 53f631b..7f76c9e 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -125,6 +125,17 @@ struct vgic_irq {
 	u8 priority;
 	enum vgic_irq_config config;	/* Level or edge */
 
+	/*
+	 * Callback function pointer to in-kernel devices that can tell us the
+	 * state of the input level of mapped level-triggered IRQ faster than
+	 * peaking into the physical GIC.
+	 *
+	 * Always called in non-preemptible section and the functions can use
+	 * kvm_arm_get_running_vcpu() to get the vcpu pointer for private
+	 * IRQs.
+	 */
+	bool (*get_input_level)(int vintid);
+
 	void *owner;			/* Opaque pointer to reserve an interrupt
 					   for in-kernel devices. */
 };
@@ -309,7 +320,7 @@ void kvm_vgic_init_cpu_hardware(void);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 			bool level, void *owner);
 int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
-			  u32 vintid);
+			  u32 vintid, bool (*get_input_level)(int vindid));
 int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid);
 bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
 
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index c4fa675..5cb96ca 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -645,6 +645,19 @@ static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static bool timer_get_input_level(int vintid)
+{
+	struct kvm_vcpu *vcpu = kvm_arm_get_running_vcpu();
+	struct arch_timer_context *timer;
+
+	if (vintid == vcpu_vtimer(vcpu)->irq.irq)
+		timer = vcpu_vtimer(vcpu);
+	else
+		BUG(); /* We only map the vtimer so far */
+
+	return kvm_timer_should_fire(timer);
+}
+
 int kvm_timer_enable(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
@@ -666,7 +679,8 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
-	ret = kvm_vgic_map_phys_irq(vcpu, host_vtimer_irq, vtimer->irq.irq);
+	ret = kvm_vgic_map_phys_irq(vcpu, host_vtimer_irq, vtimer->irq.irq,
+				    timer_get_input_level);
 	if (ret)
 		return ret;
 
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 7aec730..0ca2b3d 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -154,6 +154,9 @@ bool vgic_get_phys_line_level(struct vgic_irq *irq)
 
 	BUG_ON(!irq->hw);
 
+	if (irq->get_input_level)
+		return irq->get_input_level(irq->intid);
+
 	WARN_ON(irq_get_irqchip_state(irq->host_irq,
 				      IRQCHIP_STATE_PENDING,
 				      &line_level));
@@ -437,7 +440,8 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 
 /* @irq->irq_lock must be held */
 static int kvm_vgic_map_irq(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
-			    unsigned int host_irq)
+			    unsigned int host_irq,
+			    bool (*get_input_level)(int vindid))
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
@@ -457,6 +461,7 @@ static int kvm_vgic_map_irq(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	irq->hw = true;
 	irq->host_irq = host_irq;
 	irq->hwintid = data->hwirq;
+	irq->get_input_level = get_input_level;
 	return 0;
 }
 
@@ -465,10 +470,11 @@ static inline void kvm_vgic_unmap_irq(struct vgic_irq *irq)
 {
 	irq->hw = false;
 	irq->hwintid = 0;
+	irq->get_input_level = NULL;
 }
 
 int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
-			  u32 vintid)
+			  u32 vintid, bool (*get_input_level)(int vindid))
 {
 	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
 	int ret;
@@ -476,7 +482,7 @@ int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
 	BUG_ON(!irq);
 
 	spin_lock(&irq->irq_lock);
-	ret = kvm_vgic_map_irq(vcpu, irq, host_irq);
+	ret = kvm_vgic_map_irq(vcpu, irq, host_irq, get_input_level);
 	spin_unlock(&irq->irq_lock);
 	vgic_put_irq(vcpu->kvm, irq);
 
-- 
2.9.0
