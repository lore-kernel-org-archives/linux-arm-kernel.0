From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 28 Jun 2016 14:55:50 +0100
Subject: [PATCH v7 4/6] cpuidle: introduce HAVE_GENERIC_CPUIDLE_ENTER for
 ARM{32, 64} platforms
In-Reply-To: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
References: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1467122152-5604-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function arm_enter_idle_state is exactly the same in both generic
ARM{32,64} CPUIdle driver and will be the same even on ARM64 backend
for ACPI processor idle driver. So we can unify it and move it as
generic_cpuidle_enter by introducing HAVE_GENERIC_CPUIDLE_ENTER and
enabling the same on both ARM{32,64}.

This is in preparation of reuse of the generic cpuidle entry function
for ACPI LPI support on ARM64.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/kernel/cpuidle.c     |  4 ++--
 arch/arm64/Kconfig            |  1 +
 arch/arm64/kernel/cpuidle.c   |  6 +++---
 drivers/cpuidle/Kconfig       |  3 +++
 drivers/cpuidle/cpuidle-arm.c | 21 +--------------------
 drivers/cpuidle/cpuidle.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h       |  8 ++++++++
 8 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db1220d..52b3dca0381c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -54,6 +54,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_GENERIC_CPUIDLE_ENTER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_IDE if PCI || ISA || PCMCIA
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index a44b268e12e1..49704e333bfc 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -41,7 +41,7 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 }
 
 /**
- * arm_cpuidle_suspend() - function to enter low power idle states
+ * cpuidle_generic_enter() - function to enter low power idle states
  * @index: an integer used as an identifier for the low level PM callbacks
  *
  * This function calls the underlying arch specific low level PM code as
@@ -50,7 +50,7 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
  * Returns -EOPNOTSUPP if no suspend callback is defined, the result of the
  * callback otherwise.
  */
-int arm_cpuidle_suspend(int index)
+int cpuidle_generic_enter(int index)
 {
 	int ret = -EOPNOTSUPP;
 	int cpu = smp_processor_id();
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691d4220..0916b6e6c8ef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -76,6 +76,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_GENERIC_CPUIDLE_ENTER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 06786fdaadeb..bade1b04ff12 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -9,10 +9,10 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpuidle.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
 int arm_cpuidle_init(unsigned int cpu)
@@ -27,13 +27,13 @@ int arm_cpuidle_init(unsigned int cpu)
 }
 
 /**
- * cpu_suspend() - function to enter a low-power idle state
+ * cpuidle_generic_enter() - function to enter a low-power idle state
  * @arg: argument to pass to CPU suspend operations
  *
  * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
  * operations back-end error code otherwise.
  */
-int arm_cpuidle_suspend(int index)
+int cpuidle_generic_enter(int index)
 {
 	int cpu = smp_processor_id();
 
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 7e48eb5bf0a7..e557289cff90 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -45,4 +45,7 @@ endif
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
 	def_bool n
+
+config HAVE_GENERIC_CPUIDLE_ENTER
+	def_bool n
 endmenu
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index e342565e8715..13012d8eba53 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -36,26 +36,7 @@
 static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	int ret;
-
-	if (!idx) {
-		cpu_do_idle();
-		return idx;
-	}
-
-	ret = cpu_pm_enter();
-	if (!ret) {
-		/*
-		 * Pass idle state index to cpu_suspend which in turn will
-		 * call the CPU ops suspend protocol with idle index as a
-		 * parameter.
-		 */
-		ret = arm_cpuidle_suspend(idx);
-
-		cpu_pm_exit();
-	}
-
-	return ret ? -1 : idx;
+	return cpuidle_generic_enter_state(idx);
 }
 
 static struct cpuidle_driver arm_idle_driver = {
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a4d0059e232c..e490dea98b89 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -16,6 +16,7 @@
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
@@ -255,6 +256,40 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 }
 
 /**
+ * cpuidle_generic_enter_state - enter into the specified idle state using the
+ *				 generic callback if implemented
+ *
+ * @index: the index in the idle state table
+ *
+ * Returns the index in the idle state, -1 in case of error.
+ */
+int cpuidle_generic_enter_state(int idx)
+{
+	int ret;
+
+	if (!idx) {
+		cpu_do_idle();
+		return idx;
+	}
+
+	ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		 * Pass idle state index to cpu_suspend which in turn will
+		 * call the CPU ops suspend protocol with idle index as a
+		 * parameter.
+		 */
+		ret = cpuidle_generic_enter(idx);
+
+		cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_generic_enter_state);
+
+/**
  * cpuidle_enter - enter into the specified idle state
  *
  * @drv:   the cpuidle driver tied with the cpu
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 07b83d32f66c..9fd3c10166fa 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -154,6 +154,7 @@ extern int cpuidle_play_dead(void);
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 static inline struct cpuidle_device *cpuidle_get_device(void)
 {return __this_cpu_read(cpuidle_devices); }
+extern int cpuidle_generic_enter_state(int idx);
 #else
 static inline void disable_cpuidle(void) { }
 static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
@@ -190,6 +191,7 @@ static inline int cpuidle_play_dead(void) {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
 static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
+static inline int cpuidle_generic_enter_state(int idx) { return -1; }
 #endif
 
 #if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
@@ -246,6 +248,12 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
 #endif
 
+#ifdef CONFIG_HAVE_GENERIC_CPUIDLE_ENTER
+extern int cpuidle_generic_enter(int idx);
+#else
+static inline int cpuidle_generic_enter(int idx) { return -1; }
+#endif
+
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
 #define CPUIDLE_DRIVER_STATE_START	1
 #else
-- 
2.7.4
