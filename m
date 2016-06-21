From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 21 Jun 2016 12:11:48 -0500
Subject: [PATCH 10/11] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1466529109-21715-11-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Its possible that an ACPI system has multiple CPU types in it
with differing PMU counters. Use the newly provided acpi_pmu routines
to detect that case, and instantiate more than one set of counters.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c      |  7 +++-
 drivers/perf/arm_pmu_acpi.c | 82 ++++++++++++++++-----------------------------
 2 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 28cac3a..f94d279 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1044,7 +1044,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else if (probe_table) {
-		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
+		if (acpi_disabled) {
+			/* use the current cpu. */
+			ret = probe_plat_pmu(pmu, probe_table,
+					     read_cpuid_id());
+		} else
+			ret = probe_plat_pmu(pmu, probe_table, pdev->id);
 	}
 
 	if (ret) {
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 482a54d..6f5df1a 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -50,7 +50,7 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 }
 
 /* Count number and type of CPU cores in the system. */
-void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
+static void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
 {
 	int i;
 
@@ -84,7 +84,7 @@ void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
  * Registers the group of PMU interfaces which correspond to the 'last_cpu_id'.
  * This group utilizes 'count' resources in the 'res'.
  */
-int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
+static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
 					    int last_cpu_id)
 {
 	int i;
@@ -130,7 +130,7 @@ int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
  * them to the resource structure. Return the number of GSI's contained
  * in the res structure, and the id of the last CPU/PMU we added.
  */
-int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
+static int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
 				       struct resource *res, int *last_cpu_id)
 {
 	int i, count;
@@ -169,63 +169,39 @@ int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
 
 static int __init pmu_acpi_init(void)
 {
-	struct platform_device *pdev;
-	struct pmu_irq *pirq = pmu_irqs;
-	struct resource	*res, *r;
+	struct resource	*res;
 	int err = -ENOMEM;
-	int i, count, irq;
+	int count, cpu_id;
+	struct pmu_types *pmu, *safe_temp;
+	LIST_HEAD(pmus);
 
 	if (acpi_disabled)
 		return 0;
 
-	/* Must have irq for boot cpu, at least */
-	if (pirq->gsi == 0)
-		return -EINVAL;
-
-	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
-				ACPI_ACTIVE_HIGH);
-
-	if (irq_is_percpu(irq))
-		count = 1;
-	else
-		for (i = 1, count = 1; i < NR_CPUS; i++)
-			if (pmu_irqs[i].gsi)
-				++count;
-
-	pdev = platform_device_alloc(ARMV8_PMU_PDEV_NAME, -1);
-	if (!pdev)
-		goto err_free_gsi;
-
-	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		goto err_free_device;
-
-	for (i = 0, r = res; i < count; i++, pirq++, r++) {
-		if (i)
-			irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
-						ACPI_ACTIVE_HIGH);
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ;
-		if (pirq->trigger == ACPI_EDGE_SENSITIVE)
-			r->flags |= IORESOURCE_IRQ_HIGHEDGE;
-		else
-			r->flags |= IORESOURCE_IRQ_HIGHLEVEL;
+	arm_pmu_acpi_determine_cpu_types(&pmus);
+
+	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
+		res = kcalloc(pmu->cpu_count,
+			      sizeof(struct resource), GFP_KERNEL);
+
+		/* for a given PMU type collect all the GSIs. */
+		if (res) {
+			count = arm_pmu_acpi_gsi_res(pmu, res,
+						     &cpu_id);
+			/*
+			 * register this set of interrupts
+			 * with a new PMU device
+			 */
+			err = arm_pmu_acpi_register_pmu(count, res, cpu_id);
+			kfree(res);
+		} else
+			pr_warn("PMU unable to allocate interrupt resource space\n");
+
+		list_del(&pmu->list);
+		kfree(pmu);
 	}
 
-	err = platform_device_add_resources(pdev, res, count);
-	if (!err)
-		err = platform_device_add(pdev);
-	kfree(res);
-	if (!err)
-		return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-err_free_gsi:
-	for (i = 0; i < count; i++)
-		acpi_unregister_gsi(pmu_irqs[i].gsi);
-
 	return err;
 }
+
 arch_initcall(pmu_acpi_init);
-- 
2.5.5
