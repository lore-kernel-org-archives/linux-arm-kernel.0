From: stratosk@semaphore.gr (Stratos Karafotis)
Date: Tue, 15 Apr 2014 00:09:10 +0300
Subject: [PATCH 07/20] cpufreq: exynos: Use cpufreq_for_each_entry macro for
 iteration
Message-ID: <534C4E76.6000905@semaphore.gr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/exynos-cpufreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index f99cfe2..0e19bce 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -28,18 +28,18 @@ static unsigned int locking_frequency;
 
 static int exynos_cpufreq_get_index(unsigned int freq)
 {
-	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
-	int index;
+	struct cpufreq_frequency_table *pos, *freq_table;
 
-	for (index = 0;
-		freq_table[index].frequency != CPUFREQ_TABLE_END; index++)
-		if (freq_table[index].frequency == freq)
+	freq_table = exynos_info->freq_table;
+	cpufreq_for_each_entry(pos, freq_table) {
+		if (pos->frequency == freq)
 			break;
+	}
 
-	if (freq_table[index].frequency == CPUFREQ_TABLE_END)
+	if (pos->frequency == CPUFREQ_TABLE_END)
 		return -EINVAL;
 
-	return index;
+	return pos - freq_table;
 }
 
 static int exynos_cpufreq_scale(unsigned int target_freq)
-- 
1.9.0
