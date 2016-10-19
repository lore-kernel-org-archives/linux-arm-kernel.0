From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:32 +0100
Subject: [PATCH 08/10] arm64: make cpu number a percpu variable
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the absence of CONFIG_THREAD_INFO_IN_TASK, core code maintains
thread_info::cpu, and low-level architecture code can access this to
build raw_smp_processor_id(). With CONFIG_THREAD_INFO_IN_TASK, core code
maintains task_struct::cpu, which for reasons of hte header soup is not
accessible to low-level arch code.

Instead, we can maintain a percpu variable containing the cpu number.
Non-preemptible code will receive the current CPU's number, while
preemptible code may race (as was previosuly the case), and see a stale
value. Thus, there shouldn't be a change in observable behaviour.

For both the old and new implementation of raw_smp_processor_id(), we
read a syreg into a GPR, add an offset, and load the result. As the
offset is now large, it probably won't be folded into the load, but
otherwise the assembly shouldn't change much.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/smp.h | 6 +++++-
 arch/arm64/kernel/smp.c      | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 0226447..f77ac0d 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -29,11 +29,15 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/percpu.h>
+
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
+
+#define raw_smp_processor_id() (*this_cpu_ptr(&cpu_number))
 
 struct seq_file;
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7af46bf..2679722 100644
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
@@ -718,6 +721,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	for_each_possible_cpu(cpu) {
 
+		per_cpu(cpu_number, cpu) = cpu;
+
 		if (cpu == smp_processor_id())
 			continue;
 
-- 
1.9.1
