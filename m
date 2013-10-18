From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Oct 2013 21:12:59 +0200
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131018203555.4d974251@armhf>
References: <20131018203555.4d974251@armhf>
Message-ID: <20131018191259.GF10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Oct 18, 2013 at 08:35:55PM +0200, Jean-Francois Moine wrote:
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index 8ac89f5..2bbbab5 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -496,15 +496,13 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  		return err;
>  
>  	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> -	if (!IS_ERR(priv->extclk)) {
> -		if (priv->extclk == priv->clk) {
> -			devm_clk_put(&pdev->dev, priv->extclk);
> -			priv->extclk = ERR_PTR(-EINVAL);
> -		} else {
> -			dev_info(&pdev->dev, "found external clock\n");
> -			clk_prepare_enable(priv->extclk);
> -			soc_dai = &kirkwood_i2s_dai_extclk;
> -		}
> +	if (IS_ERR(priv->extclk)) {
> +		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
Maybe the better logic here is:
		if (!PTR_ERR(priv->extclk) == -ENOENT)
			return PTR_ERR(priv->extclk);

?

> +	} else {
> +		dev_info(&pdev->dev, "found external clock\n");
> +		clk_prepare_enable(priv->extclk);
> +		soc_dai = kirkwood_i2s_dai_extclk;
Another todo (that is already in the patched code) is that you should
check the return value of clk_prepare_enable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
