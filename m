From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:00:27 +0100
Subject: [PATCH v2 27/43] drm/sun4i: frontend: Add support for
 semi-planar YUV input formats
In-Reply-To: <20181123092515.2511-28-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-28-paul.kocialkowski@bootlin.com>
Message-ID: <20181127090027.mezxdx4s77ylj762@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:59AM +0100, Paul Kocialkowski wrote:
> Semi-planar YUV formats use two distinct planes, one for luminance and
> one for chrominance. To add support for them, we need to configure the
> second line stride and buffer address registers to setup the second YUV
> plane.
> 
> New definitions are introduced to configure the input format register
> for the YUV420 and YUV422 semi-planar formats.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 52 +++++++++++++++++++++++---
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 +++
>  drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 ++
>  3 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> index f443e8e1d8ec..e31438e5cabd 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -118,11 +118,23 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
>  	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
>  		     fb->pitches[0]);
>  
> +	if (fb->format->num_planes > 1)
> +		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
> +			     fb->pitches[1]);
> +
>  	/* Set the physical address of the buffer in memory */
>  	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
>  	paddr -= PHYS_OFFSET;
> -	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
> +	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
>  	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
> +
> +	if (fb->format->num_planes > 1) {
> +		paddr = drm_fb_cma_get_gem_addr(fb, state, 1);
> +		paddr -= PHYS_OFFSET;
> +		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
> +		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
> +			     paddr);
> +	}
>  }
>  EXPORT_SYMBOL(sun4i_frontend_update_buffer);
>  
> @@ -130,6 +142,8 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
>  {
>  	if (!drm_format_is_yuv(fmt))
>  		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
> +	else if (drm_format_is_yuv_sampling_420(fmt))
> +		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
>  	else if (drm_format_is_yuv_sampling_422(fmt))
>  		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
>  	else
> @@ -140,12 +154,20 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
>  
>  static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
>  {
> -	if (drm_format_num_planes(fmt) == 1)
> +	int num_planes = drm_format_num_planes(fmt);
> +
> +	switch (num_planes) {
> +	case 1:

You seem to use either the helper or retrieve the structure field
directly to access the number of planes. I'm fine either way, but this
should be consistent.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/5c6b5d9f/attachment.sig>
