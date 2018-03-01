From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 12:48:55 +0100
Subject: [PATCH] pinctrl: sunxi: always look for apb block
In-Reply-To: <20180301113701.8888-1-andre.przywara@arm.com>
References: <20180301113701.8888-1-andre.przywara@arm.com>
Message-ID: <20180301114855.s7rbk7wiealepqrf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 01, 2018 at 11:37:01AM +0000, Andre Przywara wrote:
> The Allwinner pinctrl device tree binding suggests that a clock named
> "apb" would drive the pin controller IP. However (for legacy reasons) we
> rely on this clock actually being the first clock defined.
> Since named clocks can be in any order, let's explicitly check for a
> clock called "apb" first, then revert to using the first (and only!)
> clock to keep compatibility with older DTs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 4b6cb25bc796..897ba13e6a03 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -1360,10 +1360,21 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>  			goto gpiochip_error;
>  	}
>  
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get(&pdev->dev, "apb");
>  	if (IS_ERR(clk)) {
> -		ret = PTR_ERR(clk);
> -		goto gpiochip_error;
> +		/*
> +		 * If no "apb" clock can be found, try the first one, which
> +		 * must be the only one defined.
> +		 */
> +		if (PTR_ERR(clk) == -ENOENT &&
> +		    of_count_phandle_with_args(node, "clocks",
> +					       "#clock-cells") == 1)
> +			clk = devm_clk_get(&pdev->dev, NULL);
> +
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			goto gpiochip_error;
> +		}

I guess this can be made slightly less convoluted using something like

ret = of_count_phandle_with_args(node, "clocks", "#clock-cells");
clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/bd3a1390/attachment.sig>
