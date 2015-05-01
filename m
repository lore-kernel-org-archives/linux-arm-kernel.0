From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 01 May 2015 12:06:32 -0400
Subject: [PATCH 5/5] ARM: MCPM: remove residency argument from
 mcpm_cpu_suspend()
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1430496392-15956-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is currently unused.

If a suspend must be limited to CPU level only by preventing the last man
from triggering a cluster level suspend then this should be determined
according to many other criteria the MCPM layer is currently not aware of.
It is unlikely that mcpm_cpu_suspend() would be the proper conduit for
that information anyway.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c         |  2 +-
 arch/arm/include/asm/mcpm.h          | 15 +++++----------
 arch/arm/mach-exynos/suspend.c       |  8 +-------
 drivers/cpuidle/cpuidle-big_little.c |  8 +-------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 492467587c..a923524d10 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -321,7 +321,7 @@ int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster)
 	return ret;
 }
 
-void mcpm_cpu_suspend(u64 expected_residency)
+void mcpm_cpu_suspend(void)
 {
 	if (WARN_ON_ONCE(!platform_ops))
 		return;
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 6a40d5f8db..acd4983d9b 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -137,17 +137,12 @@ int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster);
 /**
  * mcpm_cpu_suspend - bring the calling CPU in a suspended state
  *
- * @expected_residency: duration in microseconds the CPU is expected
- *			to remain suspended, or 0 if unknown/infinity.
- *
- * The calling CPU is suspended.  The expected residency argument is used
- * as a hint by the platform specific backend to implement the appropriate
- * sleep state level according to the knowledge it has on wake-up latency
- * for the given hardware.
+ * The calling CPU is suspended.  This is similar to mcpm_cpu_power_down()
+ * except for possible extra platform specific configuration steps to allow
+ * an asynchronous wake-up e.g. with a pending interrupt.
  *
  * If this CPU is found to be the "last man standing" in the cluster
- * then the cluster may be prepared for power-down too, if the expected
- * residency makes it worthwhile.
+ * then the cluster may be prepared for power-down too.
  *
  * This must be called with interrupts disabled.
  *
@@ -157,7 +152,7 @@ int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster);
  * This will return if mcpm_platform_register() has not been called
  * previously in which case the caller should take appropriate action.
  */
-void mcpm_cpu_suspend(u64 expected_residency);
+void mcpm_cpu_suspend(void);
 
 /**
  * mcpm_cpu_powered_up - housekeeping workafter a CPU has been powered up
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 3e6aea7f83..372bd0b099 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -311,13 +311,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
 		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
-
-		/*
-		 * Residency value passed to mcpm_cpu_suspend back-end
-		 * has to be given clear semantics. Set to 0 as a
-		 * temporary value.
-		 */
-		mcpm_cpu_suspend(0);
+		mcpm_cpu_suspend();
 	}
 
 	pr_info("Failed to suspend the system\n");
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 40c34faffe..db2ede565f 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -108,13 +108,7 @@ static int notrace bl_powerdown_finisher(unsigned long arg)
 	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
 	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
-
-	/*
-	 * Residency value passed to mcpm_cpu_suspend back-end
-	 * has to be given clear semantics. Set to 0 as a
-	 * temporary value.
-	 */
-	mcpm_cpu_suspend(0);
+	mcpm_cpu_suspend();
 
 	/* return value != 0 means failure */
 	return 1;
-- 
2.1.0
