From: julien.grall@arm.com (Julien Grall)
Date: Tue, 31 May 2016 12:41:21 +0100
Subject: [PATCH 1/3] drivers/perf: arm_pmu: Fix reference count of a
 device_node in of_pmu_irq_cfg
In-Reply-To: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
References: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
Message-ID: <1464694883-26298-2-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only function called by of_pmu_irq_cfg that will increment the
reference count on dn is of_parse_phandle.

Each time we successfully parse a possible CPU from an
interrupt-affinity property, we increment the refcount of that CPU node
once via of_parse_handle. After validating the CPU is possible, we
decrement the refcount once. Subsequently, we decrement the refcount
again, either as part of an early break if we don't have a matching SPI,
or as part of the end of the loop body.

This will lead to decrementing twice the refcounnt.
Remove the second pairs of call to of_node_put as nobody is using dn
between the first and second call to of_node_put.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/perf/arm_pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index f2d01d4..6401f0c 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -950,17 +950,14 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 
 		/* For SPIs, we need to track the affinity per IRQ */
 		if (using_spi) {
-			if (i >= pdev->num_resources) {
-				of_node_put(dn);
+			if (i >= pdev->num_resources)
 				break;
-			}
 
 			irqs[i] = cpu;
 		}
 
 		/* Keep track of the CPUs containing this PMU type */
 		cpumask_set_cpu(cpu, &pmu->supported_cpus);
-		of_node_put(dn);
 		i++;
 	} while (1);
 
-- 
1.9.1
