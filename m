From: john.tobias.ph@gmail.com (John Tobias)
Date: Thu, 19 Dec 2013 20:15:29 -0800
Subject: [PATCH v3 2/2] cpufreq: imx6q: add of_init_opp_table
In-Reply-To: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1387512929-7304-2-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a routine check to see if the platform supplied the OPP table.
Incase there's not OPP table exist, it will try to get it.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..f261a88 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -187,12 +187,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_node;
 	}
 
-	/* We expect an OPP table supplied by platform */
+	/* We expect an OPP table supplied by platform.
+	 * Just, incase the platform did not supply the OPP
+	 * table, it will try to get it.
+	 */
 	num = dev_pm_opp_get_opp_count(cpu_dev);
 	if (num < 0) {
-		ret = num;
-		dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
-		goto put_node;
+		ret = of_init_opp_table(cpu_dev);
+		if (ret < 0) {
+			dev_err(cpu_dev, "failed to init OPP table\n");
+			ret = -ENODEV;
+			goto put_node;
+		}
+
+		num = dev_pm_opp_get_opp_count(cpu_dev);
+		if (num < 0) {
+			ret = num;
+			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
+			goto put_node;
+		}
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
-- 
1.8.3.2
