From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:28 +0100
Subject: [RFC PATCH 15/17] ARM: perf: use cpu pm notifiers to save pmu state
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-16-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the new PM notifier chain into the perf driver
and provides code to execute proper callbacks when a CPU is powered down/up.

Since PMU registers are saved/restored on context switch a simple enable/disable
of PMU is enough to enter/exit lowpower.
v7 requires the counters to be disabled when the CPU comes out of reset since
some register values are UNKNOWN at reset; hence, when a CPU exits low power,
the perf driver reset function callback has to be executed.

Tested on dual core A9 with cores going through shut-down and reset, and
perf running a per cpu task through the "perf stat" command (perf stats
successfully checked against a normal run [power down disabled] through perf of
the same task).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/perf_event.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d53c0ab..9fd44a3 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -24,6 +24,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/pmu.h>
+#include <asm/cpu_pm.h>
 #include <asm/stacktrace.h>
 
 static struct platform_device *pmu_device;
@@ -623,6 +624,26 @@ static struct pmu pmu = {
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
+static int pmu_notifier(struct notifier_block *self, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		perf_pmu_disable(&pmu);
+		break;
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		if (armpmu->reset)
+			armpmu->reset(NULL);
+		perf_pmu_enable(&pmu);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pmu_notifier_block = {
+	.notifier_call = pmu_notifier,
+};
 /*
  * Ensure the PMU has sane values out of reset.
  * This requires SMP to be available, so exists as a separate initcall.
@@ -682,6 +703,7 @@ init_hw_perf_events(void)
 	}
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+	cpu_pm_register_notifier(&pmu_notifier_block);
 
 	return 0;
 }
-- 
1.7.4.4
