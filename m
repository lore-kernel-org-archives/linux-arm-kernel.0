From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 17 May 2017 22:46:31 +0800
Subject: [PATCH v1 1/2] clk: Hi3660: change to register clock with
 CLK_OF_DECLARE
In-Reply-To: <1495032392-19102-1-git-send-email-leo.yan@linaro.org>
References: <1495032392-19102-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495032392-19102-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer will register into system at very early phase at kernel boot;
if timer needs to use clock, the clock should be get ready in function
of_clk_init() so later the timer driver probe can retrieve clock
successfully. This is finished in below flow on arm64:

  start_kernel()
    `-> time_init()
          `-> of_clk_init(NULL)    => register timer's clock
          `-> clocksource_probe()  => register timer

On Hi3660 the sp804 timer uses clock "osc32k", this clock is registered
as platform driver rather than CLK_OF_DECLARE method. As result, sp804
timer probe returns failure due if cannot bind clock properly. To fix
the failure, this patch is to change crgctrl clock registration from
platform driver to CLK_OF_DECLARE method so the clocks can be
registered ahead with function of_clk_init() and then timer driver can
use it.

In the clock driver clk-hi3660.c, it's pointless to mix clock
registration with platform driver mode and CLK_OF_DECLARE mode; this
patch changes all clocks registration to CLK_OF_DECLARE mode to make
code neat.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3660.c | 48 ++++----------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index fd5ce7f..fc11719 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -465,6 +465,7 @@ static void hi3660_clk_iomcu_init(struct device_node *np)
 				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
 				   clk_data);
 }
+CLK_OF_DECLARE(hi3660_clk_iomcu, "hisilicon,hi3660-iomcu", hi3660_clk_iomcu_init);
 
 static void hi3660_clk_pmuctrl_init(struct device_node *np)
 {
@@ -478,6 +479,7 @@ static void hi3660_clk_pmuctrl_init(struct device_node *np)
 	hisi_clk_register_gate(hi3660_pmu_gate_clks,
 			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
 }
+CLK_OF_DECLARE(hi3660_clk_pmuctrl, "hisilicon,hi3660-pmuctrl", hi3660_clk_pmuctrl_init);
 
 static void hi3660_clk_pctrl_init(struct device_node *np)
 {
@@ -490,6 +492,7 @@ static void hi3660_clk_pctrl_init(struct device_node *np)
 	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
 			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
 }
+CLK_OF_DECLARE(hi3660_clk_pctrl, "hisilicon,hi3660-pctrl", hi3660_clk_pctrl_init);
 
 static void hi3660_clk_sctrl_init(struct device_node *np)
 {
@@ -513,6 +516,7 @@ static void hi3660_clk_sctrl_init(struct device_node *np)
 				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
 				  clk_data);
 }
+CLK_OF_DECLARE(hi3660_clk_sctrl, "hisilicon,hi3660-sctrl", hi3660_clk_sctrl_init);
 
 static void hi3660_clk_crgctrl_init(struct device_node *np)
 {
@@ -547,46 +551,4 @@ static void hi3660_clk_crgctrl_init(struct device_node *np)
 				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
 				  clk_data);
 }
-
-static const struct of_device_id hi3660_clk_match_table[] = {
-	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = hi3660_clk_crgctrl_init },
-	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = hi3660_clk_pctrl_init },
-	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = hi3660_clk_pmuctrl_init },
-	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = hi3660_clk_sctrl_init },
-	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = hi3660_clk_iomcu_init },
-	{ }
-};
-
-static int hi3660_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
-
-static struct platform_driver hi3660_clk_driver = {
-	.probe          = hi3660_clk_probe,
-	.driver         = {
-		.name   = "hi3660-clk",
-		.of_match_table = hi3660_clk_match_table,
-	},
-};
-
-static int __init hi3660_clk_init(void)
-{
-	return platform_driver_register(&hi3660_clk_driver);
-}
-core_initcall(hi3660_clk_init);
+CLK_OF_DECLARE(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl", hi3660_clk_crgctrl_init);
-- 
1.9.1
