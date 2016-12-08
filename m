From: shawnguo@kernel.org (Shawn Guo)
Date: Thu,  8 Dec 2016 11:12:41 +0800
Subject: [PATCH] drm: zte: add overlay plane support
Message-ID: <1481166761-5100-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It enables VOU VL (Video Layer) to support overlay plane with scaling
function.  VL0 has some quirks on scaling support.  We chose to skip it
and only adds VL1 and VL2 into DRM core for now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/zte/zx_plane.c      | 290 ++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/zte/zx_plane_regs.h |  51 +++++++
 drivers/gpu/drm/zte/zx_vou.c        | 149 +++++++++++++++++-
 drivers/gpu/drm/zte/zx_vou.h        |   3 +
 drivers/gpu/drm/zte/zx_vou_regs.h   |  18 +++
 5 files changed, 494 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 546eb92a94e8..0dd48c66a02e 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -40,6 +40,266 @@ struct zx_plane {
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
+static u32 zx_vl_get_fmt(uint32_t format)
+{
+	u32 val = 0;
+
+	switch (format) {
+	case DRM_FORMAT_NV12:
+		val = VL_FMT_YUV420;
+		break;
+	case DRM_FORMAT_YUV420:
+		val = VL_YUV420_PLANAR | VL_FMT_YUV420;
+		break;
+	case DRM_FORMAT_YUYV:
+		val = VL_YUV422_YUYV | VL_FMT_YUV422;
+		break;
+	case DRM_FORMAT_YVYU:
+		val = VL_YUV422_YVYU | VL_FMT_YUV422;
+		break;
+	case DRM_FORMAT_UYVY:
+		val = VL_YUV422_UYVY | VL_FMT_YUV422;
+		break;
+	case DRM_FORMAT_VYUY:
+		val = VL_YUV422_VYUY | VL_FMT_YUV422;
+		break;
+	case DRM_FORMAT_YUV444:
+		val = VL_FMT_YUV444_8BIT;
+		break;
+	default:
+		WARN_ONCE(1, "invalid pixel format %d\n", format);
+	}
+
+	return val;
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
+static u32 zx_vl_rsz_get_fmt(uint32_t format)
+{
+	u32 val = 0;
+
+	switch (format) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_YUV420:
+		val = RSZ_VL_FMT_YCBCR420;
+		break;
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_VYUY:
+		val = RSZ_VL_FMT_YCBCR422;
+		break;
+	case DRM_FORMAT_YUV444:
+		val = RSZ_VL_FMT_YCBCR444;
+		break;
+	default:
+		WARN_ONCE(1, "invalid pixel format %d\n", format);
+	}
+
+	return val;
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
+	zx_writel_mask(rsz + RSZ_VL_CTRL_CFG, RSZ_VL_FMT_MASK, fmt);
+
+	/* Calculate Chroma heigth and width */
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
+	struct drm_framebuffer *fb = plane->state->fb;
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
+	src_x = plane->state->src_x >> 16;
+	src_y = plane->state->src_y >> 16;
+	src_w = plane->state->src_w >> 16;
+	src_h = plane->state->src_h >> 16;
+
+	dst_x = plane->state->crtc_x;
+	dst_y = plane->state->crtc_y;
+	dst_w = plane->state->crtc_w;
+	dst_h = plane->state->crtc_h;
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
+	zx_writel(layer + VL_CTRL1, fmt);
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
+	zx_overlay_enable(plane);
+
+	zx_vl_set_update(zplane);
+}
+
+static void zx_vl_plane_atomic_disable(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
+{
+	zx_overlay_disable(plane);
+}
+
+static const struct drm_plane_helper_funcs zx_vl_plane_helper_funcs = {
+	.atomic_check = zx_vl_plane_atomic_check,
+	.atomic_update = zx_vl_plane_atomic_update,
+	.atomic_disable = zx_vl_plane_atomic_disable,
+};
+
 static int zx_gl_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *plane_state)
 {
@@ -107,14 +367,6 @@ static inline void zx_gl_rsz_set_update(struct zx_plane *zplane)
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
@@ -230,6 +482,24 @@ static void zx_plane_destroy(struct drm_plane *plane)
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
+void zx_plane_set_update(struct drm_plane *plane)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
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
@@ -279,7 +549,9 @@ struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
 		format_count = ARRAY_SIZE(gl_formats);
 		break;
 	case DRM_PLANE_TYPE_OVERLAY:
-		/* TODO: add video layer (vl) support */
+		helper = &zx_vl_plane_helper_funcs;
+		formats = vl_formats;
+		format_count = ARRAY_SIZE(vl_formats);
 		break;
 	default:
 		return ERR_PTR(-ENODEV);
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
index 73fe15c17c32..8ca9c4bdeeaf 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -93,10 +93,38 @@ struct zx_crtc {
 	const struct zx_crtc_bits *bits;
 	enum vou_chn_type chn_type;
 	struct clk *pixclk;
+	u32 overlay_bitmap;
 };
 
 #define to_zx_crtc(x) container_of(x, struct zx_crtc, crtc)
 
+struct zx_vl_bits {
+	u32 enable;
+	u32 chnsel;
+	u32 clksel;
+};
+
+static const struct zx_vl_bits zx_vl_bits[VL_NUM] = {
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
+struct zx_overlay {
+	struct drm_plane *plane;
+	const struct zx_vl_bits *bits;
+};
+
 struct zx_vou_hw {
 	struct device *dev;
 	void __iomem *osd;
@@ -110,6 +138,7 @@ struct zx_vou_hw {
 	struct clk *aux_clk;
 	struct zx_crtc *main_crtc;
 	struct zx_crtc *aux_crtc;
+	struct zx_overlay overlays[VL_NUM];
 };
 
 static inline struct zx_vou_hw *crtc_to_vou(struct drm_crtc *crtc)
@@ -404,6 +433,112 @@ void zx_vou_disable_vblank(struct drm_device *drm, unsigned int pipe)
 		       zcrtc->bits->int_frame_mask, 0);
 }
 
+static int zx_overlay_find_vl_idx(struct drm_plane *plane,
+				  struct zx_vou_hw *vou)
+{
+	int i;
+
+	for (i = 0; i < VL_NUM; i++) {
+		if (vou->overlays[i].plane == plane)
+			break;
+	}
+
+	if (i == VL_NUM) {
+		DRM_DEV_ERROR(vou->dev, "failed to find VL\n");
+		return -EINVAL;
+	}
+
+	return i;
+}
+
+void zx_overlay_enable(struct drm_plane *plane)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(plane->state->crtc);
+	struct zx_vou_hw *vou = zcrtc->vou;
+	const struct zx_vl_bits *bits;
+	int idx;
+
+	idx = zx_overlay_find_vl_idx(plane, vou);
+	if (idx < 0)
+		return;
+
+	bits = vou->overlays[idx].bits;
+	zcrtc->overlay_bitmap |= 1 << idx;
+
+	if (zcrtc->chn_type == VOU_CHN_MAIN) {
+		zx_writel_mask(vou->osd + OSD_CTRL0, bits->chnsel, 0);
+		zx_writel_mask(vou->vouctl + VOU_CLK_SEL, bits->clksel, 0);
+	} else {
+		zx_writel_mask(vou->osd + OSD_CTRL0, bits->chnsel,
+			       bits->chnsel);
+		zx_writel_mask(vou->vouctl + VOU_CLK_SEL, bits->clksel,
+			       bits->clksel);
+	}
+
+	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, bits->enable);
+}
+
+void zx_overlay_disable(struct drm_plane *plane)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(plane->crtc);
+	struct zx_vou_hw *vou = zcrtc->vou;
+	const struct zx_vl_bits *bits;
+	int idx;
+
+	idx = zx_overlay_find_vl_idx(plane, vou);
+	if (idx < 0)
+		return;
+
+	bits = vou->overlays[idx].bits;
+	zcrtc->overlay_bitmap &= ~(1 << idx);
+
+	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, 0);
+}
+
+static void zx_overlay_init(struct drm_device *drm, struct zx_vou_hw *vou)
+{
+	struct device *dev = vou->dev;
+	struct drm_plane *plane;
+	struct zx_layer_data data;
+	int i;
+
+	/*
+	 * VL0 has some quirks on scaling support which need special handling.
+	 * Let's leave it out for now.
+	 */
+	for (i = 1; i < VL_NUM; i++) {
+		data.layer = vou->osd + OSD_VL_OFFSET(i);
+		data.hbsc = vou->osd + HBSC_VL_OFFSET(i);
+		data.rsz = vou->otfppu + RSZ_VL_OFFSET(i);
+
+		plane = zx_plane_init(drm, dev, &data, DRM_PLANE_TYPE_OVERLAY);
+		if (IS_ERR(plane)) {
+			DRM_DEV_ERROR(dev, "failed to init overlay %d\n", i);
+			continue;
+		}
+
+		vou->overlays[i].plane = plane;
+		vou->overlays[i].bits = &zx_vl_bits[i];
+	}
+}
+
+static inline void zx_osd_int_update(struct zx_crtc *zcrtc)
+{
+	u32 bitmap = zcrtc->overlay_bitmap;
+	int i;
+
+	vou_chn_set_update(zcrtc);
+	zx_plane_set_update(zcrtc->primary);
+
+	if (bitmap) {
+		for (i = 0; i < VL_NUM; i++)  {
+			if ((bitmap & (1 << i)) == 0)
+				continue;
+			zx_plane_set_update(zcrtc->vou->overlays[i].plane);
+		}
+	}
+}
+
 static irqreturn_t vou_irq_handler(int irq, void *dev_id)
 {
 	struct zx_vou_hw *vou = dev_id;
@@ -423,15 +558,11 @@ static irqreturn_t vou_irq_handler(int irq, void *dev_id)
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
@@ -611,6 +742,8 @@ static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
 		goto disable_ppu_clk;
 	}
 
+	zx_overlay_init(drm, vou);
+
 	return 0;
 
 disable_ppu_clk:
diff --git a/drivers/gpu/drm/zte/zx_vou.h b/drivers/gpu/drm/zte/zx_vou.h
index 349e06cd86f4..1559c1f79db7 100644
--- a/drivers/gpu/drm/zte/zx_vou.h
+++ b/drivers/gpu/drm/zte/zx_vou.h
@@ -43,4 +43,7 @@ struct vou_inf {
 int zx_vou_enable_vblank(struct drm_device *drm, unsigned int pipe);
 void zx_vou_disable_vblank(struct drm_device *drm, unsigned int pipe);
 
+void zx_overlay_enable(struct drm_plane *plane);
+void zx_overlay_disable(struct drm_plane *plane);
+
 #endif /* __ZX_VOU_H__ */
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
