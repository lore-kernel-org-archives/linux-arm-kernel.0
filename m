From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 17 Dec 2013 17:17:29 -0800
Subject: [PATCH 2/4] Moving of_init_opp_table
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1387329451-17480-2-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Moving of_init_opp_table from mach-imx6q.c to imx6q-cpufreq.c in order to avoid adding it to mach-imx6sl.c.
    Just incase the cpu frequency scaling is enabled on iMX6SL.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..2eea3d9 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -166,6 +166,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	if (of_init_opp_table(cpu_dev)) {
+		dev_err(cpu_dev,"failed to init OPP table\n");
+		return -ENODEV;
+	}
+
 	arm_clk = devm_clk_get(cpu_dev, "arm");
 	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
 	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
-- 
1.8.3.2
