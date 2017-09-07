From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 07 Sep 2017 18:39:03 +0900
Subject: [PATCH v2 3/3] drm/exynos/gsc: Add hardware rotation limits
In-Reply-To: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170907093912epcas2p198ae12fc11fb2b8a7a9e8d6be817e796@epcas2p1.samsung.com>
Message-ID: <1504777143-29834-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gscaler has hardware rotation limits that need to be hardcoded
into driver. Distinguish them and add them to the property list.

The hardware rotation limits are related to the cropped source size.
When swap occurs, use rot_max size instead of crop_max size.

Also the scaling limits are related to pos size, use pos size to check
the limits.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 100 +++++++++++++++++++++++---------
 include/uapi/drm/exynos_drm.h           |   2 +
 2 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 0506b2b..590a645 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -150,6 +150,15 @@ struct gsc_context {
 	bool	suspended;
 };
 
+/*
+ * struct gsc_driverdata - per device type driver data for init time.
+ *
+ * @rot_max: rotation max resolution.
+ */
+struct gsc_driverdata {
+	struct drm_exynos_sz rot_max;
+};
+
 /* 8-tap Filter Coefficient */
 static const int h_coef_8t[GSC_COEF_RATIO][GSC_COEF_ATTR][GSC_COEF_H_8T] = {
 	{	/* Ratio <= 65536 (~8:8) */
@@ -1401,6 +1410,23 @@ static int gsc_ippdrv_check_property(struct device *dev,
 	bool swap;
 	int i;
 
+	config = &property->config[EXYNOS_DRM_OPS_DST];
+
+	/* check for degree */
+	switch (config->degree) {
+	case EXYNOS_DRM_DEGREE_90:
+	case EXYNOS_DRM_DEGREE_270:
+		swap = true;
+		break;
+	case EXYNOS_DRM_DEGREE_0:
+	case EXYNOS_DRM_DEGREE_180:
+		swap = false;
+		break;
+	default:
+		DRM_ERROR("invalid degree.\n");
+		goto err_property;
+	}
+
 	for_each_ipp_ops(i) {
 		if ((i == EXYNOS_DRM_OPS_SRC) &&
 			(property->cmd == IPP_CMD_WB))
@@ -1416,21 +1442,6 @@ static int gsc_ippdrv_check_property(struct device *dev,
 			goto err_property;
 		}
 
-		/* check for degree */
-		switch (config->degree) {
-		case EXYNOS_DRM_DEGREE_90:
-		case EXYNOS_DRM_DEGREE_270:
-			swap = true;
-			break;
-		case EXYNOS_DRM_DEGREE_0:
-		case EXYNOS_DRM_DEGREE_180:
-			swap = false;
-			break;
-		default:
-			DRM_ERROR("invalid degree.\n");
-			goto err_property;
-		}
-
 		/* check for buffer bound */
 		if ((pos->x + pos->w > sz->hsize) ||
 			(pos->y + pos->h > sz->vsize)) {
@@ -1438,21 +1449,27 @@ static int gsc_ippdrv_check_property(struct device *dev,
 			goto err_property;
 		}
 
+		/*
+		 * The rotation hardware limits are related to the cropped
+		 * source size. So use rot_max size to check the limits when
+		 * swap happens. And also the scaling limits are related to pos
+		 * size, use pos size to check the limits.
+		 */
 		/* check for crop */
 		if ((i == EXYNOS_DRM_OPS_SRC) && (pp->crop)) {
 			if (swap) {
 				if ((pos->h < pp->crop_min.hsize) ||
-					(sz->vsize > pp->crop_max.hsize) ||
+					(pos->h > pp->rot_max.hsize) ||
 					(pos->w < pp->crop_min.vsize) ||
-					(sz->hsize > pp->crop_max.vsize)) {
+					(pos->w > pp->rot_max.vsize)) {
 					DRM_ERROR("out of crop size.\n");
 					goto err_property;
 				}
 			} else {
 				if ((pos->w < pp->crop_min.hsize) ||
-					(sz->hsize > pp->crop_max.hsize) ||
+					(pos->w > pp->crop_max.hsize) ||
 					(pos->h < pp->crop_min.vsize) ||
-					(sz->vsize > pp->crop_max.vsize)) {
+					(pos->h > pp->crop_max.vsize)) {
 					DRM_ERROR("out of crop size.\n");
 					goto err_property;
 				}
@@ -1463,17 +1480,17 @@ static int gsc_ippdrv_check_property(struct device *dev,
 		if ((i == EXYNOS_DRM_OPS_DST) && (pp->scale)) {
 			if (swap) {
 				if ((pos->h < pp->scale_min.hsize) ||
-					(sz->vsize > pp->scale_max.hsize) ||
+					(pos->h > pp->scale_max.hsize) ||
 					(pos->w < pp->scale_min.vsize) ||
-					(sz->hsize > pp->scale_max.vsize)) {
+					(pos->w > pp->scale_max.vsize)) {
 					DRM_ERROR("out of scale size.\n");
 					goto err_property;
 				}
 			} else {
 				if ((pos->w < pp->scale_min.hsize) ||
-					(sz->hsize > pp->scale_max.hsize) ||
+					(pos->w > pp->scale_max.hsize) ||
 					(pos->h < pp->scale_min.vsize) ||
-					(sz->vsize > pp->scale_max.vsize)) {
+					(pos->h > pp->scale_max.vsize)) {
 					DRM_ERROR("out of scale size.\n");
 					goto err_property;
 				}
@@ -1657,6 +1674,27 @@ static void gsc_ippdrv_stop(struct device *dev, enum drm_exynos_ipp_cmd cmd)
 	gsc_write(cfg, GSC_ENABLE);
 }
 
+static struct gsc_driverdata gsc_exynos5250_drvdata = {
+	.rot_max = { 2048, 2048 },
+};
+
+static struct gsc_driverdata gsc_exynos5420_drvdata = {
+	.rot_max = { 2016, 2016 },
+};
+
+static const struct of_device_id exynos_drm_gsc_of_match[] = {
+	{
+		.compatible = "samsung,exynos5250-gsc",
+		.data = &gsc_exynos5250_drvdata,
+	},
+	{
+		.compatible = "samsung,exynos5420-gsc",
+		.data = &gsc_exynos5420_drvdata,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, exynos_drm_gsc_of_match);
+
 static int gsc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1670,12 +1708,22 @@ static int gsc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (dev->of_node) {
+		const struct of_device_id *match;
+		struct gsc_driverdata *driver_data;
+
 		ctx->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
 							"samsung,sysreg");
 		if (IS_ERR(ctx->sysreg)) {
 			dev_warn(dev, "failed to get system register.\n");
 			ctx->sysreg = NULL;
 		}
+
+		match = of_match_node(exynos_drm_gsc_of_match, dev->of_node);
+		if (!match)
+			return -ENODEV;
+
+		driver_data = (struct gsc_driverdata *)match->data;
+		ctx->ippdrv.prop_list.rot_max = driver_data->rot_max;
 	}
 
 	/* clock control */
@@ -1784,12 +1832,6 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	SET_RUNTIME_PM_OPS(gsc_runtime_suspend, gsc_runtime_resume, NULL)
 };
 
-static const struct of_device_id exynos_drm_gsc_of_match[] = {
-	{ .compatible = "samsung,exynos5-gsc" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, exynos_drm_gsc_of_match);
-
 struct platform_driver gsc_driver = {
 	.probe		= gsc_probe,
 	.remove		= gsc_remove,
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index cb3e9f9..d5d5518 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -192,6 +192,7 @@ enum drm_exynos_planer {
  * @crop_max: crop max resolution.
  * @scale_min: scale min resolution.
  * @scale_max: scale max resolution.
+ * @rot_max: rotation max resolution.
  */
 struct drm_exynos_ipp_prop_list {
 	__u32	version;
@@ -210,6 +211,7 @@ struct drm_exynos_ipp_prop_list {
 	struct drm_exynos_sz	crop_max;
 	struct drm_exynos_sz	scale_min;
 	struct drm_exynos_sz	scale_max;
+	struct drm_exynos_sz	rot_max;
 };
 
 /**
-- 
1.9.1
