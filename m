From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:16 -0700
Subject: [PATCH 1/6] clk: bcm2835: probe for fixed-clock in device tree
Message-ID: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow fixed-clocks to be registered in device tree, which in
turn will allow clock clients to look up their clocks in device tree.
The first driver to use this feature will be the bcm2835 SDHCI/MMC
driver. In the long run, it is likely these fixed clocks will be
replaced with an actual clock implementation which speaks to the
VideoCore processor, but this change should be transparent to clock
consumers.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/clk/clk-bcm2835.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index e69991a..792bc57 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -20,6 +20,13 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+
+static const __initconst struct of_device_id clk_match[] = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ }
+};
 
 /*
  * These are fixed clocks. They're probably not all root clocks and it may
@@ -56,4 +63,6 @@ void __init bcm2835_init_clocks(void)
 	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
 	if (ret)
 		pr_err("uart1_pclk alias not registered\n");
+
+	of_clk_init(clk_match);
 }
-- 
1.7.10.4
