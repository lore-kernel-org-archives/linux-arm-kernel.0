From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 16:22:24 -0800
Subject: [PATCH v2 2/2] clk: hisilicon: Add clock driver for hi3660 SoC
In-Reply-To: <1482978805-6981-3-git-send-email-zhangfei.gao@linaro.org>
References: <1482978805-6981-1-git-send-email-zhangfei.gao@linaro.org>
 <1482978805-6981-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20170110002224.GH17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29, Zhangfei Gao wrote:
> Add clock drivers for hi3660 SoC, this driver controls the SoC
> registers to supply different clocks to different IPs in the SoC.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---

Applied to clk-hi3660 and merged into clk-next. I took the
liberty of using a function pointer in probe though so we don't
need the enum anymore.

---8<---
diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 4e752c632378..96a9697b06cf 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -14,14 +14,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 
-enum hi3660_clk_type {
-	HI3660_CRGCTRL = 1,
-	HI3660_PCTRL,
-	HI3660_PMUCTRL,
-	HI3660_SCTRL,
-	HI3660_IOMCU,
-};
-
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
 	{ HI3660_CLKIN_SYS, "clkin_sys", NULL, 0, 19200000, },
 	{ HI3660_CLKIN_REF, "clkin_ref", NULL, 0, 32764, },
@@ -533,15 +525,15 @@ static void hi3660_clk_crgctrl_init(struct device_node *np)
 
 static const struct of_device_id hi3660_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = (void *)HI3660_CRGCTRL },
+	  .data = hi3660_clk_crgctrl_init },
 	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = (void *)HI3660_PCTRL },
+	  .data = hi3660_clk_pctrl_init },
 	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = (void *)HI3660_PMUCTRL },
+	  .data = hi3660_clk_pmuctrl_init },
 	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = (void *)HI3660_SCTRL },
+	  .data = hi3660_clk_sctrl_init },
 	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = (void *)HI3660_IOMCU },
+	  .data = hi3660_clk_iomcu_init },
 	{ }
 };
 
@@ -549,31 +541,14 @@ static int hi3660_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
-	enum hi3660_clk_type type;
+	void (*init_func)(struct device_node *np);
 
-	type = (enum hi3660_clk_type)of_device_get_match_data(dev);
-	if (!type)
+	init_func = of_device_get_match_data(dev);
+	if (!init_func)
 		return -ENODEV;
 
-	switch (type) {
-	case HI3660_CRGCTRL:
-		hi3660_clk_crgctrl_init(np);
-		break;
-	case HI3660_PCTRL:
-		hi3660_clk_pctrl_init(np);
-		break;
-	case HI3660_PMUCTRL:
-		hi3660_clk_pmuctrl_init(np);
-		break;
-	case HI3660_SCTRL:
-		hi3660_clk_sctrl_init(np);
-		break;
-	case HI3660_IOMCU:
-		hi3660_clk_iomcu_init(np);
-		break;
-	default:
-		break;
-	}
+	init_func(np);
+
 	return 0;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
