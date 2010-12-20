From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Dec 2010 21:31:33 +0530
Subject: [PATCH v5 1/2] davinci: am18x/da850/omap-l138: add support for higher
	speed grades
Message-ID: <1292860894-3961-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM18x/DA850/OMAP-L138 SoCs have variants that can operate
at a maximum of 456 MHz at 1.3V operating point. Also the
1.2V operating point has a variant that can support a maximum
of 375 MHz.

This patch adds three new OPPs (456 MHz, 408 MHz and 372 MHz)
to the list of DA850 OPPs.

Not all silicon is qualified to run at higher speeds and
unfortunately the maximum speed the chip can support can only
be determined from the label on the package (not software
readable).

Because of this, we depend on the maximum speed grade information
to be provided to us in some board specific way. The board informs
the maximum speed grade information by setting the da850_max_speed
variable.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Since v4, the patch decription has been updated to match the code.
No code change has been made.

 arch/arm/mach-davinci/da850.c              |   75 ++++++++++++++++++++++------
 arch/arm/mach-davinci/include/mach/da8xx.h |    7 +++
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 63916b9..78b5ae2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -830,8 +830,7 @@ static void da850_set_async3_src(int pllnum)
  * According to the TRM, minimum PLLM results in maximum power savings.
  * The OPP definitions below should keep the PLLM as low as possible.
  *
- * The output of the PLLM must be between 400 to 600 MHz.
- * This rules out prediv of anything but divide-by-one for 24Mhz OSC input.
+ * The output of the PLLM must be between 300 to 600 MHz.
  */
 struct da850_opp {
 	unsigned int	freq;	/* in KHz */
@@ -842,6 +841,33 @@ struct da850_opp {
 	unsigned int	cvdd_max; /* in uV */
 };
 
+static const struct da850_opp da850_opp_456 = {
+	.freq		= 456000,
+	.prediv		= 1,
+	.mult		= 19,
+	.postdiv	= 1,
+	.cvdd_min	= 1300000,
+	.cvdd_max	= 1350000,
+};
+
+static const struct da850_opp da850_opp_408 = {
+	.freq		= 408000,
+	.prediv		= 1,
+	.mult		= 17,
+	.postdiv	= 1,
+	.cvdd_min	= 1300000,
+	.cvdd_max	= 1350000,
+};
+
+static const struct da850_opp da850_opp_372 = {
+	.freq		= 372000,
+	.prediv		= 2,
+	.mult		= 31,
+	.postdiv	= 1,
+	.cvdd_min	= 1200000,
+	.cvdd_max	= 1320000,
+};
+
 static const struct da850_opp da850_opp_300 = {
 	.freq		= 300000,
 	.prediv		= 1,
@@ -876,6 +902,9 @@ static const struct da850_opp da850_opp_96 = {
 	}
 
 static struct cpufreq_frequency_table da850_freq_table[] = {
+	OPP(456),
+	OPP(408),
+	OPP(372),
 	OPP(300),
 	OPP(200),
 	OPP(96),
@@ -886,6 +915,19 @@ static struct cpufreq_frequency_table da850_freq_table[] = {
 };
 
 #ifdef CONFIG_REGULATOR
+static int da850_set_voltage(unsigned int index);
+static int da850_regulator_init(void);
+#endif
+
+static struct davinci_cpufreq_config cpufreq_info = {
+	.freq_table = da850_freq_table,
+#ifdef CONFIG_REGULATOR
+	.init = da850_regulator_init,
+	.set_voltage = da850_set_voltage,
+#endif
+};
+
+#ifdef CONFIG_REGULATOR
 static struct regulator *cvdd;
 
 static int da850_set_voltage(unsigned int index)
@@ -895,7 +937,7 @@ static int da850_set_voltage(unsigned int index)
 	if (!cvdd)
 		return -ENODEV;
 
-	opp = (struct da850_opp *) da850_freq_table[index].index;
+	opp = (struct da850_opp *) cpufreq_info.freq_table[index].index;
 
 	return regulator_set_voltage(cvdd, opp->cvdd_min, opp->cvdd_max);
 }
@@ -912,14 +954,6 @@ static int da850_regulator_init(void)
 }
 #endif
 
-static struct davinci_cpufreq_config cpufreq_info = {
-	.freq_table = &da850_freq_table[0],
-#ifdef CONFIG_REGULATOR
-	.init = da850_regulator_init,
-	.set_voltage = da850_set_voltage,
-#endif
-};
-
 static struct platform_device da850_cpufreq_device = {
 	.name			= "cpufreq-davinci",
 	.dev = {
@@ -928,12 +962,22 @@ static struct platform_device da850_cpufreq_device = {
 	.id = -1,
 };
 
+unsigned int da850_max_speed = 300000;
+
 int __init da850_register_cpufreq(char *async_clk)
 {
+	int i;
+
 	/* cpufreq driver can help keep an "async" clock constant */
 	if (async_clk)
 		clk_add_alias("async", da850_cpufreq_device.name,
 							async_clk, NULL);
+	for (i = 0; i < ARRAY_SIZE(da850_freq_table); i++) {
+		if (da850_freq_table[i].frequency <= da850_max_speed) {
+			cpufreq_info.freq_table = &da850_freq_table[i];
+			break;
+		}
+	}
 
 	return platform_device_register(&da850_cpufreq_device);
 }
@@ -942,17 +986,18 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	int i, ret = 0, diff;
 	unsigned int best = (unsigned int) -1;
+	struct cpufreq_frequency_table *table = cpufreq_info.freq_table;
 
 	rate /= 1000; /* convert to kHz */
 
-	for (i = 0; da850_freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		diff = da850_freq_table[i].frequency - rate;
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		diff = table[i].frequency - rate;
 		if (diff < 0)
 			diff = -diff;
 
 		if (diff < best) {
 			best = diff;
-			ret = da850_freq_table[i].frequency;
+			ret = table[i].frequency;
 		}
 	}
 
@@ -973,7 +1018,7 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
 	struct pll_data *pll = clk->pll_data;
 	int ret;
 
-	opp = (struct da850_opp *) da850_freq_table[index].index;
+	opp = (struct da850_opp *) cpufreq_info.freq_table[index].index;
 	prediv = opp->prediv;
 	mult = opp->mult;
 	postdiv = opp->postdiv;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 4247b3f..e7f9520 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -28,6 +28,13 @@ extern void __iomem *da8xx_syscfg0_base;
 extern void __iomem *da8xx_syscfg1_base;
 
 /*
+ * If the DA850/OMAP-L138/AM18x SoC on board is of a higher speed grade
+ * (than the regular 300Mhz variant), the board code should set this up
+ * with the supported speed before calling da850_register_cpufreq().
+ */
+extern unsigned int da850_max_speed;
+
+/*
  * The cp_intc interrupt controller for the da8xx isn't in the same
  * chunk of physical memory space as the other registers (like it is
  * on the davincis) so it needs to be mapped separately.  It will be
-- 
1.7.3.2
