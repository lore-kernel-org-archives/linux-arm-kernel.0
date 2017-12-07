From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  7 Dec 2017 14:56:13 +0100
Subject: [PATCH v2 4/7] cpufreq: mvebu: Use dev_pm_opp_remove()
In-Reply-To: <20171207135616.23670-1-gregory.clement@free-electrons.com>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
Message-ID: <20171207135616.23670-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the introduction of this driver, the dev_pm_opp_remove() was
added. So stop claiming we can't remove opp and use it in case of
failure.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpufreq/mvebu-cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index ed915ee85dd9..419c2b01a44c 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -76,12 +76,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			return PTR_ERR(clk);
 		}
 
-		/*
-		 * In case of a failure of dev_pm_opp_add(), we don't
-		 * bother with cleaning up the registered OPP (there's
-		 * no function to do so), and simply cancel the
-		 * registration of the cpufreq device.
-		 */
 		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
 		if (ret) {
 			clk_put(clk);
@@ -90,6 +84,11 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
 		if (ret) {
+			/*
+			 * The second opp failed to be added, remove
+			 * the first one before exiting.
+			 */
+			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
 			clk_put(clk);
 			return ret;
 		}
-- 
2.15.0
