From: hsnaves@gmail.com (Humberto Silva Naves)
Date: Thu, 31 Jul 2014 13:22:08 +0200
Subject: [PATCHv2 1/5] clk: samsung: exynos5410: Add NULL pointer checks in
 clock init
In-Reply-To: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
Message-ID: <1406805732-17372-2-git-send-email-hsnaves@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added NULL pointer checks for device_node input parameter and
for the samsung_clk_provider context returned by samsung_clk_init.
Even though the *current* samsung_clk_init function never returns
a NULL pointer, it is good to keep this check in place to avoid
possible problems in the future due to changes in implementation.
That way, we also improve the consistency of the code that performs
clock initialization across the different SoCs.

Signed-off-by: Humberto Silva Naves <hsnaves@gmail.com>
---
 drivers/clk/samsung/clk-exynos5410.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 231475b..bf57c80 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -188,11 +188,17 @@ static void __init exynos5410_clk_init(struct device_node *np)
 	struct samsung_clk_provider *ctx;
 	void __iomem *reg_base;
 
-	reg_base = of_iomap(np, 0);
-	if (!reg_base)
-		panic("%s: failed to map registers\n", __func__);
+	if (np) {
+		reg_base = of_iomap(np, 0);
+		if (!reg_base)
+			panic("%s: failed to map registers\n", __func__);
+	} else {
+		panic("%s: unable to determine soc\n", __func__);
+	}
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_register_pll(ctx, exynos5410_plls,
 			ARRAY_SIZE(exynos5410_plls), reg_base);
-- 
1.7.10.4
