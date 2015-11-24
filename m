From: b51503@freescale.com (Bai Ping)
Date: Tue, 24 Nov 2015 18:25:14 +0800
Subject: [PATCH 1/3] clk: imx: Add a virtual arm clk on i.mx7d
Message-ID: <1448360716-1741-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a virtual arm clk to abstract the actual steps
when changing the ARM core frequency.So we can using
the 'cpufreq-dt' driver on i.MX7D/Solo.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 drivers/clk/imx/clk-imx7d.c             | 6 ++++++
 include/dt-bindings/clock/imx7d-clock.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 448ef32..581b428 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -833,6 +833,12 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX7D_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc", 1, 8);
 
+	clks[IMX7D_CLK_ARM] = imx_clk_cpu("arm", "arm_a7_root_clk",
+					 clks[IMX7D_ARM_A7_ROOT_CLK],
+					 clks[IMX7D_ARM_A7_ROOT_SRC],
+					 clks[IMX7D_PLL_ARM_MAIN_CLK],
+					 clks[IMX7D_PLL_SYS_MAIN_CLK]);
+
 	for (i = 0; i < ARRAY_SIZE(clks); i++)
 		if (IS_ERR(clks[i]))
 			pr_err("i.MX7D clk %d: register failed with %ld\n",
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index a4a7a9c..edca8985c 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -447,5 +447,6 @@
 #define IMX7D_SEMA4_HS_ROOT_CLK		434
 #define IMX7D_PLL_DRAM_TEST_DIV		435
 #define IMX7D_ADC_ROOT_CLK		436
-#define IMX7D_CLK_END			437
+#define IMX7D_CLK_ARM			437
+#define IMX7D_CLK_END			438
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
1.9.1
