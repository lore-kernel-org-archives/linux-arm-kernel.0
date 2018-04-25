From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Apr 2018 16:50:28 +0100
Subject: [PATCH v3] spi/bcm63xx-hspi: Enable the clock before calling
In-Reply-To: <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
Message-ID: <20180425155028.GF24769@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 03:47:30PM +0200, Stefan Potyra wrote:

> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate = clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk = devm_clk_get(dev, "pll");
>  
> -		if (IS_ERR(pll_clk))
> -			return PTR_ERR(pll_clk);
> +		if (IS_ERR(pll_clk)) {
> +			ret = PTR_ERR(pll_clk);
> +			goto out_disable_clk;
> +		}
> +
>  
>  		rate = clk_get_rate(pll_clk);

Isn't this just showing the same problem with not enabling the pll_clk
before getting the rate that you're trying to fix for the main clk?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/88181dcb/attachment-0001.sig>
