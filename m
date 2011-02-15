From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 16 Feb 2011 00:20:49 +0800
Subject: [PATCH] ARM: pxa: support 806MHz operating points for PXA31x
	processors A2 stepping
Message-ID: <1297786849.2596.13.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA3xx Specification Update document states that the 806MHz
operating points were added for PXA31x processors A2 stepping.

This patch adds 806MHz operating points support for PXA31x A2 stepping.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

I cannot find any details for PXA31x stepping B1 and B2,
thus I made this patch for PXA31x stepping A2 only.

Axel

 arch/arm/mach-pxa/cpufreq-pxa3xx.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index 88fbec0..f4f0c2e 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -210,15 +210,30 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 
 	/* set default policy and cpuinfo */
 	policy->cpuinfo.min_freq = 104000;
-	policy->cpuinfo.max_freq = (cpu_is_pxa320()) ? 806000 : 624000;
+
+	if (cpu_is_pxa300())
+		policy->cpuinfo.max_freq = 624000;
+	else if (cpu_is_pxa310())
+		policy->cpuinfo.max_freq = ((read_cpuid_id() & 0xf) == 0x2) ?
+						806000 : 624000;
+	else if (cpu_is_pxa320())
+		policy->cpuinfo.max_freq = 806000;
+
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 	policy->max = pxa3xx_get_clk_frequency_khz(0);
 	policy->cur = policy->min = policy->max;
 
-	if (cpu_is_pxa300() || cpu_is_pxa310())
+	if (cpu_is_pxa300())
 		ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa300_freqs));
-
-	if (cpu_is_pxa320())
+	else if (cpu_is_pxa310())
+		/* PXA310 A2 STEPPING supports 806Mhz operating points */
+		if ((read_cpuid_id() & 0xf) == 0x2)
+			ret = setup_freqs_table(policy,
+						ARRAY_AND_SIZE(pxa320_freqs));
+		else
+			ret = setup_freqs_table(policy,
+						ARRAY_AND_SIZE(pxa300_freqs));
+	else if (cpu_is_pxa320())
 		ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa320_freqs));
 
 	if (ret) {
-- 
1.7.2
