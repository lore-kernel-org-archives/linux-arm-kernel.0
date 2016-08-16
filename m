From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:10 +0200
Subject: [RFC 13/17] clk: samsung: audss: samsung: Switch to new clock
 controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-14-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos-audss.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index bdf8b971f332..c13e6ab6f3b6 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -30,6 +30,7 @@ static DEFINE_SPINLOCK(lock);
 static struct clk **clk_table;
 static void __iomem *reg_base;
 static struct clk_onecell_data clk_data;
+static struct clk_ctrl *clk_ctrl;
 /*
  * On Exynos5420 this will be a clock which has to be enabled before any
  * access to audss registers. Typically a child of EPLL.
@@ -135,6 +136,10 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	if (!clk_table)
 		return -ENOMEM;
 
+	clk_ctrl = clk_ctrl_register(&pdev->dev); /* FIXME: Use devm-like, leaks now on error path */
+	if (IS_ERR(clk_ctrl))
+		return PTR_ERR(clk_ctrl);
+
 	clk_data.clks = clk_table;
 	if (variant == TYPE_EXYNOS5420)
 		clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
@@ -159,7 +164,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 			}
 		}
 	}
-	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
+	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, clk_ctrl, "mout_audss",
 				mout_audss_p, ARRAY_SIZE(mout_audss_p),
 				CLK_SET_RATE_NO_REPARENT,
 				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
@@ -170,48 +175,48 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 		mout_i2s_p[1] = __clk_get_name(cdclk);
 	if (!IS_ERR(sclk_audio))
 		mout_i2s_p[2] = __clk_get_name(sclk_audio);
-	clk_table[EXYNOS_MOUT_I2S] = clk_register_mux(NULL, "mout_i2s",
+	clk_table[EXYNOS_MOUT_I2S] = clk_register_mux(NULL, clk_ctrl, "mout_i2s",
 				mout_i2s_p, ARRAY_SIZE(mout_i2s_p),
 				CLK_SET_RATE_NO_REPARENT,
 				reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
 
-	clk_table[EXYNOS_DOUT_SRP] = clk_register_divider(NULL, "dout_srp",
+	clk_table[EXYNOS_DOUT_SRP] = clk_register_divider(NULL, clk_ctrl, "dout_srp",
 				"mout_audss", 0, reg_base + ASS_CLK_DIV, 0, 4,
 				0, &lock);
 
-	clk_table[EXYNOS_DOUT_AUD_BUS] = clk_register_divider(NULL,
+	clk_table[EXYNOS_DOUT_AUD_BUS] = clk_register_divider(NULL, clk_ctrl,
 				"dout_aud_bus", "dout_srp", 0,
 				reg_base + ASS_CLK_DIV, 4, 4, 0, &lock);
 
-	clk_table[EXYNOS_DOUT_I2S] = clk_register_divider(NULL, "dout_i2s",
+	clk_table[EXYNOS_DOUT_I2S] = clk_register_divider(NULL, clk_ctrl, "dout_i2s",
 				"mout_i2s", 0, reg_base + ASS_CLK_DIV, 8, 4, 0,
 				&lock);
 
-	clk_table[EXYNOS_SRP_CLK] = clk_register_gate(NULL, "srp_clk",
+	clk_table[EXYNOS_SRP_CLK] = clk_register_gate(NULL, clk_ctrl, "srp_clk",
 				"dout_srp", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 0, 0, &lock);
 
-	clk_table[EXYNOS_I2S_BUS] = clk_register_gate(NULL, "i2s_bus",
+	clk_table[EXYNOS_I2S_BUS] = clk_register_gate(NULL, clk_ctrl, "i2s_bus",
 				"dout_aud_bus", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 2, 0, &lock);
 
-	clk_table[EXYNOS_SCLK_I2S] = clk_register_gate(NULL, "sclk_i2s",
+	clk_table[EXYNOS_SCLK_I2S] = clk_register_gate(NULL, clk_ctrl, "sclk_i2s",
 				"dout_i2s", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 3, 0, &lock);
 
-	clk_table[EXYNOS_PCM_BUS] = clk_register_gate(NULL, "pcm_bus",
+	clk_table[EXYNOS_PCM_BUS] = clk_register_gate(NULL, clk_ctrl, "pcm_bus",
 				 "sclk_pcm", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 4, 0, &lock);
 
 	sclk_pcm_in = devm_clk_get(&pdev->dev, "sclk_pcm_in");
 	if (!IS_ERR(sclk_pcm_in))
 		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
-	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate(NULL, "sclk_pcm",
+	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate(NULL, clk_ctrl, "sclk_pcm",
 				sclk_pcm_p, CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
 
 	if (variant == TYPE_EXYNOS5420) {
-		clk_table[EXYNOS_ADMA] = clk_register_gate(NULL, "adma",
+		clk_table[EXYNOS_ADMA] = clk_register_gate(NULL, clk_ctrl, "adma",
 				"dout_srp", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 9, 0, &lock);
 	}
@@ -261,6 +266,9 @@ static int exynos_audss_clk_remove(struct platform_device *pdev)
 	if (!IS_ERR(epll))
 		clk_disable_unprepare(epll);
 
+	clk_ctrl_unregister(clk_ctrl);
+	clk_ctrl = NULL;
+
 	return 0;
 }
 
-- 
1.9.1
