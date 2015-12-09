From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  9 Dec 2015 09:57:15 +0000
Subject: [RFC PATCH v3 4/8] arm64: Handle early CPU boot failures
In-Reply-To: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1449655039-22022-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A secondary CPU could fail to come online due to insufficient
capabilities and could simply die or loop in the kernel.
e.g, a CPU with no support for the selected kernel PAGE_SIZE
loops in kernel with MMU turned off.
or a hotplugged CPU which doesn't have one of the advertised
system capability will die during the activation.

There is no way to synchronise the status of the failing CPU
back to the master. This patch solves the issue by adding a
field to the secondary_data which can be updated by the failing
CPU.

Here are the possible states :

 -1. CPU_WAIT_STATUS - Initial value set by the master CPU.

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
 arch/arm64/include/asm/smp.h    |   24 +++++++++++++++++++-
 arch/arm64/kernel/asm-offsets.c |    3 +++
 arch/arm64/kernel/head.S        |   19 ++++++++++++++--
 arch/arm64/kernel/smp.c         |   48 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 13ce01f..240ab3d 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -16,6 +16,19 @@
 #ifndef __ASM_SMP_H
 #define __ASM_SMP_H
 
+/* Values for secondary_data.status */
+
+#define CPU_WAIT_RESULT		-1
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
@@ -54,10 +67,15 @@ asmlinkage void secondary_start_kernel(void);
 
 /*
  * Initial data for bringing up a secondary CPU.
+ * @stack  - sp for the secondary CPU
+ * @status - Result passed back from the secondary CPU to
+ *           indicate failure.
  */
 struct secondary_data {
 	void *stack;
-};
+	unsigned long status;
+} ____cacheline_aligned;
+
 extern struct secondary_data secondary_data;
 extern void secondary_entry(void);
 
@@ -70,4 +88,8 @@ extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void);
 extern void cpu_die_early(void);
 
+extern void update_cpu_boot_status(unsigned long);
+
+#endif /* ifndef __ASSEMBLY__ */
+
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 25de8b2..d8975f0 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -103,6 +103,9 @@ int main(void)
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
+  DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
+  DEFINE(CPU_BOOT_STATUS,	offsetof(struct secondary_data, status));
+  BLANK();
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
   DEFINE(CPU_GP_REGS,		offsetof(struct kvm_cpu_context, gp_regs));
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b225d34..e0a42dd 100644
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
@@ -605,7 +606,7 @@ ENTRY(secondary_startup)
 ENDPROC(secondary_startup)
 
 ENTRY(__secondary_switched)
-	ldr	x0, [x22]			// get secondary_data.stack
+	ldr	x0, [x22, #CPU_BOOT_STACK]	// get secondary_data.stack
 	mov	sp, x0
 	mov	x29, #0
 	b	secondary_start_kernel
@@ -615,6 +616,7 @@ ENDPROC(__secondary_switched)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x22 = __va(secondary_data)
  *  x27 = *virtual* address to jump to upon completion
  *
  * Other registers depend on the function called upon completion.
@@ -647,6 +649,19 @@ __enable_mmu:
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
+	/* Indicate that this CPU can't boot and is stuck in the kernel */
+	cmp	x22, 0				// Boot CPU doesn't update status
+	b.eq	1f
+	adrp	x1, secondary_data
+	add	x1, x1, #:lo12:secondary_data	// x1 = __pa(secondary_data)
+	mov	x0, #CPU_STUCK_IN_KERNEL
+	str	x0, [x1, #CPU_BOOT_STATUS]	// update the secondary_data.status
+	/* flush the data to PoC */
+	isb
+	dc	civac, x1
+	dsb	sy
+	isb
+1:
 	wfe
-	b __no_granule_support
+	b 1b
 ENDPROC(__no_granule_support)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 607d876..708f4b1 100644
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
@@ -86,6 +98,12 @@ static int boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static DECLARE_COMPLETION(cpu_running);
 
+void update_cpu_boot_status(unsigned long status)
+{
+	secondary_data.status = status;
+	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
+}
+
 int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -95,7 +113,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	 * page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
-	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
+	update_cpu_boot_status(CPU_WAIT_RESULT);
 
 	/*
 	 * Now bring the CPU into our world.
@@ -117,7 +135,31 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
+	mb();
+
 	secondary_data.stack = NULL;
+	if (ret && secondary_data.status) {
+		switch(secondary_data.status) {
+		default:
+			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
+					cpu, secondary_data.status);
+			break;
+		case CPU_KILL_ME:
+			if (op_cpu_kill(cpu)) {
+				pr_crit("CPU%u: may not have shut down cleanly\n",
+							cpu);
+				cpus_stuck_in_kernel++;
+			} else
+				pr_crit("CPU%u: died during early boot\n", cpu);
+			break;
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
@@ -185,6 +227,7 @@ asmlinkage void secondary_start_kernel(void)
 	 */
 	pr_info("CPU%u: Booted secondary processor [%08x]\n",
 					 cpu, read_cpuid_id());
+	update_cpu_boot_status(CPU_BOOT_SUCCESS);
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
@@ -327,10 +370,13 @@ void cpu_die_early(void)
 	set_cpu_present(cpu, 0);
 
 #ifdef CONFIG_HOTPLUG_CPU
+	update_cpu_boot_status(CPU_KILL_ME);
 	/* Check if we can park ourselves */
 	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
 		cpu_ops[cpu]->cpu_die(cpu);
 #endif
+	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
+	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
 
 	for (;;) {
 		wfe();
-- 
1.7.9.5
