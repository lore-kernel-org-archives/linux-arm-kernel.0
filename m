From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 01 Sep 2017 10:47:56 +0900
Subject: [PATCH 3/3] drm/exynos/gsc: Add rotation hardware limits of gscaler
In-Reply-To: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170901014758epcas2p13ae73e7dcac72a1a28c9324164efbd6d@epcas2p1.samsung.com>
Message-ID: <1504230476-1878-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gscaler has hardware rotation limits that need to be imported from
dts. Parse them and add them to the property list.

The rotation hardware limits are related to the cropped source size.
When swap occurs, use rot_max size instead of crop_max size.

Also the scaling limits are related to post size, use pos size to
check the limits.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 63 +++++++++++++++++++++------------
 include/uapi/drm/exynos_drm.h           |  2 ++
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 0506b2b..dd9b057 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1401,6 +1401,23 @@ static int gsc_ippdrv_check_property(struct device *dev,
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
@@ -1416,21 +1433,6 @@ static int gsc_ippdrv_check_property(struct device *dev,
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
@@ -1438,21 +1440,27 @@ static int gsc_ippdrv_check_property(struct device *dev,
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
@@ -1463,17 +1471,17 @@ static int gsc_ippdrv_check_property(struct device *dev,
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
@@ -1676,6 +1684,15 @@ static int gsc_probe(struct platform_device *pdev)
 			dev_warn(dev, "failed to get system register.\n");
 			ctx->sysreg = NULL;
 		}
+
+		ret = of_property_read_u32(dev->of_node, "rot-max-hsize",
+				&ctx->ippdrv.prop_list.rot_max.hsize);
+		ret |= of_property_read_u32(dev->of_node, "rot-max-vsize",
+				&ctx->ippdrv.prop_list.rot_max.vsize);
+		if (ret) {
+			dev_err(dev, "rot-max property should be provided by device tree.\n");
+			return -EINVAL;
+		}
 	}
 
 	/* clock control */
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
