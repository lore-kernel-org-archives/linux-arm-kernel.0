From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Sun,  7 Oct 2012 09:43:57 +0200
Subject: [RFC 5/6] sched: pack the idle load balance
In-Reply-To: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1349595838-31274-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Look for an idle CPU close the pack buddy CPU whenever possible.
The goal is to prevent the wake up of a CPU which doesn't share the power
line of the pack CPU

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6df53b5..f76acdc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5158,7 +5158,25 @@ static struct {
 
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
