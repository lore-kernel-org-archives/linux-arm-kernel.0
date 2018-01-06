From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Sun, 7 Jan 2018 00:02:54 +0800
Subject: [PATCH v9 4/7] KVM: arm64: Trap RAS error registers and set HCR_EL2's
 TERR & TEA
In-Reply-To: <1515254577-6460-1-git-send-email-gengdongjiu@huawei.com>
References: <1515254577-6460-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1515254577-6460-5-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 adds a new bit HCR_EL2.TEA which routes synchronous external
aborts to EL2, and adds a trap control bit HCR_EL2.TERR which traps
all Non-secure EL1&0 error record accesses to EL2.

This patch enables the two bits for the guest OS, guaranteeing that
KVM takes external aborts and traps attempts to access the physical
error registers.

ERRIDR_EL1 advertises the number of error records, we return
zero meaning we can treat all the other registers as RAZ/WI too.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
[removed specific emulation, use trap_raz_wi() directly for everything,
 rephrased parts of the commit message]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h     |  2 ++
 arch/arm64/include/asm/kvm_emulate.h |  7 +++++++
 arch/arm64/include/asm/sysreg.h      | 10 ++++++++++
 arch/arm64/kvm/sys_regs.c            | 10 ++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 61d694c..1188272 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -23,6 +23,8 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_TEA		(UL(1) << 37)
+#define HCR_TERR	(UL(1) << 36)
 #define HCR_E2H		(UL(1) << 34)
 #define HCR_ID		(UL(1) << 33)
 #define HCR_CD		(UL(1) << 32)
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index e5df3fc..555b28b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -47,6 +47,13 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
 	if (is_kernel_in_hyp_mode())
 		vcpu->arch.hcr_el2 |= HCR_E2H;
+	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN)) {
+		/* route synchronous external abort exceptions to EL2 */
+		vcpu->arch.hcr_el2 |= HCR_TEA;
+		/* trap error record accesses */
+		vcpu->arch.hcr_el2 |= HCR_TERR;
+	}
+
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 }
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 64e2a80..47b967d 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -169,6 +169,16 @@
 #define SYS_AFSR0_EL1			sys_reg(3, 0, 5, 1, 0)
 #define SYS_AFSR1_EL1			sys_reg(3, 0, 5, 1, 1)
 #define SYS_ESR_EL1			sys_reg(3, 0, 5, 2, 0)
+
+#define SYS_ERRIDR_EL1			sys_reg(3, 0, 5, 3, 0)
+#define SYS_ERRSELR_EL1			sys_reg(3, 0, 5, 3, 1)
+#define SYS_ERXFR_EL1			sys_reg(3, 0, 5, 4, 0)
+#define SYS_ERXCTLR_EL1			sys_reg(3, 0, 5, 4, 1)
+#define SYS_ERXSTATUS_EL1		sys_reg(3, 0, 5, 4, 2)
+#define SYS_ERXADDR_EL1			sys_reg(3, 0, 5, 4, 3)
+#define SYS_ERXMISC0_EL1		sys_reg(3, 0, 5, 5, 0)
+#define SYS_ERXMISC1_EL1		sys_reg(3, 0, 5, 5, 1)
+
 #define SYS_FAR_EL1			sys_reg(3, 0, 6, 0, 0)
 #define SYS_PAR_EL1			sys_reg(3, 0, 7, 4, 0)
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2e070d3..2b1fafa 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -953,6 +953,16 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
 	{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
 	{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
 	{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
+
+	{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
+
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 
-- 
1.9.1
