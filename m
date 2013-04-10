From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Apr 2013 15:06:15 +0200
Subject: [PATCH] cpufreq: dbx500: Round to closest available freq
Message-ID: <1365599175-22361-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mats Fagerstrom <mats.fagerstrom@stericsson.com>

When reading the cpu speed, round it to the closest available
frequency from the table.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Mats Fagerstrom <mats.fagerstrom@stericsson.com>
---
 drivers/cpufreq/dbx500-cpufreq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 15ed367..6ec6539 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -71,15 +71,15 @@ static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
 	int i = 0;
 	unsigned long freq = clk_get_rate(armss_clk) / 1000;
 
-	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
-		if (freq <= freq_table[i].frequency)
+	/* The value is rounded to closest frequency in the defined table. */
+	while (freq_table[i + 1].frequency != CPUFREQ_TABLE_END) {
+		if (freq < freq_table[i].frequency +
+		   (freq_table[i + 1].frequency - freq_table[i].frequency) / 2)
 			return freq_table[i].frequency;
 		i++;
 	}
 
-	/* We could not find a corresponding frequency. */
-	pr_err("dbx500-cpufreq: Failed to find cpufreq speed\n");
-	return 0;
+	return freq_table[i].frequency;
 }
 
 static int __cpuinit dbx500_cpufreq_init(struct cpufreq_policy *policy)
-- 
1.7.10
