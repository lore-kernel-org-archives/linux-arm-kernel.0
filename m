From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 25 Jul 2017 17:28:02 +0200
Subject: [PATCH v4 1/9] clk: at91: clk-generated: remove useless divisor
 loop
In-Reply-To: <b9d92004d22f745e8acde0599359d67538c006a9.1500968090.git-series.quentin.schulz@free-electrons.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <b9d92004d22f745e8acde0599359d67538c006a9.1500968090.git-series.quentin.schulz@free-electrons.com>
Message-ID: <4bffddd0-cf9d-8f68-204a-f754f7f384d5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/2017 at 09:37, Quentin Schulz wrote:
> The driver requests the current clk rate of each of its parent clocks to
> decide whether a clock rate is suitable or not. It does not request
> determine_rate from a parent clock which could request a rate change in
> parent clock (i.e. there is no parent rate propagation).
> 
> We know the rate we want (passed along req argument of the function) and
> the parent clock rate, thus we know the closest rounded divisor, we
> don't need to iterate over the available divisors to find the best one
> for a given clock.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index f0b7ae9..ef4b4e0 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -124,19 +124,18 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  		    (gck->range.max && min_rate > gck->range.max))
>  			continue;
>  
> -		for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
> -			tmp_rate = DIV_ROUND_CLOSEST(parent_rate, div);
> -			tmp_diff = abs(req->rate - tmp_rate);
> -
> -			if (best_diff < 0 || best_diff > tmp_diff) {
> -				best_rate = tmp_rate;
> -				best_diff = tmp_diff;
> -				req->best_parent_rate = parent_rate;
> -				req->best_parent_hw = parent;
> -			}
> -
> -			if (!best_diff || tmp_rate < req->rate)
> -				break;
> +		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
> +		if (!div)
> +			tmp_rate = parent_rate;
> +		else
> +			tmp_rate = parent_rate / div;
> +		tmp_diff = abs(req->rate - tmp_rate);
> +
> +		if (best_diff < 0 || best_diff > tmp_diff) {
> +			best_rate = tmp_rate;
> +			best_diff = tmp_diff;
> +			req->best_parent_rate = parent_rate;
> +			req->best_parent_hw = parent;
>  		}
>  
>  		if (!best_diff)
> 


-- 
Nicolas Ferre
