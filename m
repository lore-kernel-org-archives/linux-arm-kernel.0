From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 11 Apr 2013 17:17:50 +0530
Subject: [PATCH 2/3] clk: composite: allow fixed rates & fixed dividers
In-Reply-To: <1365631378-16103-3-git-send-email-mturquette@linaro.org>
References: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
 <1365631378-16103-1-git-send-email-mturquette@linaro.org>
 <1365631378-16103-3-git-send-email-mturquette@linaro.org>
Message-ID: <5166A2E6.70907@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013 03:32 AM, Mike Turquette wrote:
> The composite clock assumes that any clock implementing the .recalc_rate
> callback will also implement .round_rate and .set_rate.  This is not
> always true; the basic fixed-rate clock will only implement .recalc_rate
> and a fixed-divider clock may choose to implement .recalc_rate and
> .round_rate but not .set_rate.
>
> Fix this by conditionally registering .round_rate and .set_rate
> callbacks based on the rate_ops passed in to clk_composite_register.
>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Emilio L?pez <emilio@elopez.com.ar>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   drivers/clk/clk-composite.c |   13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 6f4728c..2779fb3 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -150,17 +150,22 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
>   	}
>   
>   	if (rate_hw && rate_ops) {
> -		if (!rate_ops->recalc_rate || !rate_ops->round_rate ||
> -		    !rate_ops->set_rate) {
> +		if (!rate_ops->recalc_rate) {
>   			clk = ERR_PTR(-EINVAL);
>   			goto err;
>   		}
>   
> +		/* .round_rate is a prerequisite for .set_rate */
> +		if (rate_ops->round_rate) {
> +			clk_composite_ops->round_rate = clk_composite_round_rate;
> +			if (rate_ops->set_rate) {
> +				clk_composite_ops->set_rate = clk_composite_set_rate;
> +			}
> +		}
> +

What if rate_ops has only recalc_rate and set_rate? clk_composite_ops 
will have only recalc_rate and it will pass the sanity check in clk_init 
and caller of clk_register_composite will expect set_rate to work.
We should check here if rate_ops has set_rate but not round_rate then 
return error.

>   		composite->rate_hw = rate_hw;
>   		composite->rate_ops = rate_ops;
>   		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
> -		clk_composite_ops->round_rate = clk_composite_round_rate;
> -		clk_composite_ops->set_rate = clk_composite_set_rate;
>   	}
>   
>   	if (gate_hw && gate_ops) {
