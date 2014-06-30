From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jun 2014 16:01:37 +0100
Subject: [PATCH v6 08/21] KVM: ARM: vgic: abstract EISR bitmap access
In-Reply-To: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404140510-5382-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GICH_EISR access to its own function.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  1 +
 virt/kvm/arm/vgic.c    | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 38864f5..ccb9b59 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -86,6 +86,7 @@ struct vgic_ops {
 	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
 	void	(*sync_lr_elrsr)(struct kvm_vcpu *, int, struct vgic_lr);
 	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
+	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
 };
 
 struct vgic_dist {
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b1d646a..61a6347 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1033,11 +1033,23 @@ static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
 	return val;
 }
 
+static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
+{
+	u64 val;
+
+	val  = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[1];
+	val <<= 32;
+	val |= vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[0];
+
+	return val;
+}
+
 static const struct vgic_ops vgic_ops = {
 	.get_lr			= vgic_v2_get_lr,
 	.set_lr			= vgic_v2_set_lr,
 	.sync_lr_elrsr		= vgic_v2_sync_lr_elrsr,
 	.get_elrsr		= vgic_v2_get_elrsr,
+	.get_eisr		= vgic_v2_get_eisr,
 };
 
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
@@ -1062,6 +1074,11 @@ static inline u64 vgic_get_elrsr(struct kvm_vcpu *vcpu)
 	return vgic_ops.get_elrsr(vcpu);
 }
 
+static inline u64 vgic_get_eisr(struct kvm_vcpu *vcpu)
+{
+	return vgic_ops.get_eisr(vcpu);
+}
+
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
@@ -1268,10 +1285,11 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 		 * Some level interrupts have been EOIed. Clear their
 		 * active bit.
 		 */
+		u64 eisr = vgic_get_eisr(vcpu);
+		unsigned long *eisr_ptr = (unsigned long *)&eisr;
 		int lr;
 
-		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_eisr,
-				 vgic_cpu->nr_lr) {
+		for_each_set_bit(lr, eisr_ptr, vgic_cpu->nr_lr) {
 			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
 
 			vgic_irq_clear_active(vcpu, vlr.irq);
-- 
2.0.0
