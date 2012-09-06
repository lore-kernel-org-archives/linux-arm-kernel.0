From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu,  6 Sep 2012 15:10:24 +0800
Subject: [PATCH] cpufreq: OMAP: remove redundant loops_per_jiffy code
Message-ID: <1346915424-25868-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM smp common code updating loops_per_jiffy in a cpufreq
transiton notifier call, the loops_per_jiffy code in omap-cpufreq
driver becomes redundant.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   35 -----------------------------------
 1 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 17fa04d..83a78ad 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -40,16 +40,6 @@
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 
-#ifdef CONFIG_SMP
-struct lpj_info {
-	unsigned long	ref;
-	unsigned int	freq;
-};
-
-static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
-static struct lpj_info global_lpj_ref;
-#endif
-
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
@@ -161,31 +151,6 @@ static int omap_target(struct cpufreq_policy *policy,
 	}
 
 	freqs.new = omap_getspeed(policy->cpu);
-#ifdef CONFIG_SMP
-	/*
-	 * Note that loops_per_jiffy is not updated on SMP systems in
-	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
-	 * on frequency transition. We need to update all dependent CPUs.
-	 */
-	for_each_cpu(i, policy->cpus) {
-		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
-		if (!lpj->freq) {
-			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
-			lpj->freq = freqs.old;
-		}
-
-		per_cpu(cpu_data, i).loops_per_jiffy =
-			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
-	}
-
-	/* And don't forget to adjust the global one */
-	if (!global_lpj_ref.freq) {
-		global_lpj_ref.ref = loops_per_jiffy;
-		global_lpj_ref.freq = freqs.old;
-	}
-	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
-					freqs.new);
-#endif
 
 done:
 	/* notifiers */
-- 
1.7.5.4
