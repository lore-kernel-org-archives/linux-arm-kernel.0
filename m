From: john.tobias.ph@gmail.com (John Tobias)
Date: Thu, 19 Dec 2013 12:35:38 -0800
Subject: [PATCH v2 3/3] cpufreq: imx6q: add of_init_opp_table
In-Reply-To: <1387485338-21225-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387485338-21225-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1387485338-21225-3-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a routine check to see if the platform supplied the OPP table.
Incase there's no OPP table exist, it will try to initialise it.

It's been tested on iMX6SL board where the platform doesn't have
an OPP table.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..8c56898 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -166,6 +166,17 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	/* Get the OPP table, if the platform did not supply it. */
+	num = dev_pm_opp_get_opp_count(cpu_dev);
+	if (num < 0) {
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
