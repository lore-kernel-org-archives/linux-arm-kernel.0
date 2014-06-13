From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 13 Jun 2014 15:08:11 +0900
Subject: [PATCH 2/4] clk: samsung: Add support for cpu clocks of Exynos3250
In-Reply-To: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
References: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1402639693-31108-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for a new clock type for Exynos3250 CPU clock provider
and modify little difference of DIV_CPU0 between Exynos4 and Exynos3250.

Cc: Tomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 13fa4c5..ccdcd6a 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -36,6 +36,9 @@
 #define EXYNOS4210_DIV1_HPM_MASK	((0x7 << 0) | (0x7 << 4))
 #define EXYNOS4210_MUX_HPM_MASK		(1 << 20)
 
+#define EXYNOS3250_DIV_CPU0(d3, d2, d1, d0)			\
+		(((d3) << 24) | ((d2) << 20) | ((d1) << 16) | ((d0) <<  4))
+
 /**
  * struct exynos4210_armclk_data: config data to setup exynos4210 cpu clocks.
  * @prate:	frequency of the parent clock.
@@ -384,11 +387,27 @@ static int __init exynos4210_armclk_parser(struct device_node *np, void **data)
 			ptr = of_prop_next_u32(prop, ptr, &cfg[col]);
 
 		tdata->prate = cfg[0] * 1000;
-		tdata->div0 = EXYNOS4210_DIV_CPU0(cfg[6], cfg[5], cfg[4],
-						cfg[3], cfg[2], cfg[1]);
-		tdata->div1 = cells == 10 ?
-				EXYNOS4210_DIV_CPU1(cfg[9], cfg[8], cfg[7]) :
-				EXYNOS4210_DIV_CPU1(0, cfg[8], cfg[7]);
+
+		switch (cells) {
+		case 7:
+			tdata->div0 = EXYNOS3250_DIV_CPU0(cfg[4], cfg[3],
+						cfg[2], cfg[1]);
+			tdata->div1 = EXYNOS4210_DIV_CPU1(0, cfg[6], cfg[5]);
+			break;
+		case 9:
+			tdata->div0 = EXYNOS4210_DIV_CPU0(cfg[6], cfg[5],
+						cfg[4], cfg[3], cfg[2], cfg[1]);
+			tdata->div1 = EXYNOS4210_DIV_CPU1(0, cfg[8], cfg[7]);
+			break;
+		case 10:
+			tdata->div0 = EXYNOS4210_DIV_CPU0(cfg[6], cfg[5],
+						cfg[4], cfg[3], cfg[2], cfg[1]);
+			tdata->div1 = EXYNOS4210_DIV_CPU1(cfg[9], cfg[8],
+						cfg[7]);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 	tdata->prate = 0;
 	return 0;
@@ -409,6 +428,8 @@ static const struct exynos_cpuclk_soc_data exynos5250_cpuclk_soc_data = {
 };
 
 static const struct of_device_id exynos_clock_ids_armclk[] = {
+	{ .compatible = "samsung,exynos3250-cmu",
+			.data = &exynos4210_cpuclk_soc_data, },
 	{ .compatible = "samsung,exynos4210-clock",
 			.data = &exynos4210_cpuclk_soc_data, },
 	{ .compatible = "samsung,exynos4412-clock",
-- 
1.8.0
