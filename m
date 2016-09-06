From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue,  6 Sep 2016 19:04:37 +0200
Subject: [PATCH 01/21] arm64: FP/SIMD: Convert to hotplug state machine
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
Message-ID: <20160906170457.32393-2-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Install the callbacks via the state machine.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/fpsimd.c | 22 +++++-----------------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 975b274ee7b5..394c61db5566 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -299,28 +299,16 @@ static inline void fpsimd_pm_init(void) { }
 #endif /* CONFIG_CPU_PM */
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int fpsimd_cpu_hotplug_notifier(struct notifier_block *nfb,
-				       unsigned long action,
-				       void *hcpu)
+static int fpsimd_cpu_dead(unsigned int cpu)
 {
-	unsigned int cpu = (long)hcpu;
-
-	switch (action) {
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		per_cpu(fpsimd_last_state, cpu) = NULL;
-		break;
-	}
-	return NOTIFY_OK;
+	per_cpu(fpsimd_last_state, cpu) = NULL;
+	return 0;
 }
 
-static struct notifier_block fpsimd_cpu_hotplug_notifier_block = {
-	.notifier_call = fpsimd_cpu_hotplug_notifier,
-};
-
 static inline void fpsimd_hotplug_init(void)
 {
-	register_cpu_notifier(&fpsimd_cpu_hotplug_notifier_block);
+	cpuhp_setup_state_nocalls(CPUHP_ARM64_FPSIMD_DEAD, "arm64/fpsimd:dead",
+				  NULL, fpsimd_cpu_dead);
 }
 
 #else
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index afd59e2ca4b3..0da071ff36d2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -20,6 +20,7 @@ enum cpuhp_state {
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
 	CPUHP_CPUIDLE_DEAD,
+	CPUHP_ARM64_FPSIMD_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.9.3
