From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:45:51 +0100
Subject: [PATCH 16/31] KVM: arm64: vgic-v3: Add ICV_HPPIR1_EL1 handler
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for reading the guest's view of the ICV_HPPIR1_EL1
register. This is a simple parsing of the available LRs, extracting the
highest available interrupt.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h |  1 +
 virt/kvm/arm/hyp/vgic-v3-sr.c   | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index aad46b8eea5e..bd000686194a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -185,6 +185,7 @@
 #define SYS_ICC_SGI1R_EL1		sys_reg(3, 0, 12, 11, 5)
 #define SYS_ICC_IAR1_EL1		sys_reg(3, 0, 12, 12, 0)
 #define SYS_ICC_EOIR1_EL1		sys_reg(3, 0, 12, 12, 1)
+#define SYS_ICC_HPPIR1_EL1		sys_reg(3, 0, 12, 12, 2)
 #define SYS_ICC_BPR1_EL1		sys_reg(3, 0, 12, 12, 3)
 #define SYS_ICC_CTLR_EL1		sys_reg(3, 0, 12, 12, 4)
 #define SYS_ICC_SRE_EL1			sys_reg(3, 0, 12, 12, 5)
diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index b6803989da1f..a521e105ade1 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -754,6 +754,26 @@ static void __hyp_text __vgic_v3_write_apxr3(struct kvm_vcpu *vcpu,
 	__vgic_v3_write_apxrn(vcpu, rt, 3);
 }
 
+static void __hyp_text __vgic_v3_read_hppir(struct kvm_vcpu *vcpu,
+					    u32 vmcr, int rt)
+{
+	u64 lr_val;
+	int lr, lr_grp, grp;
+
+	grp = __vgic_v3_get_group(vcpu);
+
+	lr = __vgic_v3_highest_priority_lr(vcpu, vmcr, &lr_val);
+	if (lr == -1)
+		goto spurious;
+
+	lr_grp = !!(lr_val & ICH_LR_GROUP);
+	if (lr_grp != grp)
+		lr_val = ICC_IAR1_EL1_SPURIOUS;
+
+spurious:
+	vcpu_set_reg(vcpu, rt, lr_val & ICH_LR_VIRTUAL_ID_MASK);
+}
+
 int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 {
 	int rt = kvm_vcpu_sys_get_rt(vcpu);
@@ -816,6 +836,9 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 		else
 			fn = __vgic_v3_write_apxr3;
 		break;
+	case SYS_ICC_HPPIR1_EL1:
+		fn = __vgic_v3_read_hppir;
+		break;
 	default:
 		return 0;
 	}
-- 
2.11.0
