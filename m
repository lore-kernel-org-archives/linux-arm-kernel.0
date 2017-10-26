From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 26 Oct 2017 18:07:01 +0800
Subject: [PATCH v2] KVM: arm/arm64: Fix external abort type matching
Message-ID: <1509012421-8772-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this matching, current code using the {I,D}FSC
range to match kvm_vcpu_trap_get_fault_type() return
value, but kvm_vcpu_trap_get_fault_type() only return
the part {I,D}FSC instead of whole, so fix this issue

Value       Type
0x10        FSC_SEA
0x14        FSC_SEA_TTW0 FSC_SEA_TTW1 FSC_SEA_TTW2 FSC_SEA_TTW3
0x18        FSC_SECC
0x1c        FSC_SECC_TTW0 FSC_SECC_TTW1 FSC_SECC_TTW2 FSC_SECC_TTW3

CC: James Morse <james.morse@arm.com>
CC: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

---
As shown below code:

The kvm_vcpu_trap_get_fault_type() only return {I,D}FSC bit[5]:bit[2], not
the whole {I,D}FSC, but FSC_SEA_TTWx and FSC_SECC_TTWx are the whole {I,D}FSC
value.

static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
{
    return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
}

static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
{
    switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
    case FSC_SEA:
    case FSC_SEA_TTW0:
    case FSC_SEA_TTW1:
    case FSC_SEA_TTW2:
    case FSC_SEA_TTW3:
    case FSC_SECC:
    case FSC_SECC_TTW0:
    case FSC_SECC_TTW1:
    case FSC_SECC_TTW2:
    case FSC_SECC_TTW3:
        return true;
    default:
        return false;
    }
}
---
 arch/arm/include/asm/kvm_arm.h       | 10 ++--------
 arch/arm/include/asm/kvm_emulate.h   | 10 ++--------
 arch/arm64/include/asm/kvm_arm.h     | 10 ++--------
 arch/arm64/include/asm/kvm_emulate.h | 10 ++--------
 4 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index c878145..b4b155c 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -188,15 +188,9 @@
 #define FSC_ACCESS	(0x08)
 #define FSC_PERM	(0x0c)
 #define FSC_SEA		(0x10)
-#define FSC_SEA_TTW0	(0x14)
-#define FSC_SEA_TTW1	(0x15)
-#define FSC_SEA_TTW2	(0x16)
-#define FSC_SEA_TTW3	(0x17)
+#define FSC_SEA_TTW	(0x14)
 #define FSC_SECC	(0x18)
-#define FSC_SECC_TTW0	(0x1c)
-#define FSC_SECC_TTW1	(0x1d)
-#define FSC_SECC_TTW2	(0x1e)
-#define FSC_SECC_TTW3	(0x1f)
+#define FSC_SECC_TTW	(0x1c)
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~0xf)
diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 98089ff..aed8279 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -205,15 +205,9 @@ static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
 	case FSC_SEA:
-	case FSC_SEA_TTW0:
-	case FSC_SEA_TTW1:
-	case FSC_SEA_TTW2:
-	case FSC_SEA_TTW3:
+	case FSC_SEA_TTW:
 	case FSC_SECC:
-	case FSC_SECC_TTW0:
-	case FSC_SECC_TTW1:
-	case FSC_SECC_TTW2:
-	case FSC_SECC_TTW3:
+	case FSC_SECC_TTW:
 		return true;
 	default:
 		return false;
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 61d694c..c0f1798 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -205,15 +205,9 @@
 #define FSC_ACCESS	ESR_ELx_FSC_ACCESS
 #define FSC_PERM	ESR_ELx_FSC_PERM
 #define FSC_SEA		ESR_ELx_FSC_EXTABT
-#define FSC_SEA_TTW0	(0x14)
-#define FSC_SEA_TTW1	(0x15)
-#define FSC_SEA_TTW2	(0x16)
-#define FSC_SEA_TTW3	(0x17)
+#define FSC_SEA_TTW	(0x14)
 #define FSC_SECC	(0x18)
-#define FSC_SECC_TTW0	(0x1c)
-#define FSC_SECC_TTW1	(0x1d)
-#define FSC_SECC_TTW2	(0x1e)
-#define FSC_SECC_TTW3	(0x1f)
+#define FSC_SECC_TTW	(0x1c)
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~UL(0xf))
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index e5df3fc..5cde311 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -239,15 +239,9 @@ static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
 	case FSC_SEA:
-	case FSC_SEA_TTW0:
-	case FSC_SEA_TTW1:
-	case FSC_SEA_TTW2:
-	case FSC_SEA_TTW3:
+	case FSC_SEA_TTW:
 	case FSC_SECC:
-	case FSC_SECC_TTW0:
-	case FSC_SECC_TTW1:
-	case FSC_SECC_TTW2:
-	case FSC_SECC_TTW3:
+	case FSC_SECC_TTW:
 		return true;
 	default:
 		return false;
-- 
1.9.1
