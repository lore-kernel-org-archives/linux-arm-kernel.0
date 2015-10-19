From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:53 +0000
Subject: [PATCH 06/16] arm64: Add EL2 switch to cpu_reset
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <0e27e2e50ae3c2aa867fd5e778bd2daeb3bc6eba.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is reset it needs to be put into the exception level it had
when it entered the kernel. Update cpu_reset() to accept an argument
which signals if the reset address needs to be entered at EL1 or EL2.

Also, update the comments of cpu_reset() and cpu_soft_restart() to reflect
this change.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/cpu-reset.S | 22 +++++++++++++++++++---
 arch/arm64/kernel/cpu-reset.h |  4 +++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 64d9d7c..ffc9e385e 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,6 +16,7 @@
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
+#include <asm/virt.h>
 
 .text
 .pushsection    .idmap.text, "ax"
@@ -23,9 +24,14 @@
 .align 5
 
 /*
- * cpu_reset(addr) - Helper for cpu_soft_restart.
+ * cpu_reset(addr, el2_switch) - Helper for cpu_soft_restart.
  *
  * @addr: Location to jump to for soft reset.
+ * @el2_switch: Flag to indicate a swich to EL2 is needed.
+ *
+ * Put the CPU into the same state as it would be if it had been reset, and
+ * branch to what would be the reset vector. It must be executed with the
+ * flat identity mapping.
  */
 
 ENTRY(cpu_reset)
@@ -33,19 +39,28 @@ ENTRY(cpu_reset)
 	bic	x2, x2, #1
 	msr	sctlr_el1, x2			// disable the MMU
 	isb
-	ret	x0
+
+	cbz	x1, 1f				// el2_switch?
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	hvc	#HVC_CALL_FUNC			// no return
+
+1:	ret	x0
 ENDPROC(cpu_reset)
 
 /*
- * cpu_soft_restart(cpu_reset, addr) - Perform a cpu soft reset.
+ * cpu_soft_restart(cpu_reset, addr, el2_switch) - Perform a cpu soft reset.
  *
  * @cpu_reset: Physical address of the cpu_reset routine.
  * @addr: Location to jump to for soft reset, passed to cpu_reset.
+ * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_reset.
  */
 
 ENTRY(cpu_soft_restart)
 	mov	x19, x0				// cpu_reset
 	mov	x20, x1				// addr
+	mov	x21, x2				// el2_switch
 
 	/* Turn D-cache off */
 	mrs	x0, sctlr_el1
@@ -54,6 +69,7 @@ ENTRY(cpu_soft_restart)
 	isb
 
 	mov	x0, x20
+	mov	x1, x21
 	ret	x19
 ENDPROC(cpu_soft_restart)
 
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 4e16dfe..ef3bba2 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -11,8 +11,10 @@
 #if !defined(_ARM64_CPU_RESET_H)
 #define _ARM64_CPU_RESET_H
 
+#include <asm/virt.h>
+
 void __attribute__((noreturn)) cpu_reset(unsigned long addr);
 void __attribute__((noreturn)) cpu_soft_restart(phys_addr_t cpu_reset,
-	unsigned long addr);
+	unsigned long addr, unsigned long el2_switch);
 
 #endif
-- 
2.5.0
