From: geoff@infradead.org (Geoff Levand)
Date: Thu, 14 Apr 2016 21:21:36 +0000
Subject: [PATCH v16 03/20] arm64: kvm: Move the do_el2_call macro to a header
 file
In-Reply-To: <cover.1460668521.git.geoff@infradead.org>
References: <cover.1460668521.git.geoff@infradead.org>
Message-ID: <af6f3f4788a3d2bbda935ea02c6b08fbc305af40.1460668521.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

The hyp-stub could make use of the do_el2_call(), move it to a header file.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h  | 18 +++++++++++++++++-
 arch/arm64/kvm/hyp/hyp-entry.S | 17 +----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 9f22dd6..b8fddde 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -21,7 +21,23 @@
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+.macro do_el2_call
+	/*
+	 * Shuffle the parameters before calling the function
+	 * pointed to in x0. Assumes parameters in x[1,2,3].
+	 */
+	sub	sp, sp, #16
+	str	lr, [sp]
+	mov	lr, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	blr	lr
+	ldr	lr, [sp]
+	add	sp, sp, #16
+.endm
+#else
 
 #include <asm/ptrace.h>
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 3488894..358f27a 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -23,6 +23,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/virt.h>
 
 	.text
 	.pushsection	.hyp.text, "ax"
@@ -37,22 +38,6 @@
 	ldp	x0, x1, [sp], #16
 .endm
 
-.macro do_el2_call
-	/*
-	 * Shuffle the parameters before calling the function
-	 * pointed to in x0. Assumes parameters in x[1,2,3].
-	 */
-	sub	sp, sp, #16
-	str	lr, [sp]
-	mov	lr, x0
-	mov	x0, x1
-	mov	x1, x2
-	mov	x2, x3
-	blr	lr
-	ldr	lr, [sp]
-	add	sp, sp, #16
-.endm
-
 ENTRY(__vhe_hyp_call)
 	do_el2_call
 	/*
-- 
2.5.0
