From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:10 +0800
Subject: [PATCH RFC 4/8] drm: hisilicon: fill interface function of plane\crtc
 part
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-5-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses ADE module which is responsibe for graphic overlay, graphic
post-processing, display timing control within hi6220 SoC to implement the
plane\ctrc interface of DRM\KMS.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hisi_ade.c       | 1087 +++++++++++++++++++++++++++-
 drivers/gpu/drm/hisilicon/hisi_ade_reg.h   |  181 +++++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c  |   47 ++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h  |   12 +
 drivers/gpu/drm/hisilicon/hisi_drm_fb.c    |   21 +-
 drivers/gpu/drm/hisilicon/hisi_drm_fb.h    |    2 +
 drivers/gpu/drm/hisilicon/hisi_drm_plane.c |   17 +
 drivers/gpu/drm/hisilicon/hisi_drm_plane.h |    4 +
 8 files changed, 1368 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hisi_ade.c b/drivers/gpu/drm/hisilicon/hisi_ade.c
index 148ed2f..2ea3f8f 100644
--- a/drivers/gpu/drm/hisilicon/hisi_ade.c
+++ b/drivers/gpu/drm/hisilicon/hisi_ade.c
@@ -13,16 +13,29 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
+#include "hisi_drm_drv.h"
 #include "hisi_drm_plane.h"
 #include "hisi_drm_crtc.h"
+#include "hisi_drm_fb.h"
 #include "hisi_ade_reg.h"
 
 #define PRIMARY_CH      (ADE_CH1)
 
+#define ADE_CHANNEL_SCALE_UNSUPPORT      0
+#define ADE_CHANNEL_SCALE_SUPPORT        1
+
+#define to_ade_crtc(hcrtc) container_of(hcrtc, struct ade_crtc, base)
+
 struct ade_crtc {
 	struct hisi_crtc base;
+	struct drm_display_mode *dmode;
+
+	u32 ch_mask;
+	u64 use_mask;
 };
 
 struct ade_hardware_context {
@@ -45,6 +58,1070 @@ struct hisi_ade {
 	struct ade_hardware_context ctx;
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
+	/* packed YCbCr */
+	{ DRM_FORMAT_YUYV, ADE_YUYV },
+	{ DRM_FORMAT_YVYU, ADE_YVYU },
+	{ DRM_FORMAT_UYVY, ADE_UYVY },
+	{ DRM_FORMAT_VYUY, ADE_VYUY },
+	/* 2 plane YCbCr */
+	{ DRM_FORMAT_NV12, ADE_NV12 },
+	{ DRM_FORMAT_NV21, ADE_NV21 },
+	/* 3 plane YCbCr */
+	{ DRM_FORMAT_YUV444, ADE_YUV444 },
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
+static const u32 channel_formats2[] = {
+	/* channel 5,6 */
+	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888, DRM_FORMAT_YUYV, DRM_FORMAT_YVYU, DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY, DRM_FORMAT_NV12, DRM_FORMAT_NV21, DRM_FORMAT_YUV444
+};
+
+static const u32 channel_formats3[] = {
+	/* disp channel 7 */
+	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888, DRM_FORMAT_YUYV, DRM_FORMAT_YVYU, DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY, DRM_FORMAT_YUV444
+};
+
+/*
+ * set modules' reset mode: by software or hardware
+ * set modules' reload enable/disable
+ * */
+static void ade_set_reset_and_reload(struct ade_crtc *acrtc)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u32 mask0 = (u32)acrtc->use_mask;
+	u32 mask1 = (u32)(acrtc->use_mask >> 32);
+
+	writel(mask0, base + ADE_SOFT_RST_SEL0);
+	writel(mask1, base + ADE_SOFT_RST_SEL1);
+	writel(~mask0, base + ADE_RELOAD_DIS0);
+	writel(~mask1, base + ADE_RELOAD_DIS1);
+}
+
+/*
+ * commit to ldi to display
+ */
+static void ade_display_commit(struct ade_crtc *acrtc)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u32 out_w = acrtc->dmode->hdisplay;
+	u32 out_h = acrtc->dmode->vdisplay;
+	u32 val;
+
+	/* display source setting */
+	writel(TOP_DISP_SRC_OVLY2, base + ADE_DISP_SRC_CFG);
+
+	/* ctran6 setting */
+	writel(1, base + ADE_CTRAN_DIS(ADE_CTRAN6));
+	writel(out_w * out_h - 1, base + ADE_CTRAN_IMAGE_SIZE(ADE_CTRAN6));
+
+	acrtc->use_mask |= BIT(ADE_CTRAN_BIT_OFST + ADE_CTRAN6);
+
+	/* set reset mode:soft or hw, and reload modules */
+	ade_set_reset_and_reload(acrtc);
+
+	/* enable ade */
+	wmb();
+	writel(ADE_ENABLE, base + ADE_EN);
+
+	wmb(); /* memory barrier */
+	val = ADE_ENABLE;
+	val |= readl(base + LDI_CTRL);
+	writel(val, base + LDI_CTRL);
+
+	/* dsi pixel on */
+	set_reg(base + LDI_HDMI_DSI_GT, 0x0, 1, 0);
+}
+
+static void ade_init(struct ade_hardware_context *ctx)
+{
+	void __iomem *base = ctx->base;
+	u32 val;
+
+	/* enable clk gate */
+	val = 0x01;
+	val |= readl(base + ADE_CTRL1);
+	writel(val, base + ADE_CTRL1);
+
+	/* clear overlay */
+	writel(0, base + ADE_OVLY1_TRANS_CFG);
+	writel(0, base + ADE_OVLY_CTL);
+	writel(0, base + ADE_OVLYX_CTL(ADE_OVLY2));
+
+	/* clear reset and reload regs */
+	writel(0, base + ADE_SOFT_RST_SEL0);
+	writel(0, base + ADE_SOFT_RST_SEL1);
+	writel(0xFFFFFFFF, base + ADE_RELOAD_DIS0);
+	writel(0xFFFFFFFF, base + ADE_RELOAD_DIS1);
+
+	/* for video set to 1, means that ade registers
+	 * became effective at frame end */
+	val = 0x01;
+	val |= readl(base + ADE_CTRL);
+	writel(val, base + ADE_CTRL);
+}
+
+static void ade_ldi_set_mode(struct ade_hardware_context *ctx,
+			     struct drm_display_mode *mode)
+{
+	void __iomem *base = ctx->base;
+	u32 hfp, hbp, hsw, vfp, vbp, vsw;
+	u32 plr_flags;
+	u32 val;
+
+	plr_flags = (mode->flags & DRM_MODE_FLAG_NVSYNC)
+			? HISI_LDI_FLAG_NVSYNC : 0;
+	plr_flags |= (mode->flags & DRM_MODE_FLAG_NHSYNC)
+			? HISI_LDI_FLAG_NHSYNC : 0;
+	hfp = mode->hsync_start - mode->hdisplay;
+	hbp = mode->htotal - mode->hsync_end;
+	hsw = mode->hsync_end - mode->hsync_start;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vbp = mode->vtotal - mode->vsync_end;
+	vsw = mode->vsync_end - mode->vsync_start;
+	if (vsw > 15) {
+		DRM_ERROR("%s: vsw exceeded 15\n", __func__);
+		vsw = 15;
+	}
+
+	writel((hbp << 20) | (hfp << 0), base + LDI_HRZ_CTRL0);
+
+	/* p3-73 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(hsw - 1, base + LDI_HRZ_CTRL1);
+	writel((vbp << 20) | (vfp << 0), base + LDI_VRT_CTRL0);
+
+	/* p3-74 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(vsw - 1, base + LDI_VRT_CTRL1);
+
+	/* p3-75 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(((mode->vdisplay - 1) << 20) | ((mode->hdisplay - 1) << 0),
+	       base + LDI_DSP_SIZE);
+	writel(plr_flags, base + LDI_PLR_CTRL);
+
+	/*
+	 * other parameters setting
+	 */
+	writel(BIT(0), base + LDI_WORK_MODE);
+	val = 0x3c << 6;
+	val |= ADE_OUT_RGB_888 << 3 | BIT(2) | BIT(0);
+	writel(val, base + LDI_CTRL);
+
+	set_reg(base + LDI_DE_SPACE_LOW, 0x1, 1, 1);
+}
+
+static int ade_power_up(struct ade_hardware_context *ctx)
+{
+	void __iomem *media_base = ctx->media_base;
+	int ret;
+
+	ret = clk_set_rate(ctx->ade_core_clk, ctx->ade_core_rate);
+	if (ret) {
+		DRM_ERROR("Cannot set rate (%dHz) for ade core clk\n",
+			  ctx->ade_core_rate);
+		return ret;
+	}
+	ret = clk_set_rate(ctx->media_noc_clk, ctx->media_noc_rate);
+	if (ret) {
+		DRM_ERROR("Cannot set rate (%dHz) for media noc clk\n",
+			  ctx->media_noc_rate);
+		return ret;
+	}
+	ret = clk_prepare_enable(ctx->media_noc_clk);
+	if (ret) {
+		DRM_ERROR("fail to enable media_noc_clk: %d\n", ret);
+		return ret;
+	}
+
+	writel(0x20, media_base + SC_MEDIA_RSTDIS);
+
+	ret = clk_prepare_enable(ctx->ade_core_clk);
+	if (ret) {
+		DRM_ERROR("fail to enabel ade_core_clk: %d\n", ret);
+		return ret;
+	}
+
+	ade_init(ctx);
+
+	ctx->power_on = true;
+
+	return 0;
+}
+
+static void ade_power_down(struct ade_hardware_context *ctx)
+{
+	void __iomem *base = ctx->base;
+	void __iomem *media_base = ctx->media_base;
+	u32 val;
+
+	/* disable LDI*/
+	val = ADE_DISABLE;
+	val |= readl(base + LDI_CTRL);
+	writel(val, base + LDI_CTRL);
+
+	/* dsi pixel off */
+	set_reg(base + LDI_HDMI_DSI_GT, 0x1, 1, 0);
+
+	/* ade clock off */
+	clk_disable_unprepare(ctx->ade_core_clk);
+	writel(0x20, media_base + SC_MEDIA_RSTEN);
+	clk_disable_unprepare(ctx->media_noc_clk);
+
+	ctx->power_on = false;
+}
+
+static void ade_crtc_enable(struct hisi_crtc *hcrtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	int ret;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("%s: failed to power up ade\n", __func__);
+			return;
+		}
+	}
+
+	ade_display_commit(acrtc);
+}
+
+static void ade_crtc_disable(struct hisi_crtc *hcrtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+
+	ade_power_down(ctx);
+
+	acrtc->ch_mask = 0;
+	acrtc->use_mask = 0;
+}
+
+bool ade_crtc_mode_fixup(struct hisi_crtc *hcrtc,
+			 const struct drm_display_mode *mode,
+			 struct drm_display_mode *adj_mode)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	u32 clock_kHz = mode->clock;
+	int ret;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("%s: failed to power up ade\n", __func__);
+			return ret;
+		}
+	}
+
+	do {
+		ret = clk_set_rate(ctx->ade_pix_clk, clock_kHz * 1000);
+		if (ret) {
+			DRM_ERROR("Cannot set rate (%dHz) for ade pixel clk\n",
+				  clock_kHz * 1000);
+			return false;
+		}
+
+		adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
+
+		/* This avoids a bad 720p DSI clock with 1.2GHz DPI PLL */
+		if (adj_mode->clock != 72000)
+			break;
+
+		clock_kHz += 10;
+	} while (1);
+
+	return true;
+}
+
+void ade_crtc_mode_set_nofb(struct hisi_crtc *hcrtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+
+	acrtc->dmode = &hcrtc->base.state->mode;
+
+	ade_ldi_set_mode(ctx, &hcrtc->base.state->mode);
+}
+
+void ade_crtc_atomic_begin(struct hisi_crtc *hcrtc)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	int ret;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("%s: failed to power up ade\n", __func__);
+			return;
+		}
+	}
+}
+
+void ade_crtc_atomic_flush(struct hisi_crtc *hcrtc)
+
+{
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	/* commit to  display: LDI input setting */
+	if (hcrtc->enable) {
+		/* set reset and reload */
+		ade_set_reset_and_reload(acrtc);
+		/* flush ade regitsters */
+		wmb();
+		writel(ADE_ENABLE, base + ADE_EN);
+	}
+}
+
+void ade_crtc_mode_prepare(struct hisi_crtc *hcrtc)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	int ret;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("%s: failed to power up ade\n", __func__);
+			return;
+		}
+	}
+}
+
+u32 ade_get_channel_formats(u8 ch, const u32 **formats)
+{
+	switch (ch) {
+	case ADE_CH1:
+	case ADE_CH2:
+	case ADE_CH3:
+	case ADE_CH4:
+		*formats = channel_formats1;
+		return ARRAY_SIZE(channel_formats1);
+	case ADE_CH5:
+	case ADE_CH6:
+		*formats = channel_formats2;
+		return ARRAY_SIZE(channel_formats2);
+	case ADE_DISP:
+		*formats = channel_formats3;
+		return ARRAY_SIZE(channel_formats3);
+	default:
+		DRM_ERROR("no this channel %d\n", ch);
+		*formats = NULL;
+		return 0;
+	}
+}
+
+static const struct drm_prop_enum_list ade_ch_scale_list[] = {
+	{ ADE_CHANNEL_SCALE_UNSUPPORT, "unsupport" },
+	{ ADE_CHANNEL_SCALE_SUPPORT, "support" },
+};
+
+static const struct drm_prop_enum_list ade_ch_blend_list[] = {
+	{ ALPHA_BLENDING_NONE, "blending none" },
+	{ ALPHA_BLENDING_PREMULT, "blending premult" },
+	{ ALPHA_BLENDING_COVERAGE, "blending coverage" }
+};
+
+static const struct drm_prop_enum_list ade_rotation_enum_list[] = {
+	{ DRM_ROTATE_0,   "rotate-0" },
+	{ DRM_ROTATE_90,  "rotate-90" },
+	{ DRM_ROTATE_180, "rotate-180" },
+	{ DRM_ROTATE_270, "rotate-270" },
+	{ DRM_REFLECT_X,  "reflect-x" },
+	{ DRM_REFLECT_Y,  "reflect-y" },
+};
+
+static const struct drm_prop_enum_list ade_composition_type_enum_list[] = {
+	{ COMPOSITION_UNKNOWN, "composition unknown" },
+	{ COMPOSITION_GLES, "composition GLES" },
+	{ COMPOSITION_HWC, "composition hwc" },
+	{ COMPOSITION_MIXED, "composition mixed" }
+};
+
+int ade_install_plane_properties(struct drm_device *dev,
+				 struct hisi_plane *hplane)
+{
+	struct hisi_drm_private *priv = dev->dev_private;
+	struct drm_mode_object *obj = &hplane->base.base;
+	struct drm_property *prop;
+	u8 ch = hplane->ch;
+	u64 prop_val;
+
+	/* create and attach scale capablity properties */
+	prop = priv->cap_scl_prop;
+	if (!prop) {
+		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+						"cap_scl",
+						ade_ch_scale_list,
+						ARRAY_SIZE(ade_ch_scale_list));
+		if (!prop)
+			return 0;
+
+		priv->cap_scl_prop = prop;
+	}
+
+	switch (ch) {
+	case ADE_CH5:
+	case ADE_CH6:
+		prop_val = ADE_CHANNEL_SCALE_SUPPORT;
+		break;
+	default:
+		prop_val = ADE_CHANNEL_SCALE_UNSUPPORT;
+		break;
+	}
+	drm_object_attach_property(obj, prop, prop_val);
+
+	/* create and attach rotation capablity properties */
+	prop = priv->cap_rot_prop;
+	if (!prop) {
+		prop = drm_property_create_bitmask(
+			dev, 0, "cap_rot",
+			ade_rotation_enum_list,
+			ARRAY_SIZE(ade_rotation_enum_list),
+			BIT(DRM_ROTATE_0) | BIT(DRM_ROTATE_90) |
+			BIT(DRM_ROTATE_180) | BIT(DRM_ROTATE_270) |
+			BIT(DRM_REFLECT_X) | BIT(DRM_REFLECT_Y));
+		if (!prop)
+			return 0;
+
+		priv->cap_rot_prop = prop;
+	}
+
+	switch (ch) {
+	case ADE_CH5:
+	case ADE_CH6:
+		prop_val = BIT(DRM_ROTATE_0) | BIT(DRM_ROTATE_90) |
+			BIT(DRM_ROTATE_180) | BIT(DRM_ROTATE_270) |
+			BIT(DRM_REFLECT_X) | BIT(DRM_REFLECT_Y);
+		break;
+	default:
+		prop_val = BIT(DRM_ROTATE_0);
+		break;
+	}
+	drm_object_attach_property(obj, prop, prop_val);
+
+	/* create and attach zpos properties */
+	prop = priv->zpos_prop;
+	if (!prop) {
+		prop = drm_property_create_range(dev, 0, "zpos", 0,
+						 ADE_CH_NUM - 1);
+		if (!prop)
+			return 0;
+
+		priv->zpos_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, ch);
+
+	/* create and attach rotation properties */
+	prop = dev->mode_config.rotation_property;
+	if (!prop) {
+		prop = drm_mode_create_rotation_property(
+				dev,
+				BIT(DRM_ROTATE_0) | BIT(DRM_ROTATE_90) |
+				BIT(DRM_ROTATE_180) | BIT(DRM_ROTATE_270) |
+				BIT(DRM_REFLECT_X) | BIT(DRM_REFLECT_Y));
+		if (!prop)
+			return 0;
+		dev->mode_config.rotation_property = prop;
+	}
+	drm_object_attach_property(obj, prop, DRM_ROTATE_0);
+
+	/* create and attach alpha properties */
+	prop = priv->alpha_prop;
+	if (!prop) {
+		prop = drm_property_create_range(dev, 0, "alpha", 0, 255);
+		if (!prop)
+			return 0;
+
+		priv->alpha_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, 255);
+
+	/* create and attach blending properties */
+	prop = priv->blend_prop;
+	if (!prop) {
+		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+						"blend",
+						ade_ch_blend_list,
+						ARRAY_SIZE(ade_ch_blend_list));
+		if (!prop)
+			return 0;
+
+		priv->blend_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, ALPHA_BLENDING_NONE);
+
+	return 0;
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
+	return ADE_FORMAT_NOT_SUPPORT;
+}
+
+static bool ade_is_need_csc(u32 fmt)
+{
+	switch (fmt) {
+	case ADE_YUYV:
+	case ADE_YVYU:
+	case ADE_UYVY:
+	case ADE_VYUY:
+	case ADE_YUV444:
+	case ADE_NV12:
+	case ADE_NV21:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void ade_rdma_set(struct ade_crtc *acrtc, struct drm_framebuffer *fb,
+			 u32 ch, u32 y, u32 in_h, u32 fmt, u32 rotation)
+{
+	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
+	struct drm_gem_cma_object *obj = hisi_drm_fb_get_gem_obj(fb, 0);
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u32 stride = fb->pitches[0];
+	u32 addr = (u32)obj->paddr + y * stride;
+
+	/* get reg offset */
+	switch (ch) {
+	case ADE_DISP:
+		reg_ctrl = RD_CH_DISP_CTRL;
+		reg_addr = RD_CH_DISP_ADDR;
+		reg_size = RD_CH_DISP_SIZE;
+		reg_stride = RD_CH_DISP_STRIDE;
+		reg_space = RD_CH_DISP_SPACE;
+		reg_en = RD_CH_DISP_EN;
+		break;
+	default:
+		reg_ctrl = RD_CH_CTRL(ch);
+		reg_addr = RD_CH_ADDR(ch);
+		reg_size = RD_CH_SIZE(ch);
+		reg_stride = RD_CH_STRIDE(ch);
+		reg_space = RD_CH_SPACE(ch);
+		reg_en = RD_CH_EN(ch);
+		break;
+	}
+
+	/*  TODO: set rotation */
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
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u32 reg_en;
+
+	/* get reg offset */
+	switch (ch) {
+	case ADE_DISP:
+		reg_en = RD_CH_DISP_EN;
+		break;
+	default:
+		reg_en = RD_CH_EN(ch);
+		break;
+	}
+
+	writel(0, base + reg_en);
+
+	acrtc->use_mask &= ~BIT(ADE_CH_RDMA_BIT_OFST + ch);
+}
+
+static void ade_clip_set(struct ade_crtc *acrtc, u32 ch, u32 fb_w, u32 x,
+			 u32 in_w, u32 in_h)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u32 disable_val;
+	u32 clip_left;
+	u32 clip_right;
+
+	/* ADE_DISP channel has no clip module */
+	if (ch == ADE_DISP)
+		return;
+
+	/* clip width, no need to clip height */
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
+	writel(disable_val, base + ADE_CLIP_DISABLE(ch));
+	writel((fb_w - 1) << 16 | (in_h - 1), base + ADE_CLIP_SIZE0(ch));
+	writel(clip_left << 16 | clip_right, base + ADE_CLIP_SIZE1(ch));
+
+	acrtc->use_mask |= BIT(ADE_CLIP_BIT_OFST + ch);
+}
+
+static void ade_clip_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+
+	if (ch == ADE_DISP)
+		return;
+
+	writel(1, base + ADE_CLIP_DISABLE(ch));
+	acrtc->use_mask &= ~BIT(ADE_CLIP_BIT_OFST + ch);
+}
+
+static void ade_scale_set(struct ade_crtc *acrtc, u32 ch,
+			  u32 in_w, u32 in_h,
+			  u32 *out_w, u32 *out_h)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	bool need_scale = false;
+	u32 o_w, o_h;
+	u32 ctrl_val;
+	u8 x;
+
+	switch (ch) {
+	case ADE_CH5:
+		x = ADE_SCL3;
+		break;
+	case ADE_CH6:
+		x = ADE_SCL1;
+		break;
+	default: /* channel 1,2,3,4,disp has no scale capability */
+		return;
+	}
+
+	if (!need_scale) {/* bypass */
+		ctrl_val = 0x400;
+		o_w = in_w;
+		o_h = in_h;
+	}
+
+	writel(ctrl_val, base + ADE_SCL_CTRL(x));
+	writel((in_h - 1) << 16 | (in_w - 1), base + ADE_SCL_IRES(x));
+	writel((o_h - 1) << 16 | (o_w - 1), base + ADE_SCL_ORES(x));
+	writel(1, base + ADE_SCL_START(x));
+
+	*out_w = o_w;
+	*out_h = o_h;
+
+	acrtc->use_mask |= BIT(ADE_SCL_BIT_OFST + x);
+}
+
+static void ade_scale_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u8 x;
+
+	switch (ch) {
+	case ADE_CH5:
+		x = ADE_SCL3;
+		break;
+	case ADE_CH6:
+		x = ADE_SCL1;
+		break;
+	default: /* channel 1,2,3,4,disp has no scale capability */
+		return;
+	}
+
+	writel(0, base + ADE_SCL_START(x));
+
+	acrtc->use_mask &= ~BIT(ADE_SCL_BIT_OFST + x);
+}
+
+/* corlor space converting */
+static void ade_ctran_set(struct ade_crtc *acrtc, u32 ch,
+			  u32 in_w, u32 in_h,
+			  u32 fmt)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	bool need_ctran = ade_is_need_csc(fmt);
+	u8 x;
+
+	switch (ch) {
+	case ADE_DISP:
+		x = ADE_CTRAN5;
+		break;
+	case ADE_CH5:
+		x = ADE_CTRAN1;
+		break;
+	case ADE_CH6:
+		x = ADE_CTRAN2;
+		break;
+	default: /* channel 1,2,3,4 has no csc capability */
+		return;
+	}
+
+	if (!need_ctran) {/* bypass */
+		writel(1, base + ADE_CTRAN_DIS(x));
+		writel(in_w * in_h - 1, base + ADE_CTRAN_IMAGE_SIZE(x));
+	}
+
+	acrtc->use_mask |= BIT(ADE_CTRAN_BIT_OFST + x);
+}
+
+static void ade_ctran_disable(struct ade_crtc *acrtc, u32 ch)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u8 x;
+
+	switch (ch) {
+	case ADE_DISP:
+		x = ADE_CTRAN5;
+		break;
+	case ADE_CH5:
+		x = ADE_CTRAN1;
+		break;
+	case ADE_CH6:
+		x = ADE_CTRAN2;
+		break;
+	default: /* channel 1,2,3,4 has no csc capability */
+		return;
+	}
+
+	writel(1, base + ADE_CTRAN_DIS(x));
+
+	acrtc->use_mask &= ~BIT(ADE_CTRAN_BIT_OFST + x);
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
+static void ade_get_blending_params(u32 blend, u32 fmt, u8 glb_alpha,
+				    u8 *alp_mode, u8 *alp_sel,
+				    u8 *under_alp_sel)
+{
+	bool has_alpha = has_Alpha_channel(fmt);
+
+	/* get alp_mode */
+	if (has_alpha && glb_alpha < 0xFF)
+		*alp_mode = ADE_ALP_PIXEL_AND_GLB;
+	else if (has_alpha)
+		*alp_mode = ADE_ALP_PIXEL;
+	else
+		*alp_mode = ADE_ALP_GLOBAL;
+
+	/* get alp sel */
+	*alp_sel = ADE_ALP_MUL_COEFF_3; /* 1 */
+	*under_alp_sel = ADE_ALP_MUL_COEFF_1; /* 1 - alpha */
+
+	switch (blend) {
+	case ALPHA_BLENDING_PREMULT:
+		break;
+	case ALPHA_BLENDING_COVERAGE:
+		*alp_sel = ADE_ALP_MUL_COEFF_0; /* alpha */
+		break;
+	case ALPHA_BLENDING_NONE:
+		*under_alp_sel = ADE_ALP_MUL_COEFF_2; /* 0 */
+		break;
+	default:
+		DRM_ERROR("unsupport blending=0x%X\n", blend);
+		break;
+	}
+}
+
+static void ade_overlay_set(struct ade_crtc *acrtc, u8 ch, u8 zpos, u32 x0,
+			    u32 y0, u32 in_w, u32 in_h, u32 blend,
+			    u8 glb_alpha, u32 fmt)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	struct hisi_crtc_state *
+		state = to_hisi_crtc_state(acrtc->base.base.state);
+	void __iomem *base = ctx->base;
+	u8 comp_type = state->comp_type;
+	u8 ovly_ch = zpos;
+	u8 x = ADE_OVLY2;
+	u32 x1 = x0 + in_w - 1;
+	u32 y1 = y0 + in_h - 1;
+	u32 val;
+	u8 alp_sel;
+	u8 under_alp_sel;
+	u8 alp_mode;
+
+	ade_get_blending_params(blend, fmt, glb_alpha, &alp_mode,
+				&alp_sel, &under_alp_sel);
+
+	/*
+	 * when all the HWC layers are composed by HWC, target layer(aka primary
+	 * plane) should be ignored. So make primary plane transparent.
+	 */
+
+	if (ch == PRIMARY_CH) {
+		if (comp_type == COMPOSITION_HWC)
+			alp_sel = ADE_ALP_MUL_COEFF_2; /* 0 */
+		else if (comp_type == COMPOSITION_GLES)
+			under_alp_sel = ADE_ALP_MUL_COEFF_2; /* 0 */
+	}
+
+	/* overlay routing setting */
+	writel(x0 << 16 | y0, base + ADE_OVLY_CH_XY0(ovly_ch));
+	writel(x1 << 16 | y1, base + ADE_OVLY_CH_XY1(ovly_ch));
+	val = (ch + 1) << ADE_OVLY_CH_SEL_OFST | BIT(ADE_OVLY_CH_EN_OFST) |
+		alp_sel << ADE_OVLY_CH_ALP_SEL_OFST |
+		under_alp_sel << ADE_OVLY_CH_UNDER_ALP_SEL_OFST |
+		glb_alpha << ADE_OVLY_CH_ALP_GBL_OFST |
+		alp_mode << ADE_OVLY_CH_ALP_MODE_OFST;
+	writel(val, base + ADE_OVLY_CH_CTL(ovly_ch));
+	val = (x + 1) << (ovly_ch * 4) | readl(base + ADE_OVLY_CTL);
+	writel(val, base + ADE_OVLY_CTL);
+
+	if (ch == ADE_DISP)
+		writel(1, base + ADE_CTRAN5_TRANS_CFG);
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
+static void ade_overlay_disable(struct ade_crtc *acrtc, u32 ch, u8 zpos)
+{
+	struct ade_hardware_context *ctx = acrtc->base.ctx;
+	void __iomem *base = ctx->base;
+	u8 ovly_ch = zpos;
+	u32 val;
+
+	val = ~BIT(6) & readl(base + ADE_OVLY_CH_CTL(ovly_ch));
+	writel(val, base + ADE_OVLY_CH_CTL(ovly_ch));
+
+	val = ~(0x3 << (ovly_ch * 4)) & readl(base + ADE_OVLY_CTL);
+	writel(val, base + ADE_OVLY_CTL);
+
+	if (ch == ADE_DISP)
+		writel(0, base + ADE_CTRAN5_TRANS_CFG);
+}
+
+/*
+ * Typicaly, a channel looks like: DMA-->clip-->scale-->ctrans-->overlay
+ */
+static void ade_update_channel(struct hisi_plane *hplane,
+			       struct ade_crtc *acrtc,
+			       struct drm_framebuffer *fb, int crtc_x,
+			       int crtc_y, unsigned int crtc_w,
+			       unsigned int crtc_h, u32 src_x,
+			       u32 src_y, u32 src_w, u32 src_h)
+{
+	struct drm_plane_state	*state = hplane->base.state;
+	struct hisi_plane_state *hstate = to_hisi_plane_state(state);
+	u8 ch = hplane->ch;
+	u8 zpos = hstate->zpos;
+	u8 glb_alpha = hstate->alpha;
+	u32 blend = hstate->blend;
+	u32 rotation = state->rotation;
+	u32 fmt = ade_get_format(fb->pixel_format);
+	u32 in_w;
+	u32 in_h;
+	u32 out_w;
+	u32 out_h;
+
+	/* 1) DMA setting */
+	in_w = src_w;
+	in_h = src_h;
+	ade_rdma_set(acrtc, fb, ch, src_y, in_h, fmt, rotation);
+
+	/* 2) clip setting */
+	ade_clip_set(acrtc, ch, fb->width, src_x, in_w, in_h);
+
+	/* 3) scale setting */
+	out_w = crtc_w;
+	out_h = crtc_h;
+	ade_scale_set(acrtc, ch, in_w, in_h, &out_w, &out_h);
+
+	/* 4) ctran/csc setting */
+	in_w = out_w;
+	in_h = out_h;
+	ade_ctran_set(acrtc, ch, in_w, in_h, fmt);
+
+	/* 5) overlay routing setting */
+	ade_overlay_set(acrtc, ch, zpos, crtc_x, crtc_y, in_w, in_h, blend,
+			glb_alpha, fmt);
+
+	acrtc->ch_mask |= BIT(ch);
+}
+
+static void ade_disable_channel(struct hisi_plane *hplane,
+				struct ade_crtc *acrtc)
+{
+	struct drm_plane_state  *state = hplane->base.state;
+	struct hisi_plane_state *hstate = to_hisi_plane_state(state);
+	u32 ch = hplane->ch;
+	u8 zpos = hstate->zpos;
+
+	/* reset state */
+	hstate->zpos = hplane->base.type == DRM_PLANE_TYPE_PRIMARY ? 0 :
+		drm_plane_index(&hplane->base);
+	state->rotation = BIT(DRM_ROTATE_0);
+	hstate->alpha = 255;
+	hstate->blend = ALPHA_BLENDING_NONE;
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
+	/* disable scale */
+	ade_scale_disable(acrtc, ch);
+
+	/* disable ctran */
+	ade_ctran_disable(acrtc, ch);
+
+	/* disable overlay routing */
+	ade_overlay_disable(acrtc, ch, zpos);
+
+	acrtc->ch_mask &= ~BIT(ch);
+}
+
+void ade_plane_atomic_disable(struct hisi_plane *hplane,
+			      struct drm_plane_state *old_state)
+{
+	struct hisi_crtc *hcrtc = to_hisi_crtc(old_state->crtc);
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+
+	ade_disable_channel(hplane, acrtc);
+}
+
+void ade_plane_atomic_update(struct hisi_plane *hplane,
+			     struct drm_plane_state *old_state)
+{
+	struct drm_plane *plane = &hplane->base;
+	struct drm_plane_state	*state	= plane->state;
+	struct hisi_crtc *hcrtc = to_hisi_crtc(state->crtc);
+	struct ade_crtc *acrtc = to_ade_crtc(hcrtc);
+
+	ade_update_channel(hplane, acrtc, state->fb,
+			   state->crtc_x, state->crtc_y,
+			   state->crtc_w, state->crtc_h,
+			   state->src_x >> 16, state->src_y >> 16,
+			   state->src_w >> 16, state->src_h >> 16);
+}
+
+int ade_install_crtc_properties(struct drm_device *dev,
+				struct hisi_crtc *hcrtc)
+{
+	struct hisi_drm_private *priv = dev->dev_private;
+	struct drm_mode_object *obj = &hcrtc->base.base;
+	struct drm_property *prop;
+
+	/* create and attach composition type properties */
+	prop = priv->comp_type_prop;
+	if (!prop) {
+		prop = drm_property_create_enum(
+				dev, 0,	"comp_type",
+				ade_composition_type_enum_list,
+				ARRAY_SIZE(ade_composition_type_enum_list));
+		if (!prop)
+			return 0;
+
+		priv->comp_type_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, COMPOSITION_UNKNOWN);
+
+	return 0;
+}
+
+static struct hisi_crtc_ops ade_crtc_ops = {
+	.enable = ade_crtc_enable,
+	.disable = ade_crtc_disable,
+	.mode_prepare = ade_crtc_mode_prepare,
+	.mode_fixup = ade_crtc_mode_fixup,
+	.mode_set_nofb = ade_crtc_mode_set_nofb,
+	.atomic_begin = ade_crtc_atomic_begin,
+	.atomic_flush = ade_crtc_atomic_flush,
+	.install_properties = ade_install_crtc_properties,
+};
+
+static struct hisi_plane_funcs ade_plane_ops = {
+	.atomic_update = ade_plane_atomic_update,
+	.atomic_disable = ade_plane_atomic_disable,
+	.install_properties = ade_install_plane_properties,
+	.get_properties = ade_get_channel_formats,
+};
+
 static int ade_dts_parse(struct platform_device *pdev,
 			 struct ade_hardware_context *ctx)
 {
@@ -129,19 +1206,25 @@ static int ade_bind(struct device *dev, struct device *master, void *data)
 		hplane = &ade->hplane[i];
 		hplane->ch = i;
 		hplane->ctx = ctx;
+		hplane->ops = &ade_plane_ops;
 		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
 			DRM_PLANE_TYPE_OVERLAY;
 
 		ret = hisi_drm_plane_init(drm_dev, hplane, type);
-		if (ret)
+		if (ret) {
+			DRM_ERROR("failed to hisi drm plane init\n");
 			return ret;
+		}
 	}
 
 	/* crtc init */
+	hcrtc->ops = &ade_crtc_ops;
 	hcrtc->ctx = ctx;
 	ret = hisi_drm_crtc_init(drm_dev, hcrtc, &ade->hplane[PRIMARY_CH].base);
-	if (ret)
+	if (ret) {
+		DRM_ERROR("failed to hisi drm crtc init\n");
 		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hisi_ade_reg.h b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
index bdf3c3b..0e388af 100644
--- a/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
@@ -13,6 +13,113 @@
 #ifndef __HISI_ADE_REG_H__
 #define __HISI_ADE_REG_H__
 
+/********** ADE Register Offset ***********/
+#define ADE_CTRL                (0x4)
+#define ADE_CTRL1               (0x8C)
+#define ADE_DISP_SRC_CFG        (0x18)
+#define ADE_OVLY1_TRANS_CFG     (0x2C)
+#define ADE_EN                  (0x100)
+/* reset and reload regs */
+#define ADE_SOFT_RST_SEL0       (0x78)
+#define ADE_SOFT_RST_SEL1       (0x7C)
+#define ADE_RELOAD_DIS0         (0xAC)
+#define ADE_RELOAD_DIS1         (0xB0)
+#define ADE_CH_RDMA_BIT_OFST    (0)
+#define ADE_CLIP_BIT_OFST       (15)
+#define ADE_SCL_BIT_OFST        (21)
+#define ADE_CTRAN_BIT_OFST      (24)
+#define ADE_OVLY_BIT_OFST       (37) /* 32+5 */
+/* channel regs */
+#define RD_CH_CTRL(x)           (0x1004 + (x) * 0x80)
+#define RD_CH_ADDR(x)           (0x1008 + (x) * 0x80)
+#define RD_CH_SIZE(x)           (0x100C + (x) * 0x80)
+#define RD_CH_STRIDE(x)         (0x1010 + (x) * 0x80)
+#define RD_CH_SPACE(x)          (0x1014 + (x) * 0x80)
+#define RD_CH_EN(x)             (0x1020 + (x) * 0x80)
+#define RD_CH_DISP_CTRL         (0x1404)
+#define RD_CH_DISP_ADDR         (0x1408)
+#define RD_CH_DISP_SIZE         (0x140C)
+#define RD_CH_DISP_STRIDE       (0x1410)
+#define RD_CH_DISP_SPACE        (0x1414)
+#define RD_CH_DISP_EN           (0x142C)
+/* clip regs */
+#define ADE_CLIP_DISABLE(x)     (0x6800 + (x) * 0x100)
+#define ADE_CLIP_SIZE0(x)       (0x6804 + (x) * 0x100)
+#define ADE_CLIP_SIZE1(x)       (0x6808 + (x) * 0x100)
+/* scale regs */
+#define ADE_SCL_CTRL(x)         (0x3000 + (x) * 0x800)
+#define ADE_SCL_ORES(x)         (0x3014 + (x) * 0x800)
+#define ADE_SCL_IRES(x)         (0x3018 + (x) * 0x800)
+#define ADE_SCL_START(x)        (0x301C + (x) * 0x800)
+/* ctran regs */
+#define ADE_CTRAN5_TRANS_CFG    (0x40)
+#define ADE_CTRAN_DIS(x)        (0x5004 + (x) * 0x100)
+#define ADE_CTRAN_IMAGE_SIZE(x) (0x503C + (x) * 0x100)
+/* overlay regs */
+#define ADE_OVLY_CH_XY0(x)      (0x2004 + (x) * 4)
+#define ADE_OVLY_CH_XY1(x)      (0x2024 + (x) * 4)
+#define ADE_OVLY_CH_CTL(x)      (0x204C + (x) * 4)
+#define ADE_OVLY_OUTPUT_SIZE(x) (0x2070 + (x) * 8)
+#define ADE_OVLYX_CTL(x)        (0x209C + (x) * 4)
+#define ADE_OVLY_CTL            (0x98)
+#define ADE_OVLY_CH_ALP_MODE_OFST (0)
+#define ADE_OVLY_CH_ALP_SEL_OFST (2)
+#define ADE_OVLY_CH_UNDER_ALP_SEL_OFST (4)
+#define ADE_OVLY_CH_EN_OFST (6)
+#define ADE_OVLY_CH_ALP_GBL_OFST (15)
+#define ADE_OVLY_CH_SEL_OFST (28)
+
+/* media regs */
+#define SC_MEDIA_RSTDIS         (0x530)
+#define SC_MEDIA_RSTEN		(0x52C)
+
+/*set ADE flag param define */
+#define	ADE_DISABLE		(0)
+#define	ADE_ENABLE		(1)
+#define	ADE_RGB			(0)
+#define	ADE_BGR			(1)
+
+/* ADE out format param */
+enum {
+	ADE_OUT_RGB_565 = 0,
+	ADE_OUT_RGB_666,
+	ADE_OUT_RGB_888
+};
+
+/*
+ * ADE read as big-endian, so revert the
+ * rgb order described in the SoC datasheet
+ * */
+enum ADE_FORMAT {
+	ADE_BGR_565,
+	ADE_RGB_565,
+	ADE_XBGR_8888,
+	ADE_XRGB_8888,
+	ADE_ABGR_8888,
+	ADE_ARGB_8888,
+	ADE_BGRA_8888,
+	ADE_RGBA_8888,
+	ADE_BGR_888,
+	ADE_RGB_888,
+	ADE_YUYV = 16,
+	ADE_YVYU,
+	ADE_UYVY,
+	ADE_VYUY,
+	ADE_YUV444,
+	ADE_NV12,
+	ADE_NV21,
+	ADE_FORMAT_NOT_SUPPORT = 800
+};
+
+/* ldi src cfg */
+enum {
+	TOP_DISP_SRC_NONE = 0,
+	TOP_DISP_SRC_OVLY2,
+	TOP_DISP_SRC_DISP,
+	TOP_DISP_SRC_ROT,
+	TOP_DISP_SRC_SCL2
+};
+
 enum ade_channel {
 	ADE_CH1 = 0,	/* channel 1 for primary plane */
 	ADE_CH2,
@@ -24,4 +131,78 @@ enum ade_channel {
 	ADE_CH_NUM
 };
 
+enum ade_scale {
+	ADE_SCL1 = 0,
+	ADE_SCL2,
+	ADE_SCL3,
+	ADE_SCL_NUM
+};
+
+enum ade_ctran {
+	ADE_CTRAN1 = 0,
+	ADE_CTRAN2,
+	ADE_CTRAN3,
+	ADE_CTRAN4,
+	ADE_CTRAN5,
+	ADE_CTRAN6,
+	ADE_CTRAN_NUM
+};
+
+enum ade_overlay {
+	ADE_OVLY1 = 0,
+	ADE_OVLY2,
+	ADE_OVLY3,
+	ADE_OVLY_NUM
+};
+
+enum {
+	ADE_ALP_GLOBAL = 0,
+	ADE_ALP_PIXEL,
+	ADE_ALP_PIXEL_AND_GLB
+};
+
+enum {
+	ADE_ALP_MUL_COEFF_0 = 0,	/* alpha */
+	ADE_ALP_MUL_COEFF_1,		/* 1-alpha */
+	ADE_ALP_MUL_COEFF_2,		/* 0 */
+	ADE_ALP_MUL_COEFF_3		/* 1 */
+};
+
+/********** LDI Register Offset ***********/
+#define LDI_HRZ_CTRL0		(0x7400)
+#define LDI_HRZ_CTRL1		(0x7404)
+#define LDI_VRT_CTRL0		(0x7408)
+#define LDI_VRT_CTRL1		(0x740C)
+#define LDI_PLR_CTRL		(0x7410)
+#define LDI_DSP_SIZE		(0x7414)
+#define LDI_INT_EN		(0x741C)
+#define LDI_CTRL		(0x7420)
+#define LDI_MSK_INT		(0x7428)
+#define LDI_INT_CLR		(0x742C)
+#define LDI_WORK_MODE		(0x7430)
+#define LDI_DE_SPACE_LOW	(0x7438)
+#define LDI_HDMI_DSI_GT		(0x7434)
+
+/* LDI Timing Polarity defines */
+#define HISI_LDI_FLAG_NVSYNC	BIT(0)
+#define HISI_LDI_FLAG_NHSYNC	BIT(1)
+#define HISI_LDI_FLAG_NPIXCLK	BIT(2)
+#define HISI_LDI_FLAG_NDE	BIT(3)
+
+/* set LDI param define */
+#define LDI_TEST                (0)
+#define LDI_WORK                (1)
+#define	LDI_ISR_FRAME_END_INT   (0x02)
+#define	LDI_ISR_UNDER_FLOW_INT  (0x04)
+
+/********** LDI Register Write/Read Helper functions ***********/
+static inline void set_reg(u8 *addr, u32 val, u32 bw, u32 bs)
+{
+	u32 mask = (1 << bw) - 1;
+	u32 tmp = readl(addr);
+
+	tmp &= ~(mask << bs);
+	writel(tmp | ((val & mask) << bs), addr);
+}
+
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
index ad13614..feeadc4 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
@@ -19,35 +19,82 @@
 
 static void  hisi_drm_crtc_enable(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (hcrtc->enable)
+		return;
+
+	if (ops->enable)
+		ops->enable(hcrtc);
+	drm_crtc_vblank_on(crtc);
+
+	hcrtc->enable = true;
 }
 
 static void hisi_drm_crtc_disable(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (!hcrtc->enable)
+		return;
+
+	drm_crtc_vblank_off(crtc);
+	if (ops->disable)
+		ops->disable(hcrtc);
+
+	hcrtc->enable = false;
 }
 
 static void hisi_drm_crtc_mode_prepare(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (ops->mode_prepare)
+		ops->mode_prepare(hcrtc);
 }
 
 static bool hisi_drm_crtc_mode_fixup(struct drm_crtc *crtc,
 				     const struct drm_display_mode *mode,
 				     struct drm_display_mode *adj_mode)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
 	bool ret = true;
 
+	if (ops->mode_fixup)
+		ret = ops->mode_fixup(hcrtc, mode, adj_mode);
+
 	return ret;
 }
 
 static void hisi_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (ops->mode_set_nofb)
+		ops->mode_set_nofb(hcrtc);
 }
 
 static void hisi_crtc_atomic_begin(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (ops->atomic_begin)
+		ops->atomic_begin(hcrtc);
 }
 
 static void hisi_crtc_atomic_flush(struct drm_crtc *crtc)
 {
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (ops->atomic_flush)
+		ops->atomic_flush(hcrtc);
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
index 989cb1f..6521ed8 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
@@ -13,6 +13,7 @@
 #ifndef __HISI_DRM_CRTC_H__
 #define __HISI_DRM_CRTC_H__
 
+#define to_hisi_crtc(crtc)  container_of(crtc, struct hisi_crtc, base)
 #define to_hisi_crtc_state(state) \
 		container_of(state, struct hisi_crtc_state, base)
 
@@ -27,9 +28,20 @@ struct hisi_crtc {
 	struct drm_crtc base;
 	void *ops;
 	void *ctx;
+	bool enable;
 };
 
 struct hisi_crtc_ops {
+	void (*disable)(struct hisi_crtc *hcrtc);
+	void (*enable)(struct hisi_crtc *hcrtc);
+	void (*mode_prepare)(struct hisi_crtc *hcrtc);
+	bool (*mode_fixup)(struct hisi_crtc *hcrtc,
+			   const struct drm_display_mode *mode,
+			   struct drm_display_mode *adj_mode);
+	void (*mode_set_nofb)(struct hisi_crtc *hcrtc);
+	void (*atomic_begin)(struct hisi_crtc *hcrtc);
+	void (*atomic_flush)(struct hisi_crtc *hcrtc);
+	void (*destroy)(struct hisi_crtc *hcrtc);
 	int (*install_properties)(struct drm_device *dev,
 				  struct hisi_crtc *hcrtc);
 };
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fb.c b/drivers/gpu/drm/hisilicon/hisi_drm_fb.c
index 5dace8b..9221009 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_fb.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fb.c
@@ -10,8 +10,8 @@
  *
  */
 
-#include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_gem_cma_helper.h>
 
 #include "hisi_drm_fb.h"
 
@@ -154,3 +154,22 @@ err_gem_object_unreference:
 	return ERR_PTR(ret);
 }
 
+/**
+ * hisi_drm_fb_get_gem_obj() - Get CMA GEM object for framebuffer
+ * @fb: The framebuffer
+ * @plane: Which plane
+ *
+ * Return the CMA GEM object for given framebuffer.
+ *
+ * This function will usually be called from the CRTC callback functions.
+ */
+struct drm_gem_cma_object *hisi_drm_fb_get_gem_obj(struct drm_framebuffer *fb,
+						   unsigned int plane)
+{
+	struct hisi_drm_fb *hisi_fb = to_hisi_drm_fb(fb);
+
+	if (plane >= 4)
+		return NULL;
+
+	return hisi_fb->obj[plane];
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fb.h b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
index 1db1289..4bd168e 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
@@ -22,5 +22,7 @@ struct hisi_drm_fb {
 struct drm_framebuffer *hisi_drm_fb_create(struct drm_device *dev,
 					   struct drm_file *file_priv,
 					   struct drm_mode_fb_cmd2 *mode_cmd);
+struct drm_gem_cma_object *
+hisi_drm_fb_get_gem_obj(struct drm_framebuffer *fb, unsigned int plane);
 
 #endif /* __HISI_DRM_FB_H__ */
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_plane.c b/drivers/gpu/drm/hisilicon/hisi_drm_plane.c
index af040b6..df3edab 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_plane.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_plane.c
@@ -24,11 +24,28 @@
 static void hisi_plane_atomic_disable(struct drm_plane *plane,
 				      struct drm_plane_state *old_state)
 {
+	struct hisi_plane *hplane = to_hisi_plane(plane);
+	struct hisi_plane_funcs *ops = hplane->ops;
+
+	if (!old_state->crtc)
+		return;
+
+	if (ops->atomic_disable)
+		ops->atomic_disable(hplane, old_state);
 }
 
 static void hisi_plane_atomic_update(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
+	struct hisi_plane *hplane = to_hisi_plane(plane);
+	struct hisi_plane_funcs *ops = hplane->ops;
+	struct drm_plane_state	*hstate	= plane->state;
+
+	if (!hstate->crtc)
+		return;
+
+	if (ops->atomic_update)
+		ops->atomic_update(hplane, old_state);
 }
 
 int hisi_plane_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_plane.h b/drivers/gpu/drm/hisilicon/hisi_drm_plane.h
index 70ee845..212514c 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_plane.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_plane.h
@@ -35,6 +35,10 @@ struct hisi_plane_funcs {
 	u32 (*get_properties)(u8 ch, const u32 **formats);
 	int (*install_properties)(struct drm_device *dev,
 				  struct hisi_plane *hplane);
+	void (*atomic_update)(struct hisi_plane *hplane,
+			      struct drm_plane_state *old_state);
+	void (*atomic_disable)(struct hisi_plane *hplane,
+			       struct drm_plane_state *old_state);
 };
 
 int hisi_drm_plane_init(struct drm_device *dev, struct hisi_plane *hplane,
-- 
1.9.1
