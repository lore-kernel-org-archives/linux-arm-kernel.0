From: stefan@agner.ch (Stefan Agner)
Date: Wed, 04 Mar 2015 16:04:05 +0100
Subject: [PATCH 1/3] drm/layerscape: Add fsl dcu DRM driver
In-Reply-To: <1423825436-47780-1-git-send-email-b52261@freescale.com>
References: <1423825436-47780-1-git-send-email-b52261@freescale.com>
Message-ID: <cfab32fbbc5e30f26927baa6d5c5c43c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-13 12:03, Jianwei Wang wrote:
> This patch add support for Two Dimensional Animation and Compositing
> Engine (2D-ACE) on the Freescale LS102x SoCs.
> 
> 2D-ACE is a Freescale display controller. It supports at most four
> plane and provide an hardware cursor.
> 
> This is a simplified version, only a primary plane, a fb created for
> fbdev, a crtc, a connector for TFT LCD panel, an encoder, and the
> encoder is not in use. Now this drver support fbdev only.

Hi,

Do you know if that driver also works on Vybrid devices? Vybrid has also
DCU4 module with 2D-ACE functionality, also the registers look pretty
similar. I was thinking about creating a driver for Vybrid anyway...

Some remarks below...


> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <b52261@freescale.com>
> ---
>  .../devicetree/bindings/video/fsl,dcfb.txt         |  50 +++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/fsl/Kconfig                        |  17 +
>  drivers/gpu/drm/fsl/Makefile                       |   7 +
>  drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c             | 412 +++++++++++++++++++++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h             |  40 ++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c              | 323 ++++++++++++++++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h              | 167 +++++++++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c            |  43 +++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c              |  45 +++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h              |  22 ++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c            | 124 +++++++
>  drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h            |  28 ++
>  14 files changed, 1281 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,dcfb.txt
>  create mode 100644 drivers/gpu/drm/fsl/Kconfig
>  create mode 100644 drivers/gpu/drm/fsl/Makefile
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c
>  create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h
> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,dcfb.txt
> b/Documentation/devicetree/bindings/video/fsl,dcfb.txt
> new file mode 100644
> index 0000000..de7da97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,dcfb.txt
> @@ -0,0 +1,50 @@
> +* Freescale Simple Display Controller FB Driver

"FB Driver" probably refers more to a fbdev driver in the Linux kernel
sense, but since this is a DRM driver this is somewhat confusing. The
binding should describe the hardware, in the Vybrid RM mentions the IP
as "Display Control Unit (DCU4)", so maybe

Freescale Display Controller Unit (DCU4) module

Also, instead of using dcfb, I would use somewhat more hardware
describing, e.g. dcu4?

> +
> +Required properties:
> +- compatible:		Should be one of "fsl,ls1021a-dcfb".

If the driver also works for Vybrid, be favorable to have a generic
compatible string, e.g. fsl,dcu4?

> +- reg:			Address and length of the register set for dcfb.
> +- clocks:		From common clock binding: handle to dcfb clock.
> +- clock-names:		From common clock binding: Shall be "dcfb".
> +- display:		The phandle to display node.
> +
> +Optional properties:
> +- scfg-controller:	The phandle of scfg node.
> +
> +Required properties:
> +- bits-per-pixel:	<16> for RGB565,
> +			<24> for RGB888,
> +			<32> for RGB8888.
> +
> +Required timing node for dispplay sub-node:
> +- display-timings:	Refer to binding doc display-timing.txt for details.
> +
> +Examples:
> +dcfb: dcfb at 2ce0000 {
> +	compatible = "fsl,ls1021a-dcfb";
> +	reg = <0x0 0x2ce0000 0x0 0x10000>;
> +	clocks = <&platform_clk 0>;
> +	clock-names = "dcfb";
> +	scfg-controller = <&scfg>;
> +	display = <&display>;
> +
> +	display: display at 0 {
> +		bits-per-pixel = <24>;
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: nl4827hc19 {
> +				clock-frequency = <10870000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hback-porch = <2>;
> +				hfront-porch = <2>;
> +				vback-porch = <1>;
> +				vfront-porch = <1>;
> +				hsync-len = <41>;
> +				vsync-len = <2>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +			};
> +		};
> +	};
> +};
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 151a050..a6957aa 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -199,6 +199,8 @@ source "drivers/gpu/drm/bochs/Kconfig"
>  
>  source "drivers/gpu/drm/msm/Kconfig"
>  
> +source "drivers/gpu/drm/fsl/Kconfig"
> +
>  source "drivers/gpu/drm/tegra/Kconfig"
>  
>  source "drivers/gpu/drm/panel/Kconfig"
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c239b9..ab5b9ef 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_DRM_UDL) += udl/
>  obj-$(CONFIG_DRM_AST) += ast/
>  obj-$(CONFIG_DRM_ARMADA) += armada/
>  obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
> +obj-$(CONFIG_DRM_FSL_DCU) += fsl/
>  obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
>  obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
>  obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
> diff --git a/drivers/gpu/drm/fsl/Kconfig b/drivers/gpu/drm/fsl/Kconfig
> new file mode 100644
> index 0000000..e4f8df0
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/Kconfig
> @@ -0,0 +1,17 @@
> +config DRM_FSL_DCU
> +	tristate "DRM Support for Freescale DCU"
> +	depends on DRM && OF && ARM
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select VIDEOMODE_HELPERS
> +	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_LCD_SUPPORT
> +	select REGMAP_MMIO
> +	select DRM_KMS_FB_HELPER
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	help
> +	  Choose this option if you have an Freescale DCU chipset.
> +	  If M is selected the module will be called fsl-dcu-drm.
> diff --git a/drivers/gpu/drm/fsl/Makefile b/drivers/gpu/drm/fsl/Makefile
> new file mode 100644
> index 0000000..51c3e1f
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/Makefile
> @@ -0,0 +1,7 @@
> +fsl-dcu-drm-y := fsl_dcu_drm_drv.o \
> +	       fsl_dcu_drm_kms.o \
> +	       fsl_dcu_drm_plane.o \
> +	       fsl_dcu_drm_crtc.o \
> +	       fsl_dcu_drm_fbdev.o \
> +
> +obj-$(CONFIG_DRM_FSL_DCU)	+= fsl-dcu-drm.o
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c
> new file mode 100644
> index 0000000..9f5ba86
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c
> @@ -0,0 +1,412 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/clk.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_plane_helper.h>
> +#include <video/of_display_timing.h>
> +
> +#include "fsl_dcu_drm_crtc.h"
> +#include "fsl_dcu_drm_drv.h"
> +#include "fsl_dcu_drm_kms.h"
> +#include "fsl_dcu_drm_plane.h"
> +
> +#define to_fsl_dcu_crtc(c)	container_of(c, struct fsl_dcu_drm_crtc, crtc)
> +
> +static void fsl_dcu_drm_crtc_start(struct drm_crtc *crtc)
> +{
> +	fsl_dcu_drm_plane_setup(crtc->primary);
> +}
> +
> +static void fsl_dcu_drm_crtc_stop(struct drm_crtc *crtc)
> +{
> +}
> +
> +void fsl_dcu_drm_crtc_suspend(struct drm_crtc *crtc)
> +{
> +	fsl_dcu_drm_crtc_stop(crtc);
> +}
> +
> +void fsl_dcu_drm_crtc_resume(struct drm_crtc *crtc)
> +{
> +	struct fsl_dcu_drm_crtc *fsl_crtc = to_fsl_dcu_crtc(crtc);
> +
> +	if (fsl_crtc->dpms != DRM_MODE_DPMS_ON)
> +		return;
> +
> +	fsl_dcu_drm_crtc_start(crtc);
> +}
> +
> +static void fsl_dcu_drm_crtc_update_base(struct drm_crtc *crtc)
> +{
> +}
> +
> +static void fsl_dcu_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
> +{
> +	struct fsl_dcu_drm_crtc *fsl_crtc = to_fsl_dcu_crtc(crtc);
> +
> +	if (fsl_crtc->dpms == mode)
> +		return;
> +
> +	if (mode == DRM_MODE_DPMS_ON)
> +		fsl_dcu_drm_crtc_start(crtc);
> +	else
> +		fsl_dcu_drm_crtc_stop(crtc);
> +
> +	fsl_crtc->dpms = mode;
> +}
> +
> +static bool fsl_dcu_drm_crtc_mode_fixup(struct drm_crtc *crtc,
> +					const struct drm_display_mode *mode,
> +					struct drm_display_mode *adjusted_mode)
> +{
> +	return true;
> +}
> +
> +static void fsl_dcu_drm_crtc_mode_prepare(struct drm_crtc *crtc)
> +{
> +		fsl_dcu_drm_crtc_stop(crtc);
> +}
> +
> +static int fsl_dcu_drm_crtc_mode_set(struct drm_crtc *crtc,
> +				     struct drm_display_mode *mode,
> +				     struct drm_display_mode *adjusted_mode,
> +				     int x, int y,
> +				     struct drm_framebuffer *old_fb)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> +	uint32_t hbp, hfp, hsw, vbp, vfp, vsw, div, index;
> +
> +	DBG(": set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +	    mode->base.id, mode->name,
> +	    mode->vrefresh, mode->clock,
> +	    mode->hdisplay, mode->hsync_start,
> +	    mode->hsync_end, mode->htotal,
> +	    mode->vdisplay, mode->vsync_start,
> +	    mode->vsync_end, mode->vtotal,
> +	    mode->type, mode->flags);
> +
> +	index = drm_crtc_index(crtc);
> +	div = (uint32_t)clk_get_rate(fsl_dev->clk) / crtc->mode.clock / 1000;
> +
> +	/* Configure timings: */
> +	hbp = mode->htotal - mode->hsync_end;
> +	hfp = mode->hsync_start - mode->hdisplay;
> +	hsw = mode->hsync_end - mode->hsync_start;
> +	vbp = mode->vtotal - mode->vsync_end;
> +	vfp = mode->vsync_start - mode->vdisplay;
> +	vsw = mode->vsync_end - mode->vsync_start;
> +
> +	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
> +		     DCU_HSYN_PARA_BP(hbp) |
> +		     DCU_HSYN_PARA_PW(hsw) |
> +		     DCU_HSYN_PARA_FP(hfp));
> +	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
> +		     DCU_VSYN_PARA_BP(vbp) |
> +		     DCU_VSYN_PARA_PW(vsw) |
> +		     DCU_VSYN_PARA_FP(vfp));
> +	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
> +		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
> +		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_1(index),
> +		     DCU_CTRLDESCLN_1_HEIGHT(mode->vdisplay) |
> +		     DCU_CTRLDESCLN_1_WIDTH(mode->hdisplay));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_2(index),
> +		     DCU_CTRLDESCLN_2_POSY(y) |
> +		     DCU_CTRLDESCLN_2_POSX(x));
> +	regmap_write(fsl_dev->regmap, DCU_DIV_RATIO, div);
> +	regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
> +
> +	return 0;
> +}
> +
> +static void fsl_dcu_drm_crtc_mode_commit(struct drm_crtc *crtc)
> +{
> +		fsl_dcu_drm_crtc_start(crtc);
> +}
> +
> +static int fsl_dcu_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> +					  struct drm_framebuffer *old_fb)
> +{
> +	fsl_dcu_drm_crtc_update_base(crtc);
> +
> +	return 0;
> +}
> +
> +static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
> +	.dpms = fsl_dcu_drm_crtc_dpms,
> +	.mode_fixup = fsl_dcu_drm_crtc_mode_fixup,
> +	.prepare = fsl_dcu_drm_crtc_mode_prepare,
> +	.commit = fsl_dcu_drm_crtc_mode_commit,
> +	.mode_set = fsl_dcu_drm_crtc_mode_set,
> +	.mode_set_base = fsl_dcu_drm_crtc_mode_set_base,
> +};
> +
> +static int fsl_dcu_drm_crtc_page_flip(struct drm_crtc *crtc,
> +				      struct drm_framebuffer *fb,
> +				      struct drm_pending_vblank_event *event,
> +				      uint32_t page_flip_flags)
> +{
> +	return 0;
> +}
> +
> +static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
> +	.update_plane = fsl_dcu_drm_plane_update,
> +	.disable_plane = fsl_dcu_drm_plane_disable,
> +	.destroy = fsl_dcu_drm_plane_destroy,
> +};
> +
> +static const struct drm_crtc_funcs crtc_funcs = {
> +	.destroy = drm_crtc_cleanup,
> +	.set_config = drm_crtc_helper_set_config,
> +	.page_flip = fsl_dcu_drm_crtc_page_flip,
> +};
> +
> +int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
> +{
> +	struct drm_crtc *crtc = &fsl_dev->crtc.crtc;
> +	int ret;
> +
> +	fsl_dev->crtc.dpms = DRM_MODE_DPMS_OFF;
> +
> +	ret = drm_crtc_init(fsl_dev->ddev, crtc, &crtc_funcs);
> +	if (ret < 0)
> +		return ret;
> +
> +	crtc->primary->funcs = &fsl_dcu_drm_plane_funcs;
> +
> +	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
> +
> +	regmap_write(fsl_dev->regmap, DCU_SYN_POL,
> +		     DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW);
> +	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
> +		     DCU_BGND_G(0) | DCU_BGND_B(0));
> +	regmap_write(fsl_dev->regmap, DCU_DCU_MODE,
> +		     DCU_MODE_BLEND_ITER(1) | DCU_MODE_RASTER_EN);
> +	regmap_write(fsl_dev->regmap, DCU_THRESHOLD,
> +		     DCU_THRESHOLD_LS_BF_VS(BF_VS_VAL) |
> +		     DCU_THRESHOLD_OUT_BUF_HIGH(BUF_MAX_VAL) |
> +		     DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
> +	regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
> +			   DCU_MODE_DCU_MODE_MASK,
> +			   DCU_MODE_DCU_MODE(DCU_MODE_NORMAL));
> +	regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
> +	return 0;
> +}
> +
> +/*
> + * Encoder
> + */
> +
> +#define to_fsl_dcu_encoder(e) \
> +	container_of(e, struct fsl_dcu_drm_encoder, encoder)
> +
> +static void fsl_dcu_drm_encoder_dpms(struct drm_encoder *encoder, int mode)
> +{
> +	struct fsl_dcu_drm_encoder *fsl_enc = to_fsl_dcu_encoder(encoder);
> +
> +	if (fsl_enc->dpms == mode)
> +		return;
> +
> +	fsl_enc->dpms = mode;
> +}
> +
> +static bool fsl_dcu_drm_encoder_mode_fixup
> +		(struct drm_encoder *encoder,
> +		const struct drm_display_mode *mode,
> +		struct drm_display_mode *adjusted_mode)
> +{
> +	struct drm_device *dev = encoder->dev;
> +	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> +	struct drm_connector *connector = &fsl_dev->connector.connector;
> +	const struct drm_display_mode *panel_mode;
> +
> +	if (list_empty(&connector->modes)) {
> +		dev_dbg(dev->dev, "mode_fixup: empty modes list\n");
> +		return false;
> +	}
> +
> +	/* The flat panel mode is fixed, just copy it to the adjusted mode. */
> +	panel_mode = list_first_entry(&connector->modes,
> +				      struct drm_display_mode, head);
> +	drm_mode_copy(adjusted_mode, panel_mode);
> +
> +	return true;
> +}
> +
> +static void fsl_dcu_drm_encoder_mode_prepare(struct drm_encoder *encoder)
> +{
> +}
> +
> +static void fsl_dcu_drm_encoder_mode_set(struct drm_encoder *encoder,
> +					 struct drm_display_mode *mode,
> +					 struct drm_display_mode *adjusted_mode)
> +{
> +}
> +
> +static void fsl_dcu_drm_encoder_mode_commit(struct drm_encoder *encoder)
> +{
> +	;
> +}
> +
> +static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
> +	.dpms = fsl_dcu_drm_encoder_dpms,
> +	.mode_fixup = fsl_dcu_drm_encoder_mode_fixup,
> +	.prepare = fsl_dcu_drm_encoder_mode_prepare,
> +	.commit = fsl_dcu_drm_encoder_mode_commit,
> +	.mode_set = fsl_dcu_drm_encoder_mode_set,
> +};
> +
> +static void fsl_dcu_drm_encoder_destroy(struct drm_encoder *encoder)
> +{
> +	drm_encoder_cleanup(encoder);
> +}
> +
> +static const struct drm_encoder_funcs encoder_funcs = {
> +	.destroy = fsl_dcu_drm_encoder_destroy,
> +};
> +
> +int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev)
> +{
> +	struct drm_encoder *encoder = &fsl_dev->encoder.encoder;
> +	int ret;
> +
> +	fsl_dev->encoder.dpms = DRM_MODE_DPMS_OFF;
> +
> +	encoder->possible_crtcs = 1;
> +
> +	ret = drm_encoder_init(fsl_dev->ddev, encoder, &encoder_funcs,
> +			       DRM_MODE_ENCODER_LVDS);
> +	if (ret < 0)
> +		return ret;
> +
> +	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
> +
> +	return 0;
> +}
> +
> +/*
> + * Connector
> + */
> +
> +#define to_fsl_dcu_connector(c) \
> +	container_of(c, struct fsl_dcu_drm_connector, connector)
> +
> +static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct device_node *display_np, *np = dev->dev->of_node;
> +	struct drm_display_mode *mode = drm_mode_create(connector->dev);
> +	int num_modes = 0;
> +
> +	if (np) {
> +		display_np = of_parse_phandle(np, "display", 0);
> +		if (!display_np) {
> +			dev_err(dev->dev, "failed to find display phandle\n");
> +			return num_modes;
> +		}
> +		of_get_drm_display_mode(display_np, mode, OF_USE_NATIVE_MODE);
> +		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +		drm_mode_probed_add(connector, mode);
> +		num_modes++;
> +	}
> +
> +	return num_modes;
> +}
> +
> +static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
> +					    struct drm_display_mode *mode)
> +{
> +	return MODE_OK;
> +}
> +
> +static struct drm_encoder *
> +fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
> +{
> +	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
> +
> +	return fsl_con->encoder;
> +}
> +
> +static const struct drm_connector_helper_funcs connector_helper_funcs = {
> +	.get_modes = fsl_dcu_drm_connector_get_modes,
> +	.mode_valid = fsl_dcu_drm_connector_mode_valid,
> +	.best_encoder = fsl_dcu_drm_connector_best_encoder,
> +};
> +
> +static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
> +{
> +	drm_connector_unregister(connector);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static enum drm_connector_status
> +fsl_dcu_drm_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	return connector_status_connected;
> +}
> +
> +static const struct drm_connector_funcs connector_funcs = {
> +	.dpms = drm_helper_connector_dpms,
> +	.detect = fsl_dcu_drm_connector_detect,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = fsl_dcu_drm_connector_destroy,
> +};
> +
> +int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
> +				 struct drm_encoder *encoder)
> +{
> +	struct drm_connector *connector = &fsl_dev->connector.connector;
> +	int ret;
> +
> +	fsl_dev->connector.encoder = encoder;
> +
> +	connector->display_info.width_mm = 0;
> +	connector->display_info.height_mm = 0;
> +
> +	ret = drm_connector_init(fsl_dev->ddev, connector, &connector_funcs,
> +				 DRM_MODE_CONNECTOR_LVDS);
> +	if (ret < 0)
> +		return ret;
> +
> +	drm_connector_helper_add(connector, &connector_helper_funcs);
> +	ret = drm_connector_register(connector);
> +	if (ret < 0)
> +		goto err_cleanup;
> +
> +	ret = drm_mode_connector_attach_encoder(connector, encoder);
> +	if (ret < 0)
> +		goto err_sysfs;
> +
> +	connector->encoder = encoder;
> +
> +	drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
> +	drm_object_property_set_value
> +		(&connector->base, fsl_dev->ddev->mode_config.dpms_property,
> +		DRM_MODE_DPMS_OFF);
> +
> +	return 0;
> +
> +err_sysfs:
> +	drm_connector_unregister(connector);
> +err_cleanup:
> +	drm_connector_cleanup(connector);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h
> new file mode 100644
> index 0000000..ad59992
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __FSL_DCU_DRM_MODSET_H__
> +#define __FSL_DCU_DRM_MODSET_H__
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +
> +struct fsl_dcu_drm_device;
> +
> +struct fsl_dcu_drm_crtc {
> +	struct drm_crtc crtc;
> +	int dpms;
> +};
> +
> +struct fsl_dcu_drm_encoder {
> +	struct drm_encoder encoder;
> +	int dpms;
> +};
> +
> +struct fsl_dcu_drm_connector {
> +	struct drm_connector connector;
> +	struct drm_encoder *encoder;
> +};
> +
> +int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev);
> +int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev);
> +int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
> +				 struct drm_encoder *encoder);
> +
> +#endif /* __FSL_DCU_DRM_MODSET_H__ */
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c
> new file mode 100644
> index 0000000..1bca45a
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c
> @@ -0,0 +1,323 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drmP.h>
> +#include "fsl_dcu_drm_drv.h"
> +#include "fsl_dcu_drm_kms.h"
> +
> +static int fsl_dcu_unload(struct drm_device *dev)
> +{
> +	drm_mode_config_cleanup(dev);
> +	drm_vblank_cleanup(dev);
> +	drm_irq_uninstall(dev);
> +
> +	dev->dev_private = NULL;
> +
> +	return 0;
> +}
> +
> +static struct regmap_config fsl_dcu_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +};
> +
> +static int fsl_dcu_bypass_tcon(struct fsl_dcu_drm_device *fsl_dev,
> +			       struct device_node *np)
> +{
> +	struct device_node *tcon_np;
> +	struct platform_device *pdev;
> +	struct clk *tcon_clk;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
> +	if (!tcon_np)
> +		return -EINVAL;
> +
> +	pdev = of_find_device_by_node(tcon_np);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	tcon_clk = devm_clk_get(&pdev->dev, "tcon");
> +	if (IS_ERR(tcon_clk))
> +		return PTR_ERR(tcon_clk);
> +	clk_prepare_enable(tcon_clk);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	fsl_dev->tcon_regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +			"tcon", base, &fsl_dcu_regmap_config);
> +	if (IS_ERR(fsl_dev->tcon_regmap)) {
> +		dev_err(&pdev->dev, "regmap init failed\n");
> +		return PTR_ERR(fsl_dev->tcon_regmap);
> +	}
> +
> +	regmap_write(fsl_dev->tcon_regmap, TCON_CTRL1, TCON_BYPASS_ENABLE);
> +	return 0;
> +}
> +
> +static int fsl_dcu_scfg_config(struct fsl_dcu_drm_device *fsl_dev,
> +			       struct device_node *np)
> +{
> +	struct device_node *scfg_np;
> +	struct platform_device *pdev;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	scfg_np = of_parse_phandle(np, "scfg-controller", 0);
> +	if (!scfg_np)
> +		return 0;
> +
> +	pdev = of_find_device_by_node(scfg_np);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	fsl_dev->scfg_regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +			NULL, base, &fsl_dcu_regmap_config);
> +	if (IS_ERR(fsl_dev->scfg_regmap)) {
> +		dev_err(&pdev->dev, "regmap init failed\n");
> +		return PTR_ERR(fsl_dev->scfg_regmap);
> +	}
> +
> +	regmap_write(fsl_dev->scfg_regmap, 0x28, 0x80000000);

What does this actually do? I don't think this exists in Vybrid, but I
guess we could easily make the property optional which would then not
call this function...

--
Stefan

> +
> +	return 0;
> +}
> +
> +static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
> +{
> +	struct platform_device *pdev = dev->platformdev;
> +	struct fsl_dcu_drm_device *fsl_dev;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	fsl_dev = devm_kzalloc(&pdev->dev, sizeof(*fsl_dev), GFP_KERNEL);
> +	if (!fsl_dev)
> +		return -ENOMEM;
> +
> +	fsl_dev->dev = &pdev->dev;
> +	fsl_dev->ddev = dev;
> +	dev->dev_private = fsl_dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		return ret;
> +	}
> +
> +	fsl_dev->regmap = devm_regmap_init_mmio(&pdev->dev,
> +			base, &fsl_dcu_regmap_config);
> +	if (IS_ERR(fsl_dev->regmap)) {
> +		dev_err(&pdev->dev, "regmap init failed\n");
> +		return PTR_ERR(fsl_dev->regmap);
> +	}
> +
> +	ret = fsl_dcu_drm_modeset_init(fsl_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to initialize mode setting\n");
> +		return ret;
> +	}
> +
> +	ret = drm_vblank_init(dev, 1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to initialize vblank\n");
> +		goto done;
> +	}
> +
> +	ret = drm_irq_install(dev, platform_get_irq(dev->platformdev, 0));
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to install IRQ handler\n");
> +		goto done;
> +	}
> +
> +	/* Put TCON in bypass mode, so the input signals from DCU are passed
> +	 * through TCON unchanged */
> +	fsl_dcu_bypass_tcon(fsl_dev, pdev->dev.of_node);
> +	fsl_dcu_scfg_config(fsl_dev, pdev->dev.of_node);
> +
> +	fsl_dev->clk = devm_clk_get(&pdev->dev, "dcfb");
> +	if (IS_ERR(fsl_dev->clk)) {
> +		ret = PTR_ERR(fsl_dev->clk);
> +		dev_err(&pdev->dev, "could not get clock\n");
> +		return ret;
> +	}
> +	clk_prepare_enable(fsl_dev->clk);
> +
> +	dev_set_drvdata(dev->dev, fsl_dev);
> +
> +	fsl_dcu_fbdev_init(dev);
> +
> +	return 0;
> +done:
> +	if (ret)
> +		fsl_dcu_unload(dev);
> +
> +	return ret;
> +}
> +
> +static void fsl_dcu_drm_preclose(struct drm_device *dev, struct drm_file *file)
> +{
> +	;
> +}
> +
> +static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
> +{
> +	return IRQ_HANDLED;
> +}
> +
> +static int fsl_dcu_drm_enable_vblank(struct drm_device *dev, int crtc)
> +{
> +	return 0;
> +}
> +
> +static void fsl_dcu_drm_disable_vblank(struct drm_device *dev, int crtc)
> +{
> +	;
> +}
> +
> +static const struct file_operations fsl_dcu_drm_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= drm_open,
> +	.release	= drm_release,
> +	.unlocked_ioctl	= drm_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= drm_compat_ioctl,
> +#endif
> +	.poll		= drm_poll,
> +	.read		= drm_read,
> +	.llseek		= no_llseek,
> +	.mmap		= drm_gem_cma_mmap,
> +};
> +
> +static struct drm_driver fsl_dcu_drm_driver = {
> +	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
> +				| DRIVER_PRIME,
> +	.load			= fsl_dcu_load,
> +	.unload			= fsl_dcu_unload,
> +	.preclose		= fsl_dcu_drm_preclose,
> +	.irq_handler		= fsl_dcu_drm_irq,
> +	.get_vblank_counter	= drm_vblank_count,
> +	.enable_vblank		= fsl_dcu_drm_enable_vblank,
> +	.disable_vblank		= fsl_dcu_drm_disable_vblank,
> +	.gem_free_object	= drm_gem_cma_free_object,
> +	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> +	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> +	.gem_prime_import	= drm_gem_prime_import,
> +	.gem_prime_export	= drm_gem_prime_export,
> +	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> +	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
> +	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
> +	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> +	.dumb_create		= drm_gem_cma_dumb_create,
> +	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
> +	.dumb_destroy		= drm_gem_dumb_destroy,
> +	.fops			= &fsl_dcu_drm_fops,
> +	.name			= "fsl-dcu-drm",
> +	.desc			= "Freescale DCU DRM",
> +	.date			= "20150213",
> +	.major			= 1,
> +	.minor			= 0,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int fsl_dcu_drm_pm_suspend(struct device *dev)
> +{
> +	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
> +
> +	drm_kms_helper_poll_disable(fsl_dev->ddev);
> +	fsl_dcu_drm_crtc_suspend(&fsl_dev->crtc);
> +
> +	return 0;
> +}
> +
> +static int fsl_dcu_drm_pm_resume(struct device *dev)
> +{
> +	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
> +
> +	drm_modeset_lock_all(fsl_dev->ddev);
> +	fsl_dcu_drm_crtc_resume(&fsl_dev->crtc);
> +	drm_modeset_unlock_all(fsl_dev->ddev);
> +
> +	drm_kms_helper_poll_enable(fsl_dev->ddev);
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops fsl_dcu_drm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(fsl_dcu_drm_pm_suspend, fsl_dcu_drm_pm_resume)
> +};
> +
> +static int fsl_dcu_drm_probe(struct platform_device *pdev)
> +{
> +	return drm_platform_init(&fsl_dcu_drm_driver, pdev);
> +}
> +
> +static int fsl_dcu_drm_remove(struct platform_device *pdev)
> +{
> +	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
> +
> +	drm_put_dev(fsl_dev->ddev);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id fsl_dcu_of_match[] = {
> +		{ .compatible = "fsl,ls1021a-dcfb", },
> +		{ },
> +};
> +MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
> +
> +static struct platform_driver fsl_dcu_drm_platform_driver = {
> +	.probe		= fsl_dcu_drm_probe,
> +	.remove		= fsl_dcu_drm_remove,
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= "fsl,ls1021a-dcfb",
> +		.pm	= &fsl_dcu_drm_pm_ops,
> +		.of_match_table = fsl_dcu_of_match,
> +	},
> +};
> +
> +module_platform_driver(fsl_dcu_drm_platform_driver);
> +
> +MODULE_ALIAS("platform:fsl-dcu-drm");
> +MODULE_DESCRIPTION("Freescale DCU DRM Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h
> new file mode 100644
> index 0000000..8dc7c10
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __FSL_DCU_DRM_DRV_H__
> +#define __FSL_DCU_DRM_DRV_H__
> +
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <stddef.h>
> +#include <drm/drm.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +
> +#include "fsl_dcu_drm_crtc.h"
> +#define DRIVER_NAME			"fsl-dcu-fb"
> +
> +#define DCU_DCU_MODE			0x0010
> +#define DCU_MODE_BLEND_ITER(x)		((x) << 20)
> +#define DCU_MODE_RASTER_EN		BIT(14)
> +#define DCU_MODE_DCU_MODE(x)		(x)
> +#define DCU_MODE_DCU_MODE_MASK		0x03
> +#define DCU_MODE_OFF			0
> +#define DCU_MODE_NORMAL			1
> +#define DCU_MODE_TEST			2
> +#define DCU_MODE_COLORBAR		3
> +
> +#define DCU_BGND			0x0014
> +#define DCU_BGND_R(x)			((x) << 16)
> +#define DCU_BGND_G(x)			((x) << 8)
> +#define DCU_BGND_B(x)			(x)
> +
> +#define DCU_DISP_SIZE			0x0018
> +#define DCU_DISP_SIZE_DELTA_Y(x)	((x) << 16)
> +/*Regisiter value 1/16 of horizontal resolution*/
> +#define DCU_DISP_SIZE_DELTA_X(x)	((x) >> 4)
> +
> +#define DCU_HSYN_PARA			0x001c
> +#define DCU_HSYN_PARA_BP(x)		((x) << 22)
> +#define DCU_HSYN_PARA_PW(x)		((x) << 11)
> +#define DCU_HSYN_PARA_FP(x)		(x)
> +
> +#define DCU_VSYN_PARA			0x0020
> +#define DCU_VSYN_PARA_BP(x)		((x) << 22)
> +#define DCU_VSYN_PARA_PW(x)		((x) << 11)
> +#define DCU_VSYN_PARA_FP(x)		(x)
> +
> +#define DCU_SYN_POL			0x0024
> +#define DCU_SYN_POL_INV_PXCK_FALL	(0 << 6)
> +#define DCU_SYN_POL_NEG_REMAIN		(0 << 5)
> +#define DCU_SYN_POL_INV_VS_LOW		BIT(1)
> +#define DCU_SYN_POL_INV_HS_LOW		(1)
> +
> +#define DCU_THRESHOLD			0x0028
> +#define DCU_THRESHOLD_LS_BF_VS(x)	((x) << 16)
> +#define DCU_THRESHOLD_OUT_BUF_HIGH(x)	((x) << 8)
> +#define DCU_THRESHOLD_OUT_BUF_LOW(x)	(x)
> +#define BF_VS_VAL			0x03
> +#define BUF_MAX_VAL			0x78
> +#define BUF_MIN_VAL			0x0a
> +
> +#define DCU_INT_STATUS			0x002C
> +#define DCU_INT_STATUS_UNDRUN		BIT(1)
> +
> +#define DCU_INT_MASK			0x0030
> +#define DCU_INT_MASK_UNDRUN		BIT(1)
> +#define DCU_INT_MASK_VBLANK		BIT(3)
> +
> +#define DCU_DIV_RATIO			0x0054
> +
> +#define DCU_UPDATE_MODE			0x00cc
> +#define DCU_UPDATE_MODE_MODE		BIT(31)
> +#define DCU_UPDATE_MODE_READREG		BIT(30)
> +
> +#define DCU_DCFB_MAX			0x300
> +
> +#define DCU_CTRLDESCLN_1(x)		(0x200 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_1_HEIGHT(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_1_WIDTH(x)	(x)
> +
> +#define DCU_CTRLDESCLN_2(x)		(0x204 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_2_POSY(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_2_POSX(x)	(x)
> +
> +#define DCU_CTRLDESCLN_3(x)		(0x208 + (x) * 0x40)
> +
> +#define DCU_CTRLDESCLN_4(x)		(0x20c + (x) * 0x40)
> +#define DCU_CTRLDESCLN_4_EN		BIT(31)
> +#define DCU_CTRLDESCLN_4_TILE_EN	BIT(30)
> +#define DCU_CTRLDESCLN_4_DATA_SEL_CLUT	BIT(29)
> +#define DCU_CTRLDESCLN_4_SAFETY_EN	BIT(28)
> +#define DCU_CTRLDESCLN_4_TRANS(x)	((x) << 20)
> +#define DCU_CTRLDESCLN_4_BPP(x)		((x) << 16)
> +#define DCU_CTRLDESCLN_4_RLE_EN		BIT(15)
> +#define DCU_CTRLDESCLN_4_LUOFFS(x)	((x) << 4)
> +#define DCU_CTRLDESCLN_4_BB_ON		BIT(2)
> +#define DCU_CTRLDESCLN_4_AB(x)		(x)
> +
> +#define DCU_CTRLDESCLN_5(x)		(0x210 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_5_CKMAX_R(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_5_CKMAX_G(x)	((x) << 8)
> +#define DCU_CTRLDESCLN_5_CKMAX_B(x)	(x)
> +
> +#define DCU_CTRLDESCLN_6(x)		(0x214 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_6_CKMIN_R(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_6_CKMIN_G(x)	((x) << 8)
> +#define DCU_CTRLDESCLN_6_CKMIN_B(x)	(x)
> +
> +#define DCU_CTRLDESCLN_7(x)		(0x218 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_7_TILE_VER(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_7_TILE_HOR(x)	(x)
> +
> +#define DCU_CTRLDESCLN_8(x)		(0x21c + (x) * 0x40)
> +#define DCU_CTRLDESCLN_8_FG_FCOLOR(x)	(x)
> +
> +#define DCU_CTRLDESCLN_9(x)		(0x220 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_9_BG_BCOLOR(x)	(x)
> +
> +#define DCU_CTRLDESCLN_10(x)		(0x224 + (x) * 0x40)
> +#define DCU_CTRLDESCLN_10_POST_SKIP(x)	((x) << 16)
> +#define DCU_CTRLDESCLN_10_PRE_SKIP(x)	(x)
> +
> +#define FSL_DCU_RGB565			4
> +#define FSL_DCU_RGB888			5
> +#define FSL_DCU_ARGB8888		6
> +#define FSL_DCU_ARGB1555		11
> +#define FSL_DCU_ARGB4444		12
> +#define FSL_DCU_YUV422			14
> +
> +#define TCON_CTRL1			0x0000
> +#define TCON_BYPASS_ENABLE		BIT(29)
> +
> +#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
> +
> +struct clk;
> +struct device;
> +struct drm_device;
> +
> +struct fsl_dcu_drm_device {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regmap *tcon_regmap;
> +	struct regmap *scfg_regmap;
> +	unsigned int irq;
> +	struct clk *clk;
> +	/*protects hardware register*/
> +	spinlock_t irq_lock;
> +	struct drm_device *ddev;
> +	struct drm_fbdev_cma *fbdev;
> +	struct fsl_dcu_drm_crtc crtc;
> +	struct fsl_dcu_drm_encoder encoder;
> +	struct fsl_dcu_drm_connector connector;
> +};
> +
> +void fsl_dcu_fbdev_init(struct drm_device *dev);
> +
> +#endif /* __FSL_DCU_DRM_DRV_H__ */
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c
> new file mode 100644
> index 0000000..6729f92
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/fb.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <video/of_display_timing.h>
> +#include <video/videomode.h>
> +#include <linux/uaccess.h>
> +
> +#include "fsl_dcu_drm_drv.h"
> +#include "fsl_dcu_drm_crtc.h"
> +
> +/* initialize fbdev helper */
> +void fsl_dcu_fbdev_init(struct drm_device *dev)
> +{
> +	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev->dev);
> +
> +	fsl_dev->fbdev = drm_fbdev_cma_init(dev, 24, 1, 1);
> +}
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c
> new file mode 100644
> index 0000000..0eb0652
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +
> +#include "fsl_dcu_drm_crtc.h"
> +#include "fsl_dcu_drm_drv.h"
> +#include "fsl_dcu_drm_kms.h"
> +
> +static const struct drm_mode_config_funcs fsl_dcu_drm_mode_config_funcs = {
> +	.fb_create = drm_fb_cma_create,
> +};
> +
> +int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
> +{
> +	drm_mode_config_init(fsl_dev->ddev);
> +
> +	fsl_dev->ddev->mode_config.min_width = 0;
> +	fsl_dev->ddev->mode_config.min_height = 0;
> +	fsl_dev->ddev->mode_config.max_width = 2031;
> +	fsl_dev->ddev->mode_config.max_height = 2047;
> +	fsl_dev->ddev->mode_config.funcs = &fsl_dcu_drm_mode_config_funcs;
> +
> +	fsl_dcu_drm_crtc_create(fsl_dev);
> +	fsl_dcu_drm_encoder_create(fsl_dev);
> +	fsl_dcu_drm_connector_create(fsl_dev, &fsl_dev->encoder.encoder);
> +
> +	drm_kms_helper_poll_init(fsl_dev->ddev);
> +
> +	drm_helper_disable_unused_functions(fsl_dev->ddev);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h
> new file mode 100644
> index 0000000..9d5b798
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __FSL_DCU_DRM_KMS_H__
> +#define __FSL_DCU_DRM_KMS_H__
> +
> +#include <linux/types.h>
> +
> +struct drm_gem_cma_object;
> +struct fsl_dcu_drm_device;
> +
> +int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev);
> +
> +#endif /* __FSL_DCU_DRM_KMS_H__ */
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c
> new file mode 100644
> index 0000000..d725594
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <linux/regmap.h>
> +
> +#include "fsl_dcu_drm_drv.h"
> +#include "fsl_dcu_drm_kms.h"
> +#include "fsl_dcu_drm_plane.h"
> +
> +static void __fsl_dcu_drm_plane_setup(struct drm_plane *plane,
> +				      struct drm_framebuffer *fb)
> +{
> +	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
> +	u32 plane_num = 0, alpha, bpp;
> +	struct drm_gem_cma_object *gem;
> +
> +	while (plane->possible_crtcs >> 1)
> +		plane_num++;
> +
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +
> +	switch (fb->pixel_format) {
> +	case DRM_FORMAT_RGB565:
> +		bpp = FSL_DCU_RGB565;
> +		alpha = 0xff;
> +		break;
> +	case DRM_FORMAT_RGB888:
> +		bpp = FSL_DCU_RGB888;
> +		alpha = 0xff;
> +		break;
> +	case DRM_FORMAT_ARGB8888:
> +		bpp = FSL_DCU_ARGB8888;
> +		alpha = 0xff;
> +		break;
> +	case DRM_FORMAT_BGRA4444:
> +		bpp = FSL_DCU_ARGB4444;
> +		alpha = 0xff;
> +		break;
> +	case DRM_FORMAT_ARGB1555:
> +		bpp = FSL_DCU_ARGB1555;
> +		alpha = 0xff;
> +		break;
> +	case DRM_FORMAT_YUV422:
> +		bpp = FSL_DCU_YUV422;
> +		alpha = 0xff;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_3(plane_num), gem->paddr);
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_4(plane_num),
> +		     DCU_CTRLDESCLN_4_EN |
> +		     DCU_CTRLDESCLN_4_TRANS(alpha) |
> +		     DCU_CTRLDESCLN_4_BPP(bpp) |
> +		     DCU_CTRLDESCLN_4_AB(2));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_5(plane_num),
> +		     DCU_CTRLDESCLN_5_CKMAX_R(0xFF) |
> +		     DCU_CTRLDESCLN_5_CKMAX_G(0xFF) |
> +		     DCU_CTRLDESCLN_5_CKMAX_B(0xFF));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_6(plane_num),
> +		     DCU_CTRLDESCLN_6_CKMIN_R(0) |
> +		     DCU_CTRLDESCLN_6_CKMIN_G(0) |
> +		     DCU_CTRLDESCLN_6_CKMIN_B(0));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_8(plane_num),
> +		     DCU_CTRLDESCLN_8_FG_FCOLOR(0));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_9(plane_num),
> +		     DCU_CTRLDESCLN_9_BG_BCOLOR(0));
> +	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_10(plane_num),
> +		     DCU_CTRLDESCLN_10_POST_SKIP(0) |
> +		     DCU_CTRLDESCLN_10_PRE_SKIP(0));
> +	regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
> +}
> +
> +void fsl_dcu_drm_plane_setup(struct drm_plane *plane)
> +{
> +	if (!plane->fb)
> +		return;
> +
> +	__fsl_dcu_drm_plane_setup(plane, plane->fb);
> +}
> +
> +int fsl_dcu_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
> +			     struct drm_framebuffer *fb, int crtc_x, int crtc_y,
> +			    unsigned int crtc_w, unsigned int crtc_h,
> +			    uint32_t src_x, uint32_t src_y,
> +			    uint32_t src_w, uint32_t src_h)
> +{
> +	__fsl_dcu_drm_plane_setup(plane, fb);
> +	return 0;
> +}
> +
> +int fsl_dcu_drm_plane_disable(struct drm_plane *plane)
> +{
> +	return 0;
> +}
> +
> +void fsl_dcu_drm_plane_destroy(struct drm_plane *plane)
> +{
> +	fsl_dcu_drm_plane_disable(plane);
> +	drm_plane_cleanup(plane);
> +}
> +
> +static const uint32_t formats[] = {
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_YUV422,
> +};
> diff --git a/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h
> b/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h
> new file mode 100644
> index 0000000..da88d1c
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * Freescale DCU drm device driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __FSL_DCU_DRM_PLANE_H__
> +#define __FSL_DCU_DRM_PLANE_H__
> +
> +struct fsl_dcu_drm_device;
> +
> +void fsl_dcu_drm_plane_setup(struct drm_plane *plane);
> +int fsl_dcu_drm_plane_update(struct drm_plane *plane,
> +			     struct drm_crtc *crtc,
> +			     struct drm_framebuffer *fb,
> +			     int crtc_x, int crtc_y,
> +			     unsigned int crtc_w, unsigned int crtc_h,
> +			     uint32_t src_x, uint32_t src_y,
> +			     uint32_t src_w, uint32_t src_h);
> +int fsl_dcu_drm_plane_disable(struct drm_plane *plane);
> +void fsl_dcu_drm_plane_destroy(struct drm_plane *plane);
> +
> +#endif /* __FSL_DCU_DRM_PLANE_H__ */
