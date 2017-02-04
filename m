From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sat, 4 Feb 2017 22:04:48 +0100
Subject: [PATCH 2/2] cpufreq: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
Message-ID: <9a4d7b23-3d5b-b8be-142e-76ded75a5ea4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the highest allowed SCPI DVFS clock rate and ignore all OPP's
exceeding this clock rate threshold.
Based on DT settings the highest allowed clock rate may be lower
than the firmware-offered highest clock rate.

This is useful on systems where the firmware offers too optimistic
clock rates causing instabilities and crashes.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index ea7a4e1b..b5148f3b 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -25,6 +25,8 @@
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/types.h>
+#include <linux/of.h>
+#include <linux/clk.h>
 
 #include "arm_big_little.h"
 
@@ -54,6 +56,20 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
 	struct scpi_opp *opp;
 	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
 	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
+	u32 max_freq = UINT_MAX;
+
+	if (cpu_dev->of_node) {
+		struct clk *clk = of_clk_get(cpu_dev->of_node, 0);
+
+		if (!IS_ERR(clk)) {
+			/* find highest supported rate */
+			long tmp = clk_round_rate(clk, UINT_MAX);
+
+			if (tmp > 0)
+				max_freq = tmp;
+			clk_put(clk);
+		}
+	}
 
 	if (IS_ERR(info))
 		return PTR_ERR(info);
@@ -62,6 +78,12 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
 		return -EIO;
 
 	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++) {
+		/* quirk: skip too optimistic firmware-provided rates */
+		if (opp->freq > max_freq) {
+			pr_notice("skip frequency %u\n", opp->freq);
+			continue;
+		}
+
 		ret = dev_pm_opp_add(cpu_dev, opp->freq, opp->m_volt * 1000);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
-- 
2.11.0
