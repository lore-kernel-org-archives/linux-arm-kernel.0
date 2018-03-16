From: davem@davemloft.net (David Miller)
Date: Fri, 16 Mar 2018 15:27:12 -0400 (EDT)
Subject: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
In-Reply-To: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
Message-ID: <20180316.152712.1584177628223195375.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 14 Mar 2018 22:09:34 +0100

> diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
> index 16f9bee992fe..8ee9dfd0e363 100644
> --- a/drivers/net/ethernet/arc/emac_rockchip.c
> +++ b/drivers/net/ethernet/arc/emac_rockchip.c
> @@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
>  	/* Optional regulator for PHY */
>  	priv->regulator = devm_regulator_get_optional(dev, "phy");
>  	if (IS_ERR(priv->regulator)) {
> -		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
> +			ret = -EPROBE_DEFER;
> +			goto out_clk_disable;
> +		}

Please build test your changes.

There is no 'ret' variable in this function, perhaps you meant 'err'.
