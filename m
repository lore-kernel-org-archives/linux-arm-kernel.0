From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Oct 2015 14:32:45 +0100
Subject: [PATCH 1/2] bus: arm-ccn: Handle correctly no-more-cpus case
In-Reply-To: <1444915966-8055-1-git-send-email-pawel.moll@arm.com>
References: <1444915966-8055-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1444915966-8055-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When migrating events the driver picks another cpu using
cpumask_any_but() function, which returns value >= nr_cpu_ids
when there is none available, not a negative value as the code
assumed. Fixed now.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 7d9879e..cc322fb 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1184,7 +1184,7 @@ static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
 		if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
 			break;
 		target = cpumask_any_but(cpu_online_mask, cpu);
-		if (target < 0)
+		if (target >= nr_cpu_ids)
 			break;
 		perf_pmu_migrate_context(&dt->pmu, cpu, target);
 		cpumask_set_cpu(target, &dt->cpu);
-- 
2.1.4
