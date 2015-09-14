From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Sep 2015 17:54:39 +0100
Subject: [PATCH] drivers/perf: arm_pmu: avoid CPU device_node reference leak
Message-ID: <1442249679-12899-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_cpu_device_node_get increments the reference count on the CPU
device_node, so we must take care to of_node_put once we've finished
with it.

This patch fixes the perf IRQ probing code to avoid the leak.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2365a32a595e..be3755c973e9 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -823,9 +823,15 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 		}
 
 		/* Now look up the logical CPU number */
-		for_each_possible_cpu(cpu)
-			if (dn == of_cpu_device_node_get(cpu))
+		for_each_possible_cpu(cpu) {
+			struct device_node *cpu_dn;
+
+			cpu_dn = of_cpu_device_node_get(cpu);
+			of_node_put(cpu_dn);
+
+			if (dn == cpu_dn)
 				break;
+		}
 
 		if (cpu >= nr_cpu_ids) {
 			pr_warn("Failed to find logical CPU for %s\n",
-- 
2.1.4
