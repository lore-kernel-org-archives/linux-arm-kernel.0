From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:35 +0000
Subject: [PATCH 1/5] arm_pmu: fold platform helpers into platform code
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171101141239.45340-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armpmu_{request,free}_irqs() helpers are only used by
arm_pmu_platform.c, so let's fold them in and make them static.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c          | 21 ---------------------
 drivers/perf/arm_pmu_platform.c | 21 +++++++++++++++++++++
 include/linux/perf/arm_pmu.h    |  2 --
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7bc5eee96b31..57df8dce8e19 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -548,14 +548,6 @@ void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
 	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 }
 
-void armpmu_free_irqs(struct arm_pmu *armpmu)
-{
-	int cpu;
-
-	for_each_cpu(cpu, &armpmu->supported_cpus)
-		armpmu_free_irq(armpmu, cpu);
-}
-
 int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 {
 	int err = 0;
@@ -612,19 +604,6 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 	return err;
 }
 
-int armpmu_request_irqs(struct arm_pmu *armpmu)
-{
-	int cpu, err;
-
-	for_each_cpu(cpu, &armpmu->supported_cpus) {
-		err = armpmu_request_irq(armpmu, cpu);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
 static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 {
 	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index bbc64ee6dd96..db863f14c406 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -172,6 +172,27 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	return 0;
 }
 
+static int armpmu_request_irqs(struct arm_pmu *armpmu)
+{
+	int cpu, err;
+
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
+		err = armpmu_request_irq(armpmu, cpu);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static void armpmu_free_irqs(struct arm_pmu *armpmu)
+{
+	int cpu;
+
+	for_each_cpu(cpu, &armpmu->supported_cpus)
+		armpmu_free_irq(armpmu, cpu);
+}
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table)
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index af0f44effd44..97426407904d 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -176,8 +176,6 @@ static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
-int armpmu_request_irqs(struct arm_pmu *armpmu);
-void armpmu_free_irqs(struct arm_pmu *armpmu);
 int armpmu_request_irq(struct arm_pmu *armpmu, int cpu);
 void armpmu_free_irq(struct arm_pmu *armpmu, int cpu);
 
-- 
2.11.0
