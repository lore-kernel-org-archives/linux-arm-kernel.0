From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Tue, 11 Feb 2014 11:15:29 +0900
Subject: [PATCH v1 1/1] ARM: EXYNOS: enable boot all secondary cpus instead 2
In-Reply-To: <1392084929-14116-1-git-send-email-t.dakhran@samsung.com>
References: <1392084929-14116-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <1392084929-14116-2-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions to boot secondary cpus added.
	exynos_core_power_up(unsigned int cpu) added for power up any cpu.
	exynos_core_power_down(unsigned int cpu) for power down any cpu.

Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c  |   11 ++++--
 arch/arm/mach-exynos/platsmp.c  |   75 ++++++++++++++++++++++++++++-----------
 arch/arm/mach-exynos/regs-pmu.h |    5 +++
 3 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead53..71982fa 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -90,13 +90,18 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
+static void exynos_core_power_down(unsigned int cpu)
+{
+	writel_relaxed(0, S5P_ARM_CORE_CONFIGURATION(cpu));
+}
+
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
 	for (;;) {
 
-		/* make cpu1 to be turned off at next WFI command */
-		if (cpu == 1)
-			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+		/* make cpu to be turned off at next WFI command */
+		if (cpu)
+			exynos_core_power_down(cpu);
 
 		/*
 		 * here's the WFI
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 8ea02f6..4008fc8 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -88,10 +88,61 @@ static void exynos_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
+/*
+ * core_power_state is used to get core power state.
+ * returns:
+ *        0x0 - powered off;
+ *        0x3 - powered on;
+ *        other values - in process;
+ */
+static unsigned int core_power_state(unsigned int cpu)
+{
+	unsigned int status = readl_relaxed(S5P_ARM_CORE_STATUS(cpu));
+
+	return status & CORE_PWR_STATE_MASK;
+}
+
+#define TIMEOUT 10
+#define DELAY_TIME 1
+
+static int wait_core_power_up(unsigned int cpu)
+{
+	int timeout = TIMEOUT;
+
+	do {
+		/* checking if power controller in reset */
+		if (core_power_state(cpu) == S5P_CORE_LOCAL_PWR_EN)
+				return 0;
+		mdelay(DELAY_TIME);
+		timeout -= DELAY_TIME;
+	} while (timeout > 0);
+
+	return -ETIMEDOUT; /* timeout */
+}
+
+static int exynos_core_power_up(unsigned int cpu)
+{
+	int ret;
+
+	if (core_power_state(cpu) != S5P_CORE_LOCAL_PWR_EN) {
+		writel_relaxed(S5P_CORE_LOCAL_PWR_EN,
+					S5P_ARM_CORE_CONFIGURATION(cpu));
+
+		ret = wait_core_power_up(cpu);
+		if (ret) {
+			pr_debug("timeout powering on CPU%d\n", cpu);
+			return ret; /* timeout */
+		}
+	}
+
+	return 0;
+}
+
 static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	unsigned long phys_cpu = cpu_logical_map(cpu);
+	int ret;
 
 	/*
 	 * Set synchronisation state between this boot processor
@@ -109,26 +160,10 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
-		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
-
-		timeout = 10;
-
-		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
-			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
-			if (timeout-- == 0)
-				break;
-
-			mdelay(1);
-		}
-
-		if (timeout == 0) {
-			printk(KERN_ERR "cpu1 power enable failed");
-			spin_unlock(&boot_lock);
-			return -ETIMEDOUT;
-		}
+	ret = exynos_core_power_up(cpu);
+	if (ret) {
+		spin_unlock(&boot_lock);
+		return ret;
 	}
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 7c029ce..4fc1e8f 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -104,6 +104,11 @@
 #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
+#define CORE_PWR_STATE_MASK			0x3
+
+#define S5P_ARM_CORE_CONFIGURATION(_nr)	(S5P_PMUREG(0x2000) + ((_nr) * 0x80))
+#define S5P_ARM_CORE_STATUS(_nr)	(S5P_PMUREG(0x2004) + ((_nr) * 0x80))
+
 #define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
 #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
 
-- 
1.7.10.4
