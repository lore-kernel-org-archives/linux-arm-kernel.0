From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 19:51:45 +0800
Subject: [PATCH 15/23] drm/sun4i: Add LVDS support
In-Reply-To: <6e313d0b31dca3f47583668eb755d934a1ab515e.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <6e313d0b31dca3f47583668eb755d934a1ab515e.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67s0qZnaE49W7umH4OHQH8za=WThyzRtgFZi-HQ+fZSAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The TCON supports the LVDS interface to output to a panel or a bridge.
> Let's add support for it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/Makefile     |   1 +-
>  drivers/gpu/drm/sun4i/sun4i_lvds.c | 183 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_lvds.h |  18 +++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 193 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  25 ++++-
>  5 files changed, 419 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
>
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index cfba2c07519c..6fee15d016ef 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -10,6 +10,7 @@ sun4i-drm-hdmi-y              += sun4i_hdmi_tmds_clk.o
>
>  sun4i-tcon-y                   += sun4i_tcon.o
>  sun4i-tcon-y                   += sun4i_rgb.o
> +sun4i-tcon-y                   += sun4i_lvds.o
>  sun4i-tcon-y                   += sun4i_dotclock.o
>  sun4i-tcon-y                   += sun4i_crtc.o
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> new file mode 100644
> index 000000000000..635a3f505ecb
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright (C) 2015 NextThing Co
> + * Copyright (C) 2015-2017 Free Electrons
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +
> +#include "sun4i_crtc.h"
> +#include "sun4i_tcon.h"
> +#include "sun4i_lvds.h"
> +
> +struct sun4i_lvds {
> +       struct drm_connector    connector;
> +       struct drm_encoder      encoder;
> +
> +       struct sun4i_tcon       *tcon;
> +};
> +
> +static inline struct sun4i_lvds *
> +drm_connector_to_sun4i_lvds(struct drm_connector *connector)
> +{
> +       return container_of(connector, struct sun4i_lvds,
> +                           connector);
> +}
> +
> +static inline struct sun4i_lvds *
> +drm_encoder_to_sun4i_lvds(struct drm_encoder *encoder)
> +{
> +       return container_of(encoder, struct sun4i_lvds,
> +                           encoder);
> +}
> +
> +static int sun4i_lvds_get_modes(struct drm_connector *connector)
> +{
> +       struct sun4i_lvds *lvds =
> +               drm_connector_to_sun4i_lvds(connector);
> +       struct sun4i_tcon *tcon = lvds->tcon;
> +
> +       return drm_panel_get_modes(tcon->panel);
> +}
> +
> +static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
> +       .get_modes      = sun4i_lvds_get_modes,
> +};
> +
> +static void
> +sun4i_lvds_connector_destroy(struct drm_connector *connector)
> +{
> +       struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
> +       struct sun4i_tcon *tcon = lvds->tcon;
> +
> +       drm_panel_detach(tcon->panel);
> +       drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs sun4i_lvds_con_funcs = {
> +       .fill_modes             = drm_helper_probe_single_connector_modes,
> +       .destroy                = sun4i_lvds_connector_destroy,
> +       .reset                  = drm_atomic_helper_connector_reset,
> +       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +       .atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
> +{
> +       struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
> +       struct sun4i_tcon *tcon = lvds->tcon;
> +
> +       DRM_DEBUG_DRIVER("Enabling LVDS output\n");
> +
> +       if (!IS_ERR(tcon->panel)) {
> +               drm_panel_prepare(tcon->panel);
> +               drm_panel_enable(tcon->panel);
> +       }
> +}
> +
> +static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
> +{
> +       struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
> +       struct sun4i_tcon *tcon = lvds->tcon;
> +
> +       DRM_DEBUG_DRIVER("Disabling LVDS output\n");
> +
> +       if (!IS_ERR(tcon->panel)) {
> +               drm_panel_disable(tcon->panel);
> +               drm_panel_unprepare(tcon->panel);
> +       }
> +}
> +
> +static const struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
> +       .disable        = sun4i_lvds_encoder_disable,
> +       .enable         = sun4i_lvds_encoder_enable,
> +};
> +
> +static const struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
> +       .destroy        = drm_encoder_cleanup,
> +};
> +
> +int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
> +{
> +       struct drm_encoder *encoder;
> +       struct drm_bridge *bridge;
> +       struct sun4i_lvds *lvds;
> +       int ret;
> +
> +       lvds = devm_kzalloc(drm->dev, sizeof(*lvds), GFP_KERNEL);
> +       if (!lvds)
> +               return -ENOMEM;
> +       lvds->tcon = tcon;
> +       encoder = &lvds->encoder;
> +
> +       ret = drm_of_find_panel_or_bridge(tcon->dev->of_node, 1, 0,
> +                                         &tcon->panel, &bridge);
> +       if (ret) {
> +               dev_info(drm->dev, "No panel or bridge found... LVDS output disabled\n");
> +               return 0;
> +       }
> +
> +       drm_encoder_helper_add(&lvds->encoder,
> +                              &sun4i_lvds_enc_helper_funcs);
> +       ret = drm_encoder_init(drm,
> +                              &lvds->encoder,
> +                              &sun4i_lvds_enc_funcs,
> +                              DRM_MODE_ENCODER_LVDS,
> +                              NULL);
> +       if (ret) {
> +               dev_err(drm->dev, "Couldn't initialise the lvds encoder\n");
> +               goto err_out;
> +       }
> +
> +       /* The LVDS encoder can only work with the TCON channel 0 */
> +       lvds->encoder.possible_crtcs = BIT(drm_crtc_index(&tcon->crtc->crtc));
> +
> +       if (tcon->panel) {
> +               drm_connector_helper_add(&lvds->connector,
> +                                        &sun4i_lvds_con_helper_funcs);
> +               ret = drm_connector_init(drm, &lvds->connector,
> +                                        &sun4i_lvds_con_funcs,
> +                                        DRM_MODE_CONNECTOR_LVDS);
> +               if (ret) {
> +                       dev_err(drm->dev, "Couldn't initialise the lvds connector\n");
> +                       goto err_cleanup_connector;
> +               }
> +
> +               drm_mode_connector_attach_encoder(&lvds->connector,
> +                                                 &lvds->encoder);
> +
> +               ret = drm_panel_attach(tcon->panel, &lvds->connector);
> +               if (ret) {
> +                       dev_err(drm->dev, "Couldn't attach our panel\n");
> +                       goto err_cleanup_connector;
> +               }
> +       }
> +
> +       if (bridge) {
> +               ret = drm_bridge_attach(encoder, bridge, NULL);
> +               if (ret) {
> +                       dev_err(drm->dev, "Couldn't attach our bridge\n");
> +                       goto err_cleanup_connector;
> +               }
> +       }
> +
> +       return 0;
> +
> +err_cleanup_connector:
> +       drm_encoder_cleanup(&lvds->encoder);
> +err_out:
> +       return ret;
> +}
> +EXPORT_SYMBOL(sun4i_lvds_init);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.h b/drivers/gpu/drm/sun4i/sun4i_lvds.h
> new file mode 100644
> index 000000000000..1b8fad4b82c3
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2015 NextThing Co
> + * Copyright (C) 2015-2017 Free Electrons
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef _SUN4I_LVDS_H_
> +#define _SUN4I_LVDS_H_
> +
> +int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon);
> +
> +#endif /* _SUN4I_LVDS_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3efa1ab045cd..6a20a467ee6d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -31,10 +31,52 @@
>  #include "sun4i_crtc.h"
>  #include "sun4i_dotclock.h"
>  #include "sun4i_drv.h"
> +#include "sun4i_lvds.h"
>  #include "sun4i_rgb.h"
>  #include "sun4i_tcon.h"
>  #include "sunxi_engine.h"
>
> +static struct drm_connector *sun4i_tcon_get_connector(const struct drm_encoder *encoder)
> +{
> +       struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
> +
> +       drm_connector_list_iter_begin(encoder->dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter)
> +               if (connector->encoder == encoder) {
> +                       drm_connector_list_iter_end(&iter);
> +                       return connector;
> +               }
> +       drm_connector_list_iter_end(&iter);
> +
> +       return NULL;
> +}
> +
> +static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
> +{
> +       struct drm_connector *connector;
> +       struct drm_display_info *info;
> +
> +       connector = sun4i_tcon_get_connector(encoder);
> +       if (!connector)
> +               return -EINVAL;
> +
> +       info = &connector->display_info;
> +       if (info->num_bus_formats != 1)
> +               return -EINVAL;
> +
> +       switch (info->bus_formats[0]) {
> +       case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +               return 18;
> +
> +       case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +       case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +               return 24;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
>                                           bool enabled)
>  {
> @@ -69,9 +111,13 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
>                            const struct drm_encoder *encoder,
>                            bool enabled)
>  {
> +       bool is_lvds = false;
>         int channel;
>
>         switch (encoder->encoder_type) {
> +       case DRM_MODE_ENCODER_LVDS:
> +               is_lvds = true;
> +               /* Fallthrough */
>         case DRM_MODE_ENCODER_NONE:
>                 channel = 0;
>                 break;
> @@ -84,10 +130,47 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
>                 return;
>         }
>
> +       if (is_lvds && !enabled)
> +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
> +                                  SUN4I_TCON0_LVDS_IF_EN, 0);
> +
>         regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
>                            SUN4I_TCON_GCTL_TCON_ENABLE,
>                            enabled ? SUN4I_TCON_GCTL_TCON_ENABLE : 0);
>
> +       if (is_lvds && enabled) {
> +               u8 val;
> +
> +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
> +                                  SUN4I_TCON0_LVDS_IF_EN,
> +                                  SUN4I_TCON0_LVDS_IF_EN);
> +
> +               regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +                            SUN4I_TCON0_LVDS_ANA0_C(2) |
> +                            SUN4I_TCON0_LVDS_ANA0_V(3) |
> +                            SUN4I_TCON0_LVDS_ANA0_PD(2) |
> +                            SUN4I_TCON0_LVDS_ANA0_EN_LDO);
> +               udelay(2);
> +
> +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +                                  SUN4I_TCON0_LVDS_ANA0_EN_MB,
> +                                  SUN4I_TCON0_LVDS_ANA0_EN_MB);
> +               udelay(2);
> +
> +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +                                  SUN4I_TCON0_LVDS_ANA0_EN_DRVC,
> +                                  SUN4I_TCON0_LVDS_ANA0_EN_DRVC);
> +
> +               if (sun4i_tcon_get_pixel_depth(encoder) == 18)
> +                       val = 7;
> +               else
> +                       val = 0xf;
> +
> +               regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +                                 SUN4I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
> +                                 SUN4I_TCON0_LVDS_ANA0_EN_DRVD(val));
> +       }
> +

I suggest moving the LVDS bits into a separate helper (or two) to be
called from sun4i_tcon_set_status().

>         sun4i_tcon_channel_set_status(tcon, channel, enabled);
>  }
>
> @@ -170,6 +253,78 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
>                      SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
>  }
>
> +static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
> +                                     const struct drm_encoder *encoder,
> +                                     const struct drm_display_mode *mode)
> +{
> +       unsigned int bp;
> +       u8 clk_delay;
> +       u32 reg, val = 0;
> +
> +       tcon->dclk_min_div = 7;
> +       tcon->dclk_max_div = 7;
> +       sun4i_tcon0_mode_set_common(tcon, mode);
> +
> +       /* Adjust clock delay */
> +       clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
> +       regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
> +                          SUN4I_TCON0_CTL_CLK_DELAY_MASK,
> +                          SUN4I_TCON0_CTL_CLK_DELAY(clk_delay));
> +
> +       /*
> +        * This is called a backporch in the register documentation,
> +        * but it really is the back porch + hsync
> +        */
> +       bp = mode->crtc_htotal - mode->crtc_hsync_start;
> +       DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
> +                        mode->crtc_htotal, bp);
> +
> +       /* Set horizontal display timings */
> +       regmap_write(tcon->regs, SUN4I_TCON0_BASIC1_REG,
> +                    SUN4I_TCON0_BASIC1_H_TOTAL(0x554) |
> +                    SUN4I_TCON0_BASIC1_H_BACKPORCH(0xa0));

Fixed, magic numbers?

> +
> +       /*
> +        * This is called a backporch in the register documentation,
> +        * but it really is the back porch + hsync
> +        */
> +       bp = mode->crtc_vtotal - mode->crtc_vsync_start;
> +       DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
> +                        mode->crtc_vtotal, bp);
> +
> +       /* Set vertical display timings */
> +       regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
> +                    SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal * 2) |
> +                    SUN4I_TCON0_BASIC2_V_BACKPORCH(0x17));

Same here. Are these left over from testing?

And the h/v sync stuff looks the same as for RGB. Can we move this
to the common function? Or does MIPI use something different?

> +
> +       reg = SUN4I_TCON0_LVDS_IF_CLK_SEL_TCON0 |
> +               SUN4I_TCON0_LVDS_IF_DATA_POL_NORMAL |
> +               SUN4I_TCON0_LVDS_IF_CLK_POL_NORMAL;
> +       if (sun4i_tcon_get_pixel_depth(encoder) == 24)
> +               reg |= SUN4I_TCON0_LVDS_IF_BITWIDTH_24BITS;
> +       else
> +               reg |= SUN4I_TCON0_LVDS_IF_BITWIDTH_18BITS;
> +
> +       regmap_write(tcon->regs, SUN4I_TCON0_LVDS_IF_REG, reg);
> +
> +       /* Setup the polarity of the various signals */
> +       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> +               val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> +
> +       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> +               val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> +
> +       regmap_write(tcon->regs, SUN4I_TCON0_IO_POL_REG, 0);
> +
> +       /* Map output pins to channel 0 */
> +       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
> +                          SUN4I_TCON_GCTL_IOMAP_MASK,
> +                          SUN4I_TCON_GCTL_IOMAP_TCON0);
> +
> +       /* Enable the output on the pins */
> +       regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0xe0000000);

Output pin settings look the same as well. Same question as above.

> +}
> +
>  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>                                      const struct drm_display_mode *mode)
>  {
> @@ -336,6 +491,9 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
>                          const struct drm_display_mode *mode)
>  {
>         switch (encoder->encoder_type) {
> +       case DRM_MODE_ENCODER_LVDS:
> +               sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
> +               break;
>         case DRM_MODE_ENCODER_NONE:
>                 sun4i_tcon0_mode_set_rgb(tcon, mode);
>                 sun4i_tcon_set_mux(tcon, 0, encoder);
> @@ -667,7 +825,9 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>         struct drm_device *drm = data;
>         struct sun4i_drv *drv = drm->dev_private;
>         struct sunxi_engine *engine;
> +       struct device_node *remote;
>         struct sun4i_tcon *tcon;
> +       bool has_lvds;
>         int ret;
>
>         engine = sun4i_tcon_find_engine(drv, dev->of_node);
> @@ -698,6 +858,26 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>                 return ret;
>         }
>
> +       /*
> +        * This can only be made optional since we've had DT nodes
> +        * without the LVDS reset properties.
> +        *
> +        * If the property is missing, just disable LVDS, and print a
> +        * warning.
> +        */
> +       tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
> +       if (IS_ERR(tcon->lvds_rst)) {
> +               dev_err(dev, "Couldn't get our reset line\n");
> +               return PTR_ERR(tcon->lvds_rst);
> +       } else if (tcon->lvds_rst) {
> +               has_lvds = true;
> +               reset_control_reset(tcon->lvds_rst);
> +       } else {
> +               has_lvds = false;
> +               dev_warn(dev,
> +                        "Missing LVDS reset property, you should consider upgrading your DT\n");
> +       }
> +
>         ret = sun4i_tcon_init_clocks(dev, tcon);
>         if (ret) {
>                 dev_err(dev, "Couldn't init our TCON clocks\n");
> @@ -729,7 +909,18 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>                 goto err_free_clocks;
>         }
>
> -       ret = sun4i_rgb_init(drm, tcon);
> +       /*
> +        * If we have an LVDS panel connected to the TCON, we should
> +        * just probe the LVDS connector. Otherwise, just probe RGB as
> +        * we used to.
> +        */
> +       remote = of_graph_get_remote_node(dev->of_node, 1, 0);
> +       if (has_lvds && of_device_is_compatible(remote, "panel-lvds"))

Is the compatible guaranteed? What about bridges?

Thanks
ChenYu

> +               ret = sun4i_lvds_init(drm, tcon);
> +       else
> +               ret = sun4i_rgb_init(drm, tcon);
> +       of_node_put(remote);
> +
>         if (ret < 0)
>                 goto err_free_clocks;
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index 4141fbd97ddf..382689e5396e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -70,7 +70,21 @@
>  #define SUN4I_TCON0_TTL2_REG                   0x78
>  #define SUN4I_TCON0_TTL3_REG                   0x7c
>  #define SUN4I_TCON0_TTL4_REG                   0x80
> +
>  #define SUN4I_TCON0_LVDS_IF_REG                        0x84
> +#define SUN4I_TCON0_LVDS_IF_EN                         BIT(31)
> +#define SUN4I_TCON0_LVDS_IF_BITWIDTH_MASK              BIT(26)
> +#define SUN4I_TCON0_LVDS_IF_BITWIDTH_18BITS            (1 << 26)
> +#define SUN4I_TCON0_LVDS_IF_BITWIDTH_24BITS            (0 << 26)
> +#define SUN4I_TCON0_LVDS_IF_CLK_SEL_MASK               BIT(20)
> +#define SUN4I_TCON0_LVDS_IF_CLK_SEL_TCON0              (1 << 20)
> +#define SUN4I_TCON0_LVDS_IF_CLK_POL_MASK               BIT(4)
> +#define SUN4I_TCON0_LVDS_IF_CLK_POL_NORMAL             (1 << 4)
> +#define SUN4I_TCON0_LVDS_IF_CLK_POL_INV                        (0 << 4)
> +#define SUN4I_TCON0_LVDS_IF_DATA_POL_MASK              GENMASK(3, 0)
> +#define SUN4I_TCON0_LVDS_IF_DATA_POL_NORMAL            (0xf)
> +#define SUN4I_TCON0_LVDS_IF_DATA_POL_INV               (0)
> +
>  #define SUN4I_TCON0_IO_POL_REG                 0x88
>  #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)           ((phase & 3) << 28)
>  #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE              BIT(25)
> @@ -131,6 +145,16 @@
>  #define SUN4I_TCON_CEU_RANGE_G_REG             0x144
>  #define SUN4I_TCON_CEU_RANGE_B_REG             0x148
>  #define SUN4I_TCON_MUX_CTRL_REG                        0x200
> +
> +#define SUN4I_TCON0_LVDS_ANA0_REG              0x220
> +#define SUN4I_TCON0_LVDS_ANA0_EN_MB                    BIT(31)
> +#define SUN4I_TCON0_LVDS_ANA0_EN_LDO                   BIT(30)
> +#define SUN4I_TCON0_LVDS_ANA0_EN_DRVC                  BIT(24)
> +#define SUN4I_TCON0_LVDS_ANA0_EN_DRVD(x)               (((x) & 0xf) << 20)
> +#define SUN4I_TCON0_LVDS_ANA0_C(x)                     (((x) & 3) << 17)
> +#define SUN4I_TCON0_LVDS_ANA0_V(x)                     (((x) & 3) << 8)
> +#define SUN4I_TCON0_LVDS_ANA0_PD(x)                    (((x) & 3) << 4)
> +
>  #define SUN4I_TCON1_FILL_CTL_REG               0x300
>  #define SUN4I_TCON1_FILL_BEG0_REG              0x304
>  #define SUN4I_TCON1_FILL_END0_REG              0x308
> @@ -174,6 +198,7 @@ struct sun4i_tcon {
>
>         /* Reset control */
>         struct reset_control            *lcd_rst;
> +       struct reset_control            *lvds_rst;
>
>         struct drm_panel                *panel;
>
> --
> git-series 0.9.1
