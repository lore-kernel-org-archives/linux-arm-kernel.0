From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 27 Sep 2018 18:58:53 +0200
Subject: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
In-Reply-To: <20180927114850.24565-8-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com>
Message-ID: <20180927165853.dpluekbqzat663q7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
> TCON DRQ set bits for non-burst DSI mode can computed via
> horizontal front porch instead of front porch + sync timings.
>
> Since there no documentation for TCON_DRQ_REG(0x7c) register
> this change is taken as reference from BPI-M64-bsp.

Detailing more what the issue is would be great.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 599284971ab6..9918fdb990ff 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>  	struct mipi_dsi_device *device = dsi->device;
>  	u32 val = 0;

The computation here is in the A64 driver:

if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
	dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode = 0;
} else {
	dsi_dev[sel]->dsi_tcon_drq.bits.drq_set	=
		(panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
		dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
}

It is testing that the sync + front porch is smaller than 21, and
otherwise sets the drq.

> -	if ((mode->hsync_end - mode->hdisplay) > 20) {

My code here is testing that the difference between hsync_end and
hdisplay is superior to 20, and sets the DRQ if true. The condition is
reversed, but otherwise, that difference is the front porch plus the
sync length.

> +	if ((mode->hsync_start - mode->hdisplay) > 20) {

However, you are testing for just the front porch, unlike what your
commit log is saying, and unlike what allwinner's code is saying. So
this deserves some explanation.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
