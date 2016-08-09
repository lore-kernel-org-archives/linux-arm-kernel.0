From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Aug 2016 16:51:07 +0100
Subject: [PATCH] drivers/perf: arm_pmu: fix legacy affinity-less DT support
Message-ID: <1470757867-13554-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 19a469a58720ea96 ("drivers/perf: arm-pmu: Handle per-interrupt
affinity mask") relies on using_spi being valid, but this is only
initialised correctly in the presence of an interrupt-affinity property,
which legacy DTBs do not have.

In the absence of an interrupt-affinity property, using_spi is always
false (regardless of whether SPIs are actually used), so we call
irq_get_percpu_devid_partition(irq). This returns -EINVAL, and we give
up, passing on this return value.

The code which determines using_spi also verifies that we do not have
mixed SPI/PPI interrupts. Even in the absence of an interrupt-affinity
property we do not support mixed SPI/PPI cases, so pull the validation
logic above the main loop, ensuring that using_spi is always valid.

At the same time, have the error message to give the path of the PMU
node, rather than a CPU node, as the mismatch is a property of the
entire set of PMU interrupts rather than a particular CPU associated
with it.

Fixes: 19a469a58720ea96 ("drivers/perf: arm-pmu: Handle per-interrupt affinity mask")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

It's been pointed out to me that Marc send a patch a while ago [1] fixing the
same issue, but for some reason that didn't get queued.

This patch had the added benefit of ensuring we always avoid mismatched SPI/PPI
mixes, but otherwise either patch should avoid the issue.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/444404.html

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 6ccb994..7d3c690 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -900,38 +900,41 @@ static int probe_current_pmu(struct arm_pmu *pmu,
 
 static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 {
-	int *irqs, i = 0;
+	int *irqs, i;
 	bool using_spi = false;
 	struct platform_device *pdev = pmu->plat_device;
 
+	/* Check the IRQ type and prohibit a mix of PPIs and SPIs */
+	for (i = 0; i < pdev->num_resources; i++) {
+		int irq = platform_get_irq(pdev, i);
+		if (irq >= 0) {
+			bool spi = !irq_is_percpu(irq);
+
+			if (i > 0 && spi != using_spi) {
+				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
+					of_node_full_name(pdev->dev.of_node));
+				return -EINVAL;
+			}
+
+			using_spi = spi;
+		}
+	}
+
 	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 	if (!irqs)
 		return -ENOMEM;
 
+	i = 0;
+
 	do {
 		struct device_node *dn;
-		int cpu, irq;
+		int cpu;
 
 		/* See if we have an affinity entry */
 		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity", i);
 		if (!dn)
 			break;
 
-		/* Check the IRQ type and prohibit a mix of PPIs and SPIs */
-		irq = platform_get_irq(pdev, i);
-		if (irq >= 0) {
-			bool spi = !irq_is_percpu(irq);
-
-			if (i > 0 && spi != using_spi) {
-				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
-					dn->name);
-				kfree(irqs);
-				return -EINVAL;
-			}
-
-			using_spi = spi;
-		}
-
 		/* Now look up the logical CPU number */
 		for_each_possible_cpu(cpu) {
 			struct device_node *cpu_dn;
-- 
1.9.1
