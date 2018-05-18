From: mine260309@gmail.com (Lei YU)
Date: Fri, 18 May 2018 16:57:02 +0800
Subject: [PATCH] clk: aspeed: Add 24MHz fixed clock
Message-ID: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 24MHz fixed clock.
This clock will be used for certain devices, e.g. pwm.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/clk/clk-aspeed.c                 | 9 ++++++++-
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5eb50c3..4664088 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/clock/aspeed-clock.h>
 
-#define ASPEED_NUM_CLKS		35
+#define ASPEED_NUM_CLKS		36
 
 #define ASPEED_RESET_CTRL	0x04
 #define ASPEED_CLK_SELECTION	0x08
@@ -474,6 +474,13 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
 
+	/* Fixed 24MHz clock */
+	hw = clk_hw_register_fixed_rate(NULL, "fixed-24m", "clkin",
+					0, 24000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
+
 	/*
 	 * TODO: There are a number of clocks that not included in this driver
 	 * as more information is required:
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index d3558d8..ff29d8e 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -38,6 +38,7 @@
 #define ASPEED_CLK_MAC			32
 #define ASPEED_CLK_BCLK			33
 #define ASPEED_CLK_MPLL			34
+#define ASPEED_CLK_24M			35
 
 #define ASPEED_RESET_XDMA		0
 #define ASPEED_RESET_MCTP		1
-- 
2.7.4
