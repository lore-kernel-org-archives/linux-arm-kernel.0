From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 27 Aug 2016 16:19:49 +0000
Subject: [PATCH 1/2] drivers/perf: arm_pmu: Fix leak in error path
Message-ID: <1472314790-4268-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of a IRQ type mismatch in of_pmu_irq_cfg() the
device node for interrupt affinity isn't freed. So fix this
issue by calling of_node_put().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: fa8ad7889d83 ("arm: perf: factor arm_pmu core out to drivers")
---
 drivers/perf/arm_pmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index c494613..1b48bf0 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -925,6 +925,7 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 			if (i > 0 && spi != using_spi) {
 				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
 					dn->name);
+				of_node_put(dn);
 				kfree(irqs);
 				return -EINVAL;
 			}
-- 
1.7.9.5
