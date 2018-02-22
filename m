From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Feb 2018 12:30:54 -0800
Subject: [PATCH 3/3] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <20180206121854.4407-4-linus.walleij@linaro.org>
References: <20180206121854.4407-1-linus.walleij@linaro.org>
 <20180206121854.4407-4-linus.walleij@linaro.org>
Message-ID: <87k1v4sr5t.fsf@anholt.net>
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

> +	if (bw > priv->memory_bw) {
> +		DRM_DEBUG("%d x %d @ %d Hz, %d cpp, bw %llu too fast\n",
> +			  mode->hdisplay, mode->vdisplay, mode->clock, cpp, bw);
> +
> +		return MODE_BAD;
> +	}

Oh, hey, on platforms with no memory-bandwidth property, we should make
sure not to reject all modes :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/15494b96/attachment.sig>
