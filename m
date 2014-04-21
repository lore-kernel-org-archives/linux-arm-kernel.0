From: stratosk@semaphore.gr (Stratos Karafotis)
Date: Mon, 21 Apr 2014 18:35:52 +0300
Subject: [PATCH v3 3/8] ARM: davinci: da850: Use cpufreq_for_each_entry macro
 for iteration
Message-ID: <53553AD8.5080901@semaphore.gr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core now supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---

Changes v2 -> v3
	- Added 'ARM' prefix in the subject as Sekhar Nori suggested.

 arch/arm/mach-davinci/da850.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 85399c9..45ce065 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1092,20 +1092,21 @@ int da850_register_cpufreq(char *async_clk)
 
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
-	int i, ret = 0, diff;
+	int ret = 0, diff;
 	unsigned int best = (unsigned int) -1;
 	struct cpufreq_frequency_table *table = cpufreq_info.freq_table;
+	struct cpufreq_frequency_table *pos;
 
 	rate /= 1000; /* convert to kHz */
 
-	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		diff = table[i].frequency - rate;
+	cpufreq_for_each_entry(pos, table) {
+		diff = pos->frequency - rate;
 		if (diff < 0)
 			diff = -diff;
 
 		if (diff < best) {
 			best = diff;
-			ret = table[i].frequency;
+			ret = pos->frequency;
 		}
 	}
 
-- 
1.9.0
