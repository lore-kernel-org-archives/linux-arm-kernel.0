From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 4 Jul 2017 22:39:59 +0200
Subject: [PATCH v2 6/9] clk: at91: clk-generated: make gclk determine
 audio_pll rate
In-Reply-To: <20170704115927.32662-7-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-7-quentin.schulz@free-electrons.com>
Message-ID: <20170704223959.5f4ded05@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue,  4 Jul 2017 13:59:24 +0200,
Quentin Schulz <quentin.schulz@free-electrons.com> a ?crit :

> This allows gclk to determine audio_pll rate and set the parent rate
> accordingly.
> 
> However, there are multiple children clocks that could technically
> change the rate of audio_pll (via gck). With the rate locking, the first
> consumer to enable the clock will be the one definitely setting the rate
> of the clock.
> 
> Since audio IPs are most likely to request the same rate, we enforce
> that the only clks able to modify gck rate are those of audio IPs.
> 
> To remain consistent, we deny other clocks to be children of audio_pll.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> 
> v2:
>   - added conditions for audio pll rate setting restriction for SSC and
> I2S,
> 
>  drivers/clk/at91/clk-generated.c | 48 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 6530a2e7e84d..87866786a6ab 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -26,6 +26,13 @@
>  #define GENERATED_SOURCE_MAX	6
>  #define GENERATED_MAX_DIV	255
>  
> +#define GCK_ID_SSC0		43
> +#define GCK_ID_SSC1		44
> +#define GCK_ID_I2S0		54
> +#define GCK_ID_I2S1		55
> +#define GCK_ID_CLASSD		59
> +#define GCK_INDEX_DT_AUDIO_PLL	5
> +
>  struct clk_generated {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
> @@ -126,15 +133,14 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  {
>  	struct clk_generated *gck = to_clk_generated(hw);
>  	struct clk_hw *parent = NULL;
> +	struct clk_rate_request req_parent = *req;
>  	long best_rate = -EINVAL;
> -	unsigned long min_rate;
> +	unsigned long min_rate, parent_rate;
>  	int best_diff = -1;
>  	int i;
> +	u32 div;
>  
> -	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> -		u32 div;
> -		unsigned long parent_rate;
> -
> +	for (i = 0; i < clk_hw_get_num_parents(hw) - 1; i++) {
>  		parent = clk_hw_get_parent_by_index(hw, i);
>  		if (!parent)
>  			continue;
> @@ -150,11 +156,40 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  		clk_generated_best_diff(req, parent, parent_rate, div,
>  					&best_diff, &best_rate);
>  
> +		if (!best_diff)
> +			break;
> +	}
> +
> +	/*
> +	 * The audio_pll rate can be modified, unlike the five others clocks
> +	 * that should never be altered.
> +	 * The audio_pll can technically be used by multiple consumers. However,
> +	 * with the rate locking, the first consumer to enable to clock will be
> +	 * the one definitely setting the rate of the clock.
> +	 * Since audio IPs are most likely to request the same rate, we enforce
> +	 * that the only clks able to modify gck rate are those of audio IPs.
> +	 */
> +
> +	if (gck->id != GCK_ID_SSC0 && gck->id != GCK_ID_SSC1 &&
> +	    gck->id != GCK_ID_I2S0 && gck->id != GCK_ID_I2S1 &&
> +	    gck->id != GCK_ID_CLASSD)
> +		goto end;
> +
> +	parent = clk_hw_get_parent_by_index(hw, GCK_INDEX_DT_AUDIO_PLL);
> +	if (!parent)
> +		goto end;
> +
> +	for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
> +		req_parent.rate = req->rate * div;
> +		__clk_determine_rate(parent, &req_parent);
> +		clk_generated_best_diff(req, parent, req_parent.rate, div,
> +					&best_diff, &best_rate);
>  
>  		if (!best_diff)
>  			break;
>  	}
>  
> +end:
>  	pr_debug("GCLK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
>  		 __func__, best_rate,
>  		 __clk_get_name((req->best_parent_hw)->clk),
> @@ -264,7 +299,8 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>  	init.ops = &generated_ops;
>  	init.parent_names = parent_names;
>  	init.num_parents = num_parents;
> -	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> +		CLK_SET_RATE_PARENT;
>  
>  	gck->id = id;
>  	gck->hw.init = &init;
