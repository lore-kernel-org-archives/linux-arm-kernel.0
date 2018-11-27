From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:24:28 +0100
Subject: [PATCH v2 34/43] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
In-Reply-To: <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
Message-ID: <20181127092428.z7p4mxnf3jxuqcv7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:25:06AM +0100, Paul Kocialkowski wrote:
> This introduces stride and offset configuration for the VPU tiling mode.
> Stride is calculated differently than it is for linear formats and an
> offset is calculated, for which new register definitions are introduced.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  7 ++++
>  2 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> index efa1ff0802bd..3f76a5572449 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -125,21 +125,69 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
>  {
>  	struct drm_plane_state *state = plane->state;
>  	struct drm_framebuffer *fb = state->fb;
> +	unsigned int strides[3] = {};
> +
>  	dma_addr_t paddr;
>  	bool swap;
>  
> +	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
> +		unsigned int width = state->src_w >> 16;
> +		unsigned int offset;
> +
> +		/*
> +		 * In MB32 tiled mode, the stride is defined as the distance
> +		 * between the start of the end line of the current tile and
> +		 * the start of the first line in the next vertical tile.
> +		 *
> +		 * Tiles are represented in row-major order, thus the end line
> +		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
> +		 * the next vertical tile starts at: 32-bit-aligned-width * 32
> +		 * and the distance is: 32 * (32-bit-aligned-width - 31).
> +		 */
> +
> +		strides[0] = (fb->pitches[0] - 31) * 32;
> +
> +		/* Offset of the bottom-right point in the end tile. */
> +		offset = (width + (32 - 1)) & (32 - 1);

Those computations are a bit obscure. I guess adding a bunch of
defines, and using the round_up / _down and ALIGN macros would help

> +		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
> +			     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +
> +		if (fb->format->num_planes > 1) {
> +			strides[1] = (fb->pitches[1] - 31) * 32;
> +
> +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
> +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +		}
> +
> +		if (fb->format->num_planes > 2) {
> +			strides[2] = (fb->pitches[2] - 31) * 32;
> +
> +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
> +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> +		}

I guess we could fall in a situation where this is not cleared when
moving from a format with 3 planes to one with 2 for example. Would
that break anything?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/39f6aae5/attachment.sig>
