From: zsm@chromium.org (Zubin Mithra)
Date: Thu, 15 Mar 2018 17:08:58 +0000
Subject: [RFC 2/3] arm: make cpu a percpu variable
In-Reply-To: <20180315170859.93893-1-zsm@chromium.org>
References: <20180315170859.93893-1-zsm@chromium.org>
Message-ID: <20180315170859.93893-3-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without CONFIG_THREAD_INFO_IN_TASK, core code maintains thread_info::cpu
and arch specific code can use this to build raw_smp_processor_id().
With CONFIG_THREAD_INFO_IN_TASK, core code maintains task_struct::cpu,
and arch specific code cannot access this due to header file circular
dependency.

Instead, we can maintain a percpu variable containing the cpu number.

This also means that cpu numbers obtained using smp_processor_id cannot
be used to set_my_cpu_offset. Use task_cpu(current) instead to get the
cpu in those cases.

Earlier raw_smp_processor_id() was current_thread_info()->cpu :-
	mov	r3, sp
	bic     r3, r3, #8128
	bic     r3, r3, #63
	ldr     r0, [r3, #16]

Now it is *raw_cpu_ptr(&cpu_number) :-
	movw	r3, #57344
	movt	r3, #32917
	mrc	15, 0, r0, cr13, cr0, {4}
	ldr	r0, [r3, r0]

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/arm/include/asm/cputype.h | 3 +++
 arch/arm/include/asm/smp.h     | 3 ++-
 arch/arm/kernel/setup.c        | 2 +-
 arch/arm/kernel/smp.c          | 5 +++--
 arch/arm/kernel/topology.c     | 5 +++++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..10148c7af12f 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_ARM_CPUTYPE_H
 #define __ASM_ARM_CPUTYPE_H
 
+#include <asm/percpu.h>
+DECLARE_PER_CPU(int, cpu_number);
+
 #include <linux/stringify.h>
 #include <linux/kernel.h>
 
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 709a55989cb0..7e7b198174d6 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -18,7 +18,8 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#include <asm/cputype.h>
+#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
 
 struct seq_file;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fc40a2b40595..6323b4d80306 100644
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
index 2da087926ebe..9584a52eb156 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -372,7 +372,8 @@ asmlinkage void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	cpu = smp_processor_id();
+	cpu = task_cpu(current);
+	set_my_cpu_offset(per_cpu_offset(cpu));
 	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
@@ -436,7 +437,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	set_my_cpu_offset(per_cpu_offset(task_cpu(current)));
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 24ac3cab411d..34b2136deab6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -30,6 +30,9 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
+DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 /*
  * cpu capacity scale management
  */
@@ -310,6 +313,8 @@ void __init init_cpu_topology(void)
 	for_each_possible_cpu(cpu) {
 		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
 
+		per_cpu(cpu_number, cpu) = cpu;
+
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id =  -1;
 		cpu_topo->socket_id = -1;
-- 
2.16.2.804.g6dcf76e118-goog
