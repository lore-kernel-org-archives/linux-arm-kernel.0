From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 14 May 2014 15:30:51 -0700
Subject: [RFC PATCH 1/5] cpufreq: stats: Allow small rounding errors
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1400106655-22465-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When matching a frequency against the freq_table, allow small deviances to
allow rounding errors. Rounding errors are likely to occur due to the
differenct frequency resolutions used in the common clock vs cpufreq
frameworks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index ecaaebf969fc..37a34178ab3a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -146,7 +146,7 @@ static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
 {
 	int index;
 	for (index = 0; index < stat->max_state; index++)
-		if (stat->freq_table[index] == freq)
+		if (abs(stat->freq_table[index] - freq) < 2)
 			return index;
 	return -1;
 }
-- 
1.9.3.1.ga73a6ad
