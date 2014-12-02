From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Dec 2014 17:48:02 +0100
Subject: [PATCH] ARM: mvebu: use the cpufreq-dt platform_data for independent
 clocks
Message-ID: <1417538882-19254-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adjusts the registration of the cpufreq-dt driver in the
mvebu platform to indicate to the cpufreq driver that the platform has
independent clocks for each CPU.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, this commit was part of my "[PATCHv2 0/4] cpufreq-dt,
platform_data based proposal" series, which included 3 patches for
drivers/cpufreq/, and this last patch for mach-mvebu to make use of
the new cpufreq feature. However, in order to not confuse the cpufreq
maintainer, when I sent "[PATCH v3 0/3] cpufreq: cpufreq-dt:
platform_data based proposal", I didn't include this patch for
mach-mvebu.

But now, it means that this is the only missing piece to get cpufreq
working on Armada XP. Do you think you could squeeze it into the
things merged for 3.19 ? It's a very small patch, so hopefully it's
still possible to do so.

The patch is based on mvebu/soc.
---
 arch/arm/mach-mvebu/pmsu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 5a757f9..d8ab605 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpufreq-dt.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -571,6 +572,10 @@ int mvebu_pmsu_dfs_request(int cpu)
 	return 0;
 }
 
+struct cpufreq_dt_platform_data cpufreq_dt_pd = {
+	.independent_clocks = true,
+};
+
 static int __init armada_xp_pmsu_cpufreq_init(void)
 {
 	struct device_node *np;
@@ -643,7 +648,8 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 	}
 
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	platform_device_register_data(NULL, "cpufreq-dt", -1,
+				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
 	return 0;
 }
 
-- 
2.1.0
