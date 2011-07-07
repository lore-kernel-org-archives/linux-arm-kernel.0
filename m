From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:29 +0100
Subject: [RFC PATCH 16/17] ARM: PM: enhance idle pm notifiers
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-17-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds notifiers to manage low-power entry/exit in a platform
independent manner through a series of callbacks.
The goal is to enhance CPU specific notifiers with a different notifier
chain that executes callbacks defined to put the system into low-power
states (C-state). The callback must be executed with IRQ disabled
and caches still up and running, which in particular means that spinlocks
implemented as ldrex/strex are still usable on ARM.

The callbacks are a means to achieve common idle code, where the
platform_pm_enter()/exit() functions trigger the actions required to
enter/exit low-power states (PCU, clock tree and power domain
programming) for a specific platform.

Within the common idle code for ARM, the callbacks executed upon
platform_pm_enter/exit run with a virtual mapping cloned from init_mm
which means that the virtual address space is still accessible.

The notifier is passed a (void *) argument, that in the context of
common idle code is meant to define cpu and cluster states in order to allow
the platform specific callback to handle power down/up actions accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/cpu_pm.h |   15 +++++++
 arch/arm/kernel/cpu_pm.c      |   92 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/cpu_pm.h b/arch/arm/include/asm/cpu_pm.h
index b4bb715..19b8106 100644
--- a/arch/arm/include/asm/cpu_pm.h
+++ b/arch/arm/include/asm/cpu_pm.h
@@ -42,8 +42,21 @@ enum cpu_pm_event {
 	CPU_COMPLEX_PM_EXIT,
 };
 
+enum platform_pm_event {
+	/* Time to execute code to shutdown cpu/cluster */
+	CPU_PM_SHUTDOWN,
+
+	/* Shutdown cpu/cluster failed */
+	CPU_PM_SHUTDOWN_FAILED,
+
+	/* Time to execute code to wakeup cpu/cluster */
+	CPU_PM_WAKEUP,
+};
+
 int cpu_pm_register_notifier(struct notifier_block *nb);
 int cpu_pm_unregister_notifier(struct notifier_block *nb);
+int platform_pm_register_notifier(struct notifier_block *nb);
+int platform__pm_unregister_notifier(struct notifier_block *nb);
 
 int cpu_pm_enter(void);
 int cpu_pm_exit(void);
@@ -51,4 +64,6 @@ int cpu_pm_exit(void);
 int cpu_complex_pm_enter(void);
 int cpu_complex_pm_exit(void);
 
+int platform_pm_enter(void *);
+int platform_pm_exit(void *);
 #endif
diff --git a/arch/arm/kernel/cpu_pm.c b/arch/arm/kernel/cpu_pm.c
index 48a5b53..2f1f661 100644
--- a/arch/arm/kernel/cpu_pm.c
+++ b/arch/arm/kernel/cpu_pm.c
@@ -47,6 +47,8 @@
 
 static DEFINE_RWLOCK(cpu_pm_notifier_lock);
 static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static DEFINE_RWLOCK(platform_pm_notifier_lock);
+static RAW_NOTIFIER_HEAD(platform_pm_notifier_chain);
 
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
@@ -74,6 +76,33 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
+int platform_pm_register_notifier(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret;
+
+	write_lock_irqsave(&platform_pm_notifier_lock, flags);
+	ret = raw_notifier_chain_register(&platform_pm_notifier_chain, nb);
+	write_unlock_irqrestore(&platform_pm_notifier_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(platform_pm_register_notifier);
+
+int platform_pm_unregister_notifier(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret;
+
+	write_lock_irqsave(&platform_pm_notifier_lock, flags);
+	ret = raw_notifier_chain_unregister(&platform_pm_notifier_chain, nb);
+	write_unlock_irqrestore(&platform_pm_notifier_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(platform_pm_unregister_notifier);
+
+/* These two functions are not really worth duplicating, they must be merged */
 static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
@@ -84,8 +113,19 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 	return notifier_to_errno(ret);
 }
 
+static int __platform_pm_notify(enum platform_pm_event event,
+				void *arg, int nr_to_call, int *nr_calls)
+{
+	int ret;
+
+	ret = __raw_notifier_call_chain(&platform_pm_notifier_chain, event, arg,
+		nr_to_call, nr_calls);
+
+	return notifier_to_errno(ret);
+}
+
 /**
- * cpm_pm_enter
+ * cpu_pm_enter
  *
  * Notifies listeners that a single cpu is entering a low power state that may
  * cause some blocks in the same power domain as the cpu to reset.
@@ -110,7 +150,7 @@ int cpu_pm_enter(void)
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
 
 /**
- * cpm_pm_exit
+ * cpu_pm_exit
  *
  * Notifies listeners that a single cpu is exiting a low power state that may
  * have caused some blocks in the same power domain as the cpu to reset.
@@ -130,7 +170,7 @@ int cpu_pm_exit(void)
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
 /**
- * cpm_complex_pm_enter
+ * cpu_complex_pm_enter
  *
  * Notifies listeners that all cpus in a power domain are entering a low power
  * state that may cause some blocks in the same power domain to reset.
@@ -157,7 +197,7 @@ int cpu_complex_pm_enter(void)
 EXPORT_SYMBOL_GPL(cpu_complex_pm_enter);
 
 /**
- * cpm_pm_enter
+ * cpu_complex_pm_exit
  *
  * Notifies listeners that a single cpu is entering a low power state that may
  * cause some blocks in the same power domain as the cpu to reset.
@@ -179,3 +219,47 @@ int cpu_complex_pm_exit(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_complex_pm_exit);
+/*
+ * platform_pm_enter
+ *
+ * Notifies listeners that either cpu or cluster should enter low-power
+ * Should carry out the actions needed before issuing a processor specific
+ * instruction (wfi on ARM)
+ * Must be called with IRQ disabled
+ * arg is a parameter containing information about targeted platform state
+ */
+int platform_pm_enter(void *arg)
+{
+	int nr_calls;
+	int ret = 0;
+
+	read_lock(&platform_pm_notifier_lock);
+	ret = __platform_pm_notify(CPU_PM_SHUTDOWN, arg, -1, &nr_calls);
+	if (ret)
+		__platform_pm_notify(CPU_PM_SHUTDOWN_FAILED, arg,
+				nr_calls - 1, NULL);
+	read_unlock(&platform_pm_notifier_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(platform_pm_enter);
+
+/*
+ * platform_pm_exit
+ *
+ * Notifies listeners that either cpu or cluster should undo actions executed
+ * before entering low-power mode
+ * Must be called with IRQ disabled
+ * arg is a parameter containing information about targeted platform state
+ */
+int platform_pm_exit(void *arg)
+{
+	int ret;
+
+	read_lock(&platform_pm_notifier_lock);
+	ret = __platform_pm_notify(CPU_PM_WAKEUP, arg, -1, NULL);
+	read_unlock(&platform_pm_notifier_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(platform_pm_exit);
-- 
1.7.4.4
