From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 25 Apr 2018 14:05:08 +0200
Subject: [PATCH net 1/3] net: mvpp2: Fix clk error path in mvpp2_probe
In-Reply-To: <20180425110731.20153-2-maxime.chevallier@bootlin.com> (Maxime
 Chevallier's message of "Wed, 25 Apr 2018 13:07:29 +0200")
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
 <20180425110731.20153-2-maxime.chevallier@bootlin.com>
Message-ID: <87efj3ebkb.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
 
 On mer., avril 25 2018, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When clk_prepare_enable fails for the axi_clk, the mg_clk isn't properly
> cleaned up. Add another jump label to handle that case, and make sure we
> jump to it in the later error cases.
>
> Fixes: 4792ea04bcd0 ("net: mvpp2: Fix clock resource by adding an optional bus clock")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 4202f9b5b966..0c2f04813d42 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -8774,12 +8774,12 @@ static int mvpp2_probe(struct platform_device *pdev)
>  		if (IS_ERR(priv->axi_clk)) {
>  			err = PTR_ERR(priv->axi_clk);
>  			if (err == -EPROBE_DEFER)
> -				goto err_gop_clk;
> +				goto err_mg_clk;
>  			priv->axi_clk = NULL;
>  		} else {
>  			err = clk_prepare_enable(priv->axi_clk);
>  			if (err < 0)
> -				goto err_gop_clk;
> +				goto err_mg_clk;
>  		}
>  
>  		/* Get system's tclk rate */
> @@ -8793,7 +8793,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>  	if (priv->hw_version == MVPP22) {
>  		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
>  		if (err)
> -			goto err_mg_clk;
> +			goto err_axi_clk;
>  		/* Sadly, the BM pools all share the same register to
>  		 * store the high 32 bits of their address. So they
>  		 * must all have the same high 32 bits, which forces
> @@ -8801,14 +8801,14 @@ static int mvpp2_probe(struct platform_device *pdev)
>  		 */
>  		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>  		if (err)
> -			goto err_mg_clk;
> +			goto err_axi_clk;
>  	}
>  
>  	/* Initialize network controller */
>  	err = mvpp2_init(pdev, priv);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to initialize controller\n");
> -		goto err_mg_clk;
> +		goto err_axi_clk;
>  	}
>  
>  	/* Initialize ports */
> @@ -8821,7 +8821,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>  	if (priv->port_count == 0) {
>  		dev_err(&pdev->dev, "no ports enabled\n");
>  		err = -ENODEV;
> -		goto err_mg_clk;
> +		goto err_axi_clk;
>  	}
>  
>  	/* Statistics must be gathered regularly because some of them (like
> @@ -8849,8 +8849,9 @@ static int mvpp2_probe(struct platform_device *pdev)
>  			mvpp2_port_remove(priv->port_list[i]);
>  		i++;
>  	}
> -err_mg_clk:
> +err_axi_clk:
>  	clk_disable_unprepare(priv->axi_clk);
> +err_mg_clk:
>  	if (priv->hw_version == MVPP22)
>  		clk_disable_unprepare(priv->mg_clk);
>  err_gop_clk:
> -- 
> 2.11.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
