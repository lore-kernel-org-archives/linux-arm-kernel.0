From: msalter@redhat.com (Mark Salter)
Date: Fri,  1 May 2015 10:45:48 -0400
Subject: [PATCH] arm64/perf: add ACPI support
Message-ID: <1430491548-9896-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using ACPI, the perf_event irq info needs to be parsed
from the MADT and a corresponding platform device needs to
be created and registered. The only change to the existing
driver is a check to avoid unnecessary devicetree parsing.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/perf_event.c | 106 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 195991d..1e53b26 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/acpi.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -1315,6 +1316,10 @@ static int armpmu_device_probe(struct platform_device *pdev)
 	if (!cpu_pmu)
 		return -ENODEV;
 
+	/* skip the devicetree parsing if we're using ACPI */
+	if (!acpi_disabled)
+		goto done;
+
 	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 	if (!irqs)
 		return -ENOMEM;
@@ -1350,6 +1355,7 @@ static int armpmu_device_probe(struct platform_device *pdev)
 	else
 		kfree(irqs);
 
+done:
 	cpu_pmu->plat_device = pdev;
 	return 0;
 }
@@ -1368,6 +1374,106 @@ static int __init register_pmu_driver(void)
 }
 device_initcall(register_pmu_driver);
 
+#ifdef CONFIG_ACPI
+struct acpi_pmu_irq {
+	int gsi;
+	int trigger;
+};
+
+static struct acpi_pmu_irq acpi_pmu_irqs[NR_CPUS] __initdata;
+
+static int __init
+acpi_parse_pmu_irqs(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gic;
+	int cpu;
+	u64 mpidr;
+
+	gic = (struct acpi_madt_generic_interrupt *)header;
+	if (BAD_MADT_ENTRY(gic, end))
+		return -EINVAL;
+
+	mpidr = gic->arm_mpidr & MPIDR_HWID_BITMASK;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_logical_map(cpu) != mpidr)
+			continue;
+
+		acpi_pmu_irqs[cpu].gsi = gic->performance_interrupt;
+		if (gic->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
+			acpi_pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
+		else
+			acpi_pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init pmu_acpi_init(void)
+{
+	struct platform_device *pdev;
+	struct acpi_pmu_irq *pirq = acpi_pmu_irqs;
+	struct resource	*res, *r;
+	int err = -ENOMEM;
+	int i, count, irq;
+
+	if (acpi_disabled)
+		return 0;
+
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+				      acpi_parse_pmu_irqs, num_possible_cpus());
+	/* Must have irq for boot boot cpu, at least */
+	if (count <= 0 || pirq->gsi == 0)
+		return -EINVAL;
+
+	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
+				ACPI_ACTIVE_HIGH);
+
+	if (irq_is_percpu(irq))
+		count = 1;
+
+	pdev = platform_device_alloc("arm-pmu", -1);
+	if (!pdev)
+		goto err_free_gsi;
+
+	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		goto err_free_device;
+
+	for (i = 0, r = res; i < count; i++, pirq++, r++) {
+		if (i)
+			irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
+						ACPI_ACTIVE_HIGH);
+		r->start = r->end = irq;
+		r->flags = IORESOURCE_IRQ;
+		if (pirq->trigger == ACPI_EDGE_SENSITIVE)
+			r->flags |= IORESOURCE_IRQ_HIGHEDGE;
+		else
+			r->flags |= IORESOURCE_IRQ_HIGHLEVEL;
+	}
+
+	err = platform_device_add_resources(pdev, res, count);
+	if (!err)
+		err = platform_device_add(pdev);
+	kfree(res);
+	if (!err)
+		return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+err_free_gsi:
+	for (i = 0; i < count; i++)
+		acpi_unregister_gsi(acpi_pmu_irqs[i].gsi);
+
+	return err;
+}
+arch_initcall(pmu_acpi_init);
+
+#endif /* ACPI */
+
 static struct pmu_hw_events *armpmu_get_cpu_events(void)
 {
 	return this_cpu_ptr(&cpu_hw_events);
-- 
1.8.3.1
