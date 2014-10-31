From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 31 Oct 2014 09:47:24 +0100
Subject: [PATCH v8 02/10] sched: remove frequency scaling from cpu_capacity
In-Reply-To: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1414745252-4895-3-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that arch_scale_cpu_capacity has been introduced to scale the original
capacity, the arch_scale_freq_capacity is no longer used (it was
previously used by ARM arch). Remove arch_scale_freq_capacity from the
computation of cpu_capacity. The frequency invariance will be handled in the
load tracking and not in the CPU capacity. arch_scale_freq_capacity will be
revisited for scaling load with the current frequency of the CPUs in a later
patch.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3674da..bd214d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5784,13 +5784,6 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	cpu_rq(cpu)->cpu_capacity_orig = capacity;
 	sdg->sgc->capacity_orig = capacity;
 
-	if (sched_feat(ARCH_CAPACITY))
-		capacity *= arch_scale_freq_capacity(sd, cpu);
-	else
-		capacity *= default_scale_capacity(sd, cpu);
-
-	capacity >>= SCHED_CAPACITY_SHIFT;
-
 	capacity *= scale_rt_capacity(cpu);
 	capacity >>= SCHED_CAPACITY_SHIFT;
 
-- 
1.9.1
