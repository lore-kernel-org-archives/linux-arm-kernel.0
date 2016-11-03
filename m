From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  3 Nov 2016 20:23:11 +0000
Subject: [PATCHv2 09/11] arm64: make cpu number a percpu variable
In-Reply-To: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
References: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1478204593-29145-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the absence of CONFIG_THREAD_INFO_IN_TASK, core code maintains
thread_info::cpu, and low-level architecture code can access this to
build raw_smp_processor_id(). With CONFIG_THREAD_INFO_IN_TASK, core code
maintains task_struct::cpu, which for reasons of hte header soup is not
accessible to low-level arch code.

Instead, we can maintain a percpu variable containing the cpu number.

For both the old and new implementation of raw_smp_processor_id(), we
read a syreg into a GPR, add an offset, and load the result. As the
offset is now larger, it may not be folded into the load, but otherwise
the assembly shouldn't change much.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/smp.h | 11 ++++++++++-
 arch/arm64/kernel/smp.c      |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 0226447..968b08d 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -29,11 +29,20 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/percpu.h>
+
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
+
+/*
+ * We don't use this_cpu_read(cpu_number) as that has implicit writes to
+ * preempt_count, and associated (compiler) barriers, that we'd like to avoid
+ * the expense of. If we're preemptible, the value can be stale at use anyway.
+ */
+#define raw_smp_processor_id() (*this_cpu_ptr(&cpu_number))
 
 struct seq_file;
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f64401f..6f42c68 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -58,6 +58,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
+DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -719,6 +722,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	for_each_possible_cpu(cpu) {
 
+		per_cpu(cpu_number, cpu) = cpu;
+
 		if (cpu == smp_processor_id())
 			continue;
 
-- 
2.7.4
