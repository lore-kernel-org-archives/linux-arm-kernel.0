From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 22 Jan 2014 17:45:05 +0300
Subject: [PATCHv6 4/7] staging: imx-drm: Use de-active and
 pixelclk-active display-timings.
In-Reply-To: <1390398511-8041-4-git-send-email-denis@eukrea.com>
References: <1390398511-8041-1-git-send-email-denis@eukrea.com>
 <1390398511-8041-4-git-send-email-denis@eukrea.com>
Message-ID: <20140122144505.GA7444@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:48:28PM +0100, Denis Carikli wrote:
> If de-active and/or pixelclk-active properties were set in the
> display-timings DT node, they were not used.
> 
> Instead the data-enable and the pixel data clock polarity
> were hardcoded.
> 
> This change is needed for making the eukrea-cpuimx51
>   QVGA display work.
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Eric B?nard <eric@eukrea.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: dri-devel at lists.freedesktop.org
> Cc: driverdev-devel at linuxdriverproject.org
> Cc: linux-arm-kernel at lists.infradead.org

These CC blocks are massive...  What's the point of them?

>  	if (np) {
>  		struct drm_display_mode *mode = drm_mode_create(connector->dev);
> +		struct device_node *timings_np;
> +		struct device_node *mode_np;
> +		u32 val;
> +
>  		of_get_drm_display_mode(np, &imxpd->mode, 0);
> +
> +		timings_np = of_get_child_by_name(np, "display-timings");
> +		if (timings_np) {
> +			/* get the display mode node */
> +			mode_np = of_parse_phandle(timings_np,
> +						   "native-mode", 0);
> +			if (!mode_np)
> +				mode_np = of_get_next_child(timings_np, NULL);
> +
> +			/* set de-active to 1 if not set */
> +			of_property_read_u32(mode_np, "de-active", &val);
> +			if (val) {

If of_property_read_u32() fails then val is uninitialized.

regards,
dan carpenter
