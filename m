From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Aug 2017 10:38:20 -0700
Subject: [PATCH 3/7] drm/pl111: Replace custom connector with panel bridge
In-Reply-To: <20170830180711.2791-4-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
 <20170830180711.2791-4-linus.walleij@linaro.org>
Message-ID: <87h8wnzlgz.fsf@anholt.net>
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

> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index c6ca4f1bbd49..ef86ef60aed1 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -93,7 +93,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>  	struct pl111_drm_dev_private *priv = drm->dev_private;
>  	const struct drm_display_mode *mode = &cstate->mode;
>  	struct drm_framebuffer *fb = plane->state->fb;
> -	struct drm_connector *connector = &priv->connector.connector;
> +	struct drm_connector *connector = priv->connector;
>  	u32 cntl;
>  	u32 ppl, hsw, hfp, hbp;
>  	u32 lpp, vsw, vfp, vbp;
> @@ -155,7 +155,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>  
>  	writel(0, priv->regs + CLCD_TIM3);
>  
> -	drm_panel_prepare(priv->connector.panel);
> +	drm_panel_prepare(priv->panel);

If we're moving to panel-bridge, then we should drop our manual panel
prepare/enable/disable calls -- the panel-bridge will have already
panel_prepare()d before our encoder's enable, and will panel_enable()
after we finish.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/a301ad01/attachment.sig>
