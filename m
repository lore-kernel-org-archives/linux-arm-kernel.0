From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:43 +0000
Subject: [RFC PATCH v2 13/41] arm64/sve: [BROKEN] Basic support for
 KERNEL_MODE_NEON
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-14-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to enable CONFIG_KERNEL_MODE_NEON and things that rely on
it to be configured together with Scalable Vector Extension support
in the same kernel, this patch implements basic support for
saving/restoring the SVE state around kernel_neon_begin()...
kernel_neon_end().

This patch is not optimal and will generally save more state than
necessary, more often than necessary.  Further optimisations can be
implemented in future patches.

This patch is not intended to allow general-purpose _SVE_ code to
execute in the kernel safely.  That functionality may also follow
in later patches.

*** This patch is broken in its current form: ***

Only the FPSIMD registers are ever saved around kernel_neon_begin{,
_partial}()..._end().  However, for each Vn written, the high bits
of each Zn other than bits [127:0] will be zeroed.  This is a
feature of the SVE architecture, and can corrupt userspace SVE
state with this patch as-is.

Instead, we need to save the full SVE regs if they are live: but
this is a potentially large cost.  It may also be unacceptable to
pay this cost in IRQ handlers, but we have no way to back out once
an IRQ handler calls kernel_neon_begin().  This will extend the
interrupt blackout associated with IRQ handlers that use FPSIMD.

It may be simpler to allow kernel_neon_begin() to fail if, say, the
SVE registers are live or if called in IRQ context.  The caller
would need to have a fallback C implementation of its
number-crunching code for this case.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig         |  1 -
 arch/arm64/kernel/fpsimd.c | 23 +++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 820fad1..05b6dd3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -936,7 +936,6 @@ endmenu
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-	depends on !KERNEL_MODE_NEON	# until it works with SVE
 	help
 	  The Scalable Vector Extension (SVE) is an extension to the AArch64
 	  execution state which complements and extends the SIMD functionality
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f8acce2..7c6417a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -298,11 +298,27 @@ void kernel_neon_begin_partial(u32 num_regs)
 {
 	if (WARN_ON(!system_supports_fpsimd()))
 		return;
+
+	preempt_disable();
+
+	/*
+	 * For now, we have no special storage for SVE registers in
+	 * interrupt context, so always save the userland SVE state
+	 * if there is any, even for interrupts.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE) &&
+	    current->mm &&
+	    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		fpsimd_save_state(&current->thread.fpsimd_state);
+		this_cpu_write(fpsimd_last_state, NULL);
+	}
+
 	if (in_interrupt()) {
 		struct fpsimd_partial_state *s = this_cpu_ptr(
 			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
-
 		BUG_ON(num_regs > 32);
+
+		/* Save partial state for interrupted kernel-mode NEON code: */
 		fpsimd_save_partial_state(s, roundup(num_regs, 2));
 	} else {
 		/*
@@ -311,7 +327,6 @@ void kernel_neon_begin_partial(u32 num_regs)
 		 * that there is no longer userland FPSIMD state in the
 		 * registers.
 		 */
-		preempt_disable();
 		if (current->mm &&
 		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
 			fpsimd_save_state(&current->thread.fpsimd_state);
@@ -328,9 +343,9 @@ void kernel_neon_end(void)
 		struct fpsimd_partial_state *s = this_cpu_ptr(
 			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
 		fpsimd_load_partial_state(s);
-	} else {
-		preempt_enable();
 	}
+
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.1.4
