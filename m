From: eric@anholt.net (Eric Anholt)
Date: Thu, 11 Jan 2018 12:19:53 -0800
Subject: [PATCH 4/4 v6] drm/pl111: Support handling bridge timings
In-Reply-To: <20180110141226.27826-4-linus.walleij@linaro.org>
References: <20180110141226.27826-1-linus.walleij@linaro.org>
 <20180110141226.27826-4-linus.walleij@linaro.org>
Message-ID: <87h8rsup06.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> If the bridge has a too strict setup time for the incoming
> signals, we may not be fast enough and then we need to
> compensate by outputting the signal on the inverse clock
> edge so it is for sure stable when the bridge samples it.
>
> Since bridges in difference to panels does not expose their
> connectors, make the connector optional in the display
> setup code.
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v5->v6:
> - Collect Laurent's ACK.
> ChangeLog v4->v5:
> - Use the new bridge timings setup method.
> ---
>  drivers/gpu/drm/pl111/Kconfig         |  1 +
>  drivers/gpu/drm/pl111/pl111_display.c | 35 +++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/pl111/pl111_drv.c     | 20 +++++++++++---------
>  3 files changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index e5e2abd66491..82cb3e60ddc8 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -8,6 +8,7 @@ config DRM_PL111
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_BRIDGE
>  	select DRM_PANEL_BRIDGE
> +	select DRM_DUMB_VGA_DAC
>  	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option for DRM support for the PL111 CLCD controller.

Should this be in PL111, or in whatever machine is a consumer of this
driver plus a dumb dac?  I'm OK either way, it's not a big deal for the
platform I've got.

> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index 201d57d5cb54..101a9c7db6ff 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -107,11 +107,17 @@ static int pl111_modeset_init(struct drm_device *dev)
>  			ret = PTR_ERR(bridge);
>  			goto out_config;
>  		}
> -		/*
> -		 * TODO: when we are using a different bridge than a panel
> -		 * (such as a dumb VGA connector) we need to devise a different
> -		 * method to get the connector out of the bridge.
> -		 */
> +	} else if (bridge) {
> +		dev_info(dev->dev, "Using non-panel bridge\n");

This looks like it might be a debug printf you didn't intend to leave
in.  Either way, the patch gets my:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/96e62f62/attachment.sig>
