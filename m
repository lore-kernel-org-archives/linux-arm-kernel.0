From: andreas@fatal.se (Andreas Henriksson)
Date: Wed, 5 Nov 2014 14:12:07 +0100
Subject: [PATCH 1/2] clk: at91: usb: fix at91rm9200 round and set rate
In-Reply-To: <1415179995-25062-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415179995-25062-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141105131207.GA3726@mbpah.endian.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Just confirming this exact patch fixes the problem I was running into.

On Wed, Nov 05, 2014 at 10:33:14AM +0100, Boris Brezillon wrote:
> at91rm9200_clk_usb_set_rate might fail depending on the requested rate,
> because the parent_rate / rate remainder is not necessarily zero.
> Moreover, when rounding down the calculated rate we might alter the
> divisor calculation and end up with an invalid divisor.
> 
> To solve those problems, accept a non zero remainder, and always round
> division to the closest result.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Andreas Henriksson <andreas.henriksson@endian.se>

Tested-by: Andreas Henriksson <andreas.henriksson@endian.se>

> ---
>  drivers/clk/at91/clk-usb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index 24b5b02..5b3b63c 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -253,7 +253,7 @@ static long at91rm9200_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
>  
>  		tmp_parent_rate = rate * usb->divisors[i];
>  		tmp_parent_rate = __clk_round_rate(parent, tmp_parent_rate);
> -		tmprate = tmp_parent_rate / usb->divisors[i];
> +		tmprate = DIV_ROUND_CLOSEST(tmp_parent_rate, usb->divisors[i]);
>  		if (tmprate < rate)
>  			tmpdiff = rate - tmprate;
>  		else
> @@ -281,10 +281,10 @@ static int at91rm9200_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
>  	struct at91_pmc *pmc = usb->pmc;
>  	unsigned long div;
>  
> -	if (!rate || parent_rate % rate)
> +	if (!rate)
>  		return -EINVAL;
>  
> -	div = parent_rate / rate;
> +	div = DIV_ROUND_CLOSEST(parent_rate, rate);
>  
>  	for (i = 0; i < RM9200_USB_DIV_TAB_SIZE; i++) {
>  		if (usb->divisors[i] == div) {
> -- 
> 1.9.1
> 
