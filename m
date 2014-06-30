From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jun 2014 16:01:41 +0100
Subject: [PATCH v6 12/21] KVM: ARM: vgic: introduce vgic_enable
In-Reply-To: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404140510-5382-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code dealing with enabling the VGIC on to vgic_ops.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  1 +
 virt/kvm/arm/vgic.c    | 29 +++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index f515800..2228973 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -99,6 +99,7 @@ struct vgic_ops {
 	void	(*disable_underflow)(struct kvm_vcpu *vcpu);
 	void	(*get_vmcr)(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 	void	(*set_vmcr)(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
+	void	(*enable)(struct kvm_vcpu *vcpu);
 };
 
 struct vgic_dist {
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 418cfbf..ec95402 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1091,6 +1091,19 @@ static void vgic_v2_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
 	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
 }
 
+static void vgic_v2_enable(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * By forcing VMCR to zero, the GIC will restore the binary
+	 * points to their reset values. Anything else resets to zero
+	 * anyway.
+	 */
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = 0;
+
+	/* Get the show on the road... */
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr = GICH_HCR_EN;
+}
+
 static const struct vgic_ops vgic_ops = {
 	.get_lr			= vgic_v2_get_lr,
 	.set_lr			= vgic_v2_set_lr,
@@ -1102,6 +1115,7 @@ static const struct vgic_ops vgic_ops = {
 	.disable_underflow	= vgic_v2_disable_underflow,
 	.get_vmcr		= vgic_v2_get_vmcr,
 	.set_vmcr		= vgic_v2_set_vmcr,
+	.enable			= vgic_v2_enable,
 };
 
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
@@ -1156,6 +1170,11 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
 	vgic_ops.set_vmcr(vcpu, vmcr);
 }
 
+static inline void vgic_enable(struct kvm_vcpu *vcpu)
+{
+	vgic_ops.enable(vcpu);
+}
+
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
@@ -1618,15 +1637,9 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
 	}
 
-	/*
-	 * By forcing VMCR to zero, the GIC will restore the binary
-	 * points to their reset values. Anything else resets to zero
-	 * anyway.
-	 */
-	vgic_cpu->vgic_v2.vgic_vmcr = 0;
-
 	vgic_cpu->nr_lr = vgic_nr_lr;
-	vgic_cpu->vgic_v2.vgic_hcr = GICH_HCR_EN; /* Get the show on the road... */
+
+	vgic_enable(vcpu);
 
 	return 0;
 }
-- 
2.0.0
