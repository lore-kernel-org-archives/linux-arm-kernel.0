From: Dave.Martin@arm.com (Dave P Martin)
Date: Thu, 17 Apr 2014 10:24:20 +0100
Subject: [PATCH] mcpm: Rename the power_down_finish() functions to be less
 confusing
Message-ID: <20140417092420.GA3430@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name "power_down_finish" seems to be causing some confusion,
because it suggests that this function is responsible for taking
some action to cause the specified CPU to complete its power down.

This patch renames the affected functions to "wait_for_powerdown"
and similar, since this function's intended purpose is just to wait
for the hardware to finish a powerdown initiated by a previous
cpu_power_down.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

Based on the current discussions, it sounds like this rename might be
helpful to people implementing mcpm backends.  What do people think of
it?

Thanks to Nico for the suggestion.


 arch/arm/common/mcpm_entry.c    |    6 +++---
 arch/arm/common/mcpm_platsmp.c  |    2 +-
 arch/arm/include/asm/mcpm.h     |    8 ++++----
 arch/arm/mach-vexpress/tc2_pm.c |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 1e361ab..7522c87 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -101,14 +101,14 @@ void mcpm_cpu_power_down(void)
 	BUG();
 }
 
-int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
+int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	int ret;
 
-	if (WARN_ON_ONCE(!platform_ops || !platform_ops->power_down_finish))
+	if (WARN_ON_ONCE(!platform_ops || !platform_ops->wait_for_powerdown))
 		return -EUNATCH;
 
-	ret = platform_ops->power_down_finish(cpu, cluster);
+	ret = platform_ops->wait_for_powerdown(cpu, cluster);
 	if (ret)
 		pr_warn("%s: cpu %u, cluster %u failed to power down (%d)\n",
 			__func__, cpu, cluster, ret);
diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 177251a..92e54d7 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -62,7 +62,7 @@ static int mcpm_cpu_kill(unsigned int cpu)
 
 	cpu_to_pcpu(cpu, &pcpu, &pcluster);
 
-	return !mcpm_cpu_power_down_finish(pcpu, pcluster);
+	return !mcpm_wait_for_cpu_powerdown(pcpu, pcluster);
 }
 
 static int mcpm_cpu_disable(unsigned int cpu)
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 608516e..90ed219 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -91,14 +91,14 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster);
  * previously in which case the caller should take appropriate action.
  *
  * On success, the CPU is not guaranteed to be truly halted until
- * mcpm_cpu_power_down_finish() subsequently returns non-zero for the
+ * mcpm_wait_for_cpu_powerdown() subsequently returns non-zero for the
  * specified cpu.  Until then, other CPUs should make sure they do not
  * trash memory the target CPU might be executing/accessing.
  */
 void mcpm_cpu_power_down(void);
 
 /**
- * mcpm_cpu_power_down_finish - wait for a specified CPU to halt, and
+ * mcpm_wait_for_cpu_powerdown - wait for a specified CPU to halt, and
  *	make sure it is powered off
  *
  * @cpu: CPU number within given cluster
@@ -120,7 +120,7 @@ void mcpm_cpu_power_down(void);
  *	- zero if the CPU is in a safely parked state
  *	- nonzero otherwise (e.g., timeout)
  */
-int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster);
+int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster);
 
 /**
  * mcpm_cpu_suspend - bring the calling CPU in a suspended state
@@ -164,7 +164,7 @@ int mcpm_cpu_powered_up(void);
 struct mcpm_platform_ops {
 	int (*power_up)(unsigned int cpu, unsigned int cluster);
 	void (*power_down)(void);
-	int (*power_down_finish)(unsigned int cpu, unsigned int cluster);
+	int (*wait_for_powerdown)(unsigned int cpu, unsigned int cluster);
 	void (*suspend)(u64);
 	void (*powered_up)(void);
 };
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 29e7785..b743a0a 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -209,7 +209,7 @@ static int tc2_core_in_reset(unsigned int cpu, unsigned int cluster)
 #define POLL_MSEC 10
 #define TIMEOUT_MSEC 1000
 
-static int tc2_pm_power_down_finish(unsigned int cpu, unsigned int cluster)
+static int tc2_pm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	unsigned tries;
 
@@ -290,7 +290,7 @@ static void tc2_pm_powered_up(void)
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
 	.power_up		= tc2_pm_power_up,
 	.power_down		= tc2_pm_power_down,
-	.power_down_finish	= tc2_pm_power_down_finish,
+	.wait_for_powerdown	= tc2_pm_wait_for_powerdown,
 	.suspend		= tc2_pm_suspend,
 	.powered_up		= tc2_pm_powered_up,
 };
-- 
1.7.10.4
