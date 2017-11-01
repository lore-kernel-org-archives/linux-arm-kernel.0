From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:39 +0000
Subject: [PATCH 5/5] arm_pmu: acpi: request IRQs up-front
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171101141239.45340-6-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't request IRQs in atomic context, so for ACPI systems we'll have
to request them up-front, and later associate them with CPUs.

This patch reorganises the arm_pmu code to do so. As we no longer have
the arm_pmu strucutre at probe time, a number of prototypes need to be
adjusted, requiring changes to the common arm_pmu code and arm_pmu
platform code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c          | 37 +++----------------------------------
 drivers/perf/arm_pmu_acpi.c     | 20 +++++++-------------
 drivers/perf/arm_pmu_platform.c | 25 ++++++++++++++++++++++---
 include/linux/perf/arm_pmu.h    | 13 +++++++++++--
 4 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 287b3edfb4cc..534b4b3fb440 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -323,13 +323,6 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
-static struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu)
-{
-	struct platform_device *pdev = armpmu->plat_device;
-
-	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
-}
-
 static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
@@ -542,7 +535,7 @@ int armpmu_count_irq_users(const int irq)
 	return count;
 }
 
-void __armpmu_free_irq(int irq, int cpu)
+void armpmu_free_irq(int irq, int cpu)
 {
 	if (per_cpu(cpu_irq, cpu) == 0)
 		return;
@@ -559,16 +552,7 @@ void __armpmu_free_irq(int irq, int cpu)
 	per_cpu(cpu_irq, cpu) = 0;
 }
 
-void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
-{
-	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int irq = per_cpu(hw_events->irq, cpu);
-
-	__armpmu_free_irq(irq, cpu);
-	per_cpu(cpu_armpmu, cpu) = NULL;
-}
-
-int armpmu_request_irq_flags(int irq, unsigned long irq_flags, int cpu)
+int armpmu_request_irq(int irq, unsigned long irq_flags, int cpu)
 {
 	int err = 0;
 	const irq_handler_t handler = armpmu_dispatch_irq;
@@ -603,24 +587,9 @@ int armpmu_request_irq_flags(int irq, unsigned long irq_flags, int cpu)
 	return err;
 }
 
-int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
+void armpmu_bind_cpu(struct arm_pmu *armpmu, int cpu)
 {
-	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
-	unsigned long irq_flags;
-	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int irq = per_cpu(hw_events->irq, cpu);
-	if (!irq)
-		return 0;
-
-	if (platdata && platdata->irq_flags) {
-		irq_flags = platdata->irq_flags;
-	} else {
-		irq_flags = ARM_PMU_IRQ_FLAGS;
-	}
-
 	per_cpu(cpu_armpmu, cpu) = armpmu;
-
-	return armpmu_request_irq_flags(irq, irq_flags, cpu);
 }
 
 static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 07a113b8a3b2..8740314584aa 100644
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
+		armpmu_request_irq(irq, ARM_PMU_IRQ_FLAGS, cpu);
 	}
 
 	return 0;
@@ -203,14 +209,7 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	}
 
 	cpumask_set_cpu(cpu, &pmu->supported_cpus);
-
-	/*
-	 * Log and request the IRQ so the core arm_pmu code can manage it.  In
-	 * some situations (e.g. mismatched PPIs), we may fail to request the
-	 * IRQ. However, it may be too late for us to do anything about it.
-	 * The common ARM PMU code will log a warning in this case.
-	 */
-	armpmu_request_irq(pmu, cpu);
+	armpmu_bind_cpu(pmu, cpu);
 
 	/*
 	 * Ideally, we'd probe the PMU here when we find the first matching
@@ -281,11 +280,6 @@ static int arm_pmu_acpi_init(void)
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
index 686b3f28c5d1..f5aba6bafe1d 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -174,10 +174,24 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 
 static int armpmu_request_irqs(struct arm_pmu *armpmu)
 {
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
+	unsigned long irq_flags;
 	int cpu, err;
 
+	if (platdata && platdata->irq_flags)
+		irq_flags = platdata->irq_flags;
+	else
+		irq_flags = ARM_PMU_IRQ_FLAGS;
+
 	for_each_cpu(cpu, &armpmu->supported_cpus) {
-		err = armpmu_request_irq(armpmu, cpu);
+		int irq = per_cpu(hw_events->irq, cpu);
+		if (!irq)
+			continue;
+
+		armpmu_bind_cpu(armpmu, cpu);
+
+		err = armpmu_request_irq(irq, irq_flags, cpu);
 		if (err)
 			break;
 	}
@@ -188,9 +202,14 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
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
+		armpmu_bind_cpu(NULL, cpu);
+	}
 }
 
 int arm_pmu_device_probe(struct platform_device *pdev,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 2ce6db4e00b2..00f11de8775e 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -14,6 +14,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
 
@@ -175,8 +176,16 @@ static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 struct arm_pmu *armpmu_alloc(gfp_t flags);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
-int armpmu_request_irq(struct arm_pmu *armpmu, int cpu);
-void armpmu_free_irq(struct arm_pmu *armpmu, int cpu);
+void armpmu_bind_cpu(struct arm_pmu *armpmu, int cpu);
+int armpmu_request_irq(int irq, unsigned long flags, int cpu);
+void armpmu_free_irq(int irq, int cpu);
+
+static inline struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu)
+{
+	struct platform_device *pdev = armpmu->plat_device;
+
+	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
+}
 
 #define ARM_PMU_IRQ_FLAGS (IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_THREAD)
 
-- 
2.11.0
