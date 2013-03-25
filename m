From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:28 +0800
Subject: [PATCH 2/6] ARM: mxs: look up timrot clock from device tree
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change call clk_get_sys() to of_clk_get() to look up timrot clock from
device tree, so that the clk_register_clkdev() call for timrot can be
saved in clock driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    1 +
 arch/arm/mach-mxs/timer.c    |    2 +-
 drivers/clk/mxs/clk-imx23.c  |    2 --
 drivers/clk/mxs/clk-imx28.c  |    1 -
 5 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 56afcf4..27ce807 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -426,6 +426,7 @@
 				compatible = "fsl,imx23-timrot", "fsl,timrot";
 				reg = <0x80068000 0x2000>;
 				interrupts = <28 29 30 31>;
+				clocks = <&clks 28>;
 			};
 
 			auart0: serial at 8006c000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..c2f10d3 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -838,6 +838,7 @@
 				compatible = "fsl,imx28-timrot", "fsl,timrot";
 				reg = <0x80068000 0x2000>;
 				interrupts = <48 49 50 51>;
+				clocks = <&clks 26>;
 			};
 
 			auart0: serial at 8006a000 {
diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index fe2903d..f5142aa 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -247,7 +247,7 @@ static void __init mxs_timer_init(struct device_node *np)
 	struct clk *timer_clk;
 	int irq;
 
-	timer_clk = clk_get_sys("timrot", NULL);
+	timer_clk = of_clk_get(np, 0);
 	if (IS_ERR(timer_clk)) {
 		pr_err("%s: failed to get clk\n", __func__);
 		return;
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 52e0365..f65b19c 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -160,8 +160,6 @@ int __init mx23_clocks_init(void)
 		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	}
 
-	clk_register_clkdev(clks[clk32k], NULL, "timrot");
-
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 03918e1..3cc82ea 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -238,7 +238,6 @@ int __init mx28_clocks_init(void)
 		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	}
 
-	clk_register_clkdev(clks[xbus], NULL, "timrot");
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-- 
1.7.9.5
