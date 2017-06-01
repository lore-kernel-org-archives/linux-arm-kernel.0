From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Jun 2017 11:20:58 +0100
Subject: [PATCH v2 06/25] KVM: arm64: vgic-v3: Add ICV_IGRPEN1_EL1 handler
In-Reply-To: <20170601102117.17750-1-marc.zyngier@arm.com>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
Message-ID: <20170601102117.17750-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for reading/writing the guest's view of the ICC_IGRPEN1_EL1
register, which is located in the ICH_VMCR_EL2.VENG1 field.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 6254eaf72a77..168539dfd0b9 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -395,6 +395,23 @@ static unsigned int __hyp_text __vgic_v3_get_bpr1(u32 vmcr)
 	return bpr;
 }
 
+static void __hyp_text __vgic_v3_read_igrpen1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	vcpu_set_reg(vcpu, rt, !!(vmcr & ICH_VMCR_ENG1_MASK));
+}
+
+static void __hyp_text __vgic_v3_write_igrpen1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	u64 val = vcpu_get_reg(vcpu, rt);
+
+	if (val & 1)
+		vmcr |= ICH_VMCR_ENG1_MASK;
+	else
+		vmcr &= ~ICH_VMCR_ENG1_MASK;
+
+	__vgic_v3_write_vmcr(vmcr);
+}
+
 static void __hyp_text __vgic_v3_read_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
 {
 	vcpu_set_reg(vcpu, rt, __vgic_v3_get_bpr1(vmcr));
@@ -442,6 +459,12 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
 
 	switch (sysreg) {
+	case SYS_ICC_GRPEN1_EL1:
+		if (is_read)
+			fn = __vgic_v3_read_igrpen1;
+		else
+			fn = __vgic_v3_write_igrpen1;
+		break;
 	case SYS_ICC_BPR1_EL1:
 		if (is_read)
 			fn = __vgic_v3_read_bpr1;
-- 
2.11.0
