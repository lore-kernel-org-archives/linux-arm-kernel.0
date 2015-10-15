From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Oct 2015 14:32:46 +0100
Subject: [PATCH 2/2] bus: arm-ccn: Fix irq affinity setting on CPU migration
In-Reply-To: <1444915966-8055-1-git-send-email-pawel.moll@arm.com>
References: <1444915966-8055-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1444915966-8055-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When PMU context is migrating between CPUs, interrupt affinity is set as
well. Only this should not happen when the CCN interrupt is not being
used at all (the driver is using a hrtimer tick instead).

Fixed now.

Cc: <stable@vger.kernel.org> # 4.2+
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index cc322fb..7082c72 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1188,7 +1188,8 @@ static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
 			break;
 		perf_pmu_migrate_context(&dt->pmu, cpu, target);
 		cpumask_set_cpu(target, &dt->cpu);
-		WARN_ON(irq_set_affinity(ccn->irq, &dt->cpu) != 0);
+		if (ccn->irq)
+			WARN_ON(irq_set_affinity(ccn->irq, &dt->cpu) != 0);
 	default:
 		break;
 	}
-- 
2.1.4
