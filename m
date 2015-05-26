From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:35 +0100
Subject: [PATCH 2/7] arm: perf: share arm_pmu_device_probe
In-Reply-To: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657420-887-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the probe function to be shared with other drivers, which will
inject the appropriate of_device_id and pmu_probe_info tables.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       |  4 ++++
 arch/arm/kernel/perf_event_cpu.c | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 62464a4..3fc87df 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -145,6 +145,10 @@ struct pmu_probe_info {
 #define XSCALE_PMU_PROBE(_version, _fn) \
 	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
 
+int arm_pmu_device_probe(struct platform_device *pdev,
+			 const struct of_device_id *of_table,
+			 const struct pmu_probe_info *probe_table);
+
 #endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 14a5a0a..797b569 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -286,16 +286,16 @@ static const struct pmu_probe_info pmu_probe_table[] = {
 /*
  * CPU PMU identification and probing.
  */
-static int probe_current_pmu(struct arm_pmu *pmu)
+static int probe_current_pmu(struct arm_pmu *pmu,
+			     const struct pmu_probe_info *info)
 {
 	int cpu = get_cpu();
 	unsigned int cpuid = read_cpuid_id();
 	int ret = -ENODEV;
-	const struct pmu_probe_info *info;
 
 	pr_info("probing PMU on CPU %d\n", cpu);
 
-	for (info = pmu_probe_table; info->init != NULL; info++) {
+	for (; info->init != NULL; info++) {
 		if ((cpuid & info->mask) != info->cpuid)
 			continue;
 		ret = info->init(pmu);
@@ -352,7 +352,9 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	return 0;
 }
 
-static int cpu_pmu_device_probe(struct platform_device *pdev)
+int arm_pmu_device_probe(struct platform_device *pdev,
+			 const struct of_device_id *of_table,
+			 const struct pmu_probe_info *probe_table)
 {
 	const struct of_device_id *of_id;
 	const int (*init_fn)(struct arm_pmu *);
@@ -371,14 +373,14 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 
 	pmu->plat_device = pdev;
 
-	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
+	if (node && (of_id = of_match_node(of_table, pdev->dev.of_node))) {
 		init_fn = of_id->data;
 
 		ret = of_pmu_irq_cfg(pmu);
 		if (!ret)
 			ret = init_fn(pmu);
 	} else {
-		ret = probe_current_pmu(pmu);
+		ret = probe_current_pmu(pmu, probe_table);
 		cpumask_setall(&pmu->supported_cpus);
 	}
 
@@ -405,6 +407,12 @@ out_free:
 	return ret;
 }
 
+static int cpu_pmu_device_probe(struct platform_device *pdev)
+{
+	return arm_pmu_device_probe(pdev, cpu_pmu_of_device_ids,
+				    pmu_probe_table);
+}
+
 static struct platform_driver cpu_pmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
-- 
1.9.1
