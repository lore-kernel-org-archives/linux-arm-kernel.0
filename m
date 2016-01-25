From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Jan 2016 18:07:02 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K. Poulose <suzuki.poulose@arm.com>

A secondary CPU could fail to come online due to insufficient
capabilities and could simply die or loop in the kernel.
e.g, a CPU with no support for the selected kernel PAGE_SIZE
loops in kernel with MMU turned off.
or a hotplugged CPU which doesn't have one of the advertised
system capability will die during the activation.

There is no way to synchronise the status of the failing CPU
back to the master. This patch solves the issue by adding a
field to the secondary_data which can be updated by the failing
CPU. If the secondary CPU fails even before turning the MMU on,
it updates the status in a special variable reserved in the head.txt
section to make sure that the update can be cache invalidated safely
without possible sharing of cache write back granule.

Here are the possible states :

 -1. CPU_MMU_OFF - Initial value set by the master CPU, this value
indicates that the CPU could not turn the MMU on, hence the status
could not be reliably updated in the secondary_data. Instead, the
CPU has updated the status in __early_cpu_boot_status (reserved in
head.txt section)

 0. CPU_BOOT_SUCCESS - CPU has booted successfully.

 1. CPU_KILL_ME - CPU has invoked cpu_ops->die, indicating the
master CPU to synchronise by issuing a cpu_ops->cpu_kill.

 2. CPU_STUCK_IN_KERNEL - CPU couldn't invoke die(), instead is
looping in the kernel. This information could be used by say,
kexec to check if it is really safe to do a kexec reboot.

 3. CPU_PANIC_KERNEL - CPU detected some serious issues which
requires kernel to crash immediately. The secondary CPU cannot
call panic() until it has initialised the GIC. This flag can
be used to instruct the master to do so.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h    |   26 ++++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c |    2 ++
 arch/arm64/kernel/head.S        |   39 +++++++++++++++++++++++++++++---
 arch/arm64/kernel/smp.c         |   47 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 32e75ee..6548769 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -16,6 +16,19 @@
 #ifndef __ASM_SMP_H
 #define __ASM_SMP_H
 
+/* Values for secondary_data.status */
+
+#define CPU_MMU_OFF		-1
+#define CPU_BOOT_SUCCESS	0
+/* The cpu invoked ops->cpu_die, synchronise it with cpu_kill */
+#define CPU_KILL_ME		1
+/* The cpu couldn't die gracefully and is looping in the kernel */
+#define CPU_STUCK_IN_KERNEL	2
+/* Fatal system error detected by secondary CPU, crash the system */
+#define CPU_PANIC_KERNEL	3
+
+#ifndef __ASSEMBLY__
+
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
@@ -54,11 +67,17 @@ asmlinkage void secondary_start_kernel(void);
 
 /*
  * Initial data for bringing up a secondary CPU.
+ * @stack  - sp for the secondary CPU
+ * @status - Result passed back from the secondary CPU to
+ *           indicate failure.
  */
 struct secondary_data {
 	void *stack;
+	int status;
 };
+
 extern struct secondary_data secondary_data;
+extern int __early_cpu_boot_status;
 extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
@@ -78,4 +97,11 @@ static inline void cpu_park_loop(void)
 	}
 }
 
+static inline void update_cpu_boot_status(int val)
+{
+	WRITE_ONCE(secondary_data.status, val);
+}
+
+#endif /* ifndef __ASSEMBLY__ */
+
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index fffa4ac6..463fcf1 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -104,6 +104,8 @@ int main(void)
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
+  DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
+  BLANK();
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
   DEFINE(CPU_GP_REGS,		offsetof(struct kvm_cpu_context, gp_regs));
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ffe9c2b..16bfa34 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -34,6 +34,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/smp.h>
 #include <asm/sysreg.h>
 #include <asm/thread_info.h>
 #include <asm/virt.h>
@@ -606,7 +607,7 @@ ENTRY(secondary_startup)
 ENDPROC(secondary_startup)
 
 ENTRY(__secondary_switched)
-	ldr	x0, [x21]			// get secondary_data.stack
+	ldr	x0, [x21, #CPU_BOOT_STACK]	// get secondary_data.stack
 	mov	sp, x0
 	and	x0, x0, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x0			// save thread_info
@@ -615,6 +616,32 @@ ENTRY(__secondary_switched)
 ENDPROC(__secondary_switched)
 
 /*
+ * The booting CPU updates the failed status, with MMU turned off,
+ * below which lies in head.txt to make sure it doesn't share the same writeback
+ * granule. So that we can invalidate it properly.
+ *
+ * update_early_cpu_boot_status tmp, status
+ *  - Corrupts tmp, x0, x1
+ *  - Writes 'status' to __early_cpu_boot_status and makes sure
+ *    it is committed to memory.
+ */
+
+	.macro	update_early_cpu_boot_status tmp, status
+	mov	\tmp, lr
+	adrp	x0, __early_cpu_boot_status
+	add	x0, x0, #:lo12:__early_cpu_boot_status
+	mov	x1, #\status
+	str	x1, [x0]
+	add	x1, x0, 4
+	bl	__inval_cache_range
+	mov	lr, \tmp
+	.endm
+
+ENTRY(__early_cpu_boot_status)
+	.long 	0
+END(__early_cpu_boot_status)
+
+/*
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
@@ -631,12 +658,14 @@ __enable_mmu:
 	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
+	mov	x4, x0
+	update_early_cpu_boot_status x2, 0
 	ldr	x5, =vectors
 	msr	vbar_el1, x5
 	msr	ttbr0_el1, x25			// load TTBR0
 	msr	ttbr1_el1, x26			// load TTBR1
 	isb
-	msr	sctlr_el1, x0
+	msr	sctlr_el1, x4
 	isb
 	/*
 	 * Invalidate the local I-cache so that any instructions fetched
@@ -650,6 +679,10 @@ __enable_mmu:
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
+	/* Indicate that this CPU can't boot and is stuck in the kernel */
+	update_early_cpu_boot_status x2, CPU_STUCK_IN_KERNEL
+1:
 	wfe
-	b __no_granule_support
+	wfi
+	b 1b
 ENDPROC(__no_granule_support)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 59f032b..d2721ae 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -63,6 +63,8 @@
  * where to place its SVC stack
  */
 struct secondary_data secondary_data;
+/* Number of CPUs which aren't online, but looping in kernel text. */
+u32 cpus_stuck_in_kernel;
 
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
@@ -72,6 +74,16 @@ enum ipi_msg_type {
 	IPI_IRQ_WORK,
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int op_cpu_kill(unsigned int cpu);
+#else
+static inline int op_cpu_kill(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+#endif
+
+
 /*
  * Boot a secondary CPU, and assign it the specified idle task.
  * This also gives us the initial stack to use for this CPU.
@@ -89,12 +101,14 @@ static DECLARE_COMPLETION(cpu_running);
 int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
+	int status;
 
 	/*
 	 * We need to tell the secondary core where to find its stack and the
 	 * page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
+	update_cpu_boot_status(CPU_MMU_OFF);
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
 
 	/*
@@ -117,7 +131,35 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
+	/* Make sure the update to status is visible */
+	smp_rmb();
 	secondary_data.stack = NULL;
+	status = READ_ONCE(secondary_data.status);
+	if (ret && status) {
+
+		if (status == CPU_MMU_OFF)
+			status = READ_ONCE(__early_cpu_boot_status);
+
+		switch (status) {
+		default:
+			pr_err("CPU%u: failed in unknown state : 0x%x\n",
+					cpu, status);
+			break;
+		case CPU_KILL_ME:
+			if (!op_cpu_kill(cpu)) {
+				pr_crit("CPU%u: died during early boot\n", cpu);
+				break;
+			}
+			/* Fall through */
+			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
+		case CPU_STUCK_IN_KERNEL:
+			pr_crit("CPU%u: is stuck in kernel\n", cpu);
+			cpus_stuck_in_kernel++;
+			break;
+		case CPU_PANIC_KERNEL:
+			panic("CPU%u detected unsupported configuration\n", cpu);
+		}
+	}
 
 	return ret;
 }
@@ -185,6 +227,9 @@ asmlinkage void secondary_start_kernel(void)
 	 */
 	pr_info("CPU%u: Booted secondary processor [%08x]\n",
 					 cpu, read_cpuid_id());
+	update_cpu_boot_status(CPU_BOOT_SUCCESS);
+	/* Make sure the status update is visible before we complete */
+	smp_wmb();
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
@@ -327,10 +372,12 @@ void cpu_die_early(void)
 	set_cpu_present(cpu, 0);
 
 #ifdef CONFIG_HOTPLUG_CPU
+	update_cpu_boot_status(CPU_KILL_ME);
 	/* Check if we can park ourselves */
 	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
 		cpu_ops[cpu]->cpu_die(cpu);
 #endif
+	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
 
 	cpu_park_loop();
 }
-- 
1.7.9.5
