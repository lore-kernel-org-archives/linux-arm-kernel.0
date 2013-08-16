From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 16 Aug 2013 13:19:36 +0530
Subject: [PATCH V2 2/4] clk: exynos-audss: set correct parent clocks
In-Reply-To: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
References: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
Message-ID: <1376639378-20707-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

Different Exynos SoCs have different names for certain input clocks
to the AudioSS block.  Since the order in which clock providers are
probed is not guaranteed, we can't use the device-tree to pass the
correct input clocks.  Instead, use the compatibility string to
determine what the correct parent clocks should be.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/samsung/clk-exynos-audss.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 86d2606..d81c5f8 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -35,6 +35,7 @@ static unsigned long reg_save[][2] = {
 /* list of all parent clock list */
 static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };
 static const char *mout_i2s_p[] = { "mout_audss", "cdclk0", "sclk_audio0" };
+static const char *sclk_pcm_p = "sclk_pcm0";
 
 #ifdef CONFIG_PM_SLEEP
 static int exynos_audss_clk_suspend(void)
@@ -77,6 +78,15 @@ void __init exynos_audss_clk_init(struct device_node *np)
 		return;
 	}
 
+	/* fix up clock parent names based on SoC */
+	if (of_device_is_compatible(np, "samsung,exynos5420-audss-clock")) {
+		mout_i2s_p[2] = "sclk_maudio0";
+		sclk_pcm_p = "sclk_maupcm0";
+	} else if (of_device_is_compatible(np,
+					"samsung,exynos5250-audss-clock")) {
+		sclk_pcm_p = "div_pcm0";
+	}
+
 	clk_data.clks = clk_table;
 	clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
@@ -118,7 +128,7 @@ void __init exynos_audss_clk_init(struct device_node *np)
 				reg_base + ASS_CLK_GATE, 4, 0, &lock);
 
 	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate(NULL, "sclk_pcm",
-				"div_pcm0", CLK_SET_RATE_PARENT,
+				sclk_pcm_p, CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
 
 	if (of_device_is_compatible(np, "samsung,exynos5420-audss-clock")) {
-- 
1.7.4.4
