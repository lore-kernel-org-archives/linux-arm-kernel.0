From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 12:59:21 +0200
Subject: [PATCH] clk: at91: pll: fix input range validity check
In-Reply-To: <1427594023-9697-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1427594023-9697-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150618125921.0b807f39@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Mar 2015 03:53:43 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> The PLL impose a certain input range to work correctly, but it appears that
> this input range does not apply on the input clock (or parent clock) but
> on the input clock after it has passed the PLL divisor.
> Fix the implementation accordingly.

Ping (I was expecting this patch to be part of 4.1 :-/).

> 
> Cc: <stable@vger.kernel.org> # v3.14+
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Jonas Andersson <jonas@microbit.se>
> ---
>  drivers/clk/at91/clk-pll.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 6ec79db..cbbe403 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -173,8 +173,7 @@ static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
>  	int i = 0;
>  
>  	/* Check if parent_rate is a valid input rate */
> -	if (parent_rate < characteristics->input.min ||
> -	    parent_rate > characteristics->input.max)
> +	if (parent_rate < characteristics->input.min)
>  		return -ERANGE;
>  
>  	/*
> @@ -187,6 +186,15 @@ static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
>  	if (!mindiv)
>  		mindiv = 1;
>  
> +	if (parent_rate > characteristics->input.max) {
> +		tmpdiv = DIV_ROUND_UP(parent_rate, characteristics->input.max);
> +		if (tmpdiv > PLL_DIV_MAX)
> +			return -ERANGE;
> +
> +		if (tmpdiv > mindiv)
> +			mindiv = tmpdiv;
> +	}
> +
>  	/*
>  	 * Calculate the maximum divider which is limited by PLL register
>  	 * layout (limited by the MUL or DIV field size).



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
