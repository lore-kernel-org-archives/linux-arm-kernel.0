From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  5 Dec 2011 18:22:02 +0000
Subject: [PATCH 2/2] [CPUFREQ] s3c64xx: Add VDDINT voltage scaling
In-Reply-To: <1323109322-24130-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323109322-24130-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1323109322-24130-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save a bit more power by scaling VDDINT as well as VDDARM when we have a
regulator for it. Don't worry too much if we don't have one, and just log
errors when scaling as they're unlikely to happen in practice without the
system being in great trouble and proper handling would complicate the
code quite a bit.

The documentation on the operating points is somewhat patchy but I've been
running happily on my systems with the current set of values which is
cobbled together from what I have. One possible issue is that systems
which run with ARMCLK in sync mode seem to need a higher VDDINT. However
these systems would need to explicitly hook up the VDDINT regulator so
the risk to them should be low; I don't have such a system to test on.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index a5e72cb..ca1a249 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -21,20 +21,22 @@
 
 static struct clk *armclk;
 static struct regulator *vddarm;
+static struct regulator *vddint;
 static unsigned long regulator_latency;
 
 #ifdef CONFIG_CPU_S3C6410
 struct s3c64xx_dvfs {
 	unsigned int vddarm_min;
 	unsigned int vddarm_max;
+	unsigned int vddint_min;
 };
 
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
-	[0] = { 1000000, 1150000 },
-	[1] = { 1050000, 1150000 },
-	[2] = { 1100000, 1150000 },
-	[3] = { 1200000, 1350000 },
-	[4] = { 1300000, 1350000 },
+	[0] = { 1000000, 1150000, 1050000 },
+	[1] = { 1050000, 1150000, 1150000 },
+	[2] = { 1100000, 1150000, 1200000 },
+	[3] = { 1200000, 1350000, 1200000 },
+	[4] = { 1300000, 1350000, 1200000 },
 };
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
@@ -107,6 +109,16 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 			       freqs.new, ret);
 			goto err;
 		}
+
+		if (vddint) {
+			ret = regulator_set_voltage(vddint,
+						    dvfs->vddint_min,
+						    13500000);
+			if (ret != 0) {
+				pr_err("Failed to set VDDINT for %dkHz: %d\n",
+				       freqs.new, ret);
+			}
+		}
 	}
 #endif
 
@@ -129,6 +141,16 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 			       freqs.new, ret);
 			goto err_clk;
 		}
+
+		if (vddint) {
+			ret = regulator_set_voltage(vddint,
+						    dvfs->vddint_min,
+						    13500000);
+			if (ret != 0) {
+				pr_err("Failed to set VDDINT for %dkHz: %d\n",
+				       freqs.new, ret);
+			}
+		}
 	}
 #endif
 
@@ -259,6 +281,7 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 	if (ret != 0) {
 		pr_err("Failed to configure frequency table: %d\n",
 		       ret);
+		regulator_put(vddint);
 		regulator_put(vddarm);
 		clk_put(armclk);
 	}
-- 
1.7.7.3
