From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 3 Jul 2017 16:19:05 +0200
Subject: [PATCH 5/6] clk: at91: clk-generated: make gclk determine
 audio_pll rate
In-Reply-To: <20170623090059.8371-6-quentin.schulz@free-electrons.com>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
 <20170623090059.8371-6-quentin.schulz@free-electrons.com>
Message-ID: <20170703161905.5f994151@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jun 2017 11:00:58 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> This allows gclk to determine audio_pll rate and set the parent rate
> accordingly.
> 
> However, there are multiple children clocks that could technically
> change the rate of audio_pll. Since the clock rate is usually critical
> for IPs, it isn't a good idea to have multiple clocks changing audio_pll
> clock rate. There isn't any rate locking system for the moment, thus
> we enforce that classd_gclk be the only one allowed to change audio_pll
> rate. To remain consistent, we deny other clocks to be children of
> audio_pll so classd_gclk altering audio_pll rate does not impact any
> other device.
> 
> This needs to be re-worked once we have a rate locking system so two
> clocks could be children of the same clock and be sure the clock rate
> isn't changed by one or the other.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/clk/at91/clk-generated.c | 41 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 6530a2e7e84d..e66ee735a569 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -26,6 +26,9 @@
>  #define GENERATED_SOURCE_MAX	6
>  #define GENERATED_MAX_DIV	255
>  
> +#define GCK_ID_CLASSD		59
> +#define GCK_INDEX_DT_AUDIO_PLL	5
> +
>  struct clk_generated {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
> @@ -126,15 +129,14 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
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
> @@ -150,11 +152,37 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  		clk_generated_best_diff(req, parent, parent_rate, div,
>  					&best_diff, &best_rate);
>  
> +		if (!best_diff)
> +			break;
> +	}
> +
> +	/*
> +	 * The audio_pll rate can be modified unlike the five others clocks that
> +	 * should never be altered.
> +	 * The audio_pll can technically be used by multiple consumers. However,
> +	 * they all are likely to want to modify its rate while the rate is
> +	 * critical for each one. Since we do not have a rate locking for the
> +	 * moment, let classd_gclk be the only consumer of the audio_pll clock.
> +	 */
> +
> +	if (gck->id != GCK_ID_CLASSD)
> +		goto end;

As discussed on IRC with Nicolas and Cyrille, it seems we have other
potential users of the audio-pll: SSC and I2S. Can you extend the test
to let these GCK clks take the audio-pll?

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
> @@ -264,7 +292,8 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>  	init.ops = &generated_ops;
>  	init.parent_names = parent_names;
>  	init.num_parents = num_parents;
> -	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> +		CLK_SET_RATE_PARENT;
>  
>  	gck->id = id;
>  	gck->hw.init = &init;
