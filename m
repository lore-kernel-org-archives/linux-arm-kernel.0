From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:37 +0000
Subject: [PATCH 3/5] arm_pmu: acpi: check for mismatched PPIs
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171101141239.45340-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm_pmu platform code explicitly checks for mismatched PPIs at probe
time, while the ACPI code leaves this to the core code. Future
refactoring will make this difficult for the core code to check, so
let's have the ACPI code check this explicitly.

As before, upon a failure we'll continue on without an interrupt. Ho
hum.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c      | 16 ++++------------
 drivers/perf/arm_pmu_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3d6d4c5f2356..e0242103d904 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -557,18 +557,10 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 	if (!irq)
 		return 0;
 
-	if (irq_is_percpu_devid(irq) && cpumask_empty(&armpmu->active_irqs)) {
-		err = request_percpu_irq(irq, handler, "arm-pmu",
-					 &hw_events->percpu_pmu);
-	} else if (irq_is_percpu_devid(irq)) {
-		int other_cpu = cpumask_first(&armpmu->active_irqs);
-		int other_irq = per_cpu(hw_events->irq, other_cpu);
-
-		if (irq != other_irq) {
-			pr_warn("mismatched PPIs detected.\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	if (irq_is_percpu_devid(irq)) {
+		if (cpumask_empty(&armpmu->active_irqs))
+			err = request_percpu_irq(irq, handler, "arm-pmu",
+						 &hw_events->percpu_pmu);
 	} else {
 		struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
 		unsigned long irq_flags;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index a52f5b673a15..07a113b8a3b2 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -11,6 +11,8 @@
 #include <linux/acpi.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/percpu.h>
 #include <linux/perf/arm_pmu.h>
 
@@ -140,6 +142,35 @@ static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
 }
 
 /*
+ * Check whether the new IRQ is compatible with those already associated with
+ * the PMU (e.g. we don't have mismatched PPIs).
+ */
+static bool pmu_irq_matches(struct arm_pmu *pmu, int irq)
+{
+	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
+	int cpu;
+
+	if (!irq)
+		return true;
+
+	for_each_cpu(cpu, &pmu->supported_cpus) {
+		int other_irq = per_cpu(hw_events->irq, cpu);
+		if (!other_irq)
+			continue;
+
+		if (irq == other_irq)
+			continue;
+		if (!irq_is_percpu_devid(irq) && !irq_is_percpu_devid(other_irq))
+			continue;
+
+		pr_warn("mismatched PPIs detected\n");
+		return false;
+	}
+
+	return true;
+}
+
+/*
  * This must run before the common arm_pmu hotplug logic, so that we can
  * associate a CPU and its interrupt before the common code tries to manage the
  * affinity and so on.
@@ -164,18 +195,21 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	if (!pmu)
 		return -ENOMEM;
 
-	cpumask_set_cpu(cpu, &pmu->supported_cpus);
-
 	per_cpu(probed_pmus, cpu) = pmu;
 
+	if (pmu_irq_matches(pmu, irq)) {
+		hw_events = pmu->hw_events;
+		per_cpu(hw_events->irq, cpu) = irq;
+	}
+
+	cpumask_set_cpu(cpu, &pmu->supported_cpus);
+
 	/*
 	 * Log and request the IRQ so the core arm_pmu code can manage it.  In
 	 * some situations (e.g. mismatched PPIs), we may fail to request the
 	 * IRQ. However, it may be too late for us to do anything about it.
 	 * The common ARM PMU code will log a warning in this case.
 	 */
-	hw_events = pmu->hw_events;
-	per_cpu(hw_events->irq, cpu) = irq;
 	armpmu_request_irq(pmu, cpu);
 
 	/*
-- 
2.11.0
