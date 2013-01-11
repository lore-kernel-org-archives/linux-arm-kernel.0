From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 Jan 2013 14:13:53 +0100
Subject: [PATCH 2/4] RFC: drm/lcdc: add support for LCD panels (v2)
In-Reply-To: <1357704685-3600-3-git-send-email-robdclark@gmail.com>
References: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
 <1357704685-3600-3-git-send-email-robdclark@gmail.com>
Message-ID: <20130111131353.GA4247@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jan 08, 2013 at 10:11:23PM -0600, Rob Clark wrote:
> Add an output panel driver for LCD panels.  Tested with LCD3 cape on
> beaglebone.
> 
> TODO: need some way to control the appropriate backlight device
> TODO: probably want to make the DT bindings more generic for panel-info
> 
> v1: original
> v2: s/of_find_node_by_name()/of_get_child_by_name()/ from Pantelis
>     Antoniou
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

> +static enum drm_connector_status panel_connector_detect(
> +		struct drm_connector *connector,
> +		bool force)
> +{
> +	return connector_status_connected;
> +}
> +
> +/* maybe this should be helper in drm-core? */
> +static inline void copy_timings_to_drm(struct drm_display_mode *mode,
> +		struct display_timing *timing)
> +{

This actually is a helper already and is called of_get_drm_display_mode.

> +	mode->clock = timing->pixelclock.typ / 1000;
> +
> +	mode->hdisplay = timing->hactive.typ;
> +	mode->hsync_start = mode->hdisplay + timing->hfront_porch.typ;
> +	mode->hsync_end = mode->hsync_start + timing->hsync_len.typ;
> +	mode->htotal = mode->hsync_end + timing->hback_porch.typ;
> +
> +	mode->vdisplay = timing->vactive.typ;
> +	mode->vsync_start = mode->vdisplay + timing->vfront_porch.typ;
> +	mode->vsync_end = mode->vsync_start + timing->vsync_len.typ;
> +	mode->vtotal = mode->vsync_end + timing->vback_porch.typ;
> +
> +	mode->flags = 0;
> +
> +	if (timing->interlaced)
> +		mode->flags |= DRM_MODE_FLAG_INTERLACE;
> +
> +	if (timing->doublescan)
> +		mode->flags |= DRM_MODE_FLAG_DBLSCAN;
> +
> +	if (timing->hsync_pol_active)
> +		mode->flags |= DRM_MODE_FLAG_PHSYNC;
> +	else
> +		mode->flags |= DRM_MODE_FLAG_NHSYNC;
> +
> +	if (timing->vsync_pol_active)
> +		mode->flags |= DRM_MODE_FLAG_PVSYNC;
> +	else
> +		mode->flags |= DRM_MODE_FLAG_NVSYNC;
> +}
> +

[...]

> +
> +static struct of_device_id panel_of_match[];
> +
> +static int __devinit panel_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct panel_module *panel_mod;
> +	struct lcdc_module *mod;
> +	struct pinctrl *pinctrl;
> +	int ret = -EINVAL;
> +
> +	/* bail out early if no DT data: */
> +	if (!of_match_device(panel_of_match, &pdev->dev)) {
> +		dev_err(&pdev->dev, "device-tree data is missing\n");
> +		return -ENXIO;
> +	}

You wouldn't be here if the device didn't match. How about

	if (!node)
		return -ENXIO;

instead which prevents you from trying to probe the device when
somebody registered a device without dt support?
Same for the other platform devices in this series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
