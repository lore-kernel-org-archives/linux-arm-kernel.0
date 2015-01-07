From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:19 +0000
Subject: [PATCH 6/7] arm64: kvm: remove ESR_EL2_* macros
In-Reply-To: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1420632260-8798-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users have been moved over to the common ESR_ELx_* macros,
remove the redundant ESR_EL2 macros. To maintain compatibility with the
fault handling code shared with 32-bit, the FSC_{FAULT,PERM} macros are
retained as aliases for the common ESR_ELx_FSC_{FAULT,PERM} definitions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 73 +++-------------------------------------
 1 file changed, 4 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8afb863..94674eb 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -18,6 +18,7 @@
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <asm/esr.h>
 #include <asm/memory.h>
 #include <asm/types.h>
 
@@ -184,77 +185,11 @@
 #define MDCR_EL2_TPMCR		(1 << 5)
 #define MDCR_EL2_HPMN_MASK	(0x1F)
 
-/* Exception Syndrome Register (ESR) bits */
-#define ESR_EL2_EC_SHIFT	(26)
-#define ESR_EL2_EC		(UL(0x3f) << ESR_EL2_EC_SHIFT)
-#define ESR_EL2_IL		(UL(1) << 25)
-#define ESR_EL2_ISS		(ESR_EL2_IL - 1)
-#define ESR_EL2_ISV_SHIFT	(24)
-#define ESR_EL2_ISV		(UL(1) << ESR_EL2_ISV_SHIFT)
-#define ESR_EL2_SAS_SHIFT	(22)
-#define ESR_EL2_SAS		(UL(3) << ESR_EL2_SAS_SHIFT)
-#define ESR_EL2_SSE		(1 << 21)
-#define ESR_EL2_SRT_SHIFT	(16)
-#define ESR_EL2_SRT_MASK	(0x1f << ESR_EL2_SRT_SHIFT)
-#define ESR_EL2_SF 		(1 << 15)
-#define ESR_EL2_AR 		(1 << 14)
-#define ESR_EL2_EA 		(1 << 9)
-#define ESR_EL2_CM 		(1 << 8)
-#define ESR_EL2_S1PTW 		(1 << 7)
-#define ESR_EL2_WNR		(1 << 6)
-#define ESR_EL2_FSC		(0x3f)
-#define ESR_EL2_FSC_TYPE	(0x3c)
-
-#define ESR_EL2_CV_SHIFT	(24)
-#define ESR_EL2_CV		(UL(1) << ESR_EL2_CV_SHIFT)
-#define ESR_EL2_COND_SHIFT	(20)
-#define ESR_EL2_COND		(UL(0xf) << ESR_EL2_COND_SHIFT)
-
-
-#define FSC_FAULT	(0x04)
-#define FSC_PERM	(0x0c)
+/* For compatibility with fault code shared with 32-bit */
+#define FSC_FAULT	ESR_ELx_FSC_FAULT
+#define FSC_PERM	ESR_ELx_FSC_PERM
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~UL(0xf))
 
-#define ESR_EL2_EC_UNKNOWN	(0x00)
-#define ESR_EL2_EC_WFI		(0x01)
-#define ESR_EL2_EC_CP15_32	(0x03)
-#define ESR_EL2_EC_CP15_64	(0x04)
-#define ESR_EL2_EC_CP14_MR	(0x05)
-#define ESR_EL2_EC_CP14_LS	(0x06)
-#define ESR_EL2_EC_FP_ASIMD	(0x07)
-#define ESR_EL2_EC_CP10_ID	(0x08)
-#define ESR_EL2_EC_CP14_64	(0x0C)
-#define ESR_EL2_EC_ILL_ISS	(0x0E)
-#define ESR_EL2_EC_SVC32	(0x11)
-#define ESR_EL2_EC_HVC32	(0x12)
-#define ESR_EL2_EC_SMC32	(0x13)
-#define ESR_EL2_EC_SVC64	(0x15)
-#define ESR_EL2_EC_HVC64	(0x16)
-#define ESR_EL2_EC_SMC64	(0x17)
-#define ESR_EL2_EC_SYS64	(0x18)
-#define ESR_EL2_EC_IABT		(0x20)
-#define ESR_EL2_EC_IABT_HYP	(0x21)
-#define ESR_EL2_EC_PC_ALIGN	(0x22)
-#define ESR_EL2_EC_DABT		(0x24)
-#define ESR_EL2_EC_DABT_HYP	(0x25)
-#define ESR_EL2_EC_SP_ALIGN	(0x26)
-#define ESR_EL2_EC_FP_EXC32	(0x28)
-#define ESR_EL2_EC_FP_EXC64	(0x2C)
-#define ESR_EL2_EC_SERROR	(0x2F)
-#define ESR_EL2_EC_BREAKPT	(0x30)
-#define ESR_EL2_EC_BREAKPT_HYP	(0x31)
-#define ESR_EL2_EC_SOFTSTP	(0x32)
-#define ESR_EL2_EC_SOFTSTP_HYP	(0x33)
-#define ESR_EL2_EC_WATCHPT	(0x34)
-#define ESR_EL2_EC_WATCHPT_HYP	(0x35)
-#define ESR_EL2_EC_BKPT32	(0x38)
-#define ESR_EL2_EC_VECTOR32	(0x3A)
-#define ESR_EL2_EC_BRK64	(0x3C)
-
-#define ESR_EL2_EC_xABT_xFSR_EXTABT	0x10
-
-#define ESR_EL2_EC_WFI_ISS_WFE	(1 << 0)
-
 #endif /* __ARM64_KVM_ARM_H__ */
-- 
1.9.1
