From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Apr 2018 18:32:53 +0100
Subject: [PATCH v2] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
In-Reply-To: <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
Message-ID: <20180424173253.GF22073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 06:16:05PM +0200, Stefan Potyra wrote:

> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate = clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk = devm_clk_get(dev, "pll");
> @@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  	}
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -

We can return an error after the clock was enabled, this will leake the
clock if that happens.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/092def40/attachment.sig>
