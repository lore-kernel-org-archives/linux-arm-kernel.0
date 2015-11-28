From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:39:00 +0800
Subject: [PATCH v2 05/10] drm/hisilicon: Add plane funcs for ADE
In-Reply-To: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1448707145-69348-6-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add plane funcs and helper funcs for ADE.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/gpu/drm/hisilicon/hisi_drm_ade.c | 479 +++++++++++++++++++++++++++++++
 1 file changed, 479 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
index d157879..b0976c3 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
@@ -23,15 +23,22 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_cma_helper.h>
 
 #include "hisi_drm_drv.h"
 #include "hisi_ade_reg.h"
 
 #define FORCE_PIXEL_CLOCK_SAME_OR_HIGHER 0
+#define PRIMARY_CH	(ADE_CH1)
 
 #define to_ade_crtc(crtc) \
 	container_of(crtc, struct ade_crtc, base)
 
+#define to_ade_plane(plane) \
+	container_of(plane, struct ade_plane, base)
+
 struct ade_hw_ctx {
 	void __iomem  *base;
 	void __iomem  *media_base;
@@ -53,11 +60,75 @@ struct ade_crtc {
 	u64 use_mask;
 };
 
+struct ade_plane {
+	struct drm_plane base;
+	void *ctx;
+	u8 ch; /* channel */
+};
+
 struct ade_data {
 	struct ade_crtc acrtc;
+	struct ade_plane aplane[ADE_CH_NUM];
 	struct ade_hw_ctx ctx;
 };
 
+/* ade-format info: */
+struct ade_format {
+	u32 pixel_format;
+	enum ADE_FORMAT ade_format;
+};
+
+static const struct ade_format ade_formats[] = {
+	/* 16bpp RGB: */
+	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
+	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
+	/* 24bpp RGB: */
+	{ DRM_FORMAT_RGB888, ADE_RGB_888 },
+	{ DRM_FORMAT_BGR888, ADE_BGR_888 },
+	/* 32bpp [A]RGB: */
+	{ DRM_FORMAT_XRGB8888, ADE_XRGB_8888 },
+	{ DRM_FORMAT_XBGR8888, ADE_XBGR_8888 },
+	{ DRM_FORMAT_RGBA8888, ADE_RGBA_8888 },
+	{ DRM_FORMAT_BGRA8888, ADE_BGRA_8888 },
+	{ DRM_FORMAT_ARGB8888, ADE_ARGB_8888 },
+	{ DRM_FORMAT_ABGR8888, ADE_ABGR_8888 },
+};
+
+static const u32 channel_formats1[] = {
+	/* channel 1,2,3,4 */
+	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888
+};
+
+u32 ade_get_channel_formats(u8 ch, const u32 **formats)
+{
+	switch (ch) {
+	case ADE_CH1:
+		*formats = channel_formats1;
+		return ARRAY_SIZE(channel_formats1);
+	default:
+		DRM_ERROR("no this channel %d\n", ch);
+		*formats = NULL;
+		return 0;
+	}
+}
+
+/* convert from fourcc format to ade format */
+static u32 ade_get_format(u32 pixel_format)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
+		if (ade_formats[i].pixel_format == pixel_format)
+			return ade_formats[i].ade_format;
+
+	/* not found */
+	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n", pixel_format);
+	return ADE_FORMAT_NOT_SUPPORT;
+}
+
 static void ade_init(struct ade_hw_ctx *ctx)
 {
 	void __iomem *base = ctx->base;
@@ -377,8 +448,416 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	return 0;
 }
 
+static void ade_rdma_set(struct ade_crtc *acrtc, struct drm_framebuffer *fb,
+			 u32 ch, u32 y, u32 in_h, u32 fmt)
+{
+	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
+	struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, 0);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 stride = fb->pitches[0];
+	u32 addr = (u32)obj->paddr + y * stride;
+
+	DRM_DEBUG_DRIVER("rdma%d: (y=%d, height=%d), stride=%d, paddr=0x%x,",
+			 "addr=0x%x, fb:%dx%d, pixel_format=%d(%s)\n",
+			 ch + 1, y, in_h, stride, (u32)obj->paddr,
+			 addr, fb->width, fb->height,
+			 fmt, drm_get_format_name(fb->pixel_format));
+
+	/* get reg offset */
+	reg_ctrl = RD_CH_CTRL(ch);
+	reg_addr = RD_CH_ADDR(ch);
+	reg_size = RD_CH_SIZE(ch);
+	reg_stride = RD_CH_STRIDE(ch);
+	reg_space = RD_CH_SPACE(ch);
+	reg_en = RD_CH_EN(ch);
+
+	/*
+	 * TODO: set rotation
+	 */
+	writel((fmt << 16) & 0x1f0000, base + reg_ctrl);
+	writel(addr, base + reg_addr);
+	writel((in_h << 16) | stride, base + reg_size);
+	writel(stride, base + reg_stride);
+	writel(in_h * stride, base + reg_space);
+	writel(1, base + reg_en);
+
+	acrtc->use_mask |= BIT(ADE_CH_RDMA_BIT_OFST + ch);
+}
+
+static void ade_rdma_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 reg_en;
+
+	/* get reg offset */
+	reg_en = RD_CH_EN(ch);
+
+	writel(0, base + reg_en);
+	acrtc->use_mask &= ~BIT(ADE_CH_RDMA_BIT_OFST + ch);
+}
+
+static void ade_clip_set(struct ade_crtc *acrtc, u32 ch, u32 fb_w, u32 x,
+			 u32 in_w, u32 in_h)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 disable_val;
+	u32 clip_left;
+	u32 clip_right;
+
+	/*
+	 * clip width, no need to clip height
+	 */
+	if (fb_w == in_w) { /* bypass */
+		disable_val = 1;
+		clip_left = 0;
+		clip_right = 0;
+	} else {
+		disable_val = 0;
+		clip_left = x;
+		clip_right = fb_w - (x + in_w) - 1;
+	}
+
+	DRM_DEBUG_DRIVER("clip%d: clip_left=%d, clip_right=%d\n",
+			 ch + 1, clip_left, clip_right);
+
+	writel(disable_val, base + ADE_CLIP_DISABLE(ch));
+	writel((fb_w - 1) << 16 | (in_h - 1), base + ADE_CLIP_SIZE0(ch));
+	writel(clip_left << 16 | clip_right, base + ADE_CLIP_SIZE1(ch));
+
+	acrtc->use_mask |= BIT(ADE_CLIP_BIT_OFST + ch);
+}
+
+static void ade_clip_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	writel(1, base + ADE_CLIP_DISABLE(ch));
+	acrtc->use_mask &= ~BIT(ADE_CLIP_BIT_OFST + ch);
+}
+
+static bool has_Alpha_channel(int format)
+{
+	switch (format) {
+	case ADE_ARGB_8888:
+	case ADE_ABGR_8888:
+	case ADE_RGBA_8888:
+	case ADE_BGRA_8888:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void ade_get_blending_params(u32 fmt, u8 glb_alpha, u8 *alp_mode,
+				    u8 *alp_sel, u8 *under_alp_sel)
+{
+	bool has_alpha = has_Alpha_channel(fmt);
+
+	/*
+	 * get alp_mode
+	 */
+	if (has_alpha && glb_alpha < 255)
+		*alp_mode = ADE_ALP_PIXEL_AND_GLB;
+	else if (has_alpha)
+		*alp_mode = ADE_ALP_PIXEL;
+	else
+		*alp_mode = ADE_ALP_GLOBAL;
+
+	/*
+	 * get alp sel
+	 */
+	*alp_sel = ADE_ALP_MUL_COEFF_3; /* 1 */
+	*under_alp_sel = ADE_ALP_MUL_COEFF_2; /* 0 */
+}
+
+static void ade_overlay_set(struct ade_crtc *acrtc, u8 ch, u32 x0, u32 y0,
+			    u32 in_w, u32 in_h, u32 fmt)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u8 ovly_ch = 0;
+	u8 x = ADE_OVLY2;
+	u8 glb_alpha = 255;
+	u32 x1 = x0 + in_w - 1;
+	u32 y1 = y0 + in_h - 1;
+	u32 val;
+	u8 alp_sel;
+	u8 under_alp_sel;
+	u8 alp_mode;
+
+	ade_get_blending_params(fmt, glb_alpha, &alp_mode, &alp_sel,
+				&under_alp_sel);
+
+	/* overlay routing setting */
+	writel(x0 << 16 | y0, base + ADE_OVLY_CH_XY0(ovly_ch));
+	writel(x1 << 16 | y1, base + ADE_OVLY_CH_XY1(ovly_ch));
+	val = (ch + 1) << ADE_OVLY_CH_SEL_OFST | BIT(ADE_OVLY_CH_EN_OFST) |
+		alp_sel << ADE_OVLY_CH_ALP_SEL_OFST |
+		under_alp_sel << ADE_OVLY_CH_UNDER_ALP_SEL_OFST |
+		glb_alpha << ADE_OVLY_CH_ALP_GBL_OFST |
+		alp_mode << ADE_OVLY_CH_ALP_MODE_OFST;
+	DRM_DEBUG_DRIVER("ch%d_ctl=0x%X\n", ovly_ch + 1, val);
+	writel(val, base + ADE_OVLY_CH_CTL(ovly_ch));
+	val = (x + 1) << (ovly_ch * 4) | readl(base + ADE_OVLY_CTL);
+	DRM_DEBUG_DRIVER("ovly_ctl=0x%X\n", val);
+	writel(val, base + ADE_OVLY_CTL);
+
+	/* when primary is enable, indicate that it's ready to output. */
+	if (ch == PRIMARY_CH) {
+		val = (in_w - 1) << 16 | (in_h - 1);
+		writel(val, base + ADE_OVLY_OUTPUT_SIZE(x));
+		writel(1, base + ADE_OVLYX_CTL(x));
+		acrtc->use_mask |= BIT(ADE_OVLY_BIT_OFST + x);
+	}
+}
+
+static void ade_overlay_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u8 ovly_ch = 0;
+	u32 val;
+
+	val = ~BIT(6) & readl(base + ADE_OVLY_CH_CTL(ovly_ch));
+	DRM_DEBUG_DRIVER("ch%d_ctl=0x%X\n", ovly_ch + 1, val);
+	writel(val, base + ADE_OVLY_CH_CTL(ovly_ch));
+	val = ~(0x3 << (ovly_ch * 4)) & readl(base + ADE_OVLY_CTL);
+
+	DRM_DEBUG_DRIVER("ovly_ctl=0x%X\n", val);
+	writel(val, base + ADE_OVLY_CTL);
+}
+
+/*
+ * Typicaly, a channel looks like: DMA-->clip-->scale-->ctrans-->overlay
+ */
+static void ade_update_channel(struct ade_plane *aplane, struct ade_crtc *acrtc,
+			       struct drm_framebuffer *fb, int crtc_x,
+			       int crtc_y, unsigned int crtc_w,
+			       unsigned int crtc_h, u32 src_x,
+			       u32 src_y, u32 src_w, u32 src_h)
+{
+	u8 ch = aplane->ch;
+	u32 fmt = ade_get_format(fb->pixel_format);
+	u32 in_w;
+	u32 in_h;
+
+	DRM_DEBUG_DRIVER("channel%d: src:(%d, %d)-%dx%d, crtc:(%d, %d)-%dx%d",
+			 ch + 1, src_x, src_y, src_w, src_h,
+			 crtc_x, crtc_y, crtc_w, crtc_h);
+
+	/* 1) DMA setting */
+	in_w = src_w;
+	in_h = src_h;
+	ade_rdma_set(acrtc, fb, ch, src_y, in_h, fmt);
+
+	/* 2) clip setting */
+	ade_clip_set(acrtc, ch, fb->width, src_x, in_w, in_h);
+
+	/* 3) TODO: scale setting for overlay planes */
+
+	/* 4) TODO: ctran/csc setting for overlay planes */
+
+	/* 5) overlay/compositor routing setting */
+	ade_overlay_set(acrtc, ch, crtc_x, crtc_y, in_w, in_h, fmt);
+
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+static void ade_disable_channel(struct ade_plane *aplane,
+				struct ade_crtc *acrtc)
+{
+	u32 ch = aplane->ch;
+
+	DRM_DEBUG_DRIVER("disable channel%d\n", ch + 1);
+
+	/*
+	 * when primary is disable, power is down
+	 * so no need to disable this channel.
+	 */
+	if (ch == PRIMARY_CH)
+		return;
+
+	/* disable read DMA */
+	ade_rdma_disable(acrtc, ch);
+
+	/* disable clip */
+	ade_clip_disable(acrtc, ch);
+
+	/* disable overlay routing */
+	ade_overlay_disable(acrtc, ch);
+
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+static int ade_plane_prepare_fb(struct drm_plane *p,
+				struct drm_framebuffer *fb,
+				const struct drm_plane_state *new_state)
+{
+	DRM_DEBUG_DRIVER("enter.\n");
+	DRM_DEBUG_DRIVER("exit success.\n");
+	return 0;
+}
+
+static void ade_plane_cleanup_fb(struct drm_plane *plane,
+				 struct drm_framebuffer *fb,
+				 const struct drm_plane_state *old_state)
+{
+	DRM_DEBUG_DRIVER("enter.\n");
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+static int ade_plane_atomic_check(struct drm_plane *plane,
+				  struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	u32 src_x = state->src_x >> 16;
+	u32 src_y = state->src_y >> 16;
+	u32 src_w = state->src_w >> 16;
+	u32 src_h = state->src_h >> 16;
+	int crtc_x = state->crtc_x;
+	int crtc_y = state->crtc_y;
+	u32 crtc_w = state->crtc_w;
+	u32 crtc_h = state->crtc_h;
+
+	if (!crtc || !fb)
+		return 0;
+
+	crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
+	if (src_w != crtc_w || src_h != crtc_h) {
+		DRM_ERROR("Scale not support!!!\n");
+		return -EINVAL;
+	}
+
+	if (src_x + src_w > fb->width ||
+	    src_y + src_h > fb->height)
+		return -EINVAL;
+
+	if (crtc_x < 0 || crtc_y < 0)
+		return -EINVAL;
+
+	if (crtc_x + crtc_w > crtc_state->adjusted_mode.hdisplay ||
+	    crtc_y + crtc_h > crtc_state->adjusted_mode.vdisplay)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ade_plane_atomic_update(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct drm_plane_state	*state	= plane->state;
+	struct ade_plane *aplane = to_ade_plane(plane);
+	struct ade_crtc *acrtc;
+
+	if (!state->crtc)
+		return;
+
+	acrtc = to_ade_crtc(state->crtc);
+	ade_update_channel(aplane, acrtc, state->fb,
+			   state->crtc_x, state->crtc_y,
+			   state->crtc_w, state->crtc_h,
+			   state->src_x >> 16, state->src_y >> 16,
+			   state->src_w >> 16, state->src_h >> 16);
+}
+
+static void ade_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct ade_plane *aplane = to_ade_plane(plane);
+	struct ade_crtc *acrtc;
+
+	if (!old_state->crtc)
+		return;
+	acrtc = to_ade_crtc(old_state->crtc);
+	ade_disable_channel(aplane, acrtc);
+}
+
+static const struct drm_plane_helper_funcs ade_plane_helper_funcs = {
+	.prepare_fb = ade_plane_prepare_fb,
+	.cleanup_fb = ade_plane_cleanup_fb,
+	.atomic_check = ade_plane_atomic_check,
+	.atomic_update = ade_plane_atomic_update,
+	.atomic_disable = ade_plane_atomic_disable,
+};
+
+static struct drm_plane_funcs ade_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.set_property = drm_atomic_helper_plane_set_property,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+static int ade_plane_init(struct drm_device *dev, struct ade_plane *aplane,
+			  enum drm_plane_type type)
+{
+	const u32 *fmts;
+	u32 fmts_cnt;
+	int ret = 0;
+
+	/* get  properties */
+	fmts_cnt = ade_get_channel_formats(aplane->ch, &fmts);
+	if (ret)
+		return ret;
+
+	ret = drm_universal_plane_init(dev, &aplane->base, 1, &ade_plane_funcs,
+				       fmts, fmts_cnt, type);
+	if (ret) {
+		DRM_ERROR("fail to init plane, ch=%d\n", aplane->ch);
+		return ret;
+	}
+
+	drm_plane_helper_add(&aplane->base, &ade_plane_helper_funcs);
+
+	return 0;
+}
+
 static int ade_bind(struct device *dev, struct device *master, void *data)
 {
+	struct ade_data *ade = dev_get_drvdata(dev);
+	struct ade_hw_ctx *ctx = &ade->ctx;
+	struct ade_crtc *acrtc = &ade->acrtc;
+	struct drm_device *drm_dev = (struct drm_device *)data;
+	struct ade_plane *aplane;
+	enum drm_plane_type type;
+	int ret;
+	int i;
+
+	/*
+	 * plane init
+	 * TODO: Now only support primary plane, overlay planes
+	 * need to do.
+	 */
+	for (i = 0; i < ADE_CH_NUM; i++) {
+		aplane = &ade->aplane[i];
+		aplane->ch = i;
+		aplane->ctx = ctx;
+		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
+			DRM_PLANE_TYPE_OVERLAY;
+
+		ret = ade_plane_init(drm_dev, aplane, type);
+		if (ret)
+			return ret;
+	}
+
+	/* crtc init */
+	acrtc->ctx = ctx;
+	ret = ade_crtc_init(drm_dev, &acrtc->base,
+			    &ade->aplane[PRIMARY_CH].base);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
1.9.1
