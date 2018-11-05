From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 11:40:13 +0100
Subject: [PATCH 03/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
In-Reply-To: <20181103100900.30313-4-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-4-jagan@amarulasolutions.com>
Message-ID: <20181105104013.lvijeim57vojjfip@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2018 at 03:38:53PM +0530, Jagan Teki wrote:
> Burst mode display timings are different from convectional
> video mode so update the horizontal and vertical timings.
> 
> Reference code taken from BSP
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_hsa  = 0;
> dsi_hbp  = 0;
> dsi_hact = x*dsi_pixel_bits[format]/8;
> dsi_hblk = dsi_hact;
> dsi_hfp  = 0;
> dsi_vblk = 0;
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 108 ++++++++++++++-----------
>  1 file changed, 60 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 077b57ec964c..4965b2c71e4c 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -479,59 +479,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  
>  	/* Do all timing calculations up front to allocate buffer space */
>  
> -	/*
> -	 * A sync period is composed of a blanking packet (4 bytes +
> -	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> -	 * minimal size is therefore 10 bytes
> -	 */
> +	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST) {
> +		hsa = 0;
> +		hbp = 0;
> +		hblk = mode->hdisplay * Bpp;
> +		hfp = 0;
> +		vblk = 0;
> +	} else {
> +		/*
> +		 * A sync period is composed of a blanking packet (4 bytes +
> +		 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> +		 * minimal size is therefore 10 bytes
> +		 */
>  #define HSA_PACKET_OVERHEAD	10
> -	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> -		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> -
> -	/*
> -	 * The backporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> +			  (mode->hsync_end - mode->hsync_start) * Bpp -
> +			  HSA_PACKET_OVERHEAD);
> +
> +		/*
> +		 * The backporch is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 */
>  #define HBP_PACKET_OVERHEAD	6
> -	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> -		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> -
> -	/*
> -	 * hblk seems to be the line + porches length.
> -	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
> -	 * payload + 2 bytes). So minimal size is 10 bytes
> -	 */
> +		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> +			  (mode->htotal - mode->hsync_end) * Bpp -
> +			  HBP_PACKET_OVERHEAD);
> +
> +		/*
> +		 * hblk seems to be the line + porches length.
> +		 * The blank is set using a blanking packet (4 bytes + 4 bytes
> +		 * + payload + 2 bytes). So minimal size is 10 bytes
> +		 */
>  #define HBLK_PACKET_OVERHEAD	10
> -	hblk_max = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> -	hblk_max -= HBLK_PACKET_OVERHEAD;
> -	hblk = max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
> -
> -	/*
> -	 * The frontporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 *
> -	 * According to BSP code, extra 10 bytes(which is hblk packet overhead)
> -	 * is adding for hfp packet overhead since hfp depends on hblk.
> -	 */
> +		hblk_max = (mode->htotal -
> +			   (mode->hsync_end - mode->hsync_start)) * Bpp;
> +		hblk_max -= HBLK_PACKET_OVERHEAD;
> +		hblk = max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
> +
> +		/*
> +		 * The frontporch is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 *
> +		 * According to BSP code, extra 10 bytes(which is hblk packet
> +		 * overhead) is adding for hfp packet overhead since hfp
> +		 * depends on hblk.
> +		 */
>  #define HFP_PACKET_OVERHEAD	6
> -	hfp_pkt_overhead = (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
> -	hfp = max((unsigned int)hfp_pkt_overhead,
> -		  (mode->hsync_start - mode->hdisplay) * Bpp -
> -		  hfp_pkt_overhead);
> -
> -	/*
> -	 * The vertical blank is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hfp_pkt_overhead = (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
> +		hfp = max((unsigned int)hfp_pkt_overhead,
> +			  (mode->hsync_start - mode->hdisplay) * Bpp -
> +			  hfp_pkt_overhead);
> +
> +		/*
> +		 * The vertical blank is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 */
>  #define VBLK_PACKET_OVERHEAD	6
> -	if (device->lanes == 4) {
> -		int tmp;
> -
> -		tmp = (mode->htotal * Bpp) * mode->vtotal -
> -		      (hblk + VBLK_PACKET_OVERHEAD);
> -		vblk = (device->lanes - tmp % device->lanes);
> -	} else {
> -		vblk = 0;
> +		if (device->lanes == 4) {
> +			int tmp;
> +
> +			tmp = (mode->htotal * Bpp) * mode->vtotal -
> +			      (hblk + VBLK_PACKET_OVERHEAD);
> +			vblk = (device->lanes - tmp % device->lanes);
> +		} else {
> +			vblk = 0;
> +		}
>  	}

We should make this a couple of functions to make things more
readable.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/db64561b/attachment.sig>
