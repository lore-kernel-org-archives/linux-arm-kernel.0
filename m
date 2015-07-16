From: Jianwei.Wang@freescale.com (Wang J.W.)
Date: Thu, 16 Jul 2015 11:10:29 +0000
Subject: [PATCH v9 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <20150714104913.GI12465@ulmo.nvidia.com>
References: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
 <20150714104913.GI12465@ulmo.nvidia.com>
Message-ID: <DM2PR0301MB12297B66D33EE9E26F011D9E9F990@DM2PR0301MB1229.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Thank you very much for your patient and careful guidance. I'm updating my driver according to your comments.

> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding at gmail.com]
> Sent: Tuesday, July 14, 2015 6:49 PM
> To: Wang Jianwei-B52261
> Cc: dri-devel at lists.freedesktop.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> airlied at linux.ie; daniel.vetter at ffwll.ch; mark.yao at rock-chips.com; Wood
> Scott-B07421; Wang Huan-B18965; Xiubo Li; Wang Jianwei-B52261
> Subject: Re: [PATCH v9 1/4] drm/layerscape: Add Freescale DCU DRM driver
> 
> On Mon, Jul 13, 2015 at 06:51:29PM +0800, Jianwei Wang wrote:
> > This patch add support for Two Dimensional Animation and Compositing
> > Engine (2D-ACE) on the Freescale SoCs.
> >
> > 2D-ACE is a Freescale display controller. 2D-ACE describes the
> > functionality of the module extremely well its name is a value that
> > cannot be used as a token in programming languages.
> > Instead the valid token "DCU" is used to tag the register names and
> > function names.
> >
> > The Display Controller Unit (DCU) module is a system master that
> > fetches graphics stored in internal or external memory and displays
> > them on a TFT LCD panel. A wide range of panel sizes is supported and
> > the timing of the interface signals is highly configurable.
> > Graphics are read directly from memory and then blended in real-time,
> > which allows for dynamic content creation with minimal CPU
> > intervention.
> 
> Is this for some non-i.MX SoC? 

Yes. Ls1021a and i.MX use different video IP modules.

> 
> > The features:
> > (1) Full RGB888 output to TFT LCD panel.
> > (2) For the current LCD panel, WQVGA "480x272" is supported.
> 
> Would be more useful to describe the actual capabilities of the display
> controller rather than what's supported by the panel that you happened to
> have attached to it.

Ok, I'll remove it


> 
> > (3) Blending of each pixel using up to 4 source layers dependent on
> > size of panel.
> > (4) Each graphic layer can be placed with one pixel resolution in
> > either axis.
> > (5) Each graphic layer support RGB565 and RGB888 direct colors without
> > alpha channel and BGRA8888 BGRA4444 ARGB1555 direct colors with an
> > alpha channel and YUV422 format.
> > (6) Each graphic layer support alpha blending with 8-bit resolution.
> >
> > This is a simplified version, only one primary plane, one framebuffer,
> > one crtc, one connector and one encoder for TFT LCD panel.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> > Signed-off-by: Jianwei Wang <b52261@freescale.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Reviewed-by: Alison Wang <alison.wang@freescale.com>
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS index 6761318..fffb8c9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3404,6 +3404,15 @@ S:	Maintained
> >  F:	drivers/gpu/drm/imx/
> >  F:	Documentation/devicetree/bindings/drm/imx/
> >
> > +DRM DRIVERS FOR FREESCALE DCU
> > +M:	Jianwei Wang <jianwei.wang@freescale.com>
> > +M:	Alison Wang <alison.wang@freescale.com>
> > +L:	dri-devel at lists.freedesktop.org
> > +S:	Supported
> > +F:	drivers/gpu/drm/fsl-dcu/
> > +F:      Documentation/devicetree/bindings/drm/fsl-dcu/
> > +F:      Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
> 
> This binding has got nothing to do with the display driver, so it
> shouldn't be listed here.
> 
> Also, please use tabs consistently (the above two lines use spaces).


Sorry, I made this mistake when formatting patches. I'll be more careful next time.


> 
> >  DRM DRIVERS FOR NVIDIA TEGRA
> >  M:	Thierry Reding <thierry.reding@gmail.com>
> >  M:	Terje Bergstr?m <tbergstrom@nvidia.com>
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig index
> > c46ca31..9cfd14e 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -231,6 +231,8 @@ source "drivers/gpu/drm/virtio/Kconfig"
> >
> >  source "drivers/gpu/drm/msm/Kconfig"
> >
> > +source "drivers/gpu/drm/fsl-dcu/Kconfig"
> > +
> 
> As mentioned in a different email, I'm somewhat annoyed by the random
> placement of these source statements. But we can probably clean that up in
> one go and insist on proper ordering when there is one.
> 
 
Ok, I plan to move it to the last line. Is it ok?



> > diff --git a/drivers/gpu/drm/fsl-dcu/Makefile
> > b/drivers/gpu/drm/fsl-dcu/Makefile
> > new file mode 100644
> > index 0000000..336b4a6
> > --- /dev/null
> > +++ b/drivers/gpu/drm/fsl-dcu/Makefile
> > @@ -0,0 +1,7 @@
> > +fsl-dcu-drm-y := fsl_dcu_drm_drv.o \
> > +	       fsl_dcu_drm_kms.o \
> > +	       fsl_dcu_drm_connector.o \
> > +	       fsl_dcu_drm_plane.o \
> > +	       fsl_dcu_drm_crtc.o \
> > +	       fsl_dcu_drm_fbdev.o
> 
> I don't get what kind of indentation this is supposed to be. Either align
> everything with the first object file, or use a single tab rather than a
> tab followed by a couple of spaces.
> 

OK!


> > +obj-$(CONFIG_DRM_FSL_DCU)	+= fsl-dcu-drm.o
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
> > new file mode 100644
> > index 0000000..41dd1d0
> > --- /dev/null
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
> > @@ -0,0 +1,187 @@
> > +/*
> > + * Copyright 2015 Freescale Semiconductor, Inc.
> > + *
> > + * Freescale DCU drm device driver
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/backlight.h>
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include "fsl_dcu_drm_drv.h"
> > +#include "fsl_dcu_drm_connector.h"
> > +
> > +static void fsl_dcu_drm_encoder_disable(struct drm_encoder *encoder)
> > +{ }
> > +
> > +static int
> > +fsl_dcu_drm_encoder_atomic_check(struct drm_encoder *encoder,
> > +				 struct drm_crtc_state *crtc_state,
> > +				 struct drm_connector_state *conn_state) {
> > +	return 0;
> > +}
> > +
> > +static void fsl_dcu_drm_encoder_destroy(struct drm_encoder *encoder)
> > +{
> > +	drm_encoder_cleanup(encoder);
> > +}
> > +
> > +static void fsl_dcu_drm_encoder_enable(struct drm_encoder *encoder) {
> > +}
> > +
> > +static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
> > +	.enable = fsl_dcu_drm_encoder_enable,
> > +	.disable = fsl_dcu_drm_encoder_disable,
> > +	.atomic_check = fsl_dcu_drm_encoder_atomic_check, };
> > +
> > +static const struct drm_encoder_funcs encoder_funcs = {
> > +	.destroy = fsl_dcu_drm_encoder_destroy, };
> 
> For ease of maintenance and review, you might want to reorder your
> function definitions to match the structure layout and put them closer
> together.
> 
> The same applies to other places in this file.
> 


OK!


> > +int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
> > +			       struct drm_crtc *crtc)
> > +{
> > +	struct drm_encoder *encoder = &fsl_dev->encoder;
> > +	int ret;
> > +
> > +	encoder->possible_crtcs = 1;
> > +	ret = drm_encoder_init(fsl_dev->ddev, encoder, &encoder_funcs,
> > +			       DRM_MODE_ENCODER_LVDS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
> > +	encoder->crtc = crtc;
> 
> I think you're supposed to let the DRM core make this association.
> 
 

I'll remove it


> > +
> > +	return 0;
> > +}
> > +
> > +#define to_fsl_dcu_connector(connector) \
> > +	container_of(connector, struct fsl_dcu_drm_connector, connector)
> > +
> 
> It's common to put this near the definition of the structure that the
> upcast is for. It's also preferred (though not by everyone it seems) to
> make this a static inline function rather than a #define.
> 

Ok!


> > +static int fsl_dcu_drm_connector_get_modes(struct drm_connector
> > +*connector) {
> > +	struct fsl_dcu_drm_connector *fsl_connector;
> > +	int num_modes = 0;
> > +
> > +	fsl_connector = to_fsl_dcu_connector(connector);
> > +	if (fsl_connector->panel && fsl_connector->panel->funcs &&
> > +	    fsl_connector->panel->funcs->get_modes)
> > +		num_modes = fsl_connector->panel->funcs->get_modes
> > +				(fsl_connector->panel);
> 
> You could perhaps use some temporary variables to make this more readable.
> 


Ok!


> > +int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
> > +				 struct drm_encoder *encoder)
> > +{
> > +	struct drm_connector *connector = &fsl_dev->connector.connector;
> > +	struct device_node *panel_node;
> > +	int ret;
> > +
> > +	fsl_dev->connector.encoder = encoder;
> 
> Why do you need this? The DRM core should set this for you when setting
> the initial configuration.
> 

This connector is a private structure fsl_dcu_drm_connector. I set it for select best encoder.


> > +
> > +	connector->display_info.width_mm = 0;
> > +	connector->display_info.height_mm = 0;
> 
> Why do you need to zero these out?
 

I'll remove it


> 
> > +	ret = drm_connector_init(fsl_dev->ddev, connector,
> > +				 &fsl_dcu_drm_connector_funcs,
> > +				 DRM_MODE_CONNECTOR_LVDS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	connector->dpms = DRM_MODE_DPMS_OFF;
> 
> This looks like it really belongs in the ->reset() callback.


OK! I'll adjust it


> 
> > +	drm_connector_helper_add(connector, &connector_helper_funcs);
> > +	ret = drm_connector_register(connector);
> > +	if (ret < 0)
> > +		goto err_cleanup;
> > +
> > +	ret = drm_mode_connector_attach_encoder(connector, encoder);
> > +	if (ret < 0)
> > +		goto err_sysfs;
> > +
> > +	connector->encoder = encoder;
> 
> You did this before already, why repeat it? Why even do it in the first
> place? Does this somehow not work if you omit this explicit assignment?
> 


I'll remove it


> > +	drm_object_property_set_value
> > +		(&connector->base, fsl_dev->ddev->mode_config.dpms_property,
> > +		DRM_MODE_DPMS_OFF);
> 
> This is badly aligned. "&connector->base," should go on the first line and
> the second line (all subsequent ones, really) should align with it.
> 


Ok!



> > +
> > +	panel_node = of_parse_phandle(fsl_dev->np, "panel", 0);
> 
> This isn't a standard property, so technically you'd need to prefix it
> with a vendor prefix.
> 

Ok!


> > +	if (panel_node) {
> > +		fsl_dev->connector.panel = of_drm_find_panel(panel_node);
> > +		if (!fsl_dev->connector.panel) {
> > +			of_node_put(panel_node);
> > +			ret = -EPROBE_DEFER;
> > +			goto err_sysfs;
> > +		}
> > +	}
> > +	of_node_put(panel_node);
> 
> You're leaking the OF node reference on -EPROBE_DEFER.
> 


Got it!


> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> [...]
> > +#include <linux/regmap.h>
> > +#include <linux/clk.h>
> 
> You should keep these sorted alphabetically, that'll save you headaches
> later on.
> 


Ok!



> > +static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc) {
> > +	struct drm_device *dev = crtc->dev;
> > +	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> > +	struct drm_display_mode *mode = &crtc->state->mode;
> > +	uint32_t hbp, hfp, hsw, vbp, vfp, vsw, div, index;
> > +	int err;
> > +
> > +	DBG(": set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> > +	    mode->base.id, mode->name,
> > +	    mode->vrefresh, mode->clock,
> > +	    mode->hdisplay, mode->hsync_start,
> > +	    mode->hsync_end, mode->htotal,
> > +	    mode->vdisplay, mode->vsync_start,
> > +	    mode->vsync_end, mode->vtotal,
> > +	    mode->type, mode->flags);
> 
> The KMS helpers already output this line, don't they?


Yes, I'll remove it

> 
> > +	index = drm_crtc_index(crtc);
> > +	div = (uint32_t)clk_get_rate(fsl_dev->clk) / mode->clock / 1000;
> 
> You should probably not cast the clk_get_rate() return value. You risk
> running into problems if you ever need to support rates higher than 4 GHz.
> I'll grant you that it's unlikely to happen any time soon, but it
> shouldn't be a reason not to write future-proof code.
> 

Got it


> > +
> > +	/* Configure timings: */
> > +	hbp = mode->htotal - mode->hsync_end;
> > +	hfp = mode->hsync_start - mode->hdisplay;
> > +	hsw = mode->hsync_end - mode->hsync_start;
> > +	vbp = mode->vtotal - mode->vsync_end;
> > +	vfp = mode->vsync_start - mode->vdisplay;
> > +	vsw = mode->vsync_end - mode->vsync_start;
> > +
> > +	err = regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
> > +			   DCU_HSYN_PARA_BP(hbp) |
> > +			   DCU_HSYN_PARA_PW(hsw) |
> > +			   DCU_HSYN_PARA_FP(hfp));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
> > +			   DCU_VSYN_PARA_BP(vbp) |
> > +			   DCU_VSYN_PARA_PW(vsw) |
> > +			   DCU_VSYN_PARA_FP(vfp));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
> > +			   DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
> > +			   DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_DIV_RATIO, div);
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
> > +			   DCU_UPDATE_MODE_READREG);
> > +	if (err)
> > +		goto set_failed;
> > +	return;
> > +set_failed:
> > +	dev_err(dev->dev, "set DCU register failed\n"); }
> [...]
> > +static void fsl_dcu_drm_crtc_enable(struct drm_crtc *crtc) { }
> > +
> > +static int fsl_dcu_drm_crtc_atomic_check(struct drm_crtc *crtc,
> > +					 struct drm_crtc_state *state)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void fsl_dcu_drm_crtc_atomic_begin(struct drm_crtc *crtc) { }
> > +
> > +static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc) { }
> > +
> > +static void fsl_dcu_drm_disable_crtc(struct drm_crtc *crtc) { }
> 
> Really? Then how does the CRTC get enabled or disabled, I wonder?
> 


I'll implement crtc enable and disable function.


> > +int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev) {
> > +	struct drm_plane *primary;
> > +	struct drm_crtc *crtc = &fsl_dev->crtc;
> > +	int i, ret;
> 
> i could be unsigned int.
> 

Ok!

> > +
> > +	primary = fsl_dcu_drm_primary_create_plane(fsl_dev->ddev);
> > +	ret = drm_crtc_init_with_planes(fsl_dev->ddev, crtc, primary, NULL,
> > +					&fsl_dcu_drm_crtc_funcs);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	drm_crtc_helper_add(crtc, &fsl_dcu_drm_crtc_helper_funcs);
> > +
> > +	for (i = 0; i < DCU_TOTAL_LAYER_NUM; i++) {
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_1(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_2(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_3(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_4(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_5(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_6(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_7(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_8(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> > +		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_9(i), 0);
> > +		if (ret)
> > +			goto init_failed;
> 
> This is highly repetitive, perhaps make a DCU_CTRLDESCLN(x, y) instead and
> use nested loops here?
> 

Good idea, I'll do it


> > +		if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
> > +			ret = regmap_write(fsl_dev->regmap,
> > +					   DCU_CTRLDESCLN_10(i), 0);
> > +			if (ret)
> > +				goto init_failed;
> > +		}
> > +	}
> 
> Might be better to introduce some sort of per-SoC capability structure to
> parameterize, so that you can avoid this sort of check on the OF node's
> compatible string. You typically do that by setting the OF match table's
> entries' .data field to the instance of the structure for the particular
> SoC or hardware block.
> 


I'm adjusting my driver. Much will be move to platform related file.
Thanks for your guidance.



> > +	ret = regmap_write(fsl_dev->regmap, DCU_SYN_POL,
> > +			   DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW);
> > +	if (ret)
> > +		goto init_failed;
> 
> This looks like it should be part of the ->mode_set_nofb() implementation
> and depend on parameters of the mode.
> 


Ok, I'll move them(including of some registers below) to the right place.


> > +	ret = regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
> > +			   DCU_BGND_G(0) | DCU_BGND_B(0));
> > +	if (ret)
> > +		goto init_failed;
> > +	ret = regmap_write(fsl_dev->regmap, DCU_DCU_MODE,
> > +			   DCU_MODE_BLEND_ITER(1) | DCU_MODE_RASTER_EN);
> > +	if (ret)
> > +		goto init_failed;
> > +	ret = regmap_write(fsl_dev->regmap, DCU_THRESHOLD,
> > +			   DCU_THRESHOLD_LS_BF_VS(BF_VS_VAL) |
> > +			   DCU_THRESHOLD_OUT_BUF_HIGH(BUF_MAX_VAL) |
> > +			   DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
> > +	if (ret)
> > +		goto init_failed;
> > +	ret = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
> > +				 DCU_MODE_DCU_MODE_MASK,
> > +				 DCU_MODE_DCU_MODE(DCU_MODE_OFF));
> > +	if (ret)
> > +		goto init_failed;
> > +	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
> > +			   DCU_UPDATE_MODE_READREG);
> > +	if (ret)
> > +		goto init_failed;
> > +
> > +	return 0;
> > +init_failed:
> > +	dev_err(fsl_dev->dev, "init DCU register failed\n");
> > +	return ret;
> > +}
> [...]
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> [...]
> > +static int fsl_dcu_unload(struct drm_device *dev) {
> > +	drm_mode_config_cleanup(dev);
> > +	drm_vblank_cleanup(dev);
> > +	drm_irq_uninstall(dev);
> > +
> > +	dev->dev_private = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct regmap_config fsl_dcu_regmap_config = {
> 
> static const
> 

Got it

> > +	.reg_bits = 32,
> > +	.reg_stride = 4,
> > +	.val_bits = 32,
> > +};
> > +
> > +static int fsl_dcu_bypass_tcon(struct fsl_dcu_drm_device *fsl_dev,
> > +			       struct device_node *np)
> > +{
> > +	struct device_node *tcon_np;
> > +	struct platform_device *pdev;
> > +	struct clk *tcon_clk;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
> > +	if (!tcon_np)
> > +		return -EINVAL;
> > +
> > +	pdev = of_find_device_by_node(tcon_np);
> > +	if (!pdev)
> > +		return -EINVAL;
> > +
> > +	tcon_clk = devm_clk_get(&pdev->dev, "tcon");
> > +	if (IS_ERR(tcon_clk))
> > +		return PTR_ERR(tcon_clk);
> > +	ret = clk_prepare(tcon_clk);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to prepare tcon clk\n");
> > +		return ret;
> > +	}
> > +	ret = clk_enable(tcon_clk);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to enable tcon clk\n");
> > +		clk_unprepare(tcon_clk);
> > +		return ret;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -ENODEV;
> > +
> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	fsl_dev->tcon_regmap = devm_regmap_init_mmio(&pdev->dev,
> > +			base, &fsl_dcu_regmap_config);
> > +	if (IS_ERR(fsl_dev->tcon_regmap)) {
> > +		dev_err(&pdev->dev, "regmap init failed\n");
> > +		return PTR_ERR(fsl_dev->tcon_regmap);
> > +	}
> > +
> > +	ret = regmap_write(fsl_dev->tcon_regmap,
> > +			   TCON_CTRL1, TCON_BYPASS_ENABLE);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "set TCON_CTRL1 failed\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> 
> Erm... no. You should have a proper TCON driver to take care of this. If
> it's only used by the display driver, the TCON driver could be part of the
> DRM driver.
> 
> But as it is, you're side-stepping the driver model and are leaving
> resource crumbs all over the place that noone will get a chance to clean
> up.
> 


Ok, I'll move it out




> > +
> > +static void dcu_pixclk_enable(void)
> > +{
> > +	struct regmap *scfg_regmap;
> > +
> > +	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> > +	if (IS_ERR(scfg_regmap)) {
> > +		pr_err("No syscfg phandle specified\n");
> > +		return;
> > +	}
> > +
> > +	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_ENABLE); }
> 
> This should be a clock driver. Chances are that you're going to need to
> change the pixel clock frequency at some point, in which case you're going
> to need a proper pixel clock anyway.
> 
> That said, you already have a "dcu" clock that you use. According to the
> modeset code it's some kind of parent of the pixel clock (you derive a
> divider based on the "dcu" clock frequency and the mode clock). You should
> really model this properly as a clock tree.
> 


Ok!


> > +static int fsl_dcu_drm_irq_init(struct drm_device *dev) {
> > +	struct platform_device *pdev = to_platform_device(dev->dev);
> > +	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> > +	unsigned int int_mask;
> > +	int ret;
> > +
> > +	ret = drm_irq_install(dev, platform_get_irq(pdev, 0));
> > +	if (ret < 0)
> > +		dev_err(&pdev->dev, "failed to install IRQ handler\n");
> 
> If you think you'll ever need to support multiple interrupts, I'd suggest
> you don't use drm_irq_install() but rather set up the interrupt yourself.
> It's not difficult to do and will give you some more flexibility in turn.
> 
> > +	dev->irq_enabled = true;
> > +	dev->vblank_disable_allowed = true;
> > +
> > +	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "set DCU_INT_STATUS failed\n");
> > +	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &int_mask);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "read DCU_INT_MASK failed\n");
> > +	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, int_mask &
> > +			   ~DCU_INT_MASK_VBLANK);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "set DCU_INT_MASK failed\n");
> > +	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
> > +			   DCU_UPDATE_MODE_READREG);
> 
> What's this DCU_UPDATE_MODE_READREG bit?
> 

In fact, Only when setting DCU_UPDATE_MODE_READREG bit, it begin to transfer register values.
So setting DCU_UPDATE_MODE_READREG bit is a must after registers updating.



> > +static int fsl_dcu_load(struct drm_device *ddev, unsigned long flags)
> > +{
> > +	struct device *dev = ddev->dev;
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct fsl_dcu_drm_device *fsl_dev;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	fsl_dev = devm_kzalloc(dev, sizeof(*fsl_dev), GFP_KERNEL);
> > +	if (!fsl_dev)
> > +		return -ENOMEM;
> > +
> > +	fsl_dev->dev = dev;
> > +	fsl_dev->ddev = ddev;
> > +	fsl_dev->np = dev->of_node;
> > +	ddev->dev_private = fsl_dev;
> > +	dev_set_drvdata(dev, fsl_dev);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "could not get memory IO resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(base)) {
> > +		ret = PTR_ERR(base);
> > +		return ret;
> > +	}
> > +
> > +	fsl_dev->clk = devm_clk_get(dev, "dcu");
> > +	if (IS_ERR(fsl_dev->clk)) {
> > +		ret = PTR_ERR(fsl_dev->clk);
> > +		dev_err(dev, "failed to get dcu clock\n");
> > +		return ret;
> > +	}
> > +	ret = clk_prepare(fsl_dev->clk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to prepare dcu clk\n");
> > +		return ret;
> > +	}
> > +	ret = clk_enable(fsl_dev->clk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to enable dcu clk\n");
> > +		clk_unprepare(fsl_dev->clk);
> > +		return ret;
> > +	}
> > +
> > +	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
> > +			&fsl_dcu_regmap_config);
> > +	if (IS_ERR(fsl_dev->regmap)) {
> > +		dev_err(dev, "regmap init failed\n");
> > +		return PTR_ERR(fsl_dev->regmap);
> > +	}
> > +
> > +	/* Put TCON in bypass mode, so the input signals from DCU are passed
> > +	 * through TCON unchanged */
> > +	fsl_dcu_bypass_tcon(fsl_dev, fsl_dev->np);
> > +
> > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
> > +		dcu_pixclk_enable();
> 
> All of the above really belongs in ->probe(). If you do that you don't
> need to involve anything of DRM until after all resources have been
> successfully claimed. Also it allows you to get rid of the ugly upcast
> from struct device to struct platform_device, because ->probe() will
> directly give you a platform device.
> 

Got it


> > +	ret = fsl_dcu_drm_modeset_init(fsl_dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to initialize mode setting\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = drm_vblank_init(ddev, ddev->mode_config.num_crtc);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to initialize vblank\n");
> > +		goto done;
> > +	}
> > +
> > +	ret = fsl_dcu_drm_irq_init(ddev);
> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	fsl_dcu_fbdev_init(ddev);
> > +
> > +	return 0;
> > +done:
> > +	if (ret)
> > +		fsl_dcu_unload(ddev);
> > +
> > +	return ret;
> > +}
> > +
> > +static void fsl_dcu_drm_preclose(struct drm_device *dev, struct
> > +drm_file *file) { }
> > +
> > +static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg) {
> > +	struct drm_device *dev = arg;
> > +	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> > +	unsigned int int_status;
> > +	int ret;
> > +
> > +	regmap_read(fsl_dev->regmap, DCU_INT_STATUS, &int_status);
> 
> No error checking here?
> 

Ok I'll do it


> > +	if (int_status & DCU_INT_STATUS_VBLANK)
> > +		drm_handle_vblank(dev, 0);
> > +
> > +	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0xffffffff);
> > +	if (ret)
> > +		dev_err(dev->dev, "set DCU_INT_STATUS failed\n");
> > +	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
> > +			   DCU_UPDATE_MODE_READREG);
> > +	if (ret)
> > +		dev_err(dev->dev, "set DCU_UPDATE_MODE failed\n");
> 
> Here it is again. Is this some sort of manual trigger for screen updates?
> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int fsl_dcu_drm_enable_vblank(struct drm_device *dev, int
> > +crtc) {
> > +	return 0;
> > +}
> > +
> > +static void fsl_dcu_drm_disable_vblank(struct drm_device *dev, int
> > +crtc) { }
> 
> You do have a way to enable and disable VBLANK, why don't you use it?
> 

Ok, I'll implement vblank enable and disable functions.


> > +static struct drm_driver fsl_dcu_drm_driver = {
> > +	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
> > +				| DRIVER_PRIME | DRIVER_ATOMIC,
> > +	.load			= fsl_dcu_load,
> > +	.unload			= fsl_dcu_unload,
> > +	.preclose		= fsl_dcu_drm_preclose,
> > +	.irq_handler		= fsl_dcu_drm_irq,
> > +	.get_vblank_counter	= drm_vblank_count,
> > +	.enable_vblank		= fsl_dcu_drm_enable_vblank,
> > +	.disable_vblank		= fsl_dcu_drm_disable_vblank,
> > +	.gem_free_object	= drm_gem_cma_free_object,
> > +	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> > +	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> > +	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> > +	.gem_prime_import	= drm_gem_prime_import,
> > +	.gem_prime_export	= drm_gem_prime_export,
> > +	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> > +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> > +	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
> > +	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
> > +	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> > +	.dumb_create		= drm_gem_cma_dumb_create,
> > +	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
> > +	.dumb_destroy		= drm_gem_dumb_destroy,
> > +	.fops			= &fsl_dcu_drm_fops,
> > +	.name			= "fsl-dcu-drm",
> > +	.desc			= "Freescale DCU DRM",
> > +	.date			= "20150213",
> > +	.major			= 1,
> > +	.minor			= 0,
> > +};
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static void dcu_pixclk_disable(void)
> > +{
> > +	struct regmap *scfg_regmap;
> > +
> > +	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> > +	if (IS_ERR(scfg_regmap)) {
> > +		pr_err("No syscfg phandle specified\n");
> > +		return;
> > +	}
> > +
> > +	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_DISABLE); }
> 
> Again, if this was modelled as a clock, you could hide all this
> integration glue from the display driver.
> 

Ok!

> > +static int fsl_dcu_drm_pm_suspend(struct device *dev) {
> > +	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
> > +
> > +	if (!fsl_dev)
> > +		return 0;
> > +
> > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
> > +		dcu_pixclk_disable();
> > +
> > +	drm_kms_helper_poll_disable(fsl_dev->ddev);
> > +	regcache_cache_only(fsl_dev->regmap, true);
> > +	regcache_mark_dirty(fsl_dev->regmap);
> > +	clk_disable(fsl_dev->clk);
> 
> Why not unprepare the clock at the same time?
> 

> > +
> > +	if (fsl_dev->tcon_regmap) {
> > +		regcache_cache_only(fsl_dev->tcon_regmap, true);
> > +		regcache_mark_dirty(fsl_dev->tcon_regmap);
> > +		clk_disable(fsl_dev->tcon_clk);
> 
> Same here.
> 


Ok, I'll do it


> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_dcu_drm_pm_resume(struct device *dev) {
> > +	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (!fsl_dev)
> > +		return 0;
> > +
> > +	/* Enable clocks and restore all registers */
> > +	if (fsl_dev->tcon_regmap) {
> > +		ret = clk_enable(fsl_dev->tcon_clk);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to enable tcon clk\n");
> > +			clk_unprepare(fsl_dev->tcon_clk);
> > +			return ret;
> > +		}
> > +		regcache_cache_only(fsl_dev->tcon_regmap, false);
> > +		regcache_sync(fsl_dev->tcon_regmap);
> > +	}
> > +
> > +	ret = clk_enable(fsl_dev->clk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to enable dcu clk\n");
> > +		clk_unprepare(fsl_dev->clk);
> > +		return ret;
> > +	}
> > +
> > +	drm_kms_helper_poll_enable(fsl_dev->ddev);
> > +	regcache_cache_only(fsl_dev->regmap, false);
> > +	regcache_sync(fsl_dev->regmap);
> > +
> > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
> > +		dcu_pixclk_enable();
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops fsl_dcu_drm_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(fsl_dcu_drm_pm_suspend,
> > +fsl_dcu_drm_pm_resume) };
> > +
> > +static int fsl_dcu_drm_probe(struct platform_device *pdev) {
> > +	struct drm_driver *driver = &fsl_dcu_drm_driver;
> > +	struct drm_device *drm;
> > +	int err;
> > +
> > +	drm = drm_dev_alloc(driver, &pdev->dev);
> > +	if (!drm)
> > +		return -ENOMEM;
> > +
> > +	drm_dev_set_unique(drm, dev_name(&pdev->dev));
> > +
> > +	err = drm_dev_register(drm, 0);
> > +	if (err < 0)
> > +		goto unref;
> > +
> > +	DRM_INFO("Initialized %s %d.%d.%d %s on minor %d\n", driver->name,
> > +		 driver->major, driver->minor, driver->patchlevel,
> > +		 driver->date, drm->primary->index);
> > +
> > +	return 0;
> > +
> > +unref:
> > +	drm_dev_unref(drm);
> > +	return err;
> > +}
> > +
> > +static int fsl_dcu_drm_remove(struct platform_device *pdev) {
> > +	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
> > +
> > +	drm_put_dev(fsl_dev->ddev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id fsl_dcu_of_match[] = {
> > +		{ .compatible = "fsl,ls1021a-dcu", },
> > +		{ .compatible = "fsl,vf610-dcu", },
> > +		{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
> > +
> > +static struct platform_driver fsl_dcu_drm_platform_driver = {
> > +	.probe		= fsl_dcu_drm_probe,
> > +	.remove		= fsl_dcu_drm_remove,
> > +	.driver		= {
> > +		.name	= "fsl,dcu",
> 
> I don't think it's typical to use "vendor-prefix," in platform driver
> names. Perhaps a more typical name would be "fsl-dcu".
> 

Ok

> > +		.pm	= &fsl_dcu_drm_pm_ops,
> > +		.of_match_table = fsl_dcu_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(fsl_dcu_drm_platform_driver);
> > +
> > +MODULE_DESCRIPTION("Freescale DCU DRM Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> [...]
> > +#define DCU_DISP_SIZE			0x0018
> > +#define DCU_DISP_SIZE_DELTA_Y(x)	((x) << 16)
> > +/*Regisiter value 1/16 of horizontal resolution*/
> > +#define DCU_DISP_SIZE_DELTA_X(x)	((x) >> 4)
> 
> Does this mean the display controller only supports horizontal resolutions
> that are a multiple of 16?
> 

Yes. 


> > +#ifdef CONFIG_SOC_VF610
> > +#define DCU_TOTAL_LAYER_NUM             64
> > +#define DCU_LAYER_NUM_MAX               6
> > +#else
> > +#define DCU_TOTAL_LAYER_NUM             16
> > +#define DCU_LAYER_NUM_MAX               4
> > +#endif
> 
> Should this not be a runtime decision so that the same driver can run on
> VF610 and LS1021A platforms?
> 

Yes, Both VF610 and LS1021A use DCU as video IP module.
And there are a bit of differences on each SoCs.

> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
> [...]
> > new file mode 100644
> > index 0000000..f8ef0e1
> > --- /dev/null
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Copyright 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify it
> > + * under the terms of the GNU General Public License version 2 as
> > +published by
> > + * the Free Software Foundation.
> 
> The rest of your driver is GPL v2 (or later), this file isn't. Pick one.
> 

Ok


> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> [...]
> > +#include <drm/drmP.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <linux/regmap.h>
> > +#include <drm/drm_plane_helper.h>
> > +#include <drm/drm_atomic_helper.h>
> > +
> > +#include "fsl_dcu_drm_drv.h"
> > +#include "fsl_dcu_drm_kms.h"
> > +#include "fsl_dcu_drm_plane.h"
> > +
> > +#define to_fsl_dcu_plane(plane) \
> > +	container_of(plane, struct fsl_dcu_drm_plane, plane)
> > +
> > +static int
> > +fsl_dcu_drm_plane_prepare_fb(struct drm_plane *plane,
> > +			     struct drm_framebuffer *fb,
> > +			     const struct drm_plane_state *new_state) {
> > +	return 0;
> > +}
> > +
> > +static void
> > +fsl_dcu_drm_plane_cleanup_fb(struct drm_plane *plane,
> > +			     struct drm_framebuffer *fb,
> > +			     const struct drm_plane_state *new_state) { }
> > +
> > +static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
> > +					  struct drm_plane_state *state) {
> > +	return 0;
> > +}
> > +
> > +static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
> > +					     struct drm_plane_state *old_state) { }
> 
> This really should disable the plane. Perhaps clear DCU_CTRLDESCLN_4_EN
> here?
> 


Yes, I'll do it


> > +void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
> > +				     struct drm_plane_state *old_state) {
> > +	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
> > +	struct drm_plane_state *state = plane->state;
> > +	struct drm_framebuffer *fb = plane->state->fb;
> > +	struct drm_gem_cma_object *gem;
> > +	struct fsl_dcu_drm_plane *fsl_plane = to_fsl_dcu_plane(plane);
> > +	u32 index, alpha, bpp;
> > +	int err;
> > +
> > +	if (!fb)
> > +		return;
> > +
> > +	index = fsl_plane->index;
> > +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> > +
> > +	switch (fb->pixel_format) {
> > +	case DRM_FORMAT_RGB565:
> > +		bpp = FSL_DCU_RGB565;
> > +		alpha = 0xff;
> > +		break;
> > +	case DRM_FORMAT_RGB888:
> > +		bpp = FSL_DCU_RGB888;
> > +		alpha = 0xff;
> > +		break;
> > +	case DRM_FORMAT_ARGB8888:
> > +		bpp = FSL_DCU_ARGB8888;
> > +		alpha = 0xff;
> > +		break;
> > +	case DRM_FORMAT_BGRA4444:
> > +		bpp = FSL_DCU_ARGB4444;
> > +		alpha = 0xff;
> > +		break;
> > +	case DRM_FORMAT_ARGB1555:
> > +		bpp = FSL_DCU_ARGB1555;
> > +		alpha = 0xff;
> > +		break;
> > +	case DRM_FORMAT_YUV422:
> > +		bpp = FSL_DCU_YUV422;
> > +		alpha = 0xff;
> > +		break;
> > +	default:
> > +		return;
> > +	}
> 
> You should do this in ->atomic_check() already so that you can guarantee
> that the selected format can be set. The DRM core should already check it
> for you, but silently aborting here still doesn't seem like the right
> solution.
> 

Ok, I'll add format check in atomic_check().
Here is transfer pixel_format to value wrote to register.



> > +
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_1(index),
> > +			   DCU_CTRLDESCLN_1_HEIGHT(state->crtc_h) |
> > +			   DCU_CTRLDESCLN_1_WIDTH(state->crtc_w));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_2(index),
> > +			   DCU_CTRLDESCLN_2_POSY(state->crtc_y) |
> > +			   DCU_CTRLDESCLN_2_POSX(state->crtc_x));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap,
> > +			   DCU_CTRLDESCLN_3(index), gem->paddr);
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_4(index),
> > +			   DCU_CTRLDESCLN_4_EN |
> > +			   DCU_CTRLDESCLN_4_TRANS(alpha) |
> > +			   DCU_CTRLDESCLN_4_BPP(bpp) |
> > +			   DCU_CTRLDESCLN_4_AB(0));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_5(index),
> > +			   DCU_CTRLDESCLN_5_CKMAX_R(0xFF) |
> > +			   DCU_CTRLDESCLN_5_CKMAX_G(0xFF) |
> > +			   DCU_CTRLDESCLN_5_CKMAX_B(0xFF));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_6(index),
> > +			   DCU_CTRLDESCLN_6_CKMIN_R(0) |
> > +			   DCU_CTRLDESCLN_6_CKMIN_G(0) |
> > +			   DCU_CTRLDESCLN_6_CKMIN_B(0));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_7(index), 0);
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_8(index),
> > +			   DCU_CTRLDESCLN_8_FG_FCOLOR(0));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_9(index),
> > +			   DCU_CTRLDESCLN_9_BG_BCOLOR(0));
> > +	if (err)
> > +		goto set_failed;
> > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
> > +		err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_10(index),
> > +				   DCU_CTRLDESCLN_10_POST_SKIP(0) |
> > +				   DCU_CTRLDESCLN_10_PRE_SKIP(0));
> > +		if (err)
> > +			goto set_failed;
> > +	}
> > +	err = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
> > +				 DCU_MODE_DCU_MODE_MASK,
> > +				 DCU_MODE_DCU_MODE(DCU_MODE_NORMAL));
> > +	if (err)
> > +		goto set_failed;
> > +	err = regmap_write(fsl_dev->regmap,
> > +			   DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
> > +	if (err)
> > +		goto set_failed;
> > +	return;
> > +
> > +set_failed:
> > +	dev_err(fsl_dev->dev, "set DCU register failed\n"); }
> > +
> > +int fsl_dcu_drm_plane_disable(struct drm_plane *plane) {
> > +	return 0;
> > +}
> > +
> > +void fsl_dcu_drm_plane_destroy(struct drm_plane *plane) {
> > +	fsl_dcu_drm_plane_disable(plane);
> 
> Hmm? This function doesn't do anything, so why not just drop it?
> 


I'll implement fsl_dcu_drm_plane_disable(plane)



> > +	drm_plane_cleanup(plane);
> > +}
> 
> Also this function and ->atomic_update() should be static. Perhaps make it
> a habit of running your build tests with C=1 occasionally to get notified
> of this kind of error.
> 
> Thierry



One question: How can I set C=1?

Thanks again.
Jianwei
