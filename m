From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:55 +0100
Subject: [PATCH 39/58] KVM: arm64: vgic-v3: Add ICV_BPR0_EL1 handler
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-40-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for reading/writing the guest's view of the ICC_BPR0_EL1
register, which is located in the ICH_VMCR_EL2.BPR0 field.

Tested-by: Alexander Graf <agraf@suse.de>
Acked-by: David Daney <david.daney@cavium.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/sysreg.h |  1 +
 virt/kvm/arm/hyp/vgic-v3-sr.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0ce7f81dd47e..6b80211f9837 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -180,6 +180,7 @@
 
 #define SYS_VBAR_EL1			sys_reg(3, 0, 12, 0, 0)
 
+#define SYS_ICC_BPR0_EL1		sys_reg(3, 0, 12, 8, 3)
 #define SYS_ICC_AP1Rn_EL1(n)		sys_reg(3, 0, 12, 9, n)
 #define SYS_ICC_DIR_EL1			sys_reg(3, 0, 12, 11, 1)
 #define SYS_ICC_SGI1R_EL1		sys_reg(3, 0, 12, 11, 5)
diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index a2a62f030341..f53908cc981c 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -706,11 +706,33 @@ static void __hyp_text __vgic_v3_write_igrpen1(struct kvm_vcpu *vcpu, u32 vmcr,
 	__vgic_v3_write_vmcr(vmcr);
 }
 
+static void __hyp_text __vgic_v3_read_bpr0(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	vcpu_set_reg(vcpu, rt, __vgic_v3_get_bpr0(vmcr));
+}
+
 static void __hyp_text __vgic_v3_read_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
 {
 	vcpu_set_reg(vcpu, rt, __vgic_v3_get_bpr1(vmcr));
 }
 
+static void __hyp_text __vgic_v3_write_bpr0(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
+{
+	u64 val = vcpu_get_reg(vcpu, rt);
+	u8 bpr_min = __vgic_v3_bpr_min() - 1;
+
+	/* Enforce BPR limiting */
+	if (val < bpr_min)
+		val = bpr_min;
+
+	val <<= ICH_VMCR_BPR0_SHIFT;
+	val &= ICH_VMCR_BPR0_MASK;
+	vmcr &= ~ICH_VMCR_BPR0_MASK;
+	vmcr |= val;
+
+	__vgic_v3_write_vmcr(vmcr);
+}
+
 static void __hyp_text __vgic_v3_write_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
 {
 	u64 val = vcpu_get_reg(vcpu, rt);
@@ -888,6 +910,12 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	case SYS_ICC_HPPIR1_EL1:
 		fn = __vgic_v3_read_hppir;
 		break;
+	case SYS_ICC_BPR0_EL1:
+		if (is_read)
+			fn = __vgic_v3_read_bpr0;
+		else
+			fn = __vgic_v3_write_bpr0;
+		break;
 	default:
 		return 0;
 	}
-- 
2.11.0
