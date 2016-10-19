From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:34 +0100
Subject: [PATCH 10/10] arm64: split thread_info from task stack
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves arm64's struct thread_info from the task stack into
task_struct. This protects thread_info from corruption in the case of
stack overflows, and makes its address harder to determine if stack
addresses are leaked, making a number of attacks more difficult. Precise
detection and handling of overflow is left for subsequent patches.

Largely, this involves changing code to store the task_struct in sp_el0,
and acquire the thread_info from the task struct (which is the opposite
way around to the current code). Both secondary entry and idle are
updated to stash the sp and task pointer separately.

Userspace clobbers sp_el0, and we can no longer restore this from the
stack. Instead, the current task is cached in a per-cpu variable that we
can safely access from early assembly as interrupts are disabled (and we
are thus not preemptible).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/current.h     | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/smp.h         |  1 +
 arch/arm64/include/asm/thread_info.h | 24 ------------------------
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/arm64/kernel/entry.S            |  4 ++--
 arch/arm64/kernel/head.S             | 11 ++++++-----
 arch/arm64/kernel/process.c          | 13 +++++++++++++
 arch/arm64/kernel/smp.c              |  2 ++
 10 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/include/asm/current.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398db..1874b61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -109,6 +109,7 @@ config ARM64
 	select POWER_SUPPLY
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 44e1d7f1..28196b1 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generic-y += bugs.h
 generic-y += clkdev.h
 generic-y += cputime.h
-generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
 generic-y += dma.h
diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
new file mode 100644
index 0000000..f2bcbe2
--- /dev/null
+++ b/arch/arm64/include/asm/current.h
@@ -0,0 +1,22 @@
+#ifndef __ASM_CURRENT_H
+#define __ASM_CURRENT_H
+
+#include <linux/compiler.h>
+
+#include <asm/sysreg.h>
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return (struct task_struct *)read_sysreg(sp_el0);
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CURRENT_H */
+
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index f77ac0d..4400719 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -77,6 +77,7 @@
  */
 struct secondary_data {
 	void *stack;
+	struct task_struct *task;
 	long status;
 };
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 3a4f85d..7a4e0e4 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -47,41 +47,17 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	mm_segment_t		addr_limit;	/* address limit */
-	struct task_struct	*task;		/* main task structure */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
-	int			cpu;		/* cpu */
 };
 
 #define INIT_THREAD_INFO(tsk)						\
 {									\
-	.task		= &tsk,						\
-	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
 }
 
 #define init_stack		(init_thread_union.stack)
 
-/*
- * how to get the thread information struct from C
- */
-static inline struct thread_info *current_thread_info(void) __attribute_const__;
-
-/*
- * struct thread_info can be accessed directly via sp_el0.
- *
- * We don't use read_sysreg() as we want the compiler to cache the value where
- * possible.
- */
-static inline struct thread_info *current_thread_info(void)
-{
-	unsigned long sp_el0;
-
-	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
-
-	return (struct thread_info *)sp_el0;
-}
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(tsk->thread.cpu_context.pc))
 #define thread_saved_sp(tsk)	\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index d30b232..9c2c770 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -121,6 +121,7 @@ int main(void)
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
   DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
+  DEFINE(CPU_BOOT_TASK,		offsetof(struct secondary_data, task));
   BLANK();
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2d4c83b..e781391 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -123,6 +123,7 @@
 	 * Set sp_el0 to current thread_info.
 	 */
 	.if	\el == 0
+	ldr_this_cpu	tsk, __entry_task, x21
 	msr	sp_el0, tsk
 	.endif
 
@@ -674,8 +675,7 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
-	and	x9, x9, #~(THREAD_SIZE - 1)
-	msr	sp_el0, x9
+	msr	sp_el0, x1
 	ret
 ENDPROC(cpu_switch_to)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 427f6d3..12cf383 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -428,7 +428,8 @@ ENDPROC(__create_page_tables)
 __primary_switched:
 	adrp	x4, init_thread_union
 	add	sp, x4, #THREAD_SIZE
-	msr	sp_el0, x4			// Save thread_info
+	adr_l	x5, init_task
+	msr	sp_el0, x5			// Save thread_info
 
 	adr_l	x8, vectors			// load VBAR_EL1 with virtual
 	msr	vbar_el1, x8			// vector table address
@@ -698,10 +699,10 @@ __secondary_switched:
 	isb
 
 	adr_l	x0, secondary_data
-	ldr	x0, [x0, #CPU_BOOT_STACK]	// get secondary_data.stack
-	mov	sp, x0
-	and	x0, x0, #~(THREAD_SIZE - 1)
-	msr	sp_el0, x0			// save thread_info
+	ldr	x1, [x0, #CPU_BOOT_STACK]	// get secondary_data.stack
+	mov	sp, x1
+	ldr	x2, [x0, #CPU_BOOT_TASK]
+	msr	sp_el0, x2
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2f39036..ddce61b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -45,6 +45,7 @@
 #include <linux/personality.h>
 #include <linux/notifier.h>
 #include <trace/events/power.h>
+#include <linux/percpu.h>
 
 #include <asm/alternative.h>
 #include <asm/compat.h>
@@ -312,6 +313,17 @@ static void uao_thread_switch(struct task_struct *next)
 }
 
 /*
+ * We store our current task in sp_el0, which is clobbered by userspace. Keep a
+ * shadow copy so that we can restore this upon entry from userspace.
+ */
+DEFINE_PER_CPU(struct task_struct *, __entry_task) = &init_task;
+
+static void entry_task_switch(struct task_struct *next)
+{
+	__this_cpu_write(__entry_task, next);
+}
+
+/*
  * Thread switching.
  */
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -323,6 +335,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	tls_thread_switch(next);
 	hw_breakpoint_thread_switch(next);
 	contextidr_thread_switch(next);
+	entry_task_switch(next);
 	uao_thread_switch(next);
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2679722..cde25f4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -149,6 +149,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	 * We need to tell the secondary core where to find its stack and the
 	 * page tables.
 	 */
+	secondary_data.task = idle;
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	update_cpu_boot_status(CPU_MMU_OFF);
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
@@ -173,6 +174,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
+	secondary_data.task = NULL;
 	secondary_data.stack = NULL;
 	status = READ_ONCE(secondary_data.status);
 	if (ret && status) {
-- 
1.9.1
