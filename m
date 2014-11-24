From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 24 Nov 2014 16:18:32 +0100
Subject: [RFC 2/2] clk: samsung: Fix clock disable failure because domain being
 gated
In-Reply-To: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1416842312-4405-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio subsystem clocks are located in separate block. If parent clock
(from main clock domain) 'mau_epll' is gated then any read or write to
audss registers will block.

This was observed on Exynos 5420 platforms (Arndale Octa and Peach
Pi/Pit) after introducing runtime PM to pl330 DMA driver. After that
commit the 'mau_epll' was gated (no users). The system hang on disabling
unused clocks from audss block.

Whenever system wants to operate on audss clock it has to enable epll
clock.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reported-by: Kevin Hilman <khilman@kernel.org>
---
 drivers/clk/samsung/clk-exynos-audss.c | 69 +++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index acce708ace18..d10286f30b4f 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -29,6 +29,7 @@ static DEFINE_SPINLOCK(lock);
 static struct clk **clk_table;
 static void __iomem *reg_base;
 static struct clk_onecell_data clk_data;
+struct clk *pll_in;
 
 #define ASS_CLK_SRC 0x0
 #define ASS_CLK_DIV 0x4
@@ -75,6 +76,48 @@ static const struct of_device_id exynos_audss_clk_of_match[] = {
 	{},
 };
 
+static int audss_clk_gate_enable(struct clk_hw *hw)
+{
+	int ret;
+
+	if (!IS_ERR(pll_in))
+		clk_prepare_enable(pll_in);
+	ret = clk_gate_ops.enable(hw);
+	if (!IS_ERR(pll_in))
+		clk_disable_unprepare(pll_in);
+
+	return ret;
+}
+
+static void audss_clk_gate_disable(struct clk_hw *hw)
+{
+	if (!IS_ERR(pll_in))
+		clk_prepare_enable(pll_in);
+	clk_gate_ops.disable(hw);
+	if (!IS_ERR(pll_in))
+		clk_disable_unprepare(pll_in);
+}
+
+static int audss_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	int ret;
+
+	if (!IS_ERR(pll_in))
+		clk_prepare_enable(pll_in);
+	ret = clk_gate_ops.is_enabled(hw);
+	if (!IS_ERR(pll_in))
+		clk_disable_unprepare(pll_in);
+
+	return ret;
+}
+
+/* TODO: Also mux and div */
+const struct clk_ops audss_clk_gate_ops = {
+	.enable = audss_clk_gate_enable,
+	.disable = audss_clk_gate_disable,
+	.is_enabled = audss_clk_gate_is_enabled,
+};
+
 /* register exynos_audss clocks */
 static int exynos_audss_clk_probe(struct platform_device *pdev)
 {
@@ -83,7 +126,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	const char *mout_audss_p[] = {"fin_pll", "fout_epll"};
 	const char *mout_i2s_p[] = {"mout_audss", "cdclk0", "sclk_audio0"};
 	const char *sclk_pcm_p = "sclk_pcm0";
-	struct clk *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
+	struct clk *pll_ref, *cdclk, *sclk_audio, *sclk_pcm_in;
 	const struct of_device_id *match;
 	enum exynos_audss_clk_type variant;
 
@@ -145,33 +188,33 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				"mout_i2s", 0, reg_base + ASS_CLK_DIV, 8, 4, 0,
 				&lock);
 
-	clk_table[EXYNOS_SRP_CLK] = clk_register_gate(NULL, "srp_clk",
+	clk_table[EXYNOS_SRP_CLK] = clk_register_gate_ops(NULL, "srp_clk",
 				"dout_srp", CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 0, 0, &lock);
+				reg_base + ASS_CLK_GATE, 0, 0, &lock, &audss_clk_gate_ops);
 
-	clk_table[EXYNOS_I2S_BUS] = clk_register_gate(NULL, "i2s_bus",
+	clk_table[EXYNOS_I2S_BUS] = clk_register_gate_ops(NULL, "i2s_bus",
 				"dout_aud_bus", CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 2, 0, &lock);
+				reg_base + ASS_CLK_GATE, 2, 0, &lock, &audss_clk_gate_ops);
 
-	clk_table[EXYNOS_SCLK_I2S] = clk_register_gate(NULL, "sclk_i2s",
+	clk_table[EXYNOS_SCLK_I2S] = clk_register_gate_ops(NULL, "sclk_i2s",
 				"dout_i2s", CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 3, 0, &lock);
+				reg_base + ASS_CLK_GATE, 3, 0, &lock, &audss_clk_gate_ops);
 
-	clk_table[EXYNOS_PCM_BUS] = clk_register_gate(NULL, "pcm_bus",
+	clk_table[EXYNOS_PCM_BUS] = clk_register_gate_ops(NULL, "pcm_bus",
 				 "sclk_pcm", CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 4, 0, &lock);
+				reg_base + ASS_CLK_GATE, 4, 0, &lock, &audss_clk_gate_ops);
 
 	sclk_pcm_in = devm_clk_get(&pdev->dev, "sclk_pcm_in");
 	if (!IS_ERR(sclk_pcm_in))
 		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
-	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate(NULL, "sclk_pcm",
+	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate_ops(NULL, "sclk_pcm",
 				sclk_pcm_p, CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 5, 0, &lock);
+				reg_base + ASS_CLK_GATE, 5, 0, &lock, &audss_clk_gate_ops);
 
 	if (variant == TYPE_EXYNOS5420) {
-		clk_table[EXYNOS_ADMA] = clk_register_gate(NULL, "adma",
+		clk_table[EXYNOS_ADMA] = clk_register_gate_ops(NULL, "adma",
 				"dout_srp", CLK_SET_RATE_PARENT,
-				reg_base + ASS_CLK_GATE, 9, 0, &lock);
+				reg_base + ASS_CLK_GATE, 9, 0, &lock, &audss_clk_gate_ops);
 	}
 
 	for (i = 0; i < clk_data.clk_num; i++) {
-- 
1.9.1
