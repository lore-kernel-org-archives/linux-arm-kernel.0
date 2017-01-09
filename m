From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  9 Jan 2017 22:35:44 +0800
Subject: [PATCH v4 3/3] drm: zte: add overlay plane support
In-Reply-To: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
References: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1483972544-12731-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It enables VOU VL (Video Layer) to support overlay plane with scaling
function.  VL0 has some quirks on scaling support.  We choose to skip it
and only adds VL1 and VL2 into DRM core for now.

Function zx_plane_atomic_disable() gets moved around with no changes to
save a forward declaration.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/zte/zx_plane.c      | 301 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/zte/zx_plane.h      |   1 +
 drivers/gpu/drm/zte/zx_plane_regs.h |  51 ++++++
 drivers/gpu/drm/zte/zx_vou.c        |  84 +++++++++-
 drivers/gpu/drm/zte/zx_vou_regs.h   |  18 +++
 5 files changed, 426 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 5445eebf830f..24426c2b4b8f 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -30,6 +30,261 @@
 	DRM_FORMAT_ARGB4444,
 };
 
+static const uint32_t vl_formats[] = {
+	DRM_FORMAT_NV12,	/* Semi-planar YUV420 */
+	DRM_FORMAT_YUV420,	/* Planar YUV420 */
+	DRM_FORMAT_YUYV,	/* Packed YUV422 */
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_YUV444,	/* YUV444 8bit */
+	/*
+	 * TODO: add formats below that HW supports:
+	 *  - YUV420 P010
+	 *  - YUV420 Hantro
+	 *  - YUV444 10bit
+	 */
+};
+
+#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
+
+static int zx_vl_plane_atomic_check(struct drm_plane *plane,
+				    struct drm_plane_state *plane_state)
+{
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_rect clip;
+	int min_scale = FRAC_16_16(1, 8);
+	int max_scale = FRAC_16_16(8, 1);
+
+	if (!crtc || !fb)
+		return 0;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(plane_state->state,
+							crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	/* nothing to check when disabling or disabled */
+	if (!crtc_state->enable)
+		return 0;
+
+	/* plane must be enabled */
+	if (!plane_state->crtc)
+		return -EINVAL;
+
+	clip.x1 = 0;
+	clip.y1 = 0;
+	clip.x2 = crtc_state->adjusted_mode.hdisplay;
+	clip.y2 = crtc_state->adjusted_mode.vdisplay;
+
+	return drm_plane_helper_check_state(plane_state, &clip,
+					    min_scale, max_scale,
+					    true, true);
+}
+
+static int zx_vl_get_fmt(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12:
+		return VL_FMT_YUV420;
+	case DRM_FORMAT_YUV420:
+		return VL_YUV420_PLANAR | VL_FMT_YUV420;
+	case DRM_FORMAT_YUYV:
+		return VL_YUV422_YUYV | VL_FMT_YUV422;
+	case DRM_FORMAT_YVYU:
+		return VL_YUV422_YVYU | VL_FMT_YUV422;
+	case DRM_FORMAT_UYVY:
+		return VL_YUV422_UYVY | VL_FMT_YUV422;
+	case DRM_FORMAT_VYUY:
+		return VL_YUV422_VYUY | VL_FMT_YUV422;
+	case DRM_FORMAT_YUV444:
+		return VL_FMT_YUV444_8BIT;
+	default:
+		WARN_ONCE(1, "invalid pixel format %d\n", format);
+		return -EINVAL;
+	}
+}
+
+static inline void zx_vl_set_update(struct zx_plane *zplane)
+{
+	void __iomem *layer = zplane->layer;
+
+	zx_writel_mask(layer + VL_CTRL0, VL_UPDATE, VL_UPDATE);
+}
+
+static inline void zx_vl_rsz_set_update(struct zx_plane *zplane)
+{
+	zx_writel(zplane->rsz + RSZ_VL_ENABLE_CFG, 1);
+}
+
+static int zx_vl_rsz_get_fmt(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_YUV420:
+		return RSZ_VL_FMT_YCBCR420;
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_VYUY:
+		return RSZ_VL_FMT_YCBCR422;
+	case DRM_FORMAT_YUV444:
+		return RSZ_VL_FMT_YCBCR444;
+	default:
+		WARN_ONCE(1, "invalid pixel format %d\n", format);
+		return -EINVAL;
+	}
+}
+
+static inline u32 rsz_step_value(u32 src, u32 dst)
+{
+	u32 val = 0;
+
+	if (src == dst)
+		val = 0;
+	else if (src < dst)
+		val = RSZ_PARA_STEP((src << 16) / dst);
+	else if (src > dst)
+		val = RSZ_DATA_STEP(src / dst) |
+		      RSZ_PARA_STEP(((src << 16) / dst) & 0xffff);
+
+	return val;
+}
+
+static void zx_vl_rsz_setup(struct zx_plane *zplane, uint32_t format,
+			    u32 src_w, u32 src_h, u32 dst_w, u32 dst_h)
+{
+	void __iomem *rsz = zplane->rsz;
+	u32 src_chroma_w = src_w;
+	u32 src_chroma_h = src_h;
+	u32 fmt;
+
+	/* Set up source and destination resolution */
+	zx_writel(rsz + RSZ_SRC_CFG, RSZ_VER(src_h - 1) | RSZ_HOR(src_w - 1));
+	zx_writel(rsz + RSZ_DEST_CFG, RSZ_VER(dst_h - 1) | RSZ_HOR(dst_w - 1));
+
+	/* Configure data format for VL RSZ */
+	fmt = zx_vl_rsz_get_fmt(format);
+	if (fmt >= 0)
+		zx_writel_mask(rsz + RSZ_VL_CTRL_CFG, RSZ_VL_FMT_MASK, fmt);
+
+	/* Calculate Chroma height and width */
+	if (fmt == RSZ_VL_FMT_YCBCR420) {
+		src_chroma_w = src_w >> 1;
+		src_chroma_h = src_h >> 1;
+	} else if (fmt == RSZ_VL_FMT_YCBCR422) {
+		src_chroma_w = src_w >> 1;
+	}
+
+	/* Set up Luma and Chroma step registers */
+	zx_writel(rsz + RSZ_VL_LUMA_HOR, rsz_step_value(src_w, dst_w));
+	zx_writel(rsz + RSZ_VL_LUMA_VER, rsz_step_value(src_h, dst_h));
+	zx_writel(rsz + RSZ_VL_CHROMA_HOR, rsz_step_value(src_chroma_w, dst_w));
+	zx_writel(rsz + RSZ_VL_CHROMA_VER, rsz_step_value(src_chroma_h, dst_h));
+
+	zx_vl_rsz_set_update(zplane);
+}
+
+static void zx_vl_plane_atomic_update(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_rect *src = &state->src;
+	struct drm_rect *dst = &state->dst;
+	struct drm_gem_cma_object *cma_obj;
+	void __iomem *layer = zplane->layer;
+	void __iomem *hbsc = zplane->hbsc;
+	void __iomem *paddr_reg;
+	dma_addr_t paddr;
+	u32 src_x, src_y, src_w, src_h;
+	u32 dst_x, dst_y, dst_w, dst_h;
+	uint32_t format;
+	u32 fmt;
+	int num_planes;
+	int i;
+
+	if (!fb)
+		return;
+
+	format = fb->pixel_format;
+
+	src_x = src->x1 >> 16;
+	src_y = src->y1 >> 16;
+	src_w = drm_rect_width(src) >> 16;
+	src_h = drm_rect_height(src) >> 16;
+
+	dst_x = dst->x1;
+	dst_y = dst->y1;
+	dst_w = drm_rect_width(dst);
+	dst_h = drm_rect_height(dst);
+
+	/* Set up data address registers for Y, Cb and Cr planes */
+	num_planes = drm_format_num_planes(format);
+	paddr_reg = layer + VL_Y;
+	for (i = 0; i < num_planes; i++) {
+		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
+		paddr = cma_obj->paddr + fb->offsets[i];
+		paddr += src_y * fb->pitches[i];
+		paddr += src_x * drm_format_plane_cpp(format, i);
+		zx_writel(paddr_reg, paddr);
+		paddr_reg += 4;
+	}
+
+	/* Set up source height/width register */
+	zx_writel(layer + VL_SRC_SIZE, GL_SRC_W(src_w) | GL_SRC_H(src_h));
+
+	/* Set up start position register */
+	zx_writel(layer + VL_POS_START, GL_POS_X(dst_x) | GL_POS_Y(dst_y));
+
+	/* Set up end position register */
+	zx_writel(layer + VL_POS_END,
+		  GL_POS_X(dst_x + dst_w) | GL_POS_Y(dst_y + dst_h));
+
+	/* Strides of Cb and Cr planes should be identical */
+	zx_writel(layer + VL_STRIDE, LUMA_STRIDE(fb->pitches[0]) |
+		  CHROMA_STRIDE(fb->pitches[1]));
+
+	/* Set up video layer data format */
+	fmt = zx_vl_get_fmt(format);
+	if (fmt >= 0)
+		zx_writel(layer + VL_CTRL1, fmt);
+
+	/* Always use scaler since it exists (set for not bypass) */
+	zx_writel_mask(layer + VL_CTRL2, VL_SCALER_BYPASS_MODE,
+		       VL_SCALER_BYPASS_MODE);
+
+	zx_vl_rsz_setup(zplane, format, src_w, src_h, dst_w, dst_h);
+
+	/* Enable HBSC block */
+	zx_writel_mask(hbsc + HBSC_CTRL0, HBSC_CTRL_EN, HBSC_CTRL_EN);
+
+	zx_vou_layer_enable(plane);
+
+	zx_vl_set_update(zplane);
+}
+
+static void zx_plane_atomic_disable(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+	void __iomem *hbsc = zplane->hbsc;
+
+	zx_vou_layer_disable(plane);
+
+	/* Disable HBSC block */
+	zx_writel_mask(hbsc + HBSC_CTRL0, HBSC_CTRL_EN, 0);
+}
+
+static const struct drm_plane_helper_funcs zx_vl_plane_helper_funcs = {
+	.atomic_check = zx_vl_plane_atomic_check,
+	.atomic_update = zx_vl_plane_atomic_update,
+	.atomic_disable = zx_plane_atomic_disable,
+};
+
 static int zx_gl_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *plane_state)
 {
@@ -97,14 +352,6 @@ static inline void zx_gl_rsz_set_update(struct zx_plane *zplane)
 	zx_writel(zplane->rsz + RSZ_ENABLE_CFG, 1);
 }
 
-void zx_plane_set_update(struct drm_plane *plane)
-{
-	struct zx_plane *zplane = to_zx_plane(plane);
-
-	zx_gl_rsz_set_update(zplane);
-	zx_gl_set_update(zplane);
-}
-
 static void zx_gl_rsz_setup(struct zx_plane *zplane, u32 src_w, u32 src_h,
 			    u32 dst_w, u32 dst_h)
 {
@@ -202,18 +449,6 @@ static void zx_gl_plane_atomic_update(struct drm_plane *plane,
 	zx_gl_set_update(zplane);
 }
 
-static void zx_plane_atomic_disable(struct drm_plane *plane,
-				    struct drm_plane_state *old_state)
-{
-	struct zx_plane *zplane = to_zx_plane(plane);
-	void __iomem *hbsc = zplane->hbsc;
-
-	zx_vou_layer_disable(plane);
-
-	/* Disable HBSC block */
-	zx_writel_mask(hbsc + HBSC_CTRL0, HBSC_CTRL_EN, 0);
-}
-
 static const struct drm_plane_helper_funcs zx_gl_plane_helper_funcs = {
 	.atomic_check = zx_gl_plane_atomic_check,
 	.atomic_update = zx_gl_plane_atomic_update,
@@ -235,6 +470,28 @@ static void zx_plane_destroy(struct drm_plane *plane)
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
+void zx_plane_set_update(struct drm_plane *plane)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+
+	/* Do nothing if the layer is not enabled */
+	if (!zplane->enabled)
+		return;
+
+	switch (plane->type) {
+	case DRM_PLANE_TYPE_PRIMARY:
+		zx_gl_rsz_set_update(zplane);
+		zx_gl_set_update(zplane);
+		break;
+	case DRM_PLANE_TYPE_OVERLAY:
+		zx_vl_rsz_set_update(zplane);
+		zx_vl_set_update(zplane);
+		break;
+	default:
+		WARN_ONCE(1, "unsupported plane type %d\n", plane->type);
+	}
+}
+
 static void zx_plane_hbsc_init(struct zx_plane *zplane)
 {
 	void __iomem *hbsc = zplane->hbsc;
@@ -272,7 +529,9 @@ int zx_plane_init(struct drm_device *drm, struct zx_plane *zplane,
 		format_count = ARRAY_SIZE(gl_formats);
 		break;
 	case DRM_PLANE_TYPE_OVERLAY:
-		/* TODO: add video layer (vl) support */
+		helper = &zx_vl_plane_helper_funcs;
+		formats = vl_formats;
+		format_count = ARRAY_SIZE(vl_formats);
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/gpu/drm/zte/zx_plane.h b/drivers/gpu/drm/zte/zx_plane.h
index 933611ddffd0..e8f9b138114d 100644
--- a/drivers/gpu/drm/zte/zx_plane.h
+++ b/drivers/gpu/drm/zte/zx_plane.h
@@ -19,6 +19,7 @@ struct zx_plane {
 	void __iomem *hbsc;
 	void __iomem *rsz;
 	const struct vou_layer_bits *bits;
+	bool enabled;
 };
 
 #define to_zx_plane(plane) container_of(plane, struct zx_plane, plane)
diff --git a/drivers/gpu/drm/zte/zx_plane_regs.h b/drivers/gpu/drm/zte/zx_plane_regs.h
index 3dde6716a558..65f271aeabed 100644
--- a/drivers/gpu/drm/zte/zx_plane_regs.h
+++ b/drivers/gpu/drm/zte/zx_plane_regs.h
@@ -46,6 +46,37 @@
 #define GL_POS_X(x)	(((x) << GL_POS_X_SHIFT) & GL_POS_X_MASK)
 #define GL_POS_Y(x)	(((x) << GL_POS_Y_SHIFT) & GL_POS_Y_MASK)
 
+/* VL registers */
+#define VL_CTRL0			0x00
+#define VL_UPDATE			BIT(3)
+#define VL_CTRL1			0x04
+#define VL_YUV420_PLANAR		BIT(5)
+#define VL_YUV422_SHIFT			3
+#define VL_YUV422_YUYV			(0 << VL_YUV422_SHIFT)
+#define VL_YUV422_YVYU			(1 << VL_YUV422_SHIFT)
+#define VL_YUV422_UYVY			(2 << VL_YUV422_SHIFT)
+#define VL_YUV422_VYUY			(3 << VL_YUV422_SHIFT)
+#define VL_FMT_YUV420			0
+#define VL_FMT_YUV422			1
+#define VL_FMT_YUV420_P010		2
+#define VL_FMT_YUV420_HANTRO		3
+#define VL_FMT_YUV444_8BIT		4
+#define VL_FMT_YUV444_10BIT		5
+#define VL_CTRL2			0x08
+#define VL_SCALER_BYPASS_MODE		BIT(0)
+#define VL_STRIDE			0x0c
+#define LUMA_STRIDE_SHIFT		16
+#define LUMA_STRIDE_MASK		(0xffff << LUMA_STRIDE_SHIFT)
+#define CHROMA_STRIDE_SHIFT		0
+#define CHROMA_STRIDE_MASK		(0xffff << CHROMA_STRIDE_SHIFT)
+#define VL_SRC_SIZE			0x10
+#define VL_Y				0x14
+#define VL_POS_START			0x30
+#define VL_POS_END			0x34
+
+#define LUMA_STRIDE(x)	 (((x) << LUMA_STRIDE_SHIFT) & LUMA_STRIDE_MASK)
+#define CHROMA_STRIDE(x) (((x) << CHROMA_STRIDE_SHIFT) & CHROMA_STRIDE_MASK)
+
 /* CSC registers */
 #define CSC_CTRL0			0x30
 #define CSC_COV_MODE_SHIFT		16
@@ -69,6 +100,18 @@
 #define RSZ_DEST_CFG			0x04
 #define RSZ_ENABLE_CFG			0x14
 
+#define RSZ_VL_LUMA_HOR			0x08
+#define RSZ_VL_LUMA_VER			0x0c
+#define RSZ_VL_CHROMA_HOR		0x10
+#define RSZ_VL_CHROMA_VER		0x14
+#define RSZ_VL_CTRL_CFG			0x18
+#define RSZ_VL_FMT_SHIFT		3
+#define RSZ_VL_FMT_MASK			(0x3 << RSZ_VL_FMT_SHIFT)
+#define RSZ_VL_FMT_YCBCR420		(0x0 << RSZ_VL_FMT_SHIFT)
+#define RSZ_VL_FMT_YCBCR422		(0x1 << RSZ_VL_FMT_SHIFT)
+#define RSZ_VL_FMT_YCBCR444		(0x2 << RSZ_VL_FMT_SHIFT)
+#define RSZ_VL_ENABLE_CFG		0x1c
+
 #define RSZ_VER_SHIFT			16
 #define RSZ_VER_MASK			(0xffff << RSZ_VER_SHIFT)
 #define RSZ_HOR_SHIFT			0
@@ -77,6 +120,14 @@
 #define RSZ_VER(x)	(((x) << RSZ_VER_SHIFT) & RSZ_VER_MASK)
 #define RSZ_HOR(x)	(((x) << RSZ_HOR_SHIFT) & RSZ_HOR_MASK)
 
+#define RSZ_DATA_STEP_SHIFT		16
+#define RSZ_DATA_STEP_MASK		(0xffff << RSZ_DATA_STEP_SHIFT)
+#define RSZ_PARA_STEP_SHIFT		0
+#define RSZ_PARA_STEP_MASK		(0xffff << RSZ_PARA_STEP_SHIFT)
+
+#define RSZ_DATA_STEP(x) (((x) << RSZ_DATA_STEP_SHIFT) & RSZ_DATA_STEP_MASK)
+#define RSZ_PARA_STEP(x) (((x) << RSZ_PARA_STEP_SHIFT) & RSZ_PARA_STEP_MASK)
+
 /* HBSC registers */
 #define HBSC_SATURATION			0x00
 #define HBSC_HUE			0x04
diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index 3fb4fc04e693..8e7edda184d0 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -112,6 +112,22 @@ struct vou_layer_bits {
 	},
 };
 
+static const struct vou_layer_bits zx_vl_bits[VL_NUM] = {
+	{
+		.enable = OSD_CTRL0_VL0_EN,
+		.chnsel = OSD_CTRL0_VL0_SEL,
+		.clksel = VOU_CLK_VL0_SEL,
+	}, {
+		.enable = OSD_CTRL0_VL1_EN,
+		.chnsel = OSD_CTRL0_VL1_SEL,
+		.clksel = VOU_CLK_VL1_SEL,
+	}, {
+		.enable = OSD_CTRL0_VL2_EN,
+		.chnsel = OSD_CTRL0_VL2_SEL,
+		.clksel = VOU_CLK_VL2_SEL,
+	},
+};
+
 struct zx_vou_hw {
 	struct device *dev;
 	void __iomem *osd;
@@ -125,6 +141,7 @@ struct zx_vou_hw {
 	struct clk *aux_clk;
 	struct zx_crtc *main_crtc;
 	struct zx_crtc *aux_crtc;
+	struct drm_plane *overlays[VL_NUM];
 };
 
 static inline struct zx_vou_hw *crtc_to_vou(struct drm_crtc *crtc)
@@ -439,6 +456,8 @@ void zx_vou_layer_enable(struct drm_plane *plane)
 	}
 
 	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, bits->enable);
+
+	zplane->enabled = true;
 }
 
 void zx_vou_layer_disable(struct drm_plane *plane)
@@ -449,6 +468,57 @@ void zx_vou_layer_disable(struct drm_plane *plane)
 	const struct vou_layer_bits *bits = zplane->bits;
 
 	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, 0);
+
+	zplane->enabled = false;
+}
+
+static void zx_overlay_init(struct drm_device *drm, struct zx_vou_hw *vou)
+{
+	struct device *dev = vou->dev;
+	struct zx_plane *zplane;
+	int i;
+	int ret;
+
+	/*
+	 * VL0 has some quirks on scaling support which need special handling.
+	 * Let's leave it out for now.
+	 */
+	for (i = 1; i < VL_NUM; i++) {
+		zplane = devm_kzalloc(dev, sizeof(*zplane), GFP_KERNEL);
+		if (!zplane) {
+			DRM_DEV_ERROR(dev, "failed to allocate zplane %d\n", i);
+			return;
+		}
+
+		zplane->layer = vou->osd + OSD_VL_OFFSET(i);
+		zplane->hbsc = vou->osd + HBSC_VL_OFFSET(i);
+		zplane->rsz = vou->otfppu + RSZ_VL_OFFSET(i);
+		zplane->bits = &zx_vl_bits[i];
+
+		ret = zx_plane_init(drm, zplane, DRM_PLANE_TYPE_OVERLAY);
+		if (ret) {
+			DRM_DEV_ERROR(dev, "failed to init overlay %d\n", i);
+			continue;
+		}
+
+		vou->overlays[i] = &zplane->plane;
+	}
+}
+
+static inline void zx_osd_int_update(struct zx_crtc *zcrtc)
+{
+	struct zx_vou_hw *vou = zcrtc->vou;
+	int i;
+
+	vou_chn_set_update(zcrtc);
+	zx_plane_set_update(zcrtc->primary);
+
+	for (i = 0; i < VL_NUM; i++) {
+		struct drm_plane *overlay = vou->overlays[i];
+
+		if (overlay)
+			zx_plane_set_update(overlay);
+	}
 }
 
 static irqreturn_t vou_irq_handler(int irq, void *dev_id)
@@ -470,15 +540,11 @@ static irqreturn_t vou_irq_handler(int irq, void *dev_id)
 	state = zx_readl(vou->osd + OSD_INT_STA);
 	zx_writel(vou->osd + OSD_INT_CLRSTA, state);
 
-	if (state & OSD_INT_MAIN_UPT) {
-		vou_chn_set_update(vou->main_crtc);
-		zx_plane_set_update(vou->main_crtc->primary);
-	}
+	if (state & OSD_INT_MAIN_UPT)
+		zx_osd_int_update(vou->main_crtc);
 
-	if (state & OSD_INT_AUX_UPT) {
-		vou_chn_set_update(vou->aux_crtc);
-		zx_plane_set_update(vou->aux_crtc->primary);
-	}
+	if (state & OSD_INT_AUX_UPT)
+		zx_osd_int_update(vou->aux_crtc);
 
 	if (state & OSD_INT_ERROR)
 		DRM_DEV_ERROR(vou->dev, "OSD ERROR: 0x%08x!\n", state);
@@ -648,6 +714,8 @@ static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
 		goto disable_ppu_clk;
 	}
 
+	zx_overlay_init(drm, vou);
+
 	return 0;
 
 disable_ppu_clk:
diff --git a/drivers/gpu/drm/zte/zx_vou_regs.h b/drivers/gpu/drm/zte/zx_vou_regs.h
index f44e7a4ae441..193c1ce01fe7 100644
--- a/drivers/gpu/drm/zte/zx_vou_regs.h
+++ b/drivers/gpu/drm/zte/zx_vou_regs.h
@@ -22,6 +22,15 @@
 #define AUX_HBSC_OFFSET			0x860
 #define AUX_RSZ_OFFSET			0x800
 
+#define OSD_VL0_OFFSET			0x040
+#define OSD_VL_OFFSET(i)		(OSD_VL0_OFFSET + 0x050 * (i))
+
+#define HBSC_VL0_OFFSET			0x760
+#define HBSC_VL_OFFSET(i)		(HBSC_VL0_OFFSET + 0x040 * (i))
+
+#define RSZ_VL1_U0			0xa00
+#define RSZ_VL_OFFSET(i)		(RSZ_VL1_U0 + 0x200 * (i))
+
 /* OSD (GPC_GLOBAL) registers */
 #define OSD_INT_STA			0x04
 #define OSD_INT_CLRSTA			0x08
@@ -42,6 +51,12 @@
 )
 #define OSD_INT_ENABLE (OSD_INT_ERROR | OSD_INT_AUX_UPT | OSD_INT_MAIN_UPT)
 #define OSD_CTRL0			0x10
+#define OSD_CTRL0_VL0_EN		BIT(13)
+#define OSD_CTRL0_VL0_SEL		BIT(12)
+#define OSD_CTRL0_VL1_EN		BIT(11)
+#define OSD_CTRL0_VL1_SEL		BIT(10)
+#define OSD_CTRL0_VL2_EN		BIT(9)
+#define OSD_CTRL0_VL2_SEL		BIT(8)
 #define OSD_CTRL0_GL0_EN		BIT(7)
 #define OSD_CTRL0_GL0_SEL		BIT(6)
 #define OSD_CTRL0_GL1_EN		BIT(5)
@@ -146,6 +161,9 @@
 #define VOU_INF_DATA_SEL		0x08
 #define VOU_SOFT_RST			0x14
 #define VOU_CLK_SEL			0x18
+#define VOU_CLK_VL2_SEL			BIT(8)
+#define VOU_CLK_VL1_SEL			BIT(7)
+#define VOU_CLK_VL0_SEL			BIT(6)
 #define VOU_CLK_GL1_SEL			BIT(5)
 #define VOU_CLK_GL0_SEL			BIT(4)
 #define VOU_CLK_REQEN			0x20
-- 
1.9.1
