From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:19:31 +0100
Subject: [PATCH v5 08/20] KVM: ARM: vgic: abstract EISR bitmap access
In-Reply-To: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
References: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169583-13668-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GICH_EISR access to its own function.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  1 +
 virt/kvm/arm/vgic.c    | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index 8b73cd6..0d9701c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1028,11 +1028,18 @@ static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
 	return *(u64 *)elrsr;
 }
 
+static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
+{
+	const u32 *eisr = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
+	return *(u64 *)eisr;
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
@@ -1057,6 +1064,11 @@ static inline u64 vgic_get_elrsr(struct kvm_vcpu *vcpu)
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
@@ -1263,10 +1275,11 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
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
1.8.3.4
