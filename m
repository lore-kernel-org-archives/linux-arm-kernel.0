From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:19:33 +0100
Subject: [PATCH v5 10/20] KVM: ARM: vgic: move underflow handling to vgic_ops
In-Reply-To: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
References: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169583-13668-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code dealing with LR underflow handling to its own functions,
and make them accessible through vgic_ops.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  2 ++
 virt/kvm/arm/vgic.c    | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 4857508..cdfa5d9 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -88,6 +88,8 @@ struct vgic_ops {
 	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
 	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
 	u32	(*get_interrupt_status)(const struct kvm_vcpu *vcpu);
+	void	(*enable_underflow)(struct kvm_vcpu *vcpu);
+	void	(*disable_underflow)(struct kvm_vcpu *vcpu);
 };
 
 struct vgic_dist {
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 9491c22..369016c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1047,6 +1047,16 @@ static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static void vgic_v2_enable_underflow(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr |= GICH_HCR_UIE;
+}
+
+static void vgic_v2_disable_underflow(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
+}
+
 static const struct vgic_ops vgic_ops = {
 	.get_lr			= vgic_v2_get_lr,
 	.set_lr			= vgic_v2_set_lr,
@@ -1054,6 +1064,8 @@ static const struct vgic_ops vgic_ops = {
 	.get_elrsr		= vgic_v2_get_elrsr,
 	.get_eisr		= vgic_v2_get_eisr,
 	.get_interrupt_status	= vgic_v2_get_interrupt_status,
+	.enable_underflow	= vgic_v2_enable_underflow,
+	.disable_underflow	= vgic_v2_disable_underflow,
 };
 
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
@@ -1088,6 +1100,16 @@ static inline u32 vgic_get_interrupt_status(struct kvm_vcpu *vcpu)
 	return vgic_ops.get_interrupt_status(vcpu);
 }
 
+static inline void vgic_enable_underflow(struct kvm_vcpu *vcpu)
+{
+	vgic_ops.enable_underflow(vcpu);
+}
+
+static inline void vgic_disable_underflow(struct kvm_vcpu *vcpu)
+{
+	vgic_ops.disable_underflow(vcpu);
+}
+
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
@@ -1269,9 +1291,9 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 
 epilog:
 	if (overflow) {
-		vgic_cpu->vgic_v2.vgic_hcr |= GICH_HCR_UIE;
+		vgic_enable_underflow(vcpu);
 	} else {
-		vgic_cpu->vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
+		vgic_disable_underflow(vcpu);
 		/*
 		 * We're about to run this VCPU, and we've consumed
 		 * everything the distributor had in store for
@@ -1324,7 +1346,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 	}
 
 	if (status & INT_STATUS_UNDERFLOW)
-		vgic_cpu->vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
+		vgic_disable_underflow(vcpu);
 
 	return level_pending;
 }
-- 
1.8.3.4
