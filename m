From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 30 Jun 2014 18:05:35 +0200
Subject: [PATCH v3 04/12] sched: Allow all archs to set the power_orig
In-Reply-To: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1404144343-18720-5-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

power_orig is only changed for system with a SMT sched_domain level in order to
reflect the lower capacity of CPUs. Heterogenous system also have to reflect an
original capacity that is different from the default value.

Create a more generic function arch_scale_cpu_power that can be also used by
non SMT platform to set power_orig.

The weak behavior of arch_scale_cpu_power is the previous SMT one in order to
keep backward compatibility in the use of power_orig.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 148b277..f0bba5f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5614,6 +5614,20 @@ unsigned long __weak arch_scale_smt_capacity(struct sched_domain *sd, int cpu)
 	return default_scale_smt_capacity(sd, cpu);
 }
 
+unsigned long __weak arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	unsigned long weight = sd->span_weight;
+
+	if ((sd->flags & SD_SHARE_CPUCAPACITY) && weight > 1) {
+		if (sched_feat(ARCH_CAPACITY))
+			return arch_scale_smt_capacity(sd, cpu);
+		else
+			return default_scale_smt_capacity(sd, cpu);
+	}
+
+	return SCHED_CAPACITY_SCALE;
+}
+
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -5650,18 +5664,12 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long weight = sd->span_weight;
 	unsigned long capacity = SCHED_CAPACITY_SCALE;
 	struct sched_group *sdg = sd->groups;
 
-	if ((sd->flags & SD_SHARE_CPUCAPACITY) && weight > 1) {
-		if (sched_feat(ARCH_CAPACITY))
-			capacity *= arch_scale_smt_capacity(sd, cpu);
-		else
-			capacity *= default_scale_smt_capacity(sd, cpu);
+	capacity *= arch_scale_cpu_capacity(sd, cpu);
 
-		capacity >>= SCHED_CAPACITY_SHIFT;
-	}
+	capacity >>= SCHED_CAPACITY_SHIFT;
 
 	sdg->sgc->capacity_orig = capacity;
 
-- 
1.9.1
