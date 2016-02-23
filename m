From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:44 +0000
Subject: [PATCH 02/13] arm-cci: fix handling cpumask_any_but return value
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

cpumask_any_but returns value >= nr_cpu_ids if there are no more CPUs.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index ee47e6b..5fb1c06 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1270,7 +1270,7 @@ static int cci_pmu_cpu_notifier(struct notifier_block *self,
 		if (!cpumask_test_and_clear_cpu(cpu, &cci_pmu->cpus))
 			break;
 		target = cpumask_any_but(cpu_online_mask, cpu);
-		if (target < 0) // UP, last CPU
+		if (target >= nr_cpu_ids) // UP, last CPU
 			break;
 		/*
 		 * TODO: migrate context once core races on event->ctx have
-- 
1.7.9.5
