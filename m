From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jan 2016 10:30:35 +0000
Subject: [PATCH 2/5] arm64: KVM: Obey RES0/1 reserved bits when setting
 CPTR_EL2
In-Reply-To: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
References: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1453977038-13516-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

Some bits in CPTR are defined as RES1 in the architecture.  Setting
these bits to zero may unintentionally enable future architecture
extensions, allowing guests to use them without supervision by the host.

This would be bad: for forwards compatibility, this patch makes
sure the affected bits are always written with 1, not 0.

This patch only addresses CPTR_EL2.  Initialisation of other system
registers may still need review.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 1 +
 arch/arm64/kvm/hyp/switch.c      | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 738a95f..bef6e92 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -182,6 +182,7 @@
 #define CPTR_EL2_TCPAC	(1 << 31)
 #define CPTR_EL2_TTA	(1 << 20)
 #define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
+#define CPTR_EL2_DEFAULT	0x000033ff
 
 /* Hyp Debug Configuration Register bits */
 #define MDCR_EL2_TDRA		(1 << 11)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index ca8f5a5..f0e7bdf 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -36,7 +36,11 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(val, hcr_el2);
 	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
 	write_sysreg(1 << 15, hstr_el2);
-	write_sysreg(CPTR_EL2_TTA | CPTR_EL2_TFP, cptr_el2);
+
+	val = CPTR_EL2_DEFAULT;
+	val |= CPTR_EL2_TTA | CPTR_EL2_TFP;
+	write_sysreg(val, cptr_el2);
+
 	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
 }
 
@@ -45,7 +49,7 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(HCR_RW, hcr_el2);
 	write_sysreg(0, hstr_el2);
 	write_sysreg(read_sysreg(mdcr_el2) & MDCR_EL2_HPMN_MASK, mdcr_el2);
-	write_sysreg(0, cptr_el2);
+	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 }
 
 static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
-- 
2.1.4
