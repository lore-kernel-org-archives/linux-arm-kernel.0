From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 22 Dec 2011 15:09:08 +0800
Subject: [PATCH v4 2/7] arm/imx: cpufreq: remove loops_per_jiffy recalculate
 for smp
In-Reply-To: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1324537753-30590-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm registered cpufreq transition notifier to recalculate it.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/cpufreq.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index c937e75..364793a 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -99,16 +99,6 @@ static int mxc_set_target(struct cpufreq_policy *policy,
 
 	ret = set_cpu_freq(freq_Hz);
 
-#ifdef CONFIG_SMP
-	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
-	 * So update it for all CPUs.
-	 */
-	for_each_possible_cpu(cpu)
-		per_cpu(cpu_data, cpu).loops_per_jiffy =
-		cpufreq_scale(per_cpu(cpu_data, cpu).loops_per_jiffy,
-					freqs.old, freqs.new);
-#endif
-
 	for_each_possible_cpu(cpu) {
 		freqs.cpu = cpu;
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-- 
1.7.5.4
