From: zsm@chromium.org (Zubin Mithra)
Date: Mon, 18 Jun 2018 08:30:52 -0700
Subject: [RFC v2 3/4] arm: make cpu a percpu variable
In-Reply-To: <20180618153053.186224-1-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
Message-ID: <20180618153053.186224-4-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without CONFIG_THREAD_INFO_IN_TASK, core code maintains thread_info::cpu
and arch specific code can use this to build raw_smp_processor_id().
With CONFIG_THREAD_INFO_IN_TASK, core code maintains task_struct::cpu
and arch specific code cannot access this due to header file circular
dependency.

Instead, we can maintain a percpu variable containing the cpu number.

This also means that cpu numbers obtained using smp_processor_id cannot
be used to set_my_cpu_offset. Use task_cpu(current) instead to get the
cpu in those cases.

Without any patches in this patchset, raw_smp_processor_id() was :-
	mov     r3, sp
	bic     r3, r3, #8128
	bic     r3, r3, #63
	ldr     r0, [r3, #16]

When thread_info is stored in sp^ as per the first patch in this series,
it becomes :-
	sub	sp, sp, #4
	stmia	sp, {sp}^
	ldr	r2, [sp]
	add	sp, sp, #4
	ldr	r2, [r2, #16]

Finally, when cpu is made a percpu variable and fetched using
raw_cpu_ptr() :-
	movw	r2, #4096	; 0x1000
	movt	r2, #32918	; 0x8096
	mrc	15, 0, r0, cr13, cr0, {4}
	ldr	r2, [r2, r0]

Note that once the thread_info is moved off of the stack, the sequence
of instructions used to fetch the cpu number would be the third sequence
using raw_cpu_ptr().

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/arm/include/asm/smp.h | 11 ++++++++++-
 arch/arm/kernel/setup.c    |  2 +-
 arch/arm/kernel/smp.c      | 13 +++++++++++--
 arch/arm/kernel/topology.c |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 709a55989cb0..cf366dd6e9f1 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARM_SMP_H
 #define __ASM_ARM_SMP_H
 
+#include <asm/percpu.h>
+
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
@@ -18,7 +20,14 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU(int, cpu_number);
+
+/*
+ * to avoid implicit writes to preempt_count, compiler barriers in
+ * preempt_enable_notrace and preempt_disable_notrace, use *raw_cpu_ptr
+ * instead of this_cpu_read.
+ */
+#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
 
 struct seq_file;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 35ca494c028c..be3f5603dcac 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -521,7 +521,7 @@ static void __init elf_hwcap_fixup(void)
 void notrace cpu_init(void)
 {
 #ifndef CONFIG_CPU_V7M
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu = task_cpu(current);
 	struct stack *stk = &stacks[cpu];
 
 	if (cpu >= NR_CPUS) {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0978282d5fc2..dbb1eabf7912 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -54,6 +54,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
+DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -372,7 +375,8 @@ asmlinkage void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	cpu = smp_processor_id();
+	cpu = task_cpu(current);
+	set_my_cpu_offset(per_cpu_offset(cpu));
 	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
@@ -439,15 +443,20 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	set_my_cpu_offset(per_cpu_offset(task_cpu(current)));
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu;
 
 	init_cpu_topology();
 
+	for_each_possible_cpu(cpu) {
+		per_cpu(cpu_number, cpu) = cpu;
+	}
+
 	smp_store_cpu_info(smp_processor_id());
 
 	/*
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 24ac3cab411d..6e05217106ac 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -310,6 +310,8 @@ void __init init_cpu_topology(void)
 	for_each_possible_cpu(cpu) {
 		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
 
+		per_cpu(cpu_number, cpu) = cpu;
+
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id =  -1;
 		cpu_topo->socket_id = -1;
-- 
2.18.0.rc1.244.gcf134e6275-goog
