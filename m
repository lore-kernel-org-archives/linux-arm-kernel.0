From: amonakov@ispras.ru (Alexander Monakov)
Date: Thu,  1 Mar 2018 23:25:36 +0300
Subject: [PATCH] drivers/perf: arm_pmu_platform: do not warn about affinity on
 uniprocessor
Message-ID: <20180301202536.11776-1-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is exactly one CPU present, there is no ambiguity: do not warn
that PMU setup would need to guess IRQ affinity.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
This helps to avoid a useless warning on single-CPU systems with a PMU.

 drivers/perf/arm_pmu_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 91b224eced18..e5740b6dee74 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -131,7 +131,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 			return pmu_parse_percpu_irq(pmu, irq);
 	}
 
-	if (!pmu_has_irq_affinity(pdev->dev.of_node)) {
+	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node)) {
 		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
 			pdev->dev.of_node);
 	}
-- 
2.11.0
