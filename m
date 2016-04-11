From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 11 Apr 2016 16:55:37 +0800
Subject: [PATCH v8 04/10] drm/hisilicon: Add plane driver for ADE
In-Reply-To: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
References: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1460364943-76135-5-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add plane funcs and helper funcs for ADE.

v8: None.
v7: None.
v6: None.
v5: None.
v4: None.
v3:
- A few cleanup.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 535 +++++++++++++++++++++++-
 1 file changed, 534 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index cfbea957297b..8a7cb5e04bf4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -27,13 +27,23 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_cma_helper.h>
 
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
 
+#define PRIMARY_CH	ADE_CH1 /* primary plane */
+#define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
+#define ADE_DEBUG	1
+
 #define to_ade_crtc(crtc) \
 	container_of(crtc, struct ade_crtc, base)
 
+#define to_ade_plane(plane) \
+	container_of(plane, struct ade_plane, base)
+
 struct ade_hw_ctx {
 	void __iomem  *base;
 	struct regmap *noc_regmap;
@@ -52,11 +62,76 @@ struct ade_crtc {
 	u32 out_format;
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
+	enum ade_fb_format ade_format;
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
+	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
+		  pixel_format);
+	return ADE_FORMAT_UNSUPPORT;
+}
+
 static void ade_update_reload_bit(void __iomem *base, u32 bit_num, u32 val)
 {
 	u32 bit_ofst, reg_num;
@@ -89,7 +164,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
 	/* clear overlay */
 	writel(0, base + ADE_OVLY1_TRANS_CFG);
 	writel(0, base + ADE_OVLY_CTL);
-	writel(0, base + ADE_OVLYX_CTL(ADE_OVLY2));
+	writel(0, base + ADE_OVLYX_CTL(OUT_OVLY));
 	/* clear reset and reload regs */
 	writel(MASK(32), base + ADE_SOFT_RST_SEL(0));
 	writel(MASK(32), base + ADE_SOFT_RST_SEL(1));
@@ -155,6 +230,10 @@ static void ade_ldi_set_mode(struct ade_crtc *acrtc,
 	       base + LDI_DSP_SIZE);
 	writel(plr_flags, base + LDI_PLR_CTRL);
 
+	/* set overlay compositor output size */
+	writel(((width - 1) << OUTPUT_XSIZE_OFST) | (height - 1),
+	       base + ADE_OVLY_OUTPUT_SIZE(OUT_OVLY));
+
 	/* ctran6 setting */
 	writel(CTRAN_BYPASS_ON, base + ADE_CTRAN_DIS(ADE_CTRAN6));
 	 /* the configured value is actual value - 1 */
@@ -229,6 +308,10 @@ static void ade_display_enable(struct ade_crtc *acrtc)
 	void __iomem *base = ctx->base;
 	u32 out_fmt = acrtc->out_format;
 
+	/* enable output overlay compositor */
+	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(OUT_OVLY));
+	ade_update_reload_bit(base, OVLY_OFST + OUT_OVLY, 0);
+
 	/* display source setting */
 	writel(DISP_SRC_OVLY2, base + ADE_DISP_SRC_CFG);
 
@@ -242,6 +325,97 @@ static void ade_display_enable(struct ade_crtc *acrtc)
 	writel(DSI_PCLK_ON, base + LDI_HDMI_DSI_GT);
 }
 
+#if ADE_DEBUG
+static void ade_rdma_dump_regs(void __iomem *base, u32 ch)
+{
+	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
+	u32 val;
+
+	reg_ctrl = RD_CH_CTRL(ch);
+	reg_addr = RD_CH_ADDR(ch);
+	reg_size = RD_CH_SIZE(ch);
+	reg_stride = RD_CH_STRIDE(ch);
+	reg_space = RD_CH_SPACE(ch);
+	reg_en = RD_CH_EN(ch);
+
+	val = ade_read_reload_bit(base, RDMA_OFST + ch);
+	DRM_DEBUG_DRIVER("[rdma%d]: reload(%d)\n", ch + 1, val);
+	val = readl(base + reg_ctrl);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_ctrl(0x%08x)\n", ch + 1, val);
+	val = readl(base + reg_addr);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_addr(0x%08x)\n", ch + 1, val);
+	val = readl(base + reg_size);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_size(0x%08x)\n", ch + 1, val);
+	val = readl(base + reg_stride);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_stride(0x%08x)\n", ch + 1, val);
+	val = readl(base + reg_space);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_space(0x%08x)\n", ch + 1, val);
+	val = readl(base + reg_en);
+	DRM_DEBUG_DRIVER("[rdma%d]: reg_en(0x%08x)\n", ch + 1, val);
+}
+
+static void ade_clip_dump_regs(void __iomem *base, u32 ch)
+{
+	u32 val;
+
+	val = ade_read_reload_bit(base, CLIP_OFST + ch);
+	DRM_DEBUG_DRIVER("[clip%d]: reload(%d)\n", ch + 1, val);
+	val = readl(base + ADE_CLIP_DISABLE(ch));
+	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_disable(0x%08x)\n", ch + 1, val);
+	val = readl(base + ADE_CLIP_SIZE0(ch));
+	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_size0(0x%08x)\n", ch + 1, val);
+	val = readl(base + ADE_CLIP_SIZE1(ch));
+	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_size1(0x%08x)\n", ch + 1, val);
+}
+
+static void ade_compositor_routing_dump_regs(void __iomem *base, u32 ch)
+{
+	u8 ovly_ch = 0; /* TODO: Only primary plane now */
+	u32 val;
+
+	val = readl(base + ADE_OVLY_CH_XY0(ovly_ch));
+	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_xy0(0x%08x)\n", ovly_ch, val);
+	val = readl(base + ADE_OVLY_CH_XY1(ovly_ch));
+	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_xy1(0x%08x)\n", ovly_ch, val);
+	val = readl(base + ADE_OVLY_CH_CTL(ovly_ch));
+	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_ctl(0x%08x)\n", ovly_ch, val);
+}
+
+static void ade_dump_overlay_compositor_regs(void __iomem *base, u32 comp)
+{
+	u32 val;
+
+	val = ade_read_reload_bit(base, OVLY_OFST + comp);
+	DRM_DEBUG_DRIVER("[overlay%d]: reload(%d)\n", comp + 1, val);
+	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(comp));
+	DRM_DEBUG_DRIVER("[overlay%d]: reg_ctl(0x%08x)\n", comp + 1, val);
+	val = readl(base + ADE_OVLY_CTL);
+	DRM_DEBUG_DRIVER("ovly_ctl(0x%08x)\n", val);
+}
+
+static void ade_dump_regs(void __iomem *base)
+{
+	u32 i;
+
+	/* dump channel regs */
+	for (i = 0; i < ADE_CH_NUM; i++) {
+		/* dump rdma regs */
+		ade_rdma_dump_regs(base, i);
+
+		/* dump clip regs */
+		ade_clip_dump_regs(base, i);
+
+		/* dump compositor routing regs */
+		ade_compositor_routing_dump_regs(base, i);
+	}
+
+	/* dump overlay compositor regs */
+	ade_dump_overlay_compositor_regs(base, OUT_OVLY);
+}
+#else
+static void ade_dump_regs(void __iomem *base) { }
+#endif
+
 static void ade_crtc_enable(struct drm_crtc *crtc)
 {
 	struct ade_crtc *acrtc = to_ade_crtc(crtc);
@@ -259,6 +433,7 @@ static void ade_crtc_enable(struct drm_crtc *crtc)
 
 	ade_set_medianoc_qos(acrtc);
 	ade_display_enable(acrtc);
+	ade_dump_regs(ctx->base);
 	acrtc->enable = true;
 }
 
@@ -313,6 +488,7 @@ static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	/* only crtc is enabled regs take effect */
 	if (acrtc->enable) {
+		ade_dump_regs(base);
 		/* flush ade registers */
 		writel(ADE_ENABLE, base + ADE_EN);
 	}
@@ -369,6 +545,338 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	return 0;
 }
 
+static void ade_rdma_set(void __iomem *base, struct drm_framebuffer *fb,
+			 u32 ch, u32 y, u32 in_h, u32 fmt)
+{
+	struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, 0);
+	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
+	u32 stride = fb->pitches[0];
+	u32 addr = (u32)obj->paddr + y * stride;
+
+	DRM_DEBUG_DRIVER("rdma%d: (y=%d, height=%d), stride=%d, paddr=0x%x\n",
+			 ch + 1, y, in_h, stride, (u32)obj->paddr);
+	DRM_DEBUG_DRIVER("addr=0x%x, fb:%dx%d, pixel_format=%d(%s)\n",
+			 addr, fb->width, fb->height, fmt,
+			 drm_get_format_name(fb->pixel_format));
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
+	writel(ADE_ENABLE, base + reg_en);
+	ade_update_reload_bit(base, RDMA_OFST + ch, 0);
+}
+
+static void ade_rdma_disable(void __iomem *base, u32 ch)
+{
+	u32 reg_en;
+
+	/* get reg offset */
+	reg_en = RD_CH_EN(ch);
+	writel(0, base + reg_en);
+	ade_update_reload_bit(base, RDMA_OFST + ch, 1);
+}
+
+static void ade_clip_set(void __iomem *base, u32 ch, u32 fb_w, u32 x,
+			 u32 in_w, u32 in_h)
+{
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
+	ade_update_reload_bit(base, CLIP_OFST + ch, 0);
+}
+
+static void ade_clip_disable(void __iomem *base, u32 ch)
+{
+	writel(1, base + ADE_CLIP_DISABLE(ch));
+	ade_update_reload_bit(base, CLIP_OFST + ch, 1);
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
+static void ade_compositor_routing_set(void __iomem *base, u8 ch,
+				       u32 x0, u32 y0,
+				       u32 in_w, u32 in_h, u32 fmt)
+{
+	u8 ovly_ch = 0; /* TODO: This is the zpos, only one plane now */
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
+	/* overlay routing setting
+	 */
+	writel(x0 << 16 | y0, base + ADE_OVLY_CH_XY0(ovly_ch));
+	writel(x1 << 16 | y1, base + ADE_OVLY_CH_XY1(ovly_ch));
+	val = (ch + 1) << CH_SEL_OFST | BIT(CH_EN_OFST) |
+		alp_sel << CH_ALP_SEL_OFST |
+		under_alp_sel << CH_UNDER_ALP_SEL_OFST |
+		glb_alpha << CH_ALP_GBL_OFST |
+		alp_mode << CH_ALP_MODE_OFST;
+	writel(val, base + ADE_OVLY_CH_CTL(ovly_ch));
+	/* connect this plane/channel to overlay2 compositor */
+	ade_update_bits(base + ADE_OVLY_CTL, CH_OVLY_SEL_OFST(ovly_ch),
+			CH_OVLY_SEL_MASK, CH_OVLY_SEL_VAL(OUT_OVLY));
+}
+
+static void ade_compositor_routing_disable(void __iomem *base, u32 ch)
+{
+	u8 ovly_ch = 0; /* TODO: Only primary plane now */
+
+	/* disable this plane/channel */
+	ade_update_bits(base + ADE_OVLY_CH_CTL(ovly_ch), CH_EN_OFST,
+			MASK(1), 0);
+	/* dis-connect this plane/channel of overlay2 compositor */
+	ade_update_bits(base + ADE_OVLY_CTL, CH_OVLY_SEL_OFST(ovly_ch),
+			CH_OVLY_SEL_MASK, 0);
+}
+
+/*
+ * Typicaly, a channel looks like: DMA-->clip-->scale-->ctrans-->compositor
+ */
+static void ade_update_channel(struct ade_plane *aplane,
+			       struct drm_framebuffer *fb, int crtc_x,
+			       int crtc_y, unsigned int crtc_w,
+			       unsigned int crtc_h, u32 src_x,
+			       u32 src_y, u32 src_w, u32 src_h)
+{
+	struct ade_hw_ctx *ctx = aplane->ctx;
+	void __iomem *base = ctx->base;
+	u32 fmt = ade_get_format(fb->pixel_format);
+	u32 ch = aplane->ch;
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
+	ade_rdma_set(base, fb, ch, src_y, in_h, fmt);
+
+	/* 2) clip setting */
+	ade_clip_set(base, ch, fb->width, src_x, in_w, in_h);
+
+	/* 3) TODO: scale setting for overlay planes */
+
+	/* 4) TODO: ctran/csc setting for overlay planes */
+
+	/* 5) compositor routing setting */
+	ade_compositor_routing_set(base, ch, crtc_x, crtc_y, in_w, in_h, fmt);
+}
+
+static void ade_disable_channel(struct ade_plane *aplane)
+{
+	struct ade_hw_ctx *ctx = aplane->ctx;
+	void __iomem *base = ctx->base;
+	u32 ch = aplane->ch;
+
+	DRM_DEBUG_DRIVER("disable channel%d\n", ch + 1);
+
+	/* disable read DMA */
+	ade_rdma_disable(base, ch);
+
+	/* disable clip */
+	ade_clip_disable(base, ch);
+
+	/* disable compositor routing */
+	ade_compositor_routing_disable(base, ch);
+}
+
+static int ade_plane_prepare_fb(struct drm_plane *plane,
+				const struct drm_plane_state *new_state)
+{
+	/* do nothing */
+	return 0;
+}
+
+static void ade_plane_cleanup_fb(struct drm_plane *plane,
+				 const struct drm_plane_state *old_state)
+{
+	/* do nothing */
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
+	u32 fmt;
+
+	if (!crtc || !fb)
+		return 0;
+
+	fmt = ade_get_format(fb->pixel_format);
+	if (fmt == ADE_FORMAT_UNSUPPORT)
+		return -EINVAL;
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
+
+	ade_update_channel(aplane, state->fb, state->crtc_x, state->crtc_y,
+			   state->crtc_w, state->crtc_h,
+			   state->src_x >> 16, state->src_y >> 16,
+			   state->src_w >> 16, state->src_h >> 16);
+}
+
+static void ade_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct ade_plane *aplane = to_ade_plane(plane);
+
+	ade_disable_channel(aplane);
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
+				       fmts, fmts_cnt, type, NULL);
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
 static int ade_dts_parse(struct platform_device *pdev, struct ade_hw_ctx *ctx)
 {
 	struct resource *res;
@@ -426,7 +934,10 @@ static int ade_drm_init(struct drm_device *dev)
 	struct ade_data *ade;
 	struct ade_hw_ctx *ctx;
 	struct ade_crtc *acrtc;
+	struct ade_plane *aplane;
+	enum drm_plane_type type;
 	int ret;
+	int i;
 
 	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
 	if (!ade) {
@@ -444,6 +955,28 @@ static int ade_drm_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
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
+		ret = ade_plane_init(dev, aplane, type);
+		if (ret)
+			return ret;
+	}
+
+	/* crtc init */
+	ret = ade_crtc_init(dev, &acrtc->base, &ade->aplane[PRIMARY_CH].base);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.8.0
