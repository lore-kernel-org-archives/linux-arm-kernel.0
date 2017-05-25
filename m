From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 May 2017 19:24:57 +0100
Subject: [RFC PATCH v3 0/4] Simplify kernel-mode NEON
Message-ID: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to simplify kernel-mode NEON.


Changes since RFC v2:

 * Re-enable softirqs between kernel_neon_begin() and kernel_mode_end()

   (This was the original intention, but I was overtaken by irrational
   paranoia when drafting the previous version of the patch.)

 * softirq disable/enable is removed from fpsimd_thread_switch() (which
   runs with hardirqs disabled in any case, thus local_bh_enable() is
   treated as an error by the core code).  The comment block is updated
   to clarify this situation.

   This also means that no cost is added to the context switch critical
   path after all.

 * Move the this_cpu_write(fpsimd_last_state, NULL) back outside the
   conditional in kernel_neon_begin() (i.e., where it was originally
   before this series).  RFC v2 accidentally moved this invalidation
   inside the conditional, which leads to state corruption if switching
   back to a user task previously running on the same CPU, after
   kernel_mode_neon() is used by a kernel thread.

 * Minor formatting and spurious #include tidyups.

Testing:

 * For now, I've hacked linux/kernel/time/timer.c:run_timer_softirq() to
   call kernel_mode_neon_begin() and erase the FPSIMD registers, and
   jacked CONFIG_HZ to 1000.  I also added a test syscall sys_blatt_neon
   that userspace can hammer to trigger the nested kernel_neon_begin()
   scenario.

   See [2].

   This is not hugely realistic, but was sufficient to diagnose the
   corruption problem described above, when running on a model.


Original blurb:

The main motivation for these changes is that supporting kernel-mode
NEON alongside SVE is tricky with the current framework: the current
partial save/restore mechanisms would need additional porting to
save/restore the extended SVE vector bits, and this renders the cost
saving of partial save/restore rather doubtful -- even if not all vector
registers are saved, the save/restore cost will still grow with
increasing vector length.  We could get the mechanics of this to work in
principle, but it doesn't feel like the right thing to do.

If we withdraw kernel-mode NEON support for hardirq context, accept some
extra softirq latency and disable nesting, then we can simplify the code
by always saving the task context directly into task_struct and
deferring all restore to ret_to_user.  Previous discussions with Ard
Biesheuvel suggest that this is a feasible approach and reasonably
aligned with other architectures.

The main impact on client code is that callers must check that
kernel-mode NEON is usable in the current context and fall back to a
non-NEON when necessary.  Ard has already done some work on this. [1]

The interesting changes are all in patch 2: the first patch just adds a
header inclusion guard that I noted was missing.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git kernel-mode-neon

Dave Martin (4):
  arm64: neon: Add missing header guard in <asm/neon.h>
  arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
  arm64: neon: Remove support for nested or hardirq kernel-mode NEON
  arm64: neon: Add backwards compatibility kernel_neon_begin_partial()

 arch/arm64/include/asm/fpsimd.h       |  14 ----
 arch/arm64/include/asm/fpsimdmacros.h |  56 ----------------
 arch/arm64/include/asm/neon.h         |  12 +++-
 arch/arm64/include/asm/simd.h         |  56 ++++++++++++++++
 arch/arm64/kernel/entry-fpsimd.S      |  24 -------
 arch/arm64/kernel/fpsimd.c            | 119 +++++++++++++++++++++++-----------
 6 files changed, 146 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm64/include/asm/simd.h

-- 

[2] Test hacks, not for merging

>From 584f1187269dcee04cb43fc6cb443d8e56454e2b Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Thu, 25 May 2017 19:08:42 +0100
Subject: [PATCH] test hacks

---
 arch/arm64/kernel/fpsimd.c        | 63 +++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/sys.c           | 58 +++++++++++++++++++++++++++++++
 blatt-neon.c                      | 31 +++++++++++++++++
 include/uapi/asm-generic/unistd.h |  5 ++-
 kernel/time/timer.c               | 72 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 blatt-neon.c

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 14329d6..6156e56 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -22,6 +22,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/percpu.h>
 #include <linux/sched/signal.h>
 #include <linux/signal.h>
@@ -37,6 +38,8 @@
 #define FPEXC_IXF	(1 << 4)
 #define FPEXC_IDF	(1 << 7)
 
+static void print_suspicious_vregs(char const *str, struct fpsimd_state const *st);
+
 /*
  * In order to reduce the number of times the FPSIMD state is needlessly saved
  * and restored, we need to keep track of two things:
@@ -138,13 +141,18 @@ void fpsimd_thread_switch(struct task_struct *next)
 {
 	if (!system_supports_fpsimd())
 		return;
+
+	BUG_ON(!irqs_disabled());
+
 	/*
 	 * Save the current FPSIMD state to memory, but only if whatever is in
 	 * the registers is in fact the most recent userland FPSIMD state of
 	 * 'current'.
 	 */
-	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
+	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		fpsimd_save_state(&current->thread.fpsimd_state);
+		print_suspicious_vregs("sched-out", &current->thread.fpsimd_state);
+	}
 
 	if (next->mm) {
 		/*
@@ -197,6 +205,55 @@ void fpsimd_preserve_current_state(void)
 	local_bh_enable();
 }
 
+static bool suspicious_vreg(u8 const *reg)
+{
+	u8 b = *reg;
+	unsigned int i;
+
+	if (b < 0xc2 || b > 0xc7)
+		return false;
+
+	for (i = 1; i < 16; ++i)
+		if (b != reg[i])
+			return false;
+
+	return true;
+}
+
+static int print_vreg_if_suspicious(u8 const *reg, unsigned int num)
+{
+	char s[16 * 2 + 1], *p = s;
+	int n;
+	unsigned int i;
+
+	if (!suspicious_vreg(reg))
+		return 0;
+
+	for (i = 0; i < 16; ++i) {
+		n = snprintf(p, s + sizeof(s) - p, "%.2hhx", reg[i]);
+		if (n < 0)
+			break;
+
+		p += n;
+	}
+
+	*p = '\0';
+	return 1;
+}
+
+static void print_suspicious_vregs(char const *str, struct fpsimd_state const *st)
+{
+	int bad = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(st->vregs); ++i)
+		bad |= print_vreg_if_suspicious((u8 const *)&st->vregs[i], i);
+
+	if (bad)
+		pr_info("%s[%d]: %s: suspicious vreg(s) detected\n",
+			current->comm, task_pid_nr(current), str);
+}
+
 /*
  * Load the userland FPSIMD state of 'current' from memory, but only if the
  * FPSIMD state already held in the registers is /not/ the most recent FPSIMD
@@ -215,6 +272,8 @@ void fpsimd_restore_current_state(void)
 		fpsimd_load_state(st);
 		__this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
+
+		print_suspicious_vregs("fpsimd_restore_current_state", st);
 	}
 
 	local_bh_enable();
@@ -290,6 +349,8 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	__this_cpu_write(fpsimd_last_state, NULL);
 
+	print_suspicious_vregs("kernel_neon_begin", &current->thread.fpsimd_state);
+
 	preempt_disable();
 
 	local_bh_enable();
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 26fe8ea..ab73b51 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <asm/cpufeature.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
 
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			 unsigned long prot, unsigned long flags,
@@ -45,6 +47,62 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	return sys_personality(personality);
 }
 
+SYSCALL_DEFINE0(blatt_neon)
+{
+	int ret = 0;
+	unsigned int i;
+
+	BUG_ON(!may_use_simd());
+
+	kernel_neon_begin();
+
+	for (i = 0; i < 1000; ++i) {
+		asm volatile (
+			"movi	v0.16b, #0\n\t"
+			"movi	v1.16b, #0\n\t"
+			"movi	v2.16b, #0\n\t"
+			"movi	v3.16b, #0\n\t"
+			"movi	v4.16b, #0\n\t"
+			"movi	v5.16b, #0\n\t"
+			"movi	v6.16b, #0\n\t"
+			"movi	v7.16b, #0\n\t"
+			"movi	v8.16b, #0\n\t"
+			"movi	v9.16b, #0\n\t"
+			"movi	v10.16b, #0\n\t"
+			"movi	v11.16b, #0\n\t"
+			"movi	v12.16b, #0\n\t"
+			"movi	v13.16b, #0\n\t"
+			"movi	v14.16b, #0\n\t"
+			"movi	v15.16b, #0\n\t"
+			"movi	v16.16b, #0\n\t"
+			"movi	v17.16b, #0\n\t"
+			"movi	v18.16b, #0\n\t"
+			"movi	v19.16b, #0\n\t"
+			"movi	v20.16b, #0\n\t"
+			"movi	v21.16b, #0\n\t"
+			"movi	v22.16b, #0\n\t"
+			"movi	v23.16b, #0\n\t"
+			"movi	v24.16b, #0\n\t"
+			"movi	v25.16b, #0\n\t"
+			"movi	v26.16b, #0\n\t"
+			"movi	v27.16b, #0\n\t"
+			"movi	v28.16b, #0\n\t"
+			"movi	v29.16b, #0\n\t"
+			"movi	v30.16b, #0\n\t"
+			"movi	v31.16b, #0"
+		);
+
+		if (test_thread_flag(TIF_SIGPENDING)) {
+			ret = -EINTR;
+			break;
+		}
+	}
+
+	kernel_neon_end();
+
+	return ret;
+}
+
 /*
  * Wrappers to pass the pt_regs argument.
  */
diff --git a/blatt-neon.c b/blatt-neon.c
new file mode 100644
index 0000000..fafb144
--- /dev/null
+++ b/blatt-neon.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <asm/unistd.h>
+
+static long blatt_neon(void)
+{
+	register long ret asm("x0");
+	register unsigned int scno asm("x8") = __NR_blatt_neon;
+
+	asm volatile (
+		"svc	#0"
+		: "=r" (ret)
+		: "r" (scno)
+	);
+
+	return ret;
+}
+
+int main(void)
+{
+	long ret;
+
+	while (1) {
+		ret = blatt_neon();
+		if (ret) {
+			fprintf(stderr, "%s\n", strerror(ret));
+			return EXIT_FAILURE;
+		}
+	}
+}
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 061185a..bf2d3e9 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -732,8 +732,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
 
+#define __NR_blatt_neon 292
+__SYSCALL(__NR_blatt_neon, sys_blatt_neon)
+
 #undef __NR_syscalls
-#define __NR_syscalls 292
+#define __NR_syscalls 293
 
 /*
  * All syscalls below here should go away really,
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 152a706..dc79771 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -34,6 +34,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/tick.h>
 #include <linux/kallsyms.h>
@@ -50,6 +51,8 @@
 #include <asm/div64.h>
 #include <asm/timex.h>
 #include <asm/io.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
 
 #include "tick-internal.h"
 
@@ -1604,6 +1607,21 @@ static inline void __run_timers(struct timer_base *base)
 	spin_unlock_irq(&base->lock);
 }
 
+static u64 neon_busy_count, neon_idle_count;
+
+static int __init timer_softirq_debugfs_init(void)
+{
+	struct dentry *dir = debugfs_create_dir("neon-softirq", NULL);
+
+	if (!dir ||
+	    !debugfs_create_u64("busy", 0444, dir, &neon_busy_count) ||
+	    !debugfs_create_u64("idle", 0444, dir, &neon_idle_count))
+		WARN_ON(1);
+
+	return 0;
+}
+early_initcall(timer_softirq_debugfs_init);
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
@@ -1611,6 +1629,60 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
+	BUG_ON(preemptible());
+	BUG_ON(!softirq_count());
+
+	if (!may_use_simd())
+		neon_busy_count++;
+	else /* may_use_simd() */ {
+		static u8 n = 0xc2;
+
+		neon_idle_count++;
+
+		kernel_neon_begin();
+		asm volatile (
+			"dup	v0.16b, %w0\n\t"
+			"dup	v1.16b, %w0\n\t"
+			"dup	v2.16b, %w0\n\t"
+			"dup	v3.16b, %w0\n\t"
+			"dup	v4.16b, %w0\n\t"
+			"dup	v5.16b, %w0\n\t"
+			"dup	v6.16b, %w0\n\t"
+			"dup	v7.16b, %w0\n\t"
+			"dup	v8.16b, %w0\n\t"
+			"dup	v9.16b, %w0\n\t"
+			"dup	v10.16b, %w0\n\t"
+			"dup	v11.16b, %w0\n\t"
+			"dup	v12.16b, %w0\n\t"
+			"dup	v13.16b, %w0\n\t"
+			"dup	v14.16b, %w0\n\t"
+			"dup	v15.16b, %w0\n\t"
+			"dup	v16.16b, %w0\n\t"
+			"dup	v17.16b, %w0\n\t"
+			"dup	v18.16b, %w0\n\t"
+			"dup	v19.16b, %w0\n\t"
+			"dup	v20.16b, %w0\n\t"
+			"dup	v21.16b, %w0\n\t"
+			"dup	v22.16b, %w0\n\t"
+			"dup	v23.16b, %w0\n\t"
+			"dup	v24.16b, %w0\n\t"
+			"dup	v25.16b, %w0\n\t"
+			"dup	v26.16b, %w0\n\t"
+			"dup	v27.16b, %w0\n\t"
+			"dup	v28.16b, %w0\n\t"
+			"dup	v29.16b, %w0\n\t"
+			"dup	v30.16b, %w0\n\t"
+			"dup	v31.16b, %w0"
+			:: "r" (n)
+		);
+
+		++n;
+		if (n == 0xc8)
+			n = 0xc2;
+
+		kernel_neon_end();
+	} /* may_use_simd() */
+
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-- 
2.1.4
