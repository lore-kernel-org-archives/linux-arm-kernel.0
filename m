From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 1 Mar 2016 00:18:15 +0530
Subject: [PATCH v6 04/11] drm/hisilicon: Add plane driver for ADE
In-Reply-To: <1456476028-36880-5-git-send-email-xinliang.liu@linaro.org>
References: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
 <1456476028-36880-5-git-send-email-xinliang.liu@linaro.org>
Message-ID: <56D4926F.1090707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/26/2016 2:10 PM, Xinliang Liu wrote:
> Add plane funcs and helper funcs for ADE.
>
> v6: None.
> v5: None.
> v4: None.
> v3:
> - A few cleanup.
> v2:
> - Remove abtraction layer.
>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> ---
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 535 +++++++++++++++++++++++-
>   1 file changed, 534 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index bb93616dcf3d..aa2cf75cab39 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -27,13 +27,23 @@
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
>
>   #include "kirin_drm_drv.h"
>   #include "kirin_ade_reg.h"
>
> +#define PRIMARY_CH	ADE_CH1 /* primary plane */
> +#define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */

Could you briefly explain this overlay/channel mapping? It looks like
it's something that is hard coded at the moment.

Do channels map to planes, and OVLs map to crtcs?

> +#define ADE_DEBUG	1
> +
>   #define to_ade_crtc(crtc) \
>   	container_of(crtc, struct ade_crtc, base)
>
> +#define to_ade_plane(plane) \
> +	container_of(plane, struct ade_plane, base)
> +
>   struct ade_hw_ctx {
>   	void __iomem  *base;
>   	struct regmap *noc_regmap;
> @@ -52,11 +62,76 @@ struct ade_crtc {
>   	u32 out_format;
>   };
>
> +struct ade_plane {
> +	struct drm_plane base;
> +	void *ctx;
> +	u8 ch; /* channel */
> +};
> +
>   struct ade_data {
>   	struct ade_crtc acrtc;
> +	struct ade_plane aplane[ADE_CH_NUM];
>   	struct ade_hw_ctx ctx;
>   };
>
> +/* ade-format info: */
> +struct ade_format {
> +	u32 pixel_format;
> +	enum ade_fb_format ade_format;
> +};
> +
> +static const struct ade_format ade_formats[] = {
> +	/* 16bpp RGB: */
> +	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
> +	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
> +	/* 24bpp RGB: */
> +	{ DRM_FORMAT_RGB888, ADE_RGB_888 },
> +	{ DRM_FORMAT_BGR888, ADE_BGR_888 },
> +	/* 32bpp [A]RGB: */
> +	{ DRM_FORMAT_XRGB8888, ADE_XRGB_8888 },
> +	{ DRM_FORMAT_XBGR8888, ADE_XBGR_8888 },
> +	{ DRM_FORMAT_RGBA8888, ADE_RGBA_8888 },
> +	{ DRM_FORMAT_BGRA8888, ADE_BGRA_8888 },
> +	{ DRM_FORMAT_ARGB8888, ADE_ARGB_8888 },
> +	{ DRM_FORMAT_ABGR8888, ADE_ABGR_8888 },
> +};
> +
> +static const u32 channel_formats1[] = {
> +	/* channel 1,2,3,4 */
> +	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888
> +};
> +
> +u32 ade_get_channel_formats(u8 ch, const u32 **formats)
> +{
> +	switch (ch) {
> +	case ADE_CH1:
> +		*formats = channel_formats1;
> +		return ARRAY_SIZE(channel_formats1);
> +	default:
> +		DRM_ERROR("no this channel %d\n", ch);
> +		*formats = NULL;
> +		return 0;
> +	}
> +}
> +
> +/* convert from fourcc format to ade format */
> +static u32 ade_get_format(u32 pixel_format)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
> +		if (ade_formats[i].pixel_format == pixel_format)
> +			return ade_formats[i].ade_format;
> +
> +	/* not found */
> +	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
> +		  pixel_format);
> +	return ADE_FORMAT_NOT_SUPPORT;
> +}
> +
>   static void ade_update_reload_bit(void __iomem *base, u32 bit_num, u32 val)
>   {
>   	u32 bit_ofst, reg_num;
> @@ -89,7 +164,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
>   	/* clear overlay */
>   	writel(0, base + ADE_OVLY1_TRANS_CFG);
>   	writel(0, base + ADE_OVLY_CTL);
> -	writel(0, base + ADE_OVLYX_CTL(ADE_OVLY2));
> +	writel(0, base + ADE_OVLYX_CTL(OUT_OVLY));
>   	/* clear reset and reload regs */
>   	writel(MASK(32), base + ADE_SOFT_RST_SEL(0));
>   	writel(MASK(32), base + ADE_SOFT_RST_SEL(1));
> @@ -147,6 +222,10 @@ static void ade_ldi_set_mode(struct ade_crtc *acrtc,
>   			  mode->clock * 1000, ret);
>   	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
>
> +	/* set overlay compositor output size */
> +	writel(((width - 1) << OUTPUT_XSIZE_OFST) | (height - 1),
> +	       base + ADE_OVLY_OUTPUT_SIZE(OUT_OVLY));
> +
>   	/* ctran6 setting */
>   	writel(CTRAN_BYPASS_ON, base + ADE_CTRAN_DIS(ADE_CTRAN6));
>   	 /* the configured value is actual value - 1 */
> @@ -219,6 +298,10 @@ static void ade_display_enable(struct ade_crtc *acrtc)
>   	void __iomem *base = ctx->base;
>   	u32 out_fmt = acrtc->out_format;
>
> +	/* enable output overlay compositor */
> +	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(OUT_OVLY));
> +	ade_update_reload_bit(base, OVLY_OFST + OUT_OVLY, 0);
> +
>   	/* display source setting */
>   	writel(DISP_SRC_OVLY2, base + ADE_DISP_SRC_CFG);
>
> @@ -232,6 +315,97 @@ static void ade_display_enable(struct ade_crtc *acrtc)
>   	writel(DSI_PCLK_ON, base + LDI_HDMI_DSI_GT);
>   }
>
> +#if ADE_DEBUG
> +static void ade_rdma_dump_regs(void __iomem *base, u32 ch)
> +{
> +	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
> +	u32 val;
> +
> +	reg_ctrl = RD_CH_CTRL(ch);
> +	reg_addr = RD_CH_ADDR(ch);
> +	reg_size = RD_CH_SIZE(ch);
> +	reg_stride = RD_CH_STRIDE(ch);
> +	reg_space = RD_CH_SPACE(ch);
> +	reg_en = RD_CH_EN(ch);
> +
> +	val = ade_read_reload_bit(base, RDMA_OFST + ch);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reload(%d)\n", ch + 1, val);
> +	val = readl(base + reg_ctrl);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_ctrl(0x%08x)\n", ch + 1, val);
> +	val = readl(base + reg_addr);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_addr(0x%08x)\n", ch + 1, val);
> +	val = readl(base + reg_size);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_size(0x%08x)\n", ch + 1, val);
> +	val = readl(base + reg_stride);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_stride(0x%08x)\n", ch + 1, val);
> +	val = readl(base + reg_space);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_space(0x%08x)\n", ch + 1, val);
> +	val = readl(base + reg_en);
> +	DRM_DEBUG_DRIVER("[rdma%d]: reg_en(0x%08x)\n", ch + 1, val);
> +}
> +
> +static void ade_clip_dump_regs(void __iomem *base, u32 ch)
> +{
> +	u32 val;
> +
> +	val = ade_read_reload_bit(base, CLIP_OFST + ch);
> +	DRM_DEBUG_DRIVER("[clip%d]: reload(%d)\n", ch + 1, val);
> +	val = readl(base + ADE_CLIP_DISABLE(ch));
> +	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_disable(0x%08x)\n", ch + 1, val);
> +	val = readl(base + ADE_CLIP_SIZE0(ch));
> +	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_size0(0x%08x)\n", ch + 1, val);
> +	val = readl(base + ADE_CLIP_SIZE1(ch));
> +	DRM_DEBUG_DRIVER("[clip%d]: reg_clip_size1(0x%08x)\n", ch + 1, val);
> +}
> +
> +static void ade_compositor_routing_dump_regs(void __iomem *base, u32 ch)
> +{
> +	u8 ovly_ch = 0; /* TODO: Only primary plane now */
> +	u32 val;
> +
> +	val = readl(base + ADE_OVLY_CH_XY0(ovly_ch));
> +	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_xy0(0x%08x)\n", ovly_ch, val);
> +	val = readl(base + ADE_OVLY_CH_XY1(ovly_ch));
> +	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_xy1(0x%08x)\n", ovly_ch, val);
> +	val = readl(base + ADE_OVLY_CH_CTL(ovly_ch));
> +	DRM_DEBUG_DRIVER("[overlay ch%d]: reg_ch_ctl(0x%08x)\n", ovly_ch, val);
> +}
> +
> +static void ade_dump_overlay_compositor_regs(void __iomem *base, u32 comp)
> +{
> +	u32 val;
> +
> +	val = ade_read_reload_bit(base, OVLY_OFST + comp);
> +	DRM_DEBUG_DRIVER("[overlay%d]: reload(%d)\n", comp + 1, val);
> +	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(comp));
> +	DRM_DEBUG_DRIVER("[overlay%d]: reg_ctl(0x%08x)\n", comp + 1, val);
> +	val = readl(base + ADE_OVLY_CTL);
> +	DRM_DEBUG_DRIVER("ovly_ctl(0x%08x)\n", val);
> +}
> +
> +static void ade_dump_regs(void __iomem *base)
> +{
> +	u32 i;
> +
> +	/* dump channel regs */
> +	for (i = 0; i < ADE_CH_NUM; i++) {
> +		/* dump rdma regs */
> +		ade_rdma_dump_regs(base, i);
> +
> +		/* dump clip regs */
> +		ade_clip_dump_regs(base, i);
> +
> +		/* dump compositor routing regs */
> +		ade_compositor_routing_dump_regs(base, i);
> +	}
> +
> +	/* dump overlay compositor regs */
> +	ade_dump_overlay_compositor_regs(base, OUT_OVLY);
> +}
> +#else
> +static void ade_dump_regs(void __iomem *base) { }
> +#endif
> +
>   static void ade_crtc_enable(struct drm_crtc *crtc)
>   {
>   	struct ade_crtc *acrtc = to_ade_crtc(crtc);
> @@ -249,6 +423,7 @@ static void ade_crtc_enable(struct drm_crtc *crtc)
>
>   	ade_set_medianoc_qos(acrtc);
>   	ade_display_enable(acrtc);
> +	ade_dump_regs(ctx->base);
>   	acrtc->enable = true;
>   }
>
> @@ -303,6 +478,7 @@ static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
>
>   	/* only crtc is eanbled regs take effect */
>   	if (acrtc->enable) {
> +		ade_dump_regs(base);
>   		/* flush ade regitsters */
>   		writel(ADE_ENABLE, base + ADE_EN);
>   	}
> @@ -359,6 +535,338 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>   	return 0;
>   }
>
> +static void ade_rdma_set(void __iomem *base, struct drm_framebuffer *fb,
> +			 u32 ch, u32 y, u32 in_h, u32 fmt)
> +{
> +	struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, 0);
> +	u32 reg_ctrl, reg_addr, reg_size, reg_stride, reg_space, reg_en;
> +	u32 stride = fb->pitches[0];
> +	u32 addr = (u32)obj->paddr + y * stride;
> +
> +	DRM_DEBUG_DRIVER("rdma%d: (y=%d, height=%d), stride=%d, paddr=0x%x\n",
> +			 ch + 1, y, in_h, stride, (u32)obj->paddr);
> +	DRM_DEBUG_DRIVER("addr=0x%x, fb:%dx%d, pixel_format=%d(%s)\n",
> +			 addr, fb->width, fb->height, fmt,
> +			 drm_get_format_name(fb->pixel_format));
> +
> +	/* get reg offset */
> +	reg_ctrl = RD_CH_CTRL(ch);
> +	reg_addr = RD_CH_ADDR(ch);
> +	reg_size = RD_CH_SIZE(ch);
> +	reg_stride = RD_CH_STRIDE(ch);
> +	reg_space = RD_CH_SPACE(ch);
> +	reg_en = RD_CH_EN(ch);
> +
> +	/*
> +	 * TODO: set rotation
> +	 */
> +	writel((fmt << 16) & 0x1f0000, base + reg_ctrl);
> +	writel(addr, base + reg_addr);
> +	writel((in_h << 16) | stride, base + reg_size);
> +	writel(stride, base + reg_stride);
> +	writel(in_h * stride, base + reg_space);
> +	writel(ADE_ENABLE, base + reg_en);
> +	ade_update_reload_bit(base, RDMA_OFST + ch, 0);
> +}
> +
> +static void ade_rdma_disable(void __iomem *base, u32 ch)
> +{
> +	u32 reg_en;
> +
> +	/* get reg offset */
> +	reg_en = RD_CH_EN(ch);
> +	writel(0, base + reg_en);
> +	ade_update_reload_bit(base, RDMA_OFST + ch, 1);
> +}
> +
> +static void ade_clip_set(void __iomem *base, u32 ch, u32 fb_w, u32 x,
> +			 u32 in_w, u32 in_h)
> +{
> +	u32 disable_val;
> +	u32 clip_left;
> +	u32 clip_right;
> +
> +	/*
> +	 * clip width, no need to clip height
> +	 */
> +	if (fb_w == in_w) { /* bypass */
> +		disable_val = 1;
> +		clip_left = 0;
> +		clip_right = 0;
> +	} else {
> +		disable_val = 0;
> +		clip_left = x;
> +		clip_right = fb_w - (x + in_w) - 1;
> +	}
> +
> +	DRM_DEBUG_DRIVER("clip%d: clip_left=%d, clip_right=%d\n",
> +			 ch + 1, clip_left, clip_right);
> +
> +	writel(disable_val, base + ADE_CLIP_DISABLE(ch));
> +	writel((fb_w - 1) << 16 | (in_h - 1), base + ADE_CLIP_SIZE0(ch));
> +	writel(clip_left << 16 | clip_right, base + ADE_CLIP_SIZE1(ch));
> +	ade_update_reload_bit(base, CLIP_OFST + ch, 0);
> +}
> +
> +static void ade_clip_disable(void __iomem *base, u32 ch)
> +{
> +	writel(1, base + ADE_CLIP_DISABLE(ch));
> +	ade_update_reload_bit(base, CLIP_OFST + ch, 1);
> +}
> +
> +static bool has_Alpha_channel(int format)
> +{
> +	switch (format) {
> +	case ADE_ARGB_8888:
> +	case ADE_ABGR_8888:
> +	case ADE_RGBA_8888:
> +	case ADE_BGRA_8888:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void ade_get_blending_params(u32 fmt, u8 glb_alpha, u8 *alp_mode,
> +				    u8 *alp_sel, u8 *under_alp_sel)
> +{
> +	bool has_alpha = has_Alpha_channel(fmt);
> +
> +	/*
> +	 * get alp_mode
> +	 */
> +	if (has_alpha && glb_alpha < 255)
> +		*alp_mode = ADE_ALP_PIXEL_AND_GLB;
> +	else if (has_alpha)
> +		*alp_mode = ADE_ALP_PIXEL;
> +	else
> +		*alp_mode = ADE_ALP_GLOBAL;
> +
> +	/*
> +	 * get alp sel
> +	 */
> +	*alp_sel = ADE_ALP_MUL_COEFF_3; /* 1 */
> +	*under_alp_sel = ADE_ALP_MUL_COEFF_2; /* 0 */
> +}
> +
> +static void ade_compositor_routing_set(void __iomem *base, u8 ch,
> +				       u32 x0, u32 y0,
> +				       u32 in_w, u32 in_h, u32 fmt)
> +{
> +	u8 ovly_ch = 0; /* TODO: This is the zpos, only one plane now */

Does the ovly_ch map to the crtc here? If so, maybe instead of hard
coding it here, you could extract the channel number via plane->crtc?

Other than the hard coding, it looks fine to me.

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
