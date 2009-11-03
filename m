From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  3 Nov 2009 14:42:11 +0000
Subject: [PATCH 8/9] S3C64XX: Separate out regulator and frequency latencies
In-Reply-To: <1257259332-7867-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1257259332-7867-8-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the transition latency reported by the S3C64xx cpufreq
driver includes both the time for the CPU to reclock itself and
the time for a regulator to change voltage. This means that if
a regulator is not in use then the transition latency reported
is excessively high.

In future the regulator API will be extended to report latencies
so the driver will be able to query the performance of a given
regulator.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/cpufreq.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/cpufreq.c b/arch/arm/plat-s3c64xx/cpufreq.c
index bdc3c96..61276bf 100644
--- a/arch/arm/plat-s3c64xx/cpufreq.c
+++ b/arch/arm/plat-s3c64xx/cpufreq.c
@@ -19,6 +19,7 @@
 
 static struct clk *armclk;
 static struct regulator *vddarm;
+static unsigned long regulator_latency;
 
 #ifdef CONFIG_CPU_S3C6410
 struct s3c64xx_dvfs {
@@ -141,7 +142,7 @@ err:
 }
 
 #ifdef CONFIG_REGULATOR
-static void __init s3c64xx_cpufreq_constrain_voltages(void)
+static void __init s3c64xx_cpufreq_config_regulator(void)
 {
 	int count, v, i, found;
 	struct cpufreq_frequency_table *freq;
@@ -150,11 +151,10 @@ static void __init s3c64xx_cpufreq_constrain_voltages(void)
 	count = regulator_count_voltages(vddarm);
 	if (count < 0) {
 		pr_err("cpufreq: Unable to check supported voltages\n");
-		return;
 	}
 
 	freq = s3c64xx_freq_table;
-	while (freq->frequency != CPUFREQ_TABLE_END) {
+	while (count > 0 && freq->frequency != CPUFREQ_TABLE_END) {
 		if (freq->frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
@@ -175,6 +175,10 @@ static void __init s3c64xx_cpufreq_constrain_voltages(void)
 
 		freq++;
 	}
+
+	/* Guess based on having to do an I2C/SPI write; in future we
+	 * will be able to query the regulator performance here. */
+	regulator_latency = 1 * 1000 * 1000;
 }
 #endif
 
@@ -206,7 +210,7 @@ static int __init s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		pr_err("cpufreq: Only frequency scaling available\n");
 		vddarm = NULL;
 	} else {
-		s3c64xx_cpufreq_constrain_voltages();
+		s3c64xx_cpufreq_config_regulator();
 	}
 #endif
 
@@ -233,9 +237,11 @@ static int __init s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 
 	policy->cur = clk_get_rate(armclk) / 1000;
 
-	/* Pick a conservative guess in ns: we'll need ~1 I2C/SPI
-	 * write plus clock reprogramming. */
-	policy->cpuinfo.transition_latency = 2 * 1000 * 1000;
+	/* Datasheet says PLL stabalisation time (if we were to use
+	 * the PLLs, which we don't currently) is ~300us worst case,
+	 * but add some fudge.
+	 */
+	policy->cpuinfo.transition_latency = (500 * 1000) + regulator_latency;
 
 	ret = cpufreq_frequency_table_cpuinfo(policy, s3c64xx_freq_table);
 	if (ret != 0) {
-- 
1.6.5.2
