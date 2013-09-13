From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:52 +0530
Subject: [PATCH 106/228] cpufreq: integrator: don't initialize part of policy
 that is set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <6d8d406ebca886e5147191cc8c333d926ef9eb30.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/integrator-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index 8152a9b..babf3e4 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -181,10 +181,9 @@ static int integrator_cpufreq_init(struct cpufreq_policy *policy)
 {
 
 	/* set default policy and cpuinfo */
-	policy->cpuinfo.max_freq = 160000;
-	policy->cpuinfo.min_freq = 12000;
+	policy->max = policy->cpuinfo.max_freq = 160000;
+	policy->min = policy->cpuinfo.min_freq = 12000;
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms, assumed */
-	policy->cur = policy->min = policy->max = integrator_get(policy->cpu);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
