From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Sep 2012 16:16:54 +0200
Subject: [PATCH 4/4] cpufreq: db8500: Fetch cpufreq table from platform data
In-Reply-To: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1348841814-13645-5-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By fetching the table as platform data we do not need the internally
hardcoded cpufreq table anymore.

Moreover the corresponding arm_opp idx2opp table, used for mapping
frequency to correct opp bits is also removed. This due to that the
opp bits is put directly in the index field of the cpufreq table.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/db8500-cpufreq.c |   67 ++++++++++++++------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 7d61a6c..dea9a49 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -17,36 +17,7 @@
 #include <linux/mfd/dbx500-prcmu.h>
 #include <mach/id.h>
 
-static struct cpufreq_frequency_table freq_table[] = {
-	[0] = {
-		.index = 0,
-		.frequency = 200000,
-	},
-	[1] = {
-		.index = 1,
-		.frequency = 400000,
-	},
-	[2] = {
-		.index = 2,
-		.frequency = 800000,
-	},
-	[3] = {
-		/* Used for MAX_OPP, if available */
-		.index = 3,
-		.frequency = CPUFREQ_TABLE_END,
-	},
-	[4] = {
-		.index = 4,
-		.frequency = CPUFREQ_TABLE_END,
-	},
-};
-
-static enum arm_opp idx2opp[] = {
-	ARM_EXTCLK,
-	ARM_50_OPP,
-	ARM_100_OPP,
-	ARM_MAX_OPP
-};
+static struct cpufreq_frequency_table *freq_table;
 
 static struct freq_attr *db8500_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
@@ -88,7 +59,7 @@ static int db8500_cpufreq_target(struct cpufreq_policy *policy,
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	/* request the PRCM unit for opp change */
-	if (prcmu_set_arm_opp(idx2opp[idx])) {
+	if (prcmu_set_arm_opp(freq_table[idx].index)) {
 		pr_err("db8500-cpufreq:  Failed to set OPP level\n");
 		return -EINVAL;
 	}
@@ -102,25 +73,30 @@ static int db8500_cpufreq_target(struct cpufreq_policy *policy,
 
 static unsigned int db8500_cpufreq_getspeed(unsigned int cpu)
 {
-	int i;
+	int i = 0;
 	/* request the prcm to get the current ARM opp */
-	for (i = 0; prcmu_get_arm_opp() != idx2opp[i]; i++)
-		;
-	return freq_table[i].frequency;
+	int opp = prcmu_get_arm_opp();
+
+	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
+		if (opp == freq_table[i].index)
+			return freq_table[i].frequency;
+		i++;
+	}
+
+	/* We could not find a corresponding opp frequency. */
+	return 0;
 }
 
 static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int i, res;
-
-	BUILD_BUG_ON(ARRAY_SIZE(idx2opp) + 1 != ARRAY_SIZE(freq_table));
-
-	if (prcmu_has_arm_maxopp())
-		freq_table[3].frequency = 1000000;
+	int i = 0;
+	int res;
 
 	pr_info("db8500-cpufreq : Available frequencies:\n");
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
+	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
 		pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
+		i++;
+	}
 
 	/* get policy fields based on the table */
 	res = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -163,6 +139,13 @@ static struct cpufreq_driver db8500_cpufreq_driver = {
 
 static int db8500_cpufreq_probe(struct platform_device *pdev)
 {
+	freq_table = dev_get_platdata(&pdev->dev);
+
+	if (!freq_table) {
+		pr_err("db8500-cpufreq: Failed to fetch cpufreq table\n");
+		return -ENODEV;
+	}
+
 	return cpufreq_register_driver(&db8500_cpufreq_driver);
 }
 
-- 
1.7.10
