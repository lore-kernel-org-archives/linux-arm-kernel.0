From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Oct 2017 16:46:06 +0100
Subject: [PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
Message-ID: <1508859966-7671-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As currently documented, no guarantee is made about what a user
task sees in the SVE registers after a syscall, except that V0-V31
(corresponding to Z0-Z31 bits [127:0]) are preserved.

The actual kernel behaviour currently implemented is that the SVE
registers are zeroed if a context switch or signal delivery occurs
during a syscall.  After a fork() or clone(), the SVE registers
of the child task are zeroed also.  The SVE registers are otherwise
preserved.  Flexibility is retained in the ABI about the exact
criteria for the decision.

There are some potential problems with this approach.

Syscall impact
--------------

Will, Catalin and Mark have expressed concerns about the risk of
creating de facto ABI here: in scenarios or workloads where a
context switch never occurs or is very unlikely, userspace may
learn to rely on preservation of the SVE registers across certain
syscalls.

It is difficult to assess the impact of this: the syscall ABI is
not a general-purpose interface, since it is usually hidden behind
libc wrappers: direct invocation of SVC is discouraged.  However,
specialised runtimes, statically linked programs and binary blobs
may bake in direct syscalls that make bad assumptions.

Conversely, the relative cost of zeroing the SVE regs to mitigate
against this also cannot be well characterised until SVE hardware
exists.

ptrace impact
-------------

The current implementation can discard and zero the SVE registers
at any point during a syscall, including before, after or between
ptrace traps inside a single syscall.  This means that setting the
SVE registers through PTRACE_SETREGSET will often not do what the
user expects: the new register values are only guaranteed to
survive as far as userspace if set from an asynchronous
signal-delivery-stop (e.g., breakpoint, SEGV or asynchronous signal
delivered outside syscall context).

This is consistent with the currently documented SVE user ABI, but
likely to be surprising for a debugger user, since setting most
registers of a tracee doesn't behave in this way.

This patch
----------

The common syscall entry path is modified to forcibly discard SVE,
and the discard logic elsewhere is removed.

This means that there is a mandatory additional trap to the kernel
when a user task tries to use SVE again after a syscall.  This can
be expensive for programs that use SVE heavily around syscalls, but
can be optimised later.

Because all ptrace traps occur after syscall entry, this also means
that no discard will occur after SVE registers are set through
ptrace, until the task next passes through userspace and does
another syscall.  The only exception to this is in fork()/clone()
where forced discard still occurs: however, this is likely to be
encountered less frequently by debugger users.

This ABI change will commit the kernel to some extra cost: at least
some thread flag manipulation, conditional branching and

	mov	v0.16b, v0.16b
	mov	v1.16b, v1.16b
	// ...
	mov 	v31.16b, v31.16b
	pfalse	p0.b
	// ...
	pfalse	p15.b
	wrffr	p0.b

(or equivalent) on the syscall fast path, for SVE tasks.

Though this patch requires trap + memset() + reload, so is
significantly more expensive right now.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Alex Benn?e <alex.bennee@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Alan Hayward <alan.hayward@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Yao Qi <yao.qi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>

---

Changes since RFC of this patch:

 * Remove ASM_BUG on TIF_FOREIGN_FPSTATE in el0_svc.

 * Use x16 for the thread flags in common with el0_svc/
   el0_svc_compat, and move it off the el0_svc_naked common path so
   that it can be done early enough in the el0_svc-specific code
   without repetition.

 * Skip storeback of the thread flags and clearing of the
   CPACR_EL1_ZEN_EL0EN bit unless TIF_SVE was set in the firsto
   place.

 * Add comment to explain why CPACR_EL1 is being modified here.

Changes since sve-v3:

 * New patch since v3.

 * This _may_ be folded into the Core task context handling patch later.
---
 arch/arm64/include/asm/fpsimd.h      |  1 -
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 24 ++++++++++++++++--
 arch/arm64/kernel/fpsimd.c           | 47 +++---------------------------------
 arch/arm64/kernel/process.c          | 29 +++++++++++++---------
 arch/arm64/kernel/signal.c           |  6 -----
 6 files changed, 44 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index da0e5be..74f3439 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -70,7 +70,6 @@ extern void fpsimd_flush_thread(void);
 
 extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
-extern void fpsimd_preserve_current_state_discard_sve(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct fpsimd_state *state);
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index b7f8442..eb43128 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -109,6 +109,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_SVE		(1 << TIF_SVE)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6718780..fbc0eb5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -660,6 +660,7 @@ el0_svc_compat:
 	/*
 	 * AArch32 syscall handling
 	 */
+	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
 	mov	wscno, w7			// syscall number in w7 (r7)
 	mov     wsc_nr, #__NR_compat_syscalls
@@ -847,16 +848,35 @@ ENDPROC(ret_to_user)
  */
 	.align	6
 el0_svc:
+	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
 	adrp	stbl, sys_call_table		// load syscall table pointer
 	mov	wscno, w8			// syscall number in w8
 	mov	wsc_nr, #__NR_syscalls
+
+#ifdef CONFIG_ARM64_SVE
+alternative_if_not ARM64_SVE
+	b	el0_svc_naked
+alternative_else
+	tbz	x16, #_TIF_SVE, el0_svc_naked	// Skip unless TIF_SVE set:
+alternative_endif
+	bic	x16, x16, #_TIF_SVE		// discard SVE state
+	str	x16, [tsk, #TSK_TI_FLAGS]
+
+	// task_fpsimd_load() won't be called to update CPACR
+	// unless TIF_FOREIGN_FPSTATE is set, which only happens if a
+	// context switch of kernel_neon_begin() gets in the way.
+	// So, ensure that CPACR is correct for the fast-path case:
+	mrs	x9, cpacr_el1
+	bic	x9, x9, #CPACR_EL1_ZEN_EL0EN	// disable SVE for el0
+	msr	cpacr_el1, x9			// synchronised by eret to el0
+#endif
+
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
 
-	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
-	tst	x16, #_TIF_SYSCALL_WORK
+	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1e0a7dc..8f15462 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -265,30 +265,11 @@ static void task_fpsimd_load(void)
  * with respect to the CPU registers.
  *
  * Softirqs (and preemption) must be disabled.
- *
- * As an optimisation, this function may skip the cost of saving the
- * full SVE state if called in syscall context: this is permitted
- * because the syscall ABI does not require the SVE registers to be
- * preserved across system calls except for the subset shared with
- * FPSIMD.  However, don't _assume_ that this will occur.  In the
- * future, discarding of SVE state may be avoided for tasks that
- * appear to use SVE heavily.
- *
- * SVE state may be discarded if in a syscall.
- * To force SVE discard unconditionally, pass force_discard==true.
  */
-static void __task_fpsimd_save(bool force_discard)
+static void task_fpsimd_save(void)
 {
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
-	if (system_supports_sve() && test_thread_flag(TIF_SVE))
-		if (force_discard || in_syscall(current_pt_regs())) {
-			clear_thread_flag(TIF_SVE);
-
-			/* Trap if the task tries to use SVE again: */
-			sve_user_disable();
-		}
-
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
 			if (WARN_ON(sve_get_vl() != current->thread.sve_vl)) {
@@ -309,11 +290,6 @@ static void __task_fpsimd_save(bool force_discard)
 	}
 }
 
-static void task_fpsimd_save(void)
-{
-	__task_fpsimd_save(false);
-}
-
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
  * vice versa).  This allows find_next_bit() to be used to find the
@@ -990,34 +966,17 @@ void fpsimd_flush_thread(void)
 /*
  * Save the userland FPSIMD state of 'current' to memory, but only if the state
  * currently held in the registers does in fact belong to 'current'
- *
- * SVE state may be discarded if in a syscall.
- * To force SVE discard unconditionally, pass force_discard==true.
  */
-static void __fpsimd_preserve_current_state(bool force_discard)
+void fpsimd_preserve_current_state(void)
 {
 	if (!system_supports_fpsimd())
 		return;
 
 	local_bh_disable();
-	__task_fpsimd_save(force_discard);
+	task_fpsimd_save();
 	local_bh_enable();
 }
 
-void fpsimd_preserve_current_state(void)
-{
-	__fpsimd_preserve_current_state(false);
-}
-
-/*
- * Like fpsimd_preserve_current_state(), but explicitly discard SVE
- * state.
- */
-void fpsimd_preserve_current_state_discard_sve(void)
-{
-	__fpsimd_preserve_current_state(true);
-}
-
 /*
  * Like fpsimd_preserve_current_state(), but ensure that
  * current->thread.fpsimd_state is updated so that it can be copied to
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index ac56a96..9a3c561 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -247,22 +247,22 @@ void arch_release_task_struct(struct task_struct *tsk)
 	fpsimd_release_task(tsk);
 }
 
+/*
+ * src and dst may temporarily have aliased sve_state after task_struct
+ * is copied.  We cannot fix this properly here, because src may have
+ * live SVE state and dst's thread_info may not exist yet, so tweaking
+ * either src's or dst's TIF_SVE is not safe.
+ *
+ * The unaliasing is done in copy_thread() instead.  This works because
+ * dst is not schedulable or traceable until both of these functions
+ * have been called.
+ */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	/*
-	 * For SVE, dst and src must not end up with aliases of the same
-	 * sve_state.  Because we are definitely in a syscall here, SVE state
-	 * can be discarded unconditionally without violating the user ABI.
-	 * dst's sve_state pointer can then be zapped with no ill effects.
-	 *
-	 * src can safely retain its sve_state memory for later use.
-	 */
 	if (current->mm)
-		fpsimd_preserve_current_state_discard_sve();
+		fpsimd_preserve_current_state();
 	*dst = *src;
 
-	dst->thread.sve_state = NULL;
-
 	return 0;
 }
 
@@ -275,6 +275,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
+	/*
+	 * Unalias p->thread.sve_state (if any) from the parent task
+	 * and disable discard SVE state for p:
+	 */
+	clear_tsk_thread_flag(p, TIF_SVE);
+	p->thread.sve_state = NULL;
+
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 15bc2ad..260b67f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -760,12 +760,6 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	/*
-	 * Ensure FPSIMD/SVE state in task_struct is up-to-date.
-	 * This is needed here in order to complete any pending SVE discard:
-	 * otherwise, discard may occur between deciding on the sigframe
-	 * layout and dumping the register data.
-	 */
 	fpsimd_signal_preserve_current_state();
 
 	if (get_sigframe(&user, ksig, regs))
-- 
2.1.4
