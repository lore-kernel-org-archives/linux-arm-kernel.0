From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:47 +0100
Subject: [PATCH 31/58] KVM: arm64: vgic-v3: Add ICV_BPR1_EL1 handler
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-32-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for reading/writing the guest's view of the ICC_BPR1_EL1
register, which is located in the ICH_VMCR_EL2.BPR1 field.

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index e6c05b95a1b1..fe021abc8b51 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -375,6 +375,57 @@ void __hyp_text __vgic_v3_write_vmcr(u32 vmcr)
 
 #ifdef CONFIG_ARM64
 
+static int __hyp_text __vgic_v3_bpr_min(void)
+{
+	/* See Pseudocode for VPriorityGroup */
+	return 8 - vtr_to_nr_pre_bits(read_gicreg(ICH_VTR_EL2));
+}
+
+static unsigned int __hyp_text __vgic_v3_get_bpr0(u32 vmcr)
+{
+	return (vmcr & ICH_VMCR_BPR0_MASK) >> ICH_VMCR_BPR0_SHIFT;
+}
+
+static unsigned int __hyp_text __vgic_v3_get_bpr1(u32 vmcr)
+{
+	unsigned int bpr;
+
+	if (vmcr & ICH_VMCR_CBPR_MASK) {
+		bpr = __vgic_v3_get_bpr0(vmcr);
+		if (bpr < 7)
+			bpr++;
+	} else {
+		bpr = (vmcr & ICH_VMCR_BPR1_MASK) >> ICH_VMCR_BPR1_SHIFT;
+	}
+
+	return bpr;
+}
+
+static void __hyp_text __vgic_v3_read_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	vcpu_set_reg(vcpu, rt, __vgic_v3_get_bpr1(vmcr));
+}
+
+static void __hyp_text __vgic_v3_write_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	u64 val = vcpu_get_reg(vcpu, rt);
+	u8 bpr_min = __vgic_v3_bpr_min();
+
+	if (vmcr & ICH_VMCR_CBPR_MASK)
+		return;
+
+	/* Enforce BPR limiting */
+	if (val < bpr_min)
+		val = bpr_min;
+
+	val <<= ICH_VMCR_BPR1_SHIFT;
+	val &= ICH_VMCR_BPR1_MASK;
+	vmcr &= ~ICH_VMCR_BPR1_MASK;
+	vmcr |= val;
+
+	__vgic_v3_write_vmcr(vmcr);
+}
+
 int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 {
 	int rt;
@@ -397,6 +448,12 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
 
 	switch (sysreg) {
+	case SYS_ICC_BPR1_EL1:
+		if (is_read)
+			fn = __vgic_v3_read_bpr1;
+		else
+			fn = __vgic_v3_write_bpr1;
+		break;
 	default:
 		return 0;
 	}
-- 
2.11.0
