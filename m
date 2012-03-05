From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Mar 2012 16:54:05 +0000
Subject: [PATCH v2] ARM: perf: add PMU hotplug notifier
Message-ID: <1330966445-4703-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

When a CPU is taken out of reset, either cold booted or hotplugged in,
some of its PMU registers can contain UNKNOWN values.

This patch adds a hotplug notifier to ARM core perf code so that upon
CPU restart the PMU unit is reset and becomes ready to use again.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v2: Use CPU_STARTING instead of CPU_UP_PREPARE, since the latter does
    not run on the CPU coming up.

 arch/arm/kernel/perf_event.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index ab59c3b..5300537 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -680,6 +680,28 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 }
 
 /*
+ * PMU hardware loses all context when a CPU goes offline.
+ * When a CPU is hotplugged back in, since some hardware registers are
+ * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
+ * junk values out of them.
+ */
+static int __cpuinit pmu_cpu_notify(struct notifier_block *b,
+					unsigned long action, void *hcpu)
+{
+	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
+		return NOTIFY_DONE;
+
+	if (cpu_pmu && cpu_pmu->reset)
+		cpu_pmu->reset(NULL);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata pmu_cpu_notifier = {
+	.notifier_call = pmu_cpu_notify,
+};
+
+/*
  * CPU PMU identification and registration.
  */
 static int __init
@@ -733,6 +755,7 @@ init_hw_perf_events(void)
 		pr_info("enabled with %s PMU driver, %d counters available\n",
 			cpu_pmu->name, cpu_pmu->num_events);
 		cpu_pmu_init(cpu_pmu);
+		register_cpu_notifier(&pmu_cpu_notifier);
 		armpmu_register(cpu_pmu, "cpu", PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
-- 
1.7.4.1
