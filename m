From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 21 Apr 2016 14:29:00 +0530
Subject: [PATCH 08/10] mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP
 tables as shared
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Message-ID: <3808dbeda9c233026ed78fa3ec94c0bbd898875c.1461228504.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That will allow us to avoid using cpufreq-dt platform data.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index ed8fda4cd055..79d0a5d9da8e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -20,7 +20,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu_pm.h>
-#include <linux/cpufreq-dt.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -609,10 +608,6 @@ int mvebu_pmsu_dfs_request(int cpu)
 	return 0;
 }
 
-struct cpufreq_dt_platform_data cpufreq_dt_pd = {
-	.independent_clocks = true,
-};
-
 static int __init armada_xp_pmsu_cpufreq_init(void)
 {
 	struct device_node *np;
@@ -683,10 +678,15 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			clk_put(clk);
 			return ret;
 		}
+
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
+				(struct cpumask *) cpumask_of(cpu_dev->id));
+		if (ret)
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
 	}
 
-	platform_device_register_data(NULL, "cpufreq-dt", -1,
-				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
-- 
2.7.1.410.g6faf27b
