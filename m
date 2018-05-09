From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 9 May 2018 09:12:26 +0200
Subject: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
In-Reply-To: <20180507220413.21990-1-contact@paulk.fr>
References: <20180507220413.21990-1-contact@paulk.fr>
Message-ID: <20180509071226.ivh4s3wtczg2u7zw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
> as found on the Ainol AW1 tablet.
> 
> The panel also supports RGB888 output. When RGB666 mode is used instead,
> the two extra lanes per component are grounded.
> 
> In the future, it might become necessary to introduce a dedicated
> device-tree property to specify the bus format to use instead of the
> default one for the panel. This will allow supporting different bus
> formats for the same panel modes.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index cbf1ab404ee7..32e30d5a8f08 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn24 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
>  };
>  
> +static const struct drm_display_mode innolux_at070tn90_mode = {
> +	.clock = 40000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 112,
> +	.hsync_end = 800 + 112 + 1,
> +	.htotal = 800 + 112 + 1 + 87,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 141,
> +	.vsync_end = 480 + 141 + 1,
> +	.vtotal = 480 + 141 + 1 + 38,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc innolux_at070tn90 = {
> +	.modes = &innolux_at070tn90_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +};
> +

I'm not really convinced this is the right approach. You said it
yourself, the panel is using a 24-bits interface, and you just happen
to have a tablet that routed it using a 18-bits interface instead.

That doesn't belong in the driver, especially associated to the
compatible, but where the routing is described: in the device
tree. And given that the panel interface is a 24 bits panel, if we
were to have a default, we should have this one, and not the one
fitting your use case.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/e968d33b/attachment.sig>
