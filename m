From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:28 +0100
Subject: [PATCH v7 04/16] arm64: kvm: Move the do_el2_call macro to a header
 file
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1459529620-22150-5-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hyp-stub could make use of the do_el2_call(), move it to a header file.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h  | 18 +++++++++++++++++-
 arch/arm64/kvm/hyp/hyp-entry.S | 17 +----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 9f22dd607958..b8fdddeca71b 100644
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
index 3488894397ff..358f27a1edc2 100644
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
2.8.0.rc3
