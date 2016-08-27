From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 27 Aug 2016 16:19:50 +0000
Subject: [PATCH 2/2] drivers/perf: arm_pmu: Fix NULL pointer dereference
 during probe
In-Reply-To: <1472314790-4268-1-git-send-email-stefan.wahren@i2se.com>
References: <1472314790-4268-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1472314790-4268-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 7f1d642fbb5c ("drivers/perf: arm-pmu: Fix handling of SPI lacking
interrupt-affinity property") unintended also fixes perf_event support
for bcm2835 which doesn't have PMU interrupts. Unfortunately this change
introduce a NULL pointer dereference on bcm2835, because irq_is_percpu
always expected to be called with a valid IRQ. So fix this regression
by validating the IRQ before.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 7f1d642fbb5c ("drivers/perf: arm-pmu: Fix handling of SPI lacking \"interrupt-affinity\" property")
---
 drivers/perf/arm_pmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Note: checkpatch.pl complains about the fixes tag, but i don't know how to
escape it correctly.

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1b48bf0..f5e1008 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -970,7 +970,7 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	if (cpumask_weight(&pmu->supported_cpus) == 0) {
 		int irq = platform_get_irq(pdev, 0);
 
-		if (irq_is_percpu(irq)) {
+		if (irq >= 0 && irq_is_percpu(irq)) {
 			/* If using PPIs, check the affinity of the partition */
 			int ret;
 
-- 
1.7.9.5
