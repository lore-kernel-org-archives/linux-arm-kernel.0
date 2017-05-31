From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 31 May 2017 09:45:38 +0800
Subject: [Resend PATCH 1/2] clk: hi6220: add acpu clock
Message-ID: <1496195139-16687-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add acpu clock, including sft clock controlling hi6220 coresight module

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Verified on clk-next, v.12-rc1

.../devicetree/bindings/clock/hi6220-clock.txt     |  1 +
 drivers/clk/hisilicon/clk-hi6220.c                 | 23 ++++++++++++++++++++++
 include/dt-bindings/clock/hi6220-clock.h           |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hi6220-clock.txt b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
index e4d5fea..ef3deb7 100644
--- a/Documentation/devicetree/bindings/clock/hi6220-clock.txt
+++ b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
@@ -11,6 +11,7 @@ Required Properties:
 - compatible: the compatible should be one of the following strings to
 	indicate the clock controller functionality.
 
+	- "hisilicon,hi6220-acpu-sctrl"
 	- "hisilicon,hi6220-aoctrl"
 	- "hisilicon,hi6220-sysctrl"
 	- "hisilicon,hi6220-mediactrl"
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index 2ae151c..fc8813f 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -285,3 +285,26 @@ static void __init hi6220_clk_power_init(struct device_node *np)
 				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
 }
 CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
+
+
+/* clocks in acpu */
+static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
+	{ HI6220_ACPU_SFT_AT_S, "sft_at_s", "cs_atb",
+	  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0xc, 11, 0, },
+};
+
+static void __init hi6220_clk_acpu_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate_sep(hi6220_acpu_sc_gate_sep_clks,
+				   ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
+				   clk_data);
+}
+
+CLK_OF_DECLARE(hi6220_clk_acpu, "hisilicon,hi6220-acpu-sctrl", hi6220_clk_acpu_init);
diff --git a/include/dt-bindings/clock/hi6220-clock.h b/include/dt-bindings/clock/hi6220-clock.h
index b8ba665..409cc02 100644
--- a/include/dt-bindings/clock/hi6220-clock.h
+++ b/include/dt-bindings/clock/hi6220-clock.h
@@ -174,4 +174,8 @@
 #define HI6220_DDRC_AXI1	7
 
 #define HI6220_POWER_NR_CLKS	8
+
+/* clk in Hi6220 acpu sctrl */
+#define HI6220_ACPU_SFT_AT_S		0
+
 #endif
-- 
2.7.4
