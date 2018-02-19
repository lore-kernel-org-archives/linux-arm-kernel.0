From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 19 Feb 2018 16:44:01 +0100
Subject: [PATCH 3/8] drm/exynos/decon: Use clk bulk API
In-Reply-To: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
 <CGME20180219154458eucas1p1b4e728757e78f3d5dde5c9aa565a5d20@eucas1p1.samsung.com>
Message-ID: <1519055046-2399-4-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 50 ++++++++-------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 1c330f2..1760fcb 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -55,7 +55,7 @@ struct decon_context {
 	struct exynos_drm_plane_config	configs[WINDOWS_NR];
 	void __iomem			*addr;
 	struct regmap			*sysreg;
-	struct clk			*clks[ARRAY_SIZE(decon_clks_name)];
+	struct clk_bulk_data		*clks;
 	unsigned int			irq;
 	unsigned int			irq_vsync;
 	unsigned int			irq_lcd_sys;
@@ -485,15 +485,13 @@ static irqreturn_t decon_te_irq_handler(int irq, void *dev_id)
 static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
-	int win, i, ret;
+	int win, ret;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		ret = clk_prepare_enable(ctx->clks[i]);
-		if (ret < 0)
-			goto err;
-	}
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(decon_clks_name), ctx->clks);
+	if (ret < 0)
+		return;
 
 	decon_shadow_protect(ctx, true);
 	for (win = 0; win < WINDOWS_NR; win++)
@@ -504,10 +502,6 @@ static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 
 	/* TODO: wait for possible vsync */
 	msleep(50);
-
-err:
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
 }
 
 static enum drm_mode_status decon_mode_valid(struct exynos_drm_crtc *crtc,
@@ -638,10 +632,8 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 static int exynos5433_decon_suspend(struct device *dev)
 {
 	struct decon_context *ctx = dev_get_drvdata(dev);
-	int i = ARRAY_SIZE(decon_clks_name);
 
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(decon_clks_name), ctx->clks);
 
 	return 0;
 }
@@ -649,19 +641,9 @@ static int exynos5433_decon_suspend(struct device *dev)
 static int exynos5433_decon_resume(struct device *dev)
 {
 	struct decon_context *ctx = dev_get_drvdata(dev);
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		ret = clk_prepare_enable(ctx->clks[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	return 0;
+	int ret;
 
-err:
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(decon_clks_name), ctx->clks);
 
 	return ret;
 }
@@ -719,7 +701,6 @@ static int exynos5433_decon_probe(struct platform_device *pdev)
 	struct decon_context *ctx;
 	struct resource *res;
 	int ret;
-	int i;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -732,15 +713,14 @@ static int exynos5433_decon_probe(struct platform_device *pdev)
 	if (ctx->out_type & IFTYPE_HDMI)
 		ctx->first_win = 1;
 
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		struct clk *clk;
-
-		clk = devm_clk_get(ctx->dev, decon_clks_name[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+	ctx->clks = devm_clk_bulk_alloc(dev, ARRAY_SIZE(decon_clks_name),
+					decon_clks_name);
+	if (IS_ERR(ctx->clks))
+		return PTR_ERR(ctx->clks);
 
-		ctx->clks[i] = clk;
-	}
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(decon_clks_name), ctx->clks);
+	if (ret < 0)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->addr = devm_ioremap_resource(dev, res);
-- 
2.7.4
