From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Fri, 29 Sep 2017 15:09:09 +0200
Subject: [RFC 07/11] hack: mediatek: get mmsys to register as both DRM and
 clock device
In-Reply-To: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1506690553-27357-8-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"mediatek,mt8173-mmsys" is the compatible string for both a clock controller
and a DRM device. The assumption seems to be that all compatible strings
trigger, and that mmsys will be registered as two devices.
This does work in the 3.18 vendor kernel, but it is not what happens in
mainline: only the clock portion is probed.

This hack probes the clocks from mtk_drm_probe(), and has all drivers
that need these clocks defer instead of fail. Fixes DRM initialization
on Acer Chromebook R13.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 4 ++--
 drivers/gpu/drm/mediatek/mtk_dpi.c     | 5 +++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 +++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c    | 5 +++--
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c..9339d2c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -1152,7 +1152,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
-static void __init mtk_mmsys_init(struct device_node *node)
+/*static*/ void /*__init*/ mtk_mmsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
@@ -1167,7 +1167,7 @@ static void __init mtk_mmsys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 }
-CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
+//CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e80a603..ed999891 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -682,8 +682,9 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	dpi->engine_clk = devm_clk_get(dev, "engine");
 	if (IS_ERR(dpi->engine_clk)) {
 		ret = PTR_ERR(dpi->engine_clk);
-		dev_err(dev, "Failed to get engine clock: %d\n", ret);
-		return ret;
+		dev_err(dev, "Failed to get engine clock: %d, deferring\n", ret);
+		return -EPROBE_DEFER;
+		//return ret;
 	}
 
 	dpi->pixel_clk = devm_clk_get(dev, "pixel");
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8130f3d..465ee60 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -382,8 +382,9 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 
 	ddp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		return PTR_ERR(ddp->clk);
+		dev_err(dev, "Failed to get clock, deferring\n");
+		return -EPROBE_DEFER;
+		//return PTR_ERR(ddp->clk);
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90f..8c92630 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -381,6 +381,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	{ }
 };
 
+static int foo = 0;
+void mtk_mmsys_init(struct device_node *node);
 static int mtk_drm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -391,6 +393,11 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
+	if (!foo) {
+		mtk_mmsys_init(dev->of_node);
+		foo = 1;
+	}
+
 	private = devm_kzalloc(dev, sizeof(*private), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 690c675..715c0e0 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1441,8 +1441,9 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 
 	ret = mtk_hdmi_get_all_clk(hdmi, np);
 	if (ret) {
-		dev_err(dev, "Failed to get clocks: %d\n", ret);
-		return ret;
+		dev_err(dev, "Failed to get clocks: %d, deferring\n", ret);
+		return -EPROBE_DEFER;
+		//return ret;
 	}
 
 	/* The CEC module handles HDMI hotplug detection */
-- 
2.7.4
