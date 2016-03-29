From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Mar 2016 18:59:58 -0700
Subject: [PATCH v2 4/8] drm/fsl-dcu: add extra clock for pixel clock
In-Reply-To: <1459216802-32094-1-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
Message-ID: <1459216802-32094-5-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Vybrid DCU variant has two independent clock inputs, one
for the registers (IPG bus clock) and one for the pixel clock.
Support this distinction in the DCU DRM driver while staying
backward compatible with devices providing only a single clock
(e.g. LS1021a SoC's).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/display/fsl,dcu.txt |  4 ++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c            |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c             | 16 +++++++++++++++-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h             |  1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/fsl,dcu.txt b/Documentation/devicetree/bindings/display/fsl,dcu.txt
index ebf1be9..f299e1e 100644
--- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
+++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
@@ -11,6 +11,10 @@ Required properties:
 - big-endian		Boolean property, LS1021A DCU registers are big-endian.
 - fsl,panel:		The phandle to panel node.
 
+Optional properties:
+- clocks:		Second handle for pixel clock.
+- clock-names:		Second name "pix" for pixel clock.
+
 Examples:
 dcu: dcu at 2ce0000 {
 	compatible = "fsl,ls1021a-dcu";
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 35876e3..68f72fb 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -79,7 +79,7 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	unsigned long dcuclk;
 
 	index = drm_crtc_index(crtc);
-	dcuclk = clk_get_rate(fsl_dev->clk);
+	dcuclk = clk_get_rate(fsl_dev->pix_clk);
 	div = dcuclk / mode->clock / 1000;
 
 	/* Configure timings: */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index f2a9c1b..f80c116 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -331,10 +331,21 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	fsl_dev->pix_clk = devm_clk_get(dev, "pix");
+	if (IS_ERR(fsl_dev->pix_clk)) {
+		/* legancy binding, use dcu clock as pixel clock */
+		fsl_dev->pix_clk = fsl_dev->clk;
+	}
+	ret = clk_prepare_enable(fsl_dev->pix_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable pix clk\n");
+		goto disable_clk;
+	}
+
 	drm = drm_dev_alloc(driver, dev);
 	if (!drm) {
 		ret = -ENOMEM;
-		goto disable_clk;
+		goto disable_pix_clk;
 	}
 
 	fsl_dev->dev = dev;
@@ -355,6 +366,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 unref:
 	drm_dev_unref(drm);
+disable_pix_clk:
+	clk_disable_unprepare(fsl_dev->pix_clk);
 disable_clk:
 	clk_disable_unprepare(fsl_dev->clk);
 	return ret;
@@ -365,6 +378,7 @@ static int fsl_dcu_drm_remove(struct platform_device *pdev)
 	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(fsl_dev->clk);
+	clk_disable_unprepare(fsl_dev->pix_clk);
 	drm_put_dev(fsl_dev->drm);
 
 	return 0;
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index af3a707..f60ec0a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -183,6 +183,7 @@ struct fsl_dcu_drm_device {
 	struct regmap *regmap;
 	int irq;
 	struct clk *clk;
+	struct clk *pix_clk;
 	/*protects hardware register*/
 	spinlock_t irq_lock;
 	struct drm_device *drm;
-- 
2.7.4
