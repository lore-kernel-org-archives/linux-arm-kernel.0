From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:05:05 +0000
Subject: [RFC PATCH 42/45] KVM: arm/arm64: vgic-new: Add vgic_v2/v3_enable
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-43-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

Enable the VGIC operation by properly initialising the registers
in the hypervisor GIC interface.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic-v2.c | 11 ++++++++++-
 virt/kvm/arm/vgic/vgic-v3.c | 23 ++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index 8d0898c..5f7c289 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -234,9 +234,18 @@ void vgic_v2_irq_change_affinity(struct kvm *kvm, u32 intid, u8 new_targets)
 	spin_unlock(&irq->irq_lock);
 }
 
-/* not yet implemented */
 void vgic_v2_enable(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * By forcing VMCR to zero, the GIC will restore the binary
+	 * points to their reset values. Anything else resets to zero
+	 * anyway.
+	 */
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = 0;
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr = ~0;
+
+	/* Get the show on the road... */
+	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr = GICH_HCR_EN;
 }
 
 int vgic_v2_map_resources(struct kvm *kvm)
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 705a269..8944c46 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -220,9 +220,30 @@ void vgic_v3_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
 	vmcrp->pmr  = (vmcr & ICH_VMCR_PMR_MASK) >> ICH_VMCR_PMR_SHIFT;
 }
 
-/* not yet implemented */
 void vgic_v3_enable(struct kvm_vcpu *vcpu)
 {
+	struct vgic_v3_cpu_if *vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
+
+	/*
+	 * By forcing VMCR to zero, the GIC will restore the binary
+	 * points to their reset values. Anything else resets to zero
+	 * anyway.
+	 */
+	vgic_v3->vgic_vmcr = 0;
+	vgic_v3->vgic_elrsr = ~0;
+
+	/*
+	 * If we are emulating a GICv3, we do it in an non-GICv2-compatible
+	 * way, so we force SRE to 1 to demonstrate this to the guest.
+	 * This goes with the spec allowing the value to be RAO/WI.
+	 */
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;
+	else
+		vgic_v3->vgic_sre = 0;
+
+	/* Get the show on the road... */
+	vgic_v3->vgic_hcr = ICH_HCR_EN;
 }
 
 int vgic_v3_map_resources(struct kvm *kvm)
-- 
2.7.3
