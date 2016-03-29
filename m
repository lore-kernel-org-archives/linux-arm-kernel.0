From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Mar 2016 18:59:59 -0700
Subject: [PATCH v2 5/8] drm/fsl-dcu: use common clock framework for pixel
 clock divider
In-Reply-To: <1459216802-32094-1-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
Message-ID: <1459216802-32094-6-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common clock framework to calculate the pixel clock
dividier. The previous implementation rounded down the calculated
factor. Thanks to the CLK_DIVIDER_ROUND_CLOSEST flag using the
common clock framework divider implementation improves the pixel
clock accuracy in some cases. Ontop of that it also allows to see
the actual pixel clock in the sysfs clock summary.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c |  7 ++-----
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c  | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 68f72fb..f7b4d87 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -75,12 +75,10 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
-	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, div, index, pol = 0;
-	unsigned long dcuclk;
+	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, index, pol = 0;
 
 	index = drm_crtc_index(crtc);
-	dcuclk = clk_get_rate(fsl_dev->pix_clk);
-	div = dcuclk / mode->clock / 1000;
+	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
 
 	/* Configure timings: */
 	hbp = mode->htotal - mode->hsync_end;
@@ -111,7 +109,6 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
 		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
 		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
-	regmap_write(fsl_dev->regmap, DCU_DIV_RATIO, div);
 	regmap_write(fsl_dev->regmap, DCU_SYN_POL, pol);
 	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
 		     DCU_BGND_G(0) | DCU_BGND_B(0));
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index f80c116..093a60b 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -283,6 +283,9 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	struct drm_driver *driver = &fsl_dcu_drm_driver;
+	struct clk *pix_clk_in;
+	char pix_clk_name[32];
+	const char *pix_clk_in_name;
 	const struct of_device_id *id;
 	int ret;
 
@@ -331,15 +334,27 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	fsl_dev->pix_clk = devm_clk_get(dev, "pix");
+	pix_clk_in = devm_clk_get(dev, "pix");
+	if (IS_ERR(pix_clk_in)) {
+		/* legancy binding, use dcu clock as pixel clock input */
+		pix_clk_in = fsl_dev->clk;
+	}
+
+	pix_clk_in_name = __clk_get_name(pix_clk_in);
+	snprintf(pix_clk_name, sizeof(pix_clk_name), "%s_pix", pix_clk_in_name);
+	fsl_dev->pix_clk = clk_register_divider(dev, pix_clk_name,
+			pix_clk_in_name, 0, base + DCU_DIV_RATIO,
+			0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL);
 	if (IS_ERR(fsl_dev->pix_clk)) {
-		/* legancy binding, use dcu clock as pixel clock */
-		fsl_dev->pix_clk = fsl_dev->clk;
+		dev_err(dev, "failed to register pix clk\n");
+		ret = PTR_ERR(fsl_dev->pix_clk);
+		goto disable_clk;
 	}
+
 	ret = clk_prepare_enable(fsl_dev->pix_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable pix clk\n");
-		goto disable_clk;
+		goto unregister_pix_clk;
 	}
 
 	drm = drm_dev_alloc(driver, dev);
@@ -368,6 +383,8 @@ unref:
 	drm_dev_unref(drm);
 disable_pix_clk:
 	clk_disable_unprepare(fsl_dev->pix_clk);
+unregister_pix_clk:
+	clk_unregister(fsl_dev->pix_clk);
 disable_clk:
 	clk_disable_unprepare(fsl_dev->clk);
 	return ret;
@@ -379,6 +396,7 @@ static int fsl_dcu_drm_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(fsl_dev->clk);
 	clk_disable_unprepare(fsl_dev->pix_clk);
+	clk_unregister(fsl_dev->pix_clk);
 	drm_put_dev(fsl_dev->drm);
 
 	return 0;
-- 
2.7.4
