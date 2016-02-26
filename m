From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Feb 2016 12:34:34 +0200
Subject: [PATCH 3/7 v2] video: ARM CLCD: support DT signal inversion flags
In-Reply-To: <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <56D02A3A.6010701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/02/16 12:01, Linus Walleij wrote:
> The device tree bindings from display-timing.txt allows us to
> specify if data enable, hsync, vsync or the pixed clock should be
> inverted on the way to the display. The driver does not currently
> handle this so add support for those flags as it is needed for
> the Versatile Sanyo LCD display.
> 
> Note that the previous behaviour was to invert the pixel clock
> for all displays, so unless the pixel clock polarity is
> explicitly defined in the device tree (i.e. the timings node
> has the "pixelclk-active" property) we fall back to inverting
> the pixel clock. This needs some extra compatibility code.
> 
> Since the timing flags have to be set up inside the struct
> clcd_panel, we need to refactor the code a bit to pass around
> the panel rather than just the mode.
> 
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - No changes. Just reposting.
> ---
>  drivers/video/fbdev/amba-clcd.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
> index c5d1e9ca81ab..8903a42c4122 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -567,10 +567,11 @@ static int clcdfb_register(struct clcd_fb *fb)
>  
>  #ifdef CONFIG_OF
>  static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
> -		struct fb_videomode *mode)
> +		struct clcd_panel *clcd_panel)
>  {
>  	int err;
>  	struct display_timing timing;
> +	struct device_node *timnp;
>  	struct videomode video;
>  
>  	err = of_get_display_timing(node, "panel-timing", &timing);
> @@ -579,10 +580,34 @@ static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
>  
>  	videomode_from_timing(&timing, &video);
>  
> -	err = fb_videomode_from_videomode(&video, mode);
> +	err = fb_videomode_from_videomode(&video, &clcd_panel->mode);
>  	if (err)
>  		return err;
>  
> +	/* Set up some inversion flags */
> +	timnp = of_get_child_by_name(node, "panel-timing");
> +	if (timnp && of_property_read_bool(timnp, "pixelclk-active")) {

Hmm, why are you poking in the videomode DT properties directly? If the
pixelclk-active was not defined in the DT, you should see it in the
videomode struct as neither DISPLAY_FLAGS_PIXDATA_POSEDGE nor
DISPLAY_FLAGS_PIXDATA_NEGEDGE being set (I think, I didn't go through
the code in detail).

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/de0044c5/attachment.sig>
