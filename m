From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:00 +0000
Subject: [PATCH v15 02/20] arm64: Cleanup SCTLR flags
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <f0b21bfc669d89b9b631664e39ebe1929e66bf68.1457977401.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have macros defining flags for the arm64 sctlr registers in
both kvm_arm.h and sysreg.h.  To clean things up and simplify move the
definitions of the SCTLR_EL2 flags from kvm_arm.h to sysreg.h, rename any
SCTLR_EL1 or SCTLR_EL2 flags that are common to both registers to be
SCTLR_ELx, with 'x' indicating a common flag, and fixup all files to
include the proper header or to use the new macro names.

Signed-off-by: Geoff Levand <geoff@infradead.org>
[Restored pgtable-hwdef.h include]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 11 -----------
 arch/arm64/include/asm/sysreg.h  | 19 +++++++++++++++----
 arch/arm64/kvm/hyp-init.S        |  5 +++--
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d201d4b..fbd5dbd 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -83,17 +83,6 @@
 #define HCR_INT_OVERRIDE   (HCR_FMO | HCR_IMO)
 
 
-/* Hyp System Control Register (SCTLR_EL2) bits */
-#define SCTLR_EL2_EE	(1 << 25)
-#define SCTLR_EL2_WXN	(1 << 19)
-#define SCTLR_EL2_I	(1 << 12)
-#define SCTLR_EL2_SA	(1 << 3)
-#define SCTLR_EL2_C	(1 << 2)
-#define SCTLR_EL2_A	(1 << 1)
-#define SCTLR_EL2_M	1
-#define SCTLR_EL2_FLAGS	(SCTLR_EL2_M | SCTLR_EL2_A | SCTLR_EL2_C |	\
-			 SCTLR_EL2_SA | SCTLR_EL2_I)
-
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1	((1 << 31) | (1 << 23))
 #define TCR_EL2_TBI	(1 << 20)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4aeebec..99dac2f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -82,10 +82,21 @@
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
-/* SCTLR_EL1 */
-#define SCTLR_EL1_CP15BEN	(0x1 << 5)
-#define SCTLR_EL1_SED		(0x1 << 8)
-#define SCTLR_EL1_SPAN		(0x1 << 23)
+/* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_EE    (1 << 25)
+#define SCTLR_ELx_I	(1 << 12)
+#define SCTLR_ELx_SA	(1 << 3)
+#define SCTLR_ELx_C	(1 << 2)
+#define SCTLR_ELx_A	(1 << 1)
+#define SCTLR_ELx_M	1
+
+#define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
+			 SCTLR_ELx_SA | SCTLR_ELx_I)
+
+/* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_SPAN		(1 << 23)
+#define SCTLR_EL1_SED		(1 << 8)
+#define SCTLR_EL1_CP15BEN	(1 << 5)
 
 
 /* id_aa64isar0 */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index d073b5a..034d152c 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -21,6 +21,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/pgtable-hwdef.h>
+#include <asm/sysreg.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -116,8 +117,8 @@ __do_hyp_init:
 	dsb	sy
 
 	mrs	x4, sctlr_el2
-	and	x4, x4, #SCTLR_EL2_EE	// preserve endianness of EL2
-	ldr	x5, =SCTLR_EL2_FLAGS
+	and	x4, x4, #SCTLR_ELx_EE	// preserve endianness of EL2
+	ldr	x5, =SCTLR_ELx_FLAGS
 	orr	x4, x4, x5
 	msr	sctlr_el2, x4
 	isb
-- 
2.5.0
