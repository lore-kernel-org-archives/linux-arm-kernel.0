From: Sudeep.KarkadaNagesha@arm.com (Sudeep.KarkadaNagesha at arm.com)
Date: Wed, 17 Jul 2013 15:06:20 +0100
Subject: [RFC PATCH v2 11/15] cpufreq: kirkwood-cpufreq: remove device tree
 parsing for cpu nodes
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374069984-20567-12-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index c233ea6..18aa3eb 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -165,6 +166,7 @@ static struct cpufreq_driver kirkwood_cpufreq_driver = {
 static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
+	struct device *cpu_dev;
 	struct resource *res;
 	int err;
 
@@ -175,9 +177,17 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(priv.base))
 		return PTR_ERR(priv.base);
 
-	np = of_find_node_by_path("/cpus/cpu at 0");
-	if (!np)
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		dev_err(&pdev->dev, "failed to get cpu device\n");
 		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		dev_err(&pdev->dev, "failed to get cpu device node\n");
+		return -ENODEV;
+	}
 
 	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
 	if (IS_ERR(priv.cpu_clk)) {
-- 
1.8.1.2
