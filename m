From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 28 Mar 2014 14:22:26 +0100
Subject: [RFC 1/4] sched: extend the usage of cpu_power_orig
In-Reply-To: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
References: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1396012949-6227-2-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_power_orig is only changed for SMT system in order to reflect the lower
capacity of CPUs. Heterogenous system also have to reflect an original
capacity that is different from the default value.

Create a more generic function arch_scale_cpu_power that can be also used by
non SMT platform to set cpu_power_orig.

The weak behavior of arch_scale_cpu_power is the previous SMT one in order to
keep backward compatibility in the use of cpu_power_orig.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e9bd0b..ed42061 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5559,6 +5559,20 @@ unsigned long __weak arch_scale_smt_power(struct sched_domain *sd, int cpu)
 	return default_scale_smt_power(sd, cpu);
 }
 
+unsigned long __weak arch_scale_cpu_power(struct sched_domain *sd, int cpu)
+{
+	unsigned long weight = sd->span_weight;
+
+	if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1) {
+		if (sched_feat(ARCH_POWER))
+			return arch_scale_smt_power(sd, cpu);
+		else
+			return default_scale_smt_power(sd, cpu);
+	}
+
+	return SCHED_POWER_SCALE;
+}
+
 static unsigned long scale_rt_power(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -5590,18 +5604,12 @@ static unsigned long scale_rt_power(int cpu)
 
 static void update_cpu_power(struct sched_domain *sd, int cpu)
 {
-	unsigned long weight = sd->span_weight;
 	unsigned long power = SCHED_POWER_SCALE;
 	struct sched_group *sdg = sd->groups;
 
-	if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1) {
-		if (sched_feat(ARCH_POWER))
-			power *= arch_scale_smt_power(sd, cpu);
-		else
-			power *= default_scale_smt_power(sd, cpu);
+	power *= arch_scale_cpu_power(sd, cpu);
 
-		power >>= SCHED_POWER_SHIFT;
-	}
+	power >>= SCHED_POWER_SHIFT;
 
 	sdg->sgp->power_orig = power;
 
-- 
1.9.0
