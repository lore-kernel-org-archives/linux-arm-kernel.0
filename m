From: eric@anholt.net (Eric Anholt)
Date: Thu, 07 Sep 2017 10:09:38 -0700
Subject: [PATCH 3/7 v3] drm/pl111: Replace custom connector with panel
 bridge
In-Reply-To: <20170907124925.13805-3-linus.walleij@linaro.org>
References: <20170907124925.13805-1-linus.walleij@linaro.org>
 <20170907124925.13805-3-linus.walleij@linaro.org>
Message-ID: <87ingul9kd.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This replaces the custom connector in the PL111 with the
> panel bridge helper.
>
> This works nicely for all standard panels, but since there
> are several PL11x-based systems that will need to use the dumb
> VGA connector bridge we use drm_of_find_panel_or_bridge()
> and make some headroom for dealing with bridges that are
> not panels as well, and drop a TODO in the code.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> +out_bridge:
> +	if (panel)
> +		drm_panel_bridge_remove(bridge);
> +	else
> +		drm_bridge_remove(bridge);

Drop the "else drm_bridge_remove(bridge)" here and in the hunk below --
that unregisters the bridge driver entirely, rather than unreferencing
it from your driver (there's no refcounting to be done).

With that change,

Reviewed-by: Eric Anholt <eric@anholt.net>

>  out_config:
>  	drm_mode_config_cleanup(dev);
>  finish:
> @@ -236,6 +250,10 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
>  	drm_dev_unregister(drm);
>  	if (priv->fbdev)
>  		drm_fbdev_cma_fini(priv->fbdev);
> +	if (priv->panel)
> +		drm_panel_bridge_remove(priv->bridge);
> +	else
> +		drm_bridge_remove(priv->bridge);
>  	drm_mode_config_cleanup(drm);
>  	drm_dev_unref(drm);
>  
> -- 
> 2.13.5
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170907/8755707f/attachment.sig>
