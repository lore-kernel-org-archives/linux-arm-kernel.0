From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Sat, 28 Nov 2015 15:56:31 +0000
Subject: [PATCH v2 04/10] drm/hisilicon: Add crtc funcs for ADE
In-Reply-To: <1448707145-69348-5-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-5-git-send-email-xinliang.liu@linaro.org>
Message-ID: <CACvgo50SD5dJ95rKSrbW1Zo3DRG9bWs2ZuDhfDC7UrZVMLSnJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use_maskOn 28 November 2015 at 10:38, Xinliang Liu
<xinliang.liu@linaro.org> wrote:
> Add crtc funcs and helper funcs for ADE.
>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---

> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h

> +#define ADE_CTRL                       (0x4)
> +#define ADE_CTRL1                      (0x8C)
> +#define ADE_ROT_SRC_CFG                        (0x10)
> +#define ADE_DISP_SRC_CFG               (0x18)
> +#define ADE_WDMA2_SRC_CFG              (0x1C)
> +#define ADE_SEC_OVLY_SRC_CFG           (0x20)
> +#define ADE_WDMA3_SRC_CFG              (0x24)
> +#define ADE_OVLY1_TRANS_CFG            (0x2C)
> +#define ADE_EN                         (0x100)
> +#define INTR_MASK_CPU_0                        (0xC10)
> +#define INTR_MASK_CPU_1                        (0xC14)
> +#define ADE_FRM_DISGARD_CTRL           (0xA4)
> +/* reset and reload regs */
> +#define ADE_SOFT_RST_SEL0              (0x78)
> +#define ADE_SOFT_RST_SEL1              (0x7C)
> +#define ADE_RELOAD_DIS0                        (0xAC)
> +#define ADE_RELOAD_DIS1                        (0xB0)
> +#define ADE_CH_RDMA_BIT_OFST           (0)
> +#define ADE_CLIP_BIT_OFST              (15)
> +#define ADE_SCL_BIT_OFST               (21)
> +#define ADE_CTRAN_BIT_OFST             (24)
> +#define ADE_OVLY_BIT_OFST              (37) /* 32+5 */
Don't think we have any cases in drm where constants are wrapped in
brackets. Is there any benefit of doing that here ?

> +/* channel regs */
> +#define RD_CH_PE(x)                    (0x1000 + (x) * 0x80)
... and I'm not talking about cases where the macros such as this one.

> +union U_LDI_CTRL {
> +struct {
> +       unsigned int    ldi_en                :1;
> +       unsigned int    disp_mode_buf         :1;
> +       unsigned int    date_gate_en          :1;
> +       unsigned int    bpp                   :2;
> +       unsigned int    wait_vsync_en         :1;
> +       unsigned int    corlorbar_width       :7;
> +       unsigned int    bgr                   :1;
> +       unsigned int    color_mode            :1;
> +       unsigned int    shutdown              :1;
> +       unsigned int    vactive_line          :12;
> +       unsigned int    ldi_en_self_clr       :1;
> +       unsigned int    reserved_573          :3;
> +       } bits;
> +       unsigned int    u32;
> +};
> +
> +union U_LDI_WORK_MODE {
> +struct {
> +       unsigned int    work_mode             :1;
> +       unsigned int    wback_en              :1;
> +       unsigned int    colorbar_en           :1;
> +       unsigned int    reserved_577          :29;
> +       } bits;
> +       unsigned int    u32;
> +};
> +
The struct in the above two unions is missing a level of indentation.


> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c

> +static void ade_ldi_set_mode(struct ade_crtc *acrtc,
> +                            struct drm_display_mode *mode,
> +                            struct drm_display_mode *adj_mode)
> +{
> +       struct ade_hw_ctx *ctx = acrtc->ctx;
> +       void __iomem *base = ctx->base;
> +       u32 out_w = mode->hdisplay;
> +       u32 out_h = mode->vdisplay;
> +       u32 hfp, hbp, hsw, vfp, vbp, vsw;
> +       u32 plr_flags;
> +       int ret;
> +
> +       plr_flags = (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +                       ? HISI_LDI_FLAG_NVSYNC : 0;
> +       plr_flags |= (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +                       ? HISI_LDI_FLAG_NHSYNC : 0;
> +       hfp = mode->hsync_start - mode->hdisplay;
> +       hbp = mode->htotal - mode->hsync_end;
> +       hsw = mode->hsync_end - mode->hsync_start;
> +       vfp = mode->vsync_start - mode->vdisplay;
> +       vbp = mode->vtotal - mode->vsync_end;
> +       vsw = mode->vsync_end - mode->vsync_start;
> +       if (vsw > 15) {
> +               DRM_INFO("vsw exceeded 15\n");

DRM_ERROR or DRM_DEBUG_xx perhaps ?

> +               vsw = 15;
> +       }
> +
> +       writel((hbp << 20) | (hfp << 0), base + LDI_HRZ_CTRL0);
> +       /* p3-73 6220V100 pdf:
> +        *  "The configured value is the actual width - 1"
> +        */
> +       writel(hsw - 1, base + LDI_HRZ_CTRL1);
> +       writel((vbp << 20) | (vfp << 0), base + LDI_VRT_CTRL0);
> +       /* p3-74 6220V100 pdf:
> +        *  "The configured value is the actual width - 1"
> +        */
> +       writel(vsw - 1, base + LDI_VRT_CTRL1);
> +
> +       /* p3-75 6220V100 pdf:
> +        *  "The configured value is the actual width - 1"
> +        */
> +       writel(((out_h - 1) << 20) | ((out_w - 1) << 0),
> +              base + LDI_DSP_SIZE);
> +       writel(plr_flags, base + LDI_PLR_CTRL);
> +
> +       ret = clk_set_rate(ctx->ade_pix_clk, mode->clock * 1000);
> +       /* Success should be guaranteed in aotomic_check
> +        * failer shouldn't happen here
> +        */
> +       if (ret)
> +               DRM_ERROR("set ade_pixel_clk_rate fail\n");
DItto

> +       adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
> +
> +       /* ctran6 setting */
> +       writel(1, base + ADE_CTRAN_DIS(ADE_CTRAN6));
> +       writel(out_w * out_h - 1, base + ADE_CTRAN_IMAGE_SIZE(ADE_CTRAN6));
> +       acrtc->use_mask |= BIT(ADE_CTRAN_BIT_OFST + ADE_CTRAN6);
> +       DRM_INFO("set mode: %dx%d\n", out_w, out_h);
> +
DRM_DEBUG_DRIVER ?

> +       /*
> +        * other parameters setting
> +        */
> +       writel(BIT(0), base + LDI_WORK_MODE);
> +       writel((0x3c << 6) | (ADE_OUT_RGB_888 << 3) | BIT(2) | BIT(0),
> +              base + LDI_CTRL);
> +       set_reg(base + LDI_DE_SPACE_LOW, 0x1, 1, 1);
> +}
> +
> +static int ade_power_up(struct ade_hw_ctx *ctx)
> +{
> +       void __iomem *media_base = ctx->media_base;
> +       int ret;
> +
> +       ret = clk_set_rate(ctx->ade_core_clk, ctx->ade_core_rate);
> +       if (ret) {
> +               DRM_ERROR("clk_set_rate ade_core_rate error\n");
How about the following (or alike) less cryptic and more informative
message. Other places could use a similar treatment.

"Failed to set rate X clk (%d)\n", ret ?


> +static void ade_crtc_enable(struct drm_crtc *crtc)
> +{
> +       struct ade_crtc *acrtc = to_ade_crtc(crtc);
> +       struct ade_hw_ctx *ctx = acrtc->ctx;
> +       int ret;
> +
> +       DRM_DEBUG_DRIVER("enter.\n");
Does this and the remaining DEBUG_DRIVER(enter|exit) messages provide
any meaningful input, past the driver development stage ?

> +       if (acrtc->enable)
> +               return;
Esp. since we have cases like this where no message is available.

Regards,
Emil
