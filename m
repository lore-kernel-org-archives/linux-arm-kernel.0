From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 14 Sep 2016 17:32:37 -0500
Subject: [PATCH v9 09/10] arm: pmu: Add PMU definitions for hot-plugged CPUs
In-Reply-To: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1473892358-22574-10-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI CPUs aren't associated with a PMU until they have been put
online. This means that we potentially have to update a PMU
definition the first time a CPU is hot added to the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c       | 39 ++++++++++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h |  4 ++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 47ab4e9..7835602 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -693,6 +693,34 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 static DEFINE_SPINLOCK(arm_pmu_lock);
 static LIST_HEAD(arm_pmu_list);
 
+static void arm_perf_associate_new_cpu(struct arm_pmu *lpmu, unsigned int cpu)
+{
+	if (lpmu) {
+		struct platform_device *pdev = lpmu->plat_device;
+		struct resource *res;
+		struct pmu_hw_events *events;
+		int num_res;
+
+		for (num_res = 0; num_res < pdev->num_resources; num_res++) {
+			if (!pdev->resource[num_res].flags)
+				break;
+		}
+		res = &pdev->resource[num_res];
+
+		arm_pmu_acpi_retrieve_irq(res, cpu);
+		events = per_cpu_ptr(lpmu->hw_events, cpu);
+		cpumask_set_cpu(cpu, &lpmu->supported_cpus);
+		if (lpmu->irq_affinity)
+			lpmu->irq_affinity[num_res] = cpu;
+		pdev->num_resources++;
+		events->percpu_pmu = lpmu;
+		if (lpmu->reset)
+			lpmu->reset(lpmu);
+	} else {
+		pr_err("ACPI: unknown PMU type, unable to enable\n");
+	}
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
@@ -702,15 +730,22 @@ static LIST_HEAD(arm_pmu_list);
 static int arm_perf_starting_cpu(unsigned int cpu)
 {
 	struct arm_pmu *pmu;
+	struct arm_pmu *lpmu = NULL;
+	bool found = false;
+	unsigned int cpuid = read_specific_cpuid(cpu);
 
 	spin_lock(&arm_pmu_lock);
 	list_for_each_entry(pmu, &arm_pmu_list, entry) {
-
+		if (cpuid == pmu->id)
+			lpmu = pmu;
 		if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
 			continue;
+		found = true;
 		if (pmu->reset)
 			pmu->reset(pmu);
 	}
+	if (!(found || acpi_disabled))
+		arm_perf_associate_new_cpu(lpmu, cpu);
 	spin_unlock(&arm_pmu_lock);
 	return 0;
 }
@@ -893,6 +928,8 @@ static int probe_plat_pmu(struct arm_pmu *pmu,
 	struct platform_device *pdev = pmu->plat_device;
 	int irq = platform_get_irq(pdev, 0);
 
+	pmu->id = pmuid;
+
 	if (irq >= 0 && !irq_is_percpu(irq)) {
 		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
 					    GFP_KERNEL);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 535c9e2..651b7a5 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -105,6 +105,7 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	id;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 	struct platform_device	*plat_device;
@@ -158,8 +159,11 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 #ifdef CONFIG_ARM_PMU_ACPI
 struct acpi_madt_generic_interrupt;
 void arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic);
+int arm_pmu_acpi_retrieve_irq(struct resource *pdev, int cpu);
 #else
 #define arm_pmu_parse_acpi(a, b) do { } while (0)
+#define arm_pmu_acpi_retrieve_irq(pdev, cpu) \
+	do { } while (0)
 #endif /* CONFIG_ARM_PMU_ACPI */
 
 #endif /* __ARM_PMU_H__ */
-- 
2.5.5
