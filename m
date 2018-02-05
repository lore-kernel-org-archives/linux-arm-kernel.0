From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Feb 2018 16:42:02 +0000
Subject: [PATCHv2 8/8] arm_pmu: acpi: request IRQs up-front
In-Reply-To: <20180205164202.26502-1-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
Message-ID: <20180205164202.26502-9-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't request IRQs in atomic context, so for ACPI systems we'll have
to request them up-front, and later associate them with CPUs.

This patch reorganises the arm_pmu code to do so. As we no longer have
the arm_pmu structure at probe time, a number of prototypes need to be
adjusted, requiring changes to the common arm_pmu code and arm_pmu
platform code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c          | 26 +++-----------------------
 drivers/perf/arm_pmu_acpi.c     | 19 ++++++-------------
 drivers/perf/arm_pmu_platform.c | 15 ++++++++++++---
 include/linux/perf/arm_pmu.h    |  5 +++--
 4 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 023a8ebdace6..1bff95ff3566 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -528,7 +528,7 @@ int armpmu_count_irq_users(const int irq)
 	return count;
 }
 
-void armpmu_free_cpu_irq(int irq, int cpu)
+void armpmu_free_irq(int irq, int cpu)
 {
 	if (per_cpu(cpu_irq, cpu) == 0)
 		return;
@@ -545,15 +545,7 @@ void armpmu_free_cpu_irq(int irq, int cpu)
 	per_cpu(cpu_irq, cpu) = 0;
 }
 
-void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
-{
-	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int irq = per_cpu(hw_events->irq, cpu);
-
-	armpmu_free_cpu_irq(irq, cpu);
-}
-
-int armpmu_request_cpu_irq(int irq, int cpu)
+int armpmu_request_irq(int irq, int cpu)
 {
 	int err = 0;
 	const irq_handler_t handler = armpmu_dispatch_irq;
@@ -576,8 +568,7 @@ int armpmu_request_cpu_irq(int irq, int cpu)
 			    IRQF_NO_THREAD;
 
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		err = request_irq(irq, handler, irq_flags, "arm-pmu",
-				  NULL);
+		err = request_irq(irq, handler, irq_flags, "arm-pmu", NULL);
 	} else if (armpmu_count_irq_users(irq) == 0) {
 		err = request_percpu_irq(irq, handler, "arm-pmu",
 					 cpu_armpmu);
@@ -594,17 +585,6 @@ int armpmu_request_cpu_irq(int irq, int cpu)
 	return err;
 }
 
-int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
-{
-	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int irq = per_cpu(hw_events->irq, cpu);
-	if (!irq)
-		return 0;
-
-
-	return armpmu_request_cpu_irq(irq, cpu);
-}
-
 static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 {
 	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 09a1a36cff57..0f197516d708 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -89,7 +89,13 @@ static int arm_pmu_acpi_parse_irqs(void)
 			pr_warn("No ACPI PMU IRQ for CPU%d\n", cpu);
 		}
 
+		/*
+		 * Log and request the IRQ so the core arm_pmu code can manage
+		 * it. We'll have to sanity-check IRQs later when we associate
+		 * them with their PMUs.
+		 */
 		per_cpu(pmu_irqs, cpu) = irq;
+		armpmu_request_irq(irq, cpu);
 	}
 
 	return 0;
@@ -205,14 +211,6 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	cpumask_set_cpu(cpu, &pmu->supported_cpus);
 
 	/*
-	 * Log and request the IRQ so the core arm_pmu code can manage it.  In
-	 * some situations (e.g. mismatched PPIs), we may fail to request the
-	 * IRQ. However, it may be too late for us to do anything about it.
-	 * The common ARM PMU code will log a warning in this case.
-	 */
-	armpmu_request_irq(pmu, cpu);
-
-	/*
 	 * Ideally, we'd probe the PMU here when we find the first matching
 	 * CPU. We can't do that for several reasons; see the comment in
 	 * arm_pmu_acpi_init().
@@ -281,11 +279,6 @@ static int arm_pmu_acpi_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	/*
-	 * We can't request IRQs yet, since we don't know the cookie value
-	 * until we know which CPUs share the same logical PMU. We'll handle
-	 * that in arm_pmu_acpi_cpu_starting().
-	 */
 	ret = arm_pmu_acpi_parse_irqs();
 	if (ret)
 		return ret;
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 1dc3c1f574e0..7729eda5909d 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -159,10 +159,15 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 
 static int armpmu_request_irqs(struct arm_pmu *armpmu)
 {
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
 	int cpu, err;
 
 	for_each_cpu(cpu, &armpmu->supported_cpus) {
-		err = armpmu_request_irq(armpmu, cpu);
+		int irq = per_cpu(hw_events->irq, cpu);
+		if (!irq)
+			continue;
+
+		err = armpmu_request_irq(irq, cpu);
 		if (err)
 			break;
 	}
@@ -173,9 +178,13 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
 static void armpmu_free_irqs(struct arm_pmu *armpmu)
 {
 	int cpu;
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
 
-	for_each_cpu(cpu, &armpmu->supported_cpus)
-		armpmu_free_irq(armpmu, cpu);
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
+		int irq = per_cpu(hw_events->irq, cpu);
+
+		armpmu_free_irq(irq, cpu);
+	}
 }
 
 int arm_pmu_device_probe(struct platform_device *pdev,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index feec9e7e85db..40036a57d072 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -14,6 +14,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
 
@@ -159,8 +160,8 @@ struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
-int armpmu_request_irq(struct arm_pmu *armpmu, int cpu);
-void armpmu_free_irq(struct arm_pmu *armpmu, int cpu);
+int armpmu_request_irq(int irq, int cpu);
+void armpmu_free_irq(int irq, int cpu);
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
-- 
2.11.0
