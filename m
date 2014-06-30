From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 30 Jun 2014 09:56:34 -0700
Subject: [PATCH 2/4] cpufreq: cpu0: Use clk_find_nearest_rate()
In-Reply-To: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1404147396-8041-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Round clock frequencies to the nearest possible frequency. Since the
OPPs as specified in DT and the CCF use different a resolution for clock
frequencies, the clk_round_rate() API may return unexpected results, due
to not mandating how rounding has to happen. The clk_find_nearest_rate()
API mitigates such issues and finds the appropriate frequency for
an OPP.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/cpufreq/cpufreq-cpu0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ee1ae303a07c..1650581f85b6 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -42,7 +42,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	long freq_Hz, freq_exact;
 	int ret;
 
-	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
+	freq_Hz = clk_find_nearest_rate(cpu_clk,
+			freq_table[index].frequency * 1000);
 	if (freq_Hz <= 0)
 		freq_Hz = freq_table[index].frequency * 1000;
 
-- 
2.0.1.1.gfbfc394
