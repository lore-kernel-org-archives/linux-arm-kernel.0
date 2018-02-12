From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Mon, 12 Feb 2018 14:42:53 +0100
Subject: [PATCH] drm/pl111: Fix regression from fbdev CMA helper
In-Reply-To: <20180212124019.25268-1-linus.walleij@linaro.org>
References: <20180212124019.25268-1-linus.walleij@linaro.org>
Message-ID: <0a3e5888-e8fc-df25-377c-5259c767aeed@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 12.02.2018 13.40, skrev Linus Walleij:
> Commit d18df744de1a ("drm/pl111: Use drm_fb_cma_fbdev_init/fini()")
> refactored the driver to use fbdev handling in the core, but
> mistakedly limited the number of maximum connections to 0.
>
> Predictably, zero possible connections also gives zero
> framebuffers when using the system. So let's bump it to 1 so
> we get our framebuffer back.
>
> Cc: Noralf Tr?nnes <noralf@tronnes.org>
> Cc: Eric Anholt <eric@anholt.net>
> Fixes: d18df744de1a ("drm/pl111: Use drm_fb_cma_fbdev_init/fini()")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index acb738c69873..306ac7cabd90 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -138,7 +138,7 @@ static int pl111_modeset_init(struct drm_device *dev)
>   
>   	drm_mode_config_reset(dev);
>   
> -	drm_fb_cma_fbdev_init(dev, 32, 0);
> +	drm_fb_cma_fbdev_init(dev, 32, 1);
>   
>   	drm_kms_helper_poll_init(dev);
>   

Sorry about that.

I don't know how bridges work, but since it doesn't work this means that
there's no connector available at this point?

This is the arg docs:

 ?* @max_conn_count: Maximum number of connectors.
 ?*????????????????? @dev->mode_config.num_connector is used if this is 
zero.

Anyways:
Acked-by: Noralf Tr?nnes <noralf@tronnes.org>
