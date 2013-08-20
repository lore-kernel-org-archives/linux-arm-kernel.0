From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 10:30:17 +0100
Subject: [PATCH v4 15/19] cpufreq: kirkwood-cpufreq: remove device tree
 parsing for cpu nodes
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376991021-12160-16-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Jason Cooper <jason@lakedaemon.net>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index c233ea6..25ac2cb 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <asm/proc-fns.h>
@@ -175,9 +175,11 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(priv.base))
 		return PTR_ERR(priv.base);
 
-	np = of_find_node_by_path("/cpus/cpu at 0");
-	if (!np)
+	np = of_cpu_device_node_get(0);
+	if (!np) {
+		dev_err(&pdev->dev, "failed to get cpu device node\n");
 		return -ENODEV;
+	}
 
 	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
 	if (IS_ERR(priv.cpu_clk)) {
-- 
1.8.1.2
