From: ben@smart-cactus.org (Ben Gamari)
Date: Wed,  2 Dec 2015 22:19:26 +0100
Subject: [PATCH 11/12] cpufreq: arm-big-little: clarify frequency units
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Message-ID: <1449091167-20758-12-git-send-email-ben@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frequency units are very confusing in this area as OPPs use Hz
whereas cpufreq uses kHz. Be explicit about this in variable naming.

Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 drivers/cpufreq/arm_big_little.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 855599b..2d5761c 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -130,14 +130,14 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 }
 
 static int
-bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
+bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
 {
 	unsigned long volt = 0, volt_old = 0;
 	long freq_Hz;
 	u32 old_rate;
 	int ret;
 
-	freq_Hz = new_rate * 1000;
+	freq_Hz = new_rate_kHz * 1000;
 	old_rate = clk_get_rate(clk[cluster]) / 1000;
 
 	if (!IS_ERR(reg[cluster])) {
@@ -163,10 +163,10 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
 		__func__, cpu, cluster,
 		old_rate / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
-		new_rate / 1000, volt ? volt / 1000 : -1);
+		new_rate_kHz / 1000, volt ? volt / 1000 : -1);
 
 	/* scaling up? scale voltage before frequency */
-	if (!IS_ERR(reg[cluster]) && new_rate > old_rate) {
+	if (!IS_ERR(reg[cluster]) && new_rate_kHz > old_rate) {
 		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
 		if (ret) {
 			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage up: %d\n",
@@ -175,7 +175,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 		}
 	}
 
-	ret = clk_set_rate(clk[cluster], new_rate * 1000);
+	ret = clk_set_rate(clk[cluster], new_rate_kHz * 1000);
 	if (WARN_ON(ret)) {
 		pr_err("%s: clk_set_rate failed: %d, cluster: %d\n",
 			__func__, cluster, ret);
@@ -185,7 +185,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 	}
 
 	/* scaling down? scale voltage after frequency */
-	if (!IS_ERR(reg[cluster]) && new_rate < old_rate) {
+	if (!IS_ERR(reg[cluster]) && new_rate_kHz < old_rate) {
 		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
 		if (ret) {
 			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage down: %d\n",
@@ -199,7 +199,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 }
 
 static unsigned int
-bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
+bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate_kHz)
 {
 	u32 new_rate, prev_rate;
 	int ret;
@@ -209,13 +209,13 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 
 	if (bLs) {
 		prev_rate = per_cpu(cpu_last_req_freq, cpu);
-		per_cpu(cpu_last_req_freq, cpu) = rate;
+		per_cpu(cpu_last_req_freq, cpu) = rate_kHz;
 		per_cpu(physical_cluster, cpu) = new_cluster;
 
 		new_rate = find_cluster_maxfreq(new_cluster);
 		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
 	} else {
-		new_rate = rate;
+		new_rate = rate_kHz;
 	}
 
 	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
@@ -236,7 +236,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	} else if (ret && bLs) {
 		per_cpu(cpu_last_req_freq, cpu) = prev_rate;
 		per_cpu(physical_cluster, cpu) = old_cluster;
-	} 
+	}
 
 	mutex_unlock(&cluster_lock[new_cluster]);
 
-- 
2.6.2
