From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 10:07:59 +0200
Subject: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
In-Reply-To: <20180519183127.2718-7-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-7-jernej.skrabec@siol.net>
Message-ID: <20180521080759.rgviuva65ijcfm2e@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 08:31:18PM +0200, Jernej Skrabec wrote:
> If SoC has TCON TOP unit, it has to be configured from TCON, since it
> has all information needed. Additionally, if it is TCON TV, it must also
> enable bus gate inside TCON TOP unit.

Why?

> Add support for such TCONs.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  8 ++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 08747fc3ee71..e0c562ce1c22 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  		dev_err(dev, "Couldn't get the TCON bus clock\n");
>  		return PTR_ERR(tcon->clk);
>  	}
> +
> +	if (tcon->quirks->needs_tcon_top && tcon->quirks->has_channel_1) {
> +		tcon->top_clk = devm_clk_get(dev, "tcon-top");
> +		if (IS_ERR(tcon->top_clk)) {
> +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> +			return PTR_ERR(tcon->top_clk);
> +		}
> +		clk_prepare_enable(tcon->top_clk);
> +	}
> +
>  	clk_prepare_enable(tcon->clk);
>  
>  	if (tcon->quirks->has_channel_0) {
> @@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
>  {
>  	clk_disable_unprepare(tcon->clk);
> +	clk_disable_unprepare(tcon->top_clk);
>  }
>  
>  static int sun4i_tcon_init_irq(struct device *dev,
> @@ -980,6 +991,23 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  	tcon->id = engine->id;
>  	tcon->quirks = of_device_get_match_data(dev);
>  
> +	if (tcon->quirks->needs_tcon_top) {
> +		struct device_node *np;
> +
> +		np = of_parse_phandle(dev->of_node, "allwinner,tcon-top", 0);
> +		if (np) {
> +			struct platform_device *pdev;
> +
> +			pdev = of_find_device_by_node(np);
> +			if (pdev)
> +				tcon->tcon_top = platform_get_drvdata(pdev);
> +			of_node_put(np);
> +
> +			if (!tcon->tcon_top)
> +				return -EPROBE_DEFER;
> +		}
> +	}
> +

I might have missed it, but I've not seen the bindings additions for
that property. This shouldn't really be done that way anyway, instead
of using a direct phandle, you should be using the of-graph, with the
TCON-top sitting where it belongs in the flow of data.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/9e6fce45/attachment.sig>
