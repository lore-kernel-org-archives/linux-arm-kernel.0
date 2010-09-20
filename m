From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 19 Sep 2010 20:10:12 -0400
Subject: [PATCH 1/2] ARM: pxa: reduce the scope of get_clk_frequency_khz()
Message-ID: <1284941413-28103-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_clk_frequency_khz() is used in private cpufreq driver. In order to meet
the change of different pxa silicons, checking cpuid is introduced in
get_clk_frequency_khz(). While more pxa silicons are supported, the workload
of checking cpuid is higher.

So restrict the scope of get_clk_frequency_khz() on pxa2xx. Different pxa
silcions use different private cpufreq driver to avoid too much checking
on cpuid.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa3xx.c |    5 +++--
 arch/arm/mach-pxa/generic.c        |    3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index 27fa329..9edd9cd 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -159,7 +159,7 @@ static int pxa3xx_cpufreq_verify(struct cpufreq_policy *policy)
 
 static unsigned int pxa3xx_cpufreq_get(unsigned int cpu)
 {
-	return get_clk_frequency_khz(0);
+	return pxa3xx_get_clk_frequency_khz(0);
 }
 
 static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
@@ -212,7 +212,8 @@ static __init int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = 104000;
 	policy->cpuinfo.max_freq = (cpu_is_pxa320()) ? 806000 : 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
-	policy->cur = policy->min = policy->max = get_clk_frequency_khz(0);
+	policy->max = pxa3xx_get_clk_frequency_khz(0);
+	policy->cur = policy->min = policy->max;
 
 	if (cpu_is_pxa300() || cpu_is_pxa310())
 		ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa300_freqs));
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index baabb3c..6655dea 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -66,8 +66,7 @@ unsigned int get_clk_frequency_khz(int info)
 		return pxa25x_get_clk_frequency_khz(info);
 	else if (cpu_is_pxa27x())
 		return pxa27x_get_clk_frequency_khz(info);
-	else
-		return pxa3xx_get_clk_frequency_khz(info);
+	return 0;
 }
 EXPORT_SYMBOL(get_clk_frequency_khz);
 
-- 
1.5.6.5
