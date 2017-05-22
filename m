From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 22 May 2017 12:52:27 +0800
Subject: [PATCH v3 1/2] clk: Hi3660: register fixed_rate_clks with
 CLK_OF_DECLARE_DRIVER
In-Reply-To: <1495428748-11153-1-git-send-email-leo.yan@linaro.org>
References: <1495428748-11153-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495428748-11153-2-git-send-email-leo.yan@linaro.org>
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
as platform driver rather than CLK_OF_DECLARE_DRIVER method. As result,
sp804 timer probe returns failure due if cannot bind clock properly.

To fix the failure, this patch is to split crgctrl clocks into two
subsets. One part is for fixed_rate_clks which includes pre-defined
fixed rate clocks, and "osc32k" clock is in this category; So we change
their registration to CLK_OF_DECLARE_DRIVER method, as result the clocks
can be registered ahead with function of_clk_init() and timer driver can
bind timer clock successfully; the rest of the crgctrl clocks are still
registered by the probe of the platform driver.

This patch also adds checking for all crgctrl clocks registration and
print out log if any clock has failure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3660.c | 48 ++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index fd5ce7f..271008b 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -452,6 +452,8 @@
 	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
 };
 
+static struct hisi_clock_data *clk_crgctrl_data;
+
 static void hi3660_clk_iomcu_init(struct device_node *np)
 {
 	struct hisi_clock_data *clk_data;
@@ -514,38 +516,64 @@ static void hi3660_clk_sctrl_init(struct device_node *np)
 				  clk_data);
 }
 
-static void hi3660_clk_crgctrl_init(struct device_node *np)
+static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
-	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
 		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
+	int i;
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
+	clk_crgctrl_data = hisi_clk_init(np, nr);
+	if (!clk_crgctrl_data)
 		return;
 
+	for (i = 0; i < nr; i++)
+		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
+
 	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
 				     ARRAY_SIZE(hi3660_fixed_rate_clks),
-				     clk_data);
+				     clk_crgctrl_data);
+}
+CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
+		      hi3660_clk_crgctrl_early_init);
+
+static void hi3660_clk_crgctrl_init(struct device_node *np)
+{
+	struct clk **clks;
+	int i;
+
+	if (!clk_crgctrl_data)
+		hi3660_clk_crgctrl_early_init(np);
+
+	/* clk_crgctrl_data initialization failed */
+	if (!clk_crgctrl_data)
+		return;
+
 	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
 				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
-				   clk_data);
+				   clk_crgctrl_data);
 	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
 			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
-			       clk_data);
+			       clk_crgctrl_data);
 	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
 			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
-			      clk_data);
+			      clk_crgctrl_data);
 	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
 				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
-				       clk_data);
+				       clk_crgctrl_data);
 	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
 				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
-				  clk_data);
+				  clk_crgctrl_data);
+
+	clks = clk_crgctrl_data->clk_data.clks;
+	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
+		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
+			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
+			       i, PTR_ERR(clks[i]));
+	}
 }
 
 static const struct of_device_id hi3660_clk_match_table[] = {
-- 
1.9.1
