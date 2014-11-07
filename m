From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Nov 2014 18:51:39 +0100
Subject: [PATCH 2/2] clk: at91: usb: fix at91sam9x5 recalc, round and set
 rate
In-Reply-To: <1415179995-25062-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415179995-25062-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141107175139.GF4068@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 at 10:33:15 +0100, Boris Brezillon wrote :
> First check for rate == 0 in set_rate and round_rate to avoid div by zero.
> Then, in order to get the closest rate, round all divisions to the closest
> result instead of rounding them down.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/clk/at91/clk-usb.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index 5b3b63c..7980e8c 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -52,7 +52,8 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
>  
>  	tmp = pmc_read(pmc, AT91_PMC_USB);
>  	usbdiv = (tmp & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
> -	return parent_rate / (usbdiv + 1);
> +
> +	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
>  }
>  
>  static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -62,19 +63,19 @@ static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long bestrate;
>  	unsigned long tmp;
>  
> +	if (!rate)
> +		return DIV_ROUND_CLOSEST(*parent_rate, SAM9X5_USB_MAX_DIV + 1);
> +

Maybe I'm missing something but I would return -EINVAL here.

>  	if (rate >= *parent_rate)
>  		return *parent_rate;
>  
> -	div = *parent_rate / rate;
> -	if (div >= SAM9X5_USB_MAX_DIV)
> -		return *parent_rate / (SAM9X5_USB_MAX_DIV + 1);
> +	div = DIV_ROUND_CLOSEST(*parent_rate, rate);
> +	if (div > SAM9X5_USB_MAX_DIV + 1)
> +		div = SAM9X5_USB_MAX_DIV + 1;
> +	else if (!div)
> +		div = 1;

In that case, you are also screwed, I would return -EINVAL.

>  
> -	bestrate = *parent_rate / div;
> -	tmp = *parent_rate / (div + 1);
> -	if (bestrate - rate > rate - tmp)
> -		bestrate = tmp;
> -
> -	return bestrate;
> +	return DIV_ROUND_CLOSEST(*parent_rate, div);
>  }
>  
>  static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
> @@ -106,9 +107,13 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
>  	u32 tmp;
>  	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
>  	struct at91_pmc *pmc = usb->pmc;
> -	unsigned long div = parent_rate / rate;
> +	unsigned long div;
>  
> -	if (parent_rate % rate || div < 1 || div >= SAM9X5_USB_MAX_DIV)
> +	if (!rate)
> +		return -EINVAL;
> +
> +	div = DIV_ROUND_CLOSEST(parent_rate, rate);
> +	if (div > SAM9X5_USB_MAX_DIV + 1 || !div)
>  		return -EINVAL;
>  
>  	tmp = pmc_read(pmc, AT91_PMC_USB) & ~AT91_PMC_OHCIUSBDIV;
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
