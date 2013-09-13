From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:25 +0530
Subject: [PATCH 139/228] cpufreq: pasemi: use cpufreq_generic_init() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <d73e3d98a7adf10f7d84aa5a1e09aa37e6864828.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 16f2508..1cca332 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -204,20 +204,13 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		pr_debug("%d: %d\n", i, pas_freqs[i].frequency);
 	}
 
-	policy->cpuinfo.transition_latency = get_gizmo_latency();
-
 	cur_astate = get_cur_astate(policy->cpu);
 	pr_debug("current astate is at %d\n",cur_astate);
 
 	policy->cur = pas_freqs[cur_astate].frequency;
-	cpumask_copy(policy->cpus, cpu_online_mask);
-
 	ppc_proc_freq = policy->cur * 1000ul;
 
-	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max
-	 * are set correctly
-	 */
-	return cpufreq_table_validate_and_show(policy, pas_freqs);
+	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
 
 out_unmap_sdcpwr:
 	iounmap(sdcpwr_mapbase);
-- 
1.7.12.rc2.18.g61b472e
