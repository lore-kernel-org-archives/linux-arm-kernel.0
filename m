From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Sep 2016 18:43:43 -0700
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <CAOw6vbKh9x5hxWLO2JswYH8Qw1xdB1Xc5c9nVDZ0WxsQRxhX0Q@mail.gmail.com>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
 <CAOw6vbKh9x5hxWLO2JswYH8Qw1xdB1Xc5c9nVDZ0WxsQRxhX0Q@mail.gmail.com>
Message-ID: <20160930014339.GB18734@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Tue, Sep 27, 2016 at 11:48:37AM -0400, Sean Paul wrote:
> On Sat, Sep 24, 2016 at 10:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > It adds the initial ZTE VOU display controller DRM driver.  There are
> > still some features to be added, like overlay plane, scaling, and more
> > output devices support.  But it's already useful with dual CRTCs and
> > HDMI monitor working.
> >
> > It's been tested on Debian Jessie LXDE desktop with modesetting driver.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Hi Shawn,
> I think overall this is very well done! A couple of things stuck out
> to me, I've pointed them out below, hopefully you can use some of
> them.

Thanks for reviewing the patch.  The comments are helpful, and I will
try to address them immediately once I get back from the business
travel.

> > diff --git a/drivers/gpu/drm/zte/Makefile b/drivers/gpu/drm/zte/Makefile
> > new file mode 100644
> > index 000000000000..b40968dc749f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/zte/Makefile
> > @@ -0,0 +1,8 @@
> > +zxdrm-y := \
> > +       zx_drm_drv.o \
> > +       zx_crtc.o \
> > +       zx_plane.o \
> > +       zx_hdmi.o
> > +
> > +obj-$(CONFIG_DRM_ZTE) += zxdrm.o
> > +
> > diff --git a/drivers/gpu/drm/zte/zx_crtc.c b/drivers/gpu/drm/zte/zx_crtc.c
> 
> I was a little tripped up when I first read this file since I assumed
> there was one instance of this driver per-crtc. However, there's
> really N crtcs per driver. Might it be less confusing to call it
> zx_vou.c instead?

Okay, will rename it.

> > +static void zx_crtc_enable(struct drm_crtc *crtc)
> > +{
> > +       struct drm_display_mode *mode = &crtc->state->adjusted_mode;
> > +       struct zx_crtc *zcrtc = to_zx_crtc(crtc);
> > +       struct zx_vou_hw *vou = dev_get_drvdata(zcrtc->dev);
> 
> IMO, it would be better to store a pointer to vou in each zx_crtc
> rather than reaching into drvdata.

Yeah, agree on that.

> > +       bool is_main = is_main_crtc(crtc);
> > +       struct videomode vm;
> > +       u32 pol = 0;
> > +       u32 val;
> > +
> > +       drm_display_mode_to_videomode(mode, &vm);
> 
> Why do this conversion? You should be able to get everything you need
> from drm_display_mode

It's a helper function, and the calculation of front_porch, back_porch
and sync_len helps me.

> > +
> > +       /* Set up timing parameters */
> > +       val = (vm.vactive - 1) << 16;
> > +       val |= (vm.hactive - 1) & 0xffff;
> > +       writel(val, vou->timing + (is_main ? FIR_MAIN_ACTIVE : FIR_AUX_ACTIVE));
> > +
> > +       val = ((vm.hsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
> > +       val |= ((vm.hback_porch - 1) << BACK_PORCH_SHIFT) & BACK_PORCH_MASK;
> > +       val |= ((vm.hfront_porch - 1) << FRONT_PORCH_SHIFT) & FRONT_PORCH_MASK;
> > +       writel(val, vou->timing + (is_main ? FIR_MAIN_H_TIMING :
> > +                                            FIR_AUX_H_TIMING));
> > +
> > +       val = ((vm.vsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
> > +       val |= ((vm.vback_porch - 1) << BACK_PORCH_SHIFT) & BACK_PORCH_MASK;
> > +       val |= ((vm.vfront_porch - 1) << FRONT_PORCH_SHIFT) & FRONT_PORCH_MASK;
> > +       writel(val, vou->timing + (is_main ? FIR_MAIN_V_TIMING :
> > +                                            FIR_AUX_V_TIMING));
> 
> It would be nice to figure out a better way of handing the main/aux
> switch as opposed to sprinkling all of these inline conditionals
> around. Perhaps you could introduce a struct which stores the
> addresses per-crtc and then reference the struct in the driver as
> opposed to the #defines.
> 
> ie:
> 
> writel(val, vou->timing + zcrtc->regs->v_timing);

Yeah, good suggestion.

> > +static void zx_crtc_atomic_begin(struct drm_crtc *crtc,
> > +                                struct drm_crtc_state *state)
> > +{
> > +       struct drm_pending_vblank_event *event = crtc->state->event;
> > +
> > +       if (event) {
> 
> nit: you can save yourself a level of indentation by exiting early on
> !event instead of scoping the entire function on event.

Aha, right!

> 
> > +               crtc->state->event = NULL;
> > +
> > +               spin_lock_irq(&crtc->dev->event_lock);
> > +               if (drm_crtc_vblank_get(crtc) == 0)
> > +                       drm_crtc_arm_vblank_event(crtc, event);
> > +               else
> > +                       drm_crtc_send_vblank_event(crtc, event);
> > +               spin_unlock_irq(&crtc->dev->event_lock);
> > +       }
> > +}

<snip>

> > +static struct zx_crtc *zx_crtc_init(struct drm_device *drm,
> > +                                   enum vou_chn_type chn_type)
> > +{
> > +       struct zx_drm_private *priv = drm->dev_private;
> > +       struct zx_vou_hw *vou = priv->vou;
> > +       struct device *dev = vou->dev;
> > +       struct zx_layer_data data;
> > +       struct zx_crtc *zcrtc;
> > +       int ret;
> > +
> > +       zcrtc = devm_kzalloc(dev, sizeof(*zcrtc), GFP_KERNEL);
> > +       if (!zcrtc)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       zcrtc->dev = dev;
> > +       zcrtc->chn_type = chn_type;
> > +
> > +       if (chn_type == VOU_CHN_MAIN) {
> > +               data.layer = vou->osd + 0x130;
> > +               data.csc = vou->osd + 0x580;
> > +               data.hbsc = vou->osd + 0x820;
> > +               data.rsz = vou->otfppu + 0x600;
> > +               zcrtc->chnreg = vou->osd + OSD_MAIN_CHN;
> > +       } else {
> > +               data.layer = vou->osd + 0x200;
> > +               data.csc = vou->osd + 0x5d0;
> > +               data.hbsc = vou->osd + 0x860;
> > +               data.rsz = vou->otfppu + 0x800;
> > +               zcrtc->chnreg = vou->osd + OSD_AUX_CHN;
> > +       }
> 
> These magic values should find their way into #defines

Yeah, will do.

> > +static void vou_dtrc_init(struct zx_vou_hw *vou)
> > +{
> > +       u32 val;
> > +
> > +       val = readl(vou->dtrc + DTRC_DETILE_CTRL);
> > +       /* Clear bit for bypass by ID */
> > +       val &= ~TILE2RASTESCAN_BYPASS_MODE;
> > +       /* Select ARIDR mode */
> > +       val &= ~DETILE_ARIDR_MODE_MASK;
> > +       val |= DETILE_ARID_IN_ARIDR;
> > +       writel(val, vou->dtrc + DTRC_DETILE_CTRL);
> > +
> > +       /* Bypass decompression for both frames */
> > +       val = readl(vou->dtrc + DTRC_F0_CTRL);
> > +       val |= DTRC_DECOMPRESS_BYPASS;
> > +       writel(val, vou->dtrc + DTRC_F0_CTRL);
> > +
> > +       val = readl(vou->dtrc + DTRC_F1_CTRL);
> > +       val |= DTRC_DECOMPRESS_BYPASS;
> > +       writel(val, vou->dtrc + DTRC_F1_CTRL);
> > +
> > +       /* Set up ARID register */
> > +       val = 0x0e;
> > +       val |= 0x0f << 8;
> > +       val |= 0x0e << 16;
> > +       val |= 0x0f << 24;
> 
> #define

Okay.

> > +static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct drm_device *drm = data;
> > +       struct zx_drm_private *priv = drm->dev_private;
> > +       struct resource *res;
> > +       struct zx_vou_hw *vou;
> > +       int irq;
> > +       int ret;
> > +
> > +       vou = devm_kzalloc(dev, sizeof(*vou), GFP_KERNEL);
> > +       if (!vou)
> > +               return -ENOMEM;
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "osd");
> > +       vou->osd = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(vou->osd))
> > +               return PTR_ERR(vou->osd);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "timing_ctrl");
> > +       vou->timing = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(vou->timing))
> > +               return PTR_ERR(vou->timing);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dtrc");
> > +       vou->dtrc = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(vou->dtrc))
> > +               return PTR_ERR(vou->dtrc);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vou_ctrl");
> > +       vou->vouctl = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(vou->vouctl))
> > +               return PTR_ERR(vou->vouctl);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otfppu");
> > +       vou->otfppu = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(vou->otfppu))
> > +               return PTR_ERR(vou->otfppu);
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0)
> > +               return irq;
> > +
> > +       vou->axi_clk = devm_clk_get(dev, "aclk");
> > +       if (IS_ERR(vou->axi_clk))
> > +               return PTR_ERR(vou->axi_clk);
> > +
> > +       vou->ppu_clk = devm_clk_get(dev, "ppu_wclk");
> > +       if (IS_ERR(vou->ppu_clk))
> > +               return PTR_ERR(vou->ppu_clk);
> > +
> > +       clk_prepare_enable(vou->axi_clk);
> > +       clk_prepare_enable(vou->ppu_clk);
> > +
> > +       vou->dev = dev;
> > +       priv->vou = vou;
> > +       dev_set_drvdata(dev, vou);
> 
> I think you should be able to avoid storing vou in priv and drvdata.

I see I can do something by avoid storing vou in priv, but not sure how
to access vou in unbind function without storing it in drvdata.  Any
suggestion?

> > +
> > +       vou_hw_init(vou);
> > +
> > +       ret = devm_request_irq(dev, irq, vou_irq_handler, 0, "zx_vou", vou);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       vou->main_crtc = zx_crtc_init(drm, VOU_CHN_MAIN);
> > +       if (IS_ERR(vou->main_crtc))
> > +               return PTR_ERR(vou->main_crtc);
> > +
> > +       vou->aux_crtc = zx_crtc_init(drm, VOU_CHN_AUX);
> > +       if (IS_ERR(vou->aux_crtc))
> > +               return PTR_ERR(vou->aux_crtc);
> > +
> > +       return 0;
> > +}

<snip>

> > diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
> > new file mode 100644
> > index 000000000000..51fafb8e5f43
> > --- /dev/null
> > +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> > @@ -0,0 +1,258 @@
> > +/*
> > + * Copyright 2016 Linaro Ltd.
> > + * Copyright 2016 ZTE Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/clk.h>
> > +#include <linux/component.h>
> > +#include <linux/list.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_platform.h>
> 
> nit: Alphabetical?

Okay, will do.

> > +static struct vou_inf vou_inf_hdmi = {
> > +       .id = VOU_HDMI,
> > +       .data_sel = VOU_YUV444,
> > +       .clocks_en_bits = BIT(24) | BIT(18) | BIT(6),
> > +       .clocks_sel_bits = BIT(13) | BIT(2),
> > +};
> 
> This should be static const, but I suppose you can't b/c you're
> storing a pointer to encoder in vou_inf. This type of information
> lends itself well to being defined and mapped as of_device_id.data,
> you'll need to pass the encoder around in a different manner.

Okay, I will find some way to remove the encoder pointer out of the
structure.

> > +static int zx_hdmi_config_video_vsi(struct zx_hdmi *hdmi,
> > +                                   struct drm_display_mode *mode)
> > +{
> > +       union hdmi_infoframe frame;
> > +       int ret;
> > +
> > +       ret = drm_hdmi_vendor_infoframe_from_display_mode(&frame.vendor.hdmi,
> > +                                                         mode);
> > +       if (ret)
> 
> Should you log in cases of failure (here and elsewhere)?

Okay, will do.

> > +               return ret;
> > +
> > +       return zx_hdmi_infoframe_trans(hdmi, &frame, FSEL_VSIF);
> > +}

<snip>

> > +static void zx_hdmi_encoder_enable(struct drm_encoder *encoder)
> > +{
> > +       struct zx_hdmi *hdmi = to_zx_hdmi(encoder);
> > +
> > +       vou_inf_enable(hdmi->inf);
> 
> I think you can remove the encoder from inf by passing encoder->crtc
> here as well. That will tell vou which encoder/crtc pair to enable
> without having that pesky static global floating around.

Yes.

> > +}
> > +
> > +static void zx_hdmi_encoder_disable(struct drm_encoder *encoder)
> > +{
> > +       struct zx_hdmi *hdmi = to_zx_hdmi(encoder);
> > +
> > +       vou_inf_disable(hdmi->inf);
> 
> Same here

Yes.

> > +}
> > +
> > +static const struct drm_encoder_helper_funcs zx_hdmi_encoder_helper_funcs = {
> > +       .enable = zx_hdmi_encoder_enable,
> > +       .disable = zx_hdmi_encoder_disable,
> > +       .mode_set = zx_hdmi_encoder_mode_set,
> > +};
> > +
> > +static const struct drm_encoder_funcs zx_hdmi_encoder_funcs = {
> > +       .destroy = drm_encoder_cleanup,
> > +};
> > +
> > +static int zx_hdmi_get_edid_block(void *data, u8 *buf, unsigned int block,
> > +                                 size_t len)
> 
> Instead of open-coding this, consider implementing an i2c adapter for
> the DDC bus and use drm_get_edid below.

Okay.  I got the same suggestion from Daniel, so it must be something
good :)

Shawn
