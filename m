From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Oct 2012 13:42:26 +0200
Subject: [PATCH 5/8] mfd: db8500: Connect ARMSS clk to ARM OPP
In-Reply-To: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349869349-8070-6-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

ARMSS clk directly maps it's frequency towards the cpufreq table.
To be able to update the ARMSS clk rate, a new set_rate function for
the ARMSS clk is added, which also will trigger a corresponding ARM
OPP request. Additionally an ARMSS clk round_rate function is added
to fetch valid cpufreq frequencies.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |   78 +++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 53c24c4..e91a6e6 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -421,9 +421,6 @@ static struct {
 
 static atomic_t ac_wake_req_state = ATOMIC_INIT(0);
 
-/* Functions definition */
-static void compute_armss_rate(void);
-
 /* Spinlocks */
 static DEFINE_SPINLOCK(prcmu_lock);
 static DEFINE_SPINLOCK(clkout_lock);
@@ -1020,7 +1017,6 @@ int db8500_prcmu_set_arm_opp(u8 opp)
 		(mb1_transfer.ack.arm_opp != opp))
 		r = -EIO;
 
-	compute_armss_rate();
 	mutex_unlock(&mb1_transfer.lock);
 
 	return r;
@@ -1670,13 +1666,8 @@ static unsigned long clock_rate(u8 clock)
 	else
 		return 0;
 }
-static unsigned long latest_armss_rate;
-static unsigned long armss_rate(void)
-{
-	return latest_armss_rate;
-}
 
-static void compute_armss_rate(void)
+static unsigned long armss_rate(void)
 {
 	u32 r;
 	unsigned long rate;
@@ -1701,7 +1692,7 @@ static void compute_armss_rate(void)
 		rate = pll_rate(PRCM_PLLARM_FREQ, ROOT_CLOCK_RATE, PLL_DIV);
 	}
 
-	latest_armss_rate = rate;
+	return rate;
 }
 
 static unsigned long dsiclk_rate(u8 n)
@@ -1821,6 +1812,35 @@ static long round_clock_rate(u8 clock, unsigned long rate)
 	return rounded_rate;
 }
 
+/* CPU FREQ table, may be changed due to if MAX_OPP is supported. */
+static struct cpufreq_frequency_table db8500_cpufreq_table[] = {
+	{ .frequency = 200000, .index = ARM_EXTCLK,},
+	{ .frequency = 400000, .index = ARM_50_OPP,},
+	{ .frequency = 800000, .index = ARM_100_OPP,},
+	{ .frequency = CPUFREQ_TABLE_END,}, /* To be used for MAX_OPP. */
+	{ .frequency = CPUFREQ_TABLE_END,},
+};
+
+static long round_armss_rate(unsigned long rate)
+{
+	long freq = 0;
+	int i = 0;
+
+	/* cpufreq table frequencies is in KHz. */
+	rate = rate / 1000;
+
+	/* Find the corresponding arm opp from the cpufreq table. */
+	while (db8500_cpufreq_table[i].frequency != CPUFREQ_TABLE_END) {
+		freq = db8500_cpufreq_table[i].frequency;
+		if (freq == rate)
+			break;
+		i++;
+	}
+
+	/* Return the last valid value, even if a match was not found. */
+	return freq * 1000;
+}
+
 #define MIN_PLL_VCO_RATE 600000000ULL
 #define MAX_PLL_VCO_RATE 1680640000ULL
 
@@ -1892,6 +1912,8 @@ long prcmu_round_clock_rate(u8 clock, unsigned long rate)
 {
 	if (clock < PRCMU_NUM_REG_CLOCKS)
 		return round_clock_rate(clock, rate);
+	else if (clock == PRCMU_ARMSS)
+		return round_armss_rate(rate);
 	else if (clock == PRCMU_PLLDSI)
 		return round_plldsi_rate(rate);
 	else if ((clock == PRCMU_DSI0CLK) || (clock == PRCMU_DSI1CLK))
@@ -1951,6 +1973,27 @@ static void set_clock_rate(u8 clock, unsigned long rate)
 	spin_unlock_irqrestore(&clk_mgt_lock, flags);
 }
 
+static int set_armss_rate(unsigned long rate)
+{
+	int i = 0;
+
+	/* cpufreq table frequencies is in KHz. */
+	rate = rate / 1000;
+
+	/* Find the corresponding arm opp from the cpufreq table. */
+	while (db8500_cpufreq_table[i].frequency != CPUFREQ_TABLE_END) {
+		if (db8500_cpufreq_table[i].frequency == rate)
+			break;
+		i++;
+	}
+
+	if (db8500_cpufreq_table[i].frequency != rate)
+		return -EINVAL;
+
+	/* Set the new arm opp. */
+	return db8500_prcmu_set_arm_opp(db8500_cpufreq_table[i].index);
+}
+
 static int set_plldsi_rate(unsigned long rate)
 {
 	unsigned long src_rate;
@@ -2031,6 +2074,8 @@ int prcmu_set_clock_rate(u8 clock, unsigned long rate)
 {
 	if (clock < PRCMU_NUM_REG_CLOCKS)
 		set_clock_rate(clock, rate);
+	else if (clock == PRCMU_ARMSS)
+		return set_armss_rate(rate);
 	else if (clock == PRCMU_PLLDSI)
 		return set_plldsi_rate(rate);
 	else if ((clock == PRCMU_DSI0CLK) || (clock == PRCMU_DSI1CLK))
@@ -2755,8 +2800,6 @@ void __init db8500_prcmu_early_init(void)
 	init_completion(&mb5_transfer.work);
 
 	INIT_WORK(&mb0_transfer.mask_work, prcmu_mask_work);
-
-	compute_armss_rate();
 }
 
 static void __init init_prcm_registers(void)
@@ -3003,15 +3046,6 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
 	},
 };
 
-/* CPU FREQ table, may be changed due to if MAX_OPP is supported. */
-static struct cpufreq_frequency_table db8500_cpufreq_table[] = {
-	{ .frequency = 200000, .index = ARM_EXTCLK,},
-	{ .frequency = 400000, .index = ARM_50_OPP,},
-	{ .frequency = 800000, .index = ARM_100_OPP,},
-	{ .frequency = CPUFREQ_TABLE_END,}, /* To be used for MAX_OPP. */
-	{ .frequency = CPUFREQ_TABLE_END,},
-};
-
 static struct resource ab8500_resources[] = {
 	[0] = {
 		.start	= IRQ_DB8500_AB8500,
-- 
1.7.10
