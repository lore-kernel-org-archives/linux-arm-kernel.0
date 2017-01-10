From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 10 Jan 2017 11:17:52 -0600
Subject: [PATCH v12 7/7] arm: pmu: Add PMU definitions for cores not initially
 online
In-Reply-To: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1484068672-15852-8-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI CPUs aren't associated with a PMU until they have been put
online. This means that we potentially have to update a PMU
definition the first time a CPU is hot added to the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c       | 34 ++++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h |  4 ++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 77ec1ae..cf5122f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -711,6 +711,26 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
+static void arm_perf_associate_new_cpu(struct arm_pmu *lpmu, unsigned int cpu)
+{
+	struct platform_device *pdev = lpmu->plat_device;
+	struct resource *res;
+	struct pmu_hw_events *events;
+	int num_res;
+
+	for (num_res = 0; num_res < pdev->num_resources; num_res++) {
+		if (!pdev->resource[num_res].flags)
+			break;
+	}
+	res = &pdev->resource[num_res];
+	arm_pmu_acpi_retrieve_irq(res, cpu);
+	events = per_cpu_ptr(lpmu->hw_events, cpu);
+	cpumask_set_cpu(cpu, &lpmu->supported_cpus);
+	if (lpmu->irq_affinity)
+		lpmu->irq_affinity[num_res] = cpu;
+	events->percpu_pmu = lpmu;
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
@@ -721,10 +741,18 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct arm_pmu *pmu = hlist_entry_safe(node, struct arm_pmu, node);
 
-	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
-		return 0;
+	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus)) {
+		unsigned int cpuid = read_specific_cpuid(cpu);
+
+		if (acpi_disabled)
+			return 0;
+		if (cpuid != pmu->id)
+			return 0;
+		arm_perf_associate_new_cpu(pmu, cpu);
+	}
 	if (pmu->reset)
 		pmu->reset(pmu);
+
 	return 0;
 }
 
@@ -905,6 +933,8 @@ static int probe_plat_pmu(struct arm_pmu *pmu,
 	struct platform_device *pdev = pmu->plat_device;
 	int irq = platform_get_irq(pdev, 0);
 
+	pmu->id = pmuid;
+
 	if (irq >= 0 && !irq_is_percpu(irq)) {
 		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
 					    GFP_KERNEL);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 42b5edb..f652cd1 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -112,6 +112,7 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	id;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 	struct platform_device	*plat_device;
@@ -168,8 +169,11 @@ int arm_pmu_device_probe(struct platform_device *pdev,
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
