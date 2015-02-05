From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Feb 2015 11:14:30 +0100
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
Message-ID: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The complete() should not be used on offlined CPU. Rewrite the
wait-complete mechanism with wait_on_bit_timeout().

The CPU triggering hot unplug (e.g. CPU0) will loop until some bit is
cleared. In each iteration schedule_timeout() is used with initial sleep
time of 1 ms. Later it is increased to 10 ms.

The dying CPU will clear the bit which is safe in that context.

This fixes following RCU warning on ARMv8 (Exynos 4412, Trats2) during
suspend to RAM:

[   31.113925] ===============================
[   31.113928] [ INFO: suspicious RCU usage. ]
[   31.113935] 3.19.0-rc7-next-20150203 #1914 Not tainted
[   31.113938] -------------------------------
[   31.113943] kernel/sched/fair.c:4740 suspicious rcu_dereference_check() usage!
[   31.113946]
[   31.113946] other info that might help us debug this:
[   31.113946]
[   31.113952]
[   31.113952] RCU used illegally from offline CPU!
[   31.113952] rcu_scheduler_active = 1, debug_locks = 0
[   31.113957] 3 locks held by swapper/1/0:
[   31.113988]  #0:  ((cpu_died).wait.lock){......}, at: [<c005a114>] complete+0x14/0x44
[   31.114012]  #1:  (&p->pi_lock){-.-.-.}, at: [<c004a790>] try_to_wake_up+0x28/0x300
[   31.114035]  #2:  (rcu_read_lock){......}, at: [<c004f1b8>] select_task_rq_fair+0x5c/0xa04
[   31.114038]
[   31.114038] stack backtrace:
[   31.114046] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc7-next-20150203 #1914
[   31.114050] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   31.114076] [<c0014ce4>] (unwind_backtrace) from [<c0011c30>] (show_stack+0x10/0x14)
[   31.114091] [<c0011c30>] (show_stack) from [<c04dc048>] (dump_stack+0x70/0xbc)
[   31.114105] [<c04dc048>] (dump_stack) from [<c004f83c>] (select_task_rq_fair+0x6e0/0xa04)
[   31.114118] [<c004f83c>] (select_task_rq_fair) from [<c004a83c>] (try_to_wake_up+0xd4/0x300)
[   31.114129] [<c004a83c>] (try_to_wake_up) from [<c00598a0>] (__wake_up_common+0x4c/0x80)
[   31.114140] [<c00598a0>] (__wake_up_common) from [<c00598e8>] (__wake_up_locked+0x14/0x1c)
[   31.114150] [<c00598e8>] (__wake_up_locked) from [<c005a134>] (complete+0x34/0x44)
[   31.114167] [<c005a134>] (complete) from [<c04d6ca4>] (cpu_die+0x24/0x84)
[   31.114179] [<c04d6ca4>] (cpu_die) from [<c005a508>] (cpu_startup_entry+0x328/0x358)
[   31.114189] [<c005a508>] (cpu_startup_entry) from [<40008784>] (0x40008784)
[   31.114226] CPU1: shutdown

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes since v1:
1. Use adaptive sleep time when waiting for CPU die (idea and code
   from Paul E. McKenney). Paul also acked the patch but I made evem more
   changes.

2. Add another bit (CPU_DIE_TIMEOUT_BIT) for synchronizing power down
   failure in case:
    CPU0 (killing)                           CPUx (killed)
     wait_for_cpu_die
     timeout
                                              cpu_die()
                                               clear_bit()
                                               self power down

   In this case the bit would be cleared and CPU would be powered down
   introducing wrong behavior in next power down sequence (CPU0 would
   see the bit cleared).
   I think that such race is still possible but was narrowed to very
   short time frame. Any CPU up will reset the bit to proper values.

3. Remove pre-test for bit in wait_for_cpu_die(). Suggested by Stephen
   Boyd. This leads to more simplification in wait_for_cpu_die() loop.

4. Update comment for second flush_cache_louis() in dying CPU.
   Suggested by Stephen Boyd.
---
 arch/arm/kernel/smp.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 86ef244c5a24..0f6f1371739d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/wait.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -76,6 +77,10 @@ enum ipi_msg_type {
 
 static DECLARE_COMPLETION(cpu_running);
 
+#define CPU_DIE_WAIT_BIT		0
+#define CPU_DIE_TIMEOUT_BIT		1
+static unsigned long wait_cpu_die;
+
 static struct smp_operations smp_ops;
 
 void __init smp_set_ops(struct smp_operations *ops)
@@ -133,6 +138,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
+	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
+	clear_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die);
+	smp_mb__after_atomic();
 
 	memset(&secondary_data, 0, sizeof(secondary_data));
 	return ret;
@@ -213,7 +221,40 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
+static inline int wait_on_die_bit_timeout(int sleep_ms)
+{
+	smp_mb__before_atomic();
+
+	return out_of_line_wait_on_bit_timeout(&wait_cpu_die,
+				CPU_DIE_WAIT_BIT, bit_wait_timeout,
+				TASK_UNINTERRUPTIBLE,
+				msecs_to_jiffies(sleep_ms));
+}
+
+/*
+ * Wait for 5000 ms for 'wait_cpu_die' bit to be cleared.
+ * Actually the real wait time may be longer because bit_wait_timeout
+ * calls schedule() in each iteration.
+ *
+ * Returns 0 if bit was cleared (CPU died) or non-zero
+ * otherwise (1 or negative ERRNO).
+ */
+static int wait_for_cpu_die(void)
+{
+	int ms_left = 5000, sleep_ms = 1, ret;
+
+	might_sleep();
+
+	while ((ret = wait_on_die_bit_timeout(sleep_ms))) {
+		ms_left -= sleep_ms;
+		if (!ret || (ms_left <= 0))
+			break;
+
+		sleep_ms = DIV_ROUND_UP(sleep_ms * 11, 10);
+	}
+
+	return ret;
+}
 
 /*
  * called on the thread which is asking for a CPU to be shutdown -
@@ -221,7 +262,9 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	if (wait_for_cpu_die()) {
+		set_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die);
+		smp_mb__after_atomic();
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -236,6 +279,11 @@ void __cpu_die(unsigned int cpu)
 	 */
 	if (!platform_cpu_kill(cpu))
 		pr_err("CPU%u: unable to kill\n", cpu);
+
+	/* Prepare the bit for some next CPU die */
+	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
+	clear_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die);
+	smp_mb__after_atomic();
 }
 
 /*
@@ -250,6 +298,8 @@ void __ref cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
 
+	WARN_ON(!test_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die));
+
 	idle_task_exit();
 
 	local_irq_disable();
@@ -267,12 +317,23 @@ void __ref cpu_die(void)
 	 * this returns, power and/or clocks can be removed@any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	clear_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
+	smp_mb__after_atomic();
+
+	/*
+	 * If killing CPU reached timeout than this thread must set dying bit
+	 * for next power down sequence.
+	 */
+	if (test_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die)) {
+		clear_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die);
+		set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
+		smp_mb__after_atomic();
+	}
 
 	/*
-	 * Ensure that the cache lines associated with that completion are
-	 * written out.  This covers the case where _this_ CPU is doing the
-	 * powering down, to ensure that the completion is visible to the
+	 * Ensure that the cache lines associated with clearing 'wait_cpu_die'
+	 * bit are written out. This covers the case where _this_ CPU is doing
+	 * the powering down, to ensure that the bit clearing is visible to the
 	 * CPU waiting for this one.
 	 */
 	flush_cache_louis();
@@ -296,6 +357,14 @@ void __ref cpu_die(void)
 		cpu);
 
 	/*
+	 * There is a chance that the killing CPU reached time out in
+	 * __cpu_die() so set the bit for next power down sequence.
+	 */
+	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
+	clear_bit(CPU_DIE_TIMEOUT_BIT, &wait_cpu_die);
+	smp_mb__after_atomic();
+
+	/*
 	 * Do not return to the idle loop - jump back to the secondary
 	 * cpu initialisation.  There's some initialisation which needs
 	 * to be repeated to undo the effects of taking the CPU offline.
-- 
1.9.1
