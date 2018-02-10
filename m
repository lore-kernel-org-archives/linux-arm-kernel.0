From: eric@anholt.net (Eric Anholt)
Date: Sat, 10 Feb 2018 17:14:30 +0000
Subject: [PATCH 3/3] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <20180206121854.4407-4-linus.walleij@linaro.org>
References: <20180206121854.4407-1-linus.walleij@linaro.org>
 <20180206121854.4407-4-linus.walleij@linaro.org>
Message-ID: <876074dax5.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> We were previously selecting 1024x768 and 32BPP as the default
> set-up for the PL111 consumers.
>
> This does not work on elder systems: the device tree bindings
> support a property "max-memory-bandwidth" in bytes/second that
> states that if you exceed this the memory bus will saturate.
> The result is flickering and unstable images.
>
> Parse the "max-memory-bandwidth" and respect it when
> intializing the driver. On the RealView PB11MP, Versatile and
> Integrator/CP we get a nice console as default with this code.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Exploit the new .mode_valid() callback we added to the
>   simple KMS helper.
> - Use the hardcoded bits per pixel per variant instead of
>   trying to be heuristic about this setting for now.
> ---
>  drivers/gpu/drm/pl111/pl111_display.c | 30 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm.h     |  1 +
>  drivers/gpu/drm/pl111/pl111_drv.c     |  6 ++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index d75923896609..a1ca9e1ffe15 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -50,6 +50,35 @@ irqreturn_t pl111_irq(int irq, void *data)
>  	return status;
>  }
>  
> +static enum drm_mode_status
> +pl111_mode_valid(struct drm_crtc *crtc,
> +		 const struct drm_display_mode *mode)
> +{
> +	struct drm_device *drm = crtc->dev;
> +	struct pl111_drm_dev_private *priv = drm->dev_private;
> +	u32 cpp = priv->variant->fb_bpp / 8;
> +	u64 bw;

Using the variant->fb_bpp for mode_valid checks here feels wrong to me
-- it means a larger mode wouldn't be considered valid on a
32bpp-preferred platform when 16bpp would make it work, and a 16bpp
platform will happily try to set a 32bpp mode that exceeds the
bandwidth.

On the other hand, if it makes things work most of the time I'm also
kind of OK with it.  Anyone else want to chime in here?

> +	/*
> +	 * We use the pixelclock to also account for interlaced modes, the
> +	 * resulting bandwidth is in bytes per second.
> +	 */
> +	bw = mode->clock * 1000; /* In Hz */
> +	bw = bw * mode->hdisplay * mode->vdisplay * cpp;
> +	bw = div_u64(bw, mode->htotal * mode->vtotal);
> +
> +	if (bw > priv->memory_bw) {
> +		DRM_DEBUG("%d x %d @ %d Hz, %d cpp, bw %llu too fast\n",
> +			  mode->hdisplay, mode->vdisplay, mode->clock, cpp, bw);
> +
> +		return MODE_BAD;
> +	}
> +	DRM_DEBUG("%d x %d @ %d Hz, %d cpp, bw %llu bytes/s OK\n",
> +		  mode->hdisplay, mode->vdisplay, mode->clock, cpp, bw);
> +
> +	return MODE_OK;
> +}

Maybe DRM_DEBUG_KMS for these?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180210/4df74e8d/attachment.sig>
