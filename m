From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 18 Dec 2013 15:50:55 -0800
Subject: [PATCH 3/4] cpufreq: imx6q: add of_init_opp_table
In-Reply-To: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1387410656-36053-3-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a routine check to see if the the platform supplied the OPP table.
Incase there's no OPP table exist, it will try to initialise it.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..47dbf3c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -151,6 +151,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct dev_pm_opp *opp;
+	struct device_opp *tmp_dev_opp;
 	unsigned long min_volt, max_volt;
 	int num, ret;
 
@@ -166,6 +167,17 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	/* Get the OPP table, if the platform did not supply it. */
+	tmp_dev_opp = find_device_opp(cpu_dev);
+	if (IS_ERR(tmp_dev_opp)) {
+		ret = of_init_opp_table(cpu_dev);
+		if (ret < 0) {
+			dev_err(cpu_dev, "failed to init OPP table\n");
+			ret = -ENODEV;
+			goto put_node;
+		}
+	}
+
 	arm_clk = devm_clk_get(cpu_dev, "arm");
 	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
 	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
-- 
1.8.3.2
