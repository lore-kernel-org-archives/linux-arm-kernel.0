From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Jul 2016 15:39:02 +0100
Subject: [PATCH] drivers/perf: arm-pmu: Fix handling of SPI lacking
 "interrupt-affinity" property
Message-ID: <1468939142-23693-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt
affinity mask") added support for partitionned PPI setups, but
inadvertently broke setups using SPIs without the "interrupt-affinity"
property (which is the case for UP platforms).

This patch restore the broken functionnality by testing whether the
interrupt is percpu or not instead of relying on the using_spi flag
that really means "SPI *and* interrupt-affinity property".

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt affinity mask")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/perf/arm_pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2513365..9275e08 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -958,11 +958,12 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 
 	/* If we didn't manage to parse anything, try the interrupt affinity */
 	if (cpumask_weight(&pmu->supported_cpus) == 0) {
-		if (!using_spi) {
+		int irq = platform_get_irq(pdev, 0);
+
+		if (irq_is_percpu(irq)) {
 			/* If using PPIs, check the affinity of the partition */
-			int ret, irq;
+			int ret;
 
-			irq = platform_get_irq(pdev, 0);
 			ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
 			if (ret) {
 				kfree(irqs);
-- 
2.1.4
