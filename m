From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 23:10:58 +0000
Subject: [PATCH 01/10] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <f57759dbc105dd3996acd959d4e3157224ff81fa.1414099246.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the macros defined in kvm_arm.h are useful in assembly files, but are
not compatible with the assembler.  Change any C language integer constant
definitions using appended U, UL, or ULL to the UL() preprocessor macro.  Also,
add a preprocessor include of the asm/memory.h file which defines the UL()
macro.

Fixes build errors like these when using kvm_arm.h in assembly
source files:

  Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/kvm_arm.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index cc83520..9038a26 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -18,6 +18,7 @@
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <asm/memory.h>
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
@@ -149,9 +150,9 @@
 #endif
 
 #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
-#define VTTBR_VMID_SHIFT  (48LLU)
-#define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
+#define VTTBR_BADDR_MASK  (((UL(1) << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_VMID_SHIFT  (UL(48))
+#define VTTBR_VMID_MASK	  (UL(0xFF) << VTTBR_VMID_SHIFT)
 
 /* Hyp System Trap Register */
 #define HSTR_EL2_TTEE	(1 << 16)
@@ -174,13 +175,13 @@
 
 /* Exception Syndrome Register (ESR) bits */
 #define ESR_EL2_EC_SHIFT	(26)
-#define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
-#define ESR_EL2_IL		(1U << 25)
+#define ESR_EL2_EC		(UL(0x3f) << ESR_EL2_EC_SHIFT)
+#define ESR_EL2_IL		(UL(1) << 25)
 #define ESR_EL2_ISS		(ESR_EL2_IL - 1)
 #define ESR_EL2_ISV_SHIFT	(24)
-#define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)
+#define ESR_EL2_ISV		(UL(1) << ESR_EL2_ISV_SHIFT)
 #define ESR_EL2_SAS_SHIFT	(22)
-#define ESR_EL2_SAS		(3U << ESR_EL2_SAS_SHIFT)
+#define ESR_EL2_SAS		(UL(3) << ESR_EL2_SAS_SHIFT)
 #define ESR_EL2_SSE		(1 << 21)
 #define ESR_EL2_SRT_SHIFT	(16)
 #define ESR_EL2_SRT_MASK	(0x1f << ESR_EL2_SRT_SHIFT)
@@ -194,16 +195,16 @@
 #define ESR_EL2_FSC_TYPE	(0x3c)
 
 #define ESR_EL2_CV_SHIFT	(24)
-#define ESR_EL2_CV		(1U << ESR_EL2_CV_SHIFT)
+#define ESR_EL2_CV		(UL(1) << ESR_EL2_CV_SHIFT)
 #define ESR_EL2_COND_SHIFT	(20)
-#define ESR_EL2_COND		(0xfU << ESR_EL2_COND_SHIFT)
+#define ESR_EL2_COND		(UL(0xf) << ESR_EL2_COND_SHIFT)
 
 
 #define FSC_FAULT	(0x04)
 #define FSC_PERM	(0x0c)
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
-#define HPFAR_MASK	(~0xFUL)
+#define HPFAR_MASK	(~UL(0xf))
 
 #define ESR_EL2_EC_UNKNOWN	(0x00)
 #define ESR_EL2_EC_WFI		(0x01)
-- 
1.9.1
