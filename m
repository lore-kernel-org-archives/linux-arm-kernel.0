From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Mar 2015 20:35:27 +0000
Subject: [PATCH 4/6] arm64: Add EL2 switch to soft_restart
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <d6a2944233981ac2131efa177bd0458ad9bc0d1f.1426793116.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is reset it needs to be put into the exception level it had when it
entered the kernel.  Update cpu_reset() to accept an argument which signals if
the soft reset address needs to be entered at EL1 or EL2.

This implementation updates cpu_soft_restart() and soft_restart() to pass the
return value of is_hyp_mode_available() as the switch argument to cpu_reset().
Also, update the comments of cpu_reset(), cpu_soft_restart() and soft_restart()
to reflect this change.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/proc-fns.h |  4 ++--
 arch/arm64/kernel/process.c       |  6 ++++-
 arch/arm64/mm/proc.S              | 47 +++++++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 9a8fd84..339394d 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -32,8 +32,8 @@ extern void cpu_cache_off(void);
 extern void cpu_do_idle(void);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
-void cpu_soft_restart(phys_addr_t cpu_reset,
-		unsigned long addr) __attribute__((noreturn));
+void cpu_soft_restart(phys_addr_t cpu_reset, unsigned long el2_switch,
+		      unsigned long addr) __attribute__((noreturn));
 extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
 extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..d894d3e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,6 +51,7 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
+#include <asm/virt.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -61,7 +62,10 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void soft_restart(unsigned long addr)
 {
 	setup_mm_for_reboot();
-	cpu_soft_restart(virt_to_phys(cpu_reset), addr);
+
+	cpu_soft_restart(virt_to_phys(cpu_reset),
+		is_hyp_mode_available(), addr);
+
 	/* Should never get here */
 	BUG();
 }
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index fe69f6e..4fe4b7d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/virt.h>
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
@@ -57,27 +58,48 @@ ENTRY(cpu_cache_off)
 ENDPROC(cpu_cache_off)
 
 /*
- *	cpu_reset(loc)
+ * cpu_reset(el2_switch, loc) - Helper for cpu_soft_restart.
  *
- *	Perform a soft reset of the system.  Put the CPU into the same state
- *	as it would be if it had been reset, and branch to what would be the
- *	reset vector. It must be executed with the flat identity mapping.
+ * @cpu_reset: Physical address of the cpu_reset routine.
+ * @el2_switch: Flag to indicate a swich to EL2 is needed.
+ * @addr: Location to jump to for soft reset.
  *
- *	- loc   - location to jump to for soft reset
+ * Put the CPU into the same state as it would be if it had been reset, and
+ * branch to what would be the reset vector. It must be executed with the
+ * flat identity mapping.
  */
+
 	.align	5
+
 ENTRY(cpu_reset)
-	mrs	x1, sctlr_el1
-	bic	x1, x1, #1
-	msr	sctlr_el1, x1			// disable the MMU
+	mrs	x2, sctlr_el1
+	bic	x2, x2, #1
+	msr	sctlr_el1, x2			// disable the MMU
 	isb
-	ret	x0
+
+	cbz	x0, 1f				// el2_switch?
+	mov	x0, x1
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	hvc	#HVC_CALL_FUNC			// no return
+
+1:	ret	x1
 ENDPROC(cpu_reset)
 
+/*
+ * cpu_soft_restart(cpu_reset, el2_switch, addr) - Perform a cpu soft reset.
+ *
+ * @cpu_reset: Physical address of the cpu_reset routine.
+ * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_reset.
+ * @addr: Location to jump to for soft reset, passed to cpu_reset.
+ *
+ */
+
 ENTRY(cpu_soft_restart)
-	/* Save address of cpu_reset() and reset address */
-	mov	x19, x0
-	mov	x20, x1
+	mov	x19, x0				// cpu_reset
+	mov	x20, x1				// el2_switch
+	mov	x21, x2				// addr
 
 	/* Turn D-cache off */
 	bl	cpu_cache_off
@@ -86,6 +108,7 @@ ENTRY(cpu_soft_restart)
 	bl	flush_cache_all
 
 	mov	x0, x20
+	mov	x1, x21
 	ret	x19
 ENDPROC(cpu_soft_restart)
 
-- 
2.1.0
