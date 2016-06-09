From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Jun 2016 17:23:32 -0500
Subject: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Its possible that an ACPI system has multiple CPU types in it
with differing PMU counters. Use the newly provided acpi_pmu routines
to detect that case, and instantiate more than one set of counters.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c      |  7 +++-
 drivers/perf/arm_pmu_acpi.c | 98 ++++++++++++++++++++-------------------------
 2 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 865a9db..97007ec 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1049,7 +1049,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else {
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
index a257fc0..8f9bea3 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -35,6 +35,11 @@ struct pmu_types {
 
 static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
 
+/*
+ * Called from acpi_map_gic_cpu_interface()'s MADT parsing during boot.
+ * This routine saves off the GSI's and their trigger state for use when we are
+ * ready to build the PMU platform device.
+*/
 void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 {
 	pmu_irqs[cpu].gsi = gic->performance_interrupt;
@@ -47,7 +52,7 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 }
 
 /* Count number and type of CPU cores in the system. */
-void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
+static void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
 {
 	int i, j;
 
@@ -74,7 +79,7 @@ void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
  * Registers the group of PMU interfaces which corrispond to the 'last_cpu_id'.
  * This group utlizes 'count' resources in the 'res'.
  */
-int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
+static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
 					    int last_cpu_id)
 {
 	int i;
@@ -121,7 +126,7 @@ int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
  * them to the resource structure. Return the number of GSI's contained
  * in the res structure, and the id of the last CPU/PMU we added.
  */
-int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
+static int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
 				       struct resource *res, int *last_cpu_id)
 {
 	int i, count;
@@ -164,63 +169,48 @@ int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
 
 static int __init pmu_acpi_init(void)
 {
-	struct platform_device *pdev;
-	struct pmu_irq *pirq = pmu_irqs;
-	struct resource	*res, *r;
+	struct resource	*res;
 	int err = -ENOMEM;
-	int i, count, irq;
+	int count;
+	int j, last_cpu_id;
+	struct pmu_types *pmus;
 
+	pr_debug("Prepare registration\n");
 	if (acpi_disabled)
 		return 0;
 
-	/* Must have irq for boot boot cpu, at least */
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
-	pdev = platform_device_alloc(PMU_PDEV_NAME, -1);
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
-	}
-
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
+	pmus = kcalloc(num_possible_cpus(), sizeof(struct pmu_types),
+		       GFP_KERNEL);
+
+	if (pmus) {
+		arm_pmu_acpi_determine_cpu_types(pmus);
+
+		for (j = 0; pmus[j].cpu_count; j++) {
+			pr_devel("CPU type %X, count %d\n", pmus[j].cpu_type,
+				 pmus[j].cpu_count);
+			res = kcalloc(pmus[j].cpu_count,
+				      sizeof(struct resource), GFP_KERNEL);
+
+			/* for a given PMU type collect all the GSIs. */
+			if (res) {
+				count = arm_pmu_acpi_gsi_res(&pmus[j], res,
+							     &last_cpu_id);
+				/*
+				 * register this set of interrupts
+				 * with a new PMU device
+				 */
+				err = arm_pmu_acpi_register_pmu(count,
+								res,
+								last_cpu_id);
+				kfree(res);
+			} else
+				pr_warn("PMU unable to allocate interrupt resource space\n");
+		}
 
+		kfree(pmus);
+	} else
+		pr_warn("PMU: Unable to allocate pmu count structures\n");
 	return err;
 }
+
 arch_initcall(pmu_acpi_init);
-- 
2.5.5
