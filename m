From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 12 Dec 2012 14:31:31 +0100
Subject: [RFC PATCH v2 5/6] sched: pack the idle load balance
In-Reply-To: <1355319092-30980-1-git-send-email-vincent.guittot@linaro.org>
References: <1355319092-30980-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1355319092-30980-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Look for an idle CPU close to the pack buddy CPU whenever possible.
The goal is to prevent the wake up of a CPU which doesn't share the power
domain of the pack buddy CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f1a4c24..6475f54 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7274,7 +7274,25 @@ static struct {
 
 static inline int find_new_ilb(int call_cpu)
 {
+	struct sched_domain *sd;
 	int ilb = cpumask_first(nohz.idle_cpus_mask);
+	int buddy = per_cpu(sd_pack_buddy, call_cpu);
+
+	/*
+	 * If we have a pack buddy CPU, we try to run load balance on a CPU
+	 * that is close to the buddy.
+	 */
+	if (buddy != -1)
+		for_each_domain(buddy, sd) {
+			if (sd->flags & SD_SHARE_CPUPOWER)
+				continue;
+
+			ilb = cpumask_first_and(sched_domain_span(sd),
+					nohz.idle_cpus_mask);
+
+			if (ilb < nr_cpu_ids)
+				break;
+		}
 
 	if (ilb < nr_cpu_ids && idle_cpu(ilb))
 		return ilb;
-- 
1.7.9.5
