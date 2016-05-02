From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 May 2016 13:13:37 +0200
Subject: [PATCH v2] clk: sunxi: predivider handling for factors clock
In-Reply-To: <1461084466-20889-2-git-send-email-vishnupatekar0510@gmail.com>
References: <1461084466-20889-1-git-send-email-vishnupatekar0510@gmail.com>
 <1461084466-20889-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160502111337.GR17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 20, 2016 at 12:47:46AM +0800, Vishnu Patekar wrote:
> For A31 ahb1 and a83t ahb1 clocks have predivider for certain parent.
> To handle this, this patch adds predivider table with parent index,
> prediv shift and width, parents with predivider will have nonzero width.
> 
> Rate adjustment is moved from clock specific recalc function to generic
> factors recalc. Also, adds prediv table for a31.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  drivers/clk/sunxi/clk-factors.c | 31 +++++++++++++++----------------
>  drivers/clk/sunxi/clk-factors.h | 10 +++++++++-
>  drivers/clk/sunxi/clk-sunxi.c   | 31 +++++++++----------------------
>  3 files changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index ddefe96..8f3b637 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -45,10 +45,12 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>  					     unsigned long parent_rate)
>  {
>  	u8 n = 1, k = 0, p = 0, m = 0;
> +	u8 par_index = 0;
>  	u32 reg;
>  	unsigned long rate;
>  	struct clk_factors *factors = to_clk_factors(hw);
>  	const struct clk_factors_config *config = factors->config;
> +	const struct clk_factors_prediv *prediv = factors->prediv_config;
>  
>  	/* Fetch the register value */
>  	reg = readl(factors->reg);
> @@ -63,24 +65,16 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>  	if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>  		p = FACTOR_GET(config->pshift, config->pwidth, reg);
>  
> -	if (factors->recalc) {
> -		struct factors_request factors_req = {
> -			.parent_rate = parent_rate,
> -			.n = n,
> -			.k = k,
> -			.m = m,
> -			.p = p,
> -		};
> -
> +	if (prediv) {
>  		/* get mux details from mux clk structure */
>  		if (factors->mux)
> -			factors_req.parent_index =
> -				(reg >> factors->mux->shift) &
> -				factors->mux->mask;
> -
> -		factors->recalc(&factors_req);
> +			par_index = (reg >> factors->mux->shift) &
> +					factors->mux->mask;
>  
> -		return factors_req.rate;
> +		if (prediv[par_index].width != SUNXI_FACTORS_NOT_APPLICABLE) {
> +			m = FACTOR_GET(prediv[par_index].shift,
> +				prediv[par_index].width, reg);
> +		}
>  	}
>  
>  	/* Calculate the rate */
> @@ -102,8 +96,12 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
>  	for (i = 0; i < num_parents; i++) {
>  		struct factors_request factors_req = {
>  			.rate = req->rate,
> -			.parent_index = i,
>  		};
> +
> +		if (factors->prediv_config)
> +			factors_req.prediv_width =
> +						factors->prediv_config[i].width;
> +
>  		parent = clk_hw_get_parent_by_index(hw, i);
>  		if (!parent)
>  			continue;
> @@ -211,6 +209,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
>  	/* set up factors properties */
>  	factors->reg = reg;
>  	factors->config = data->table;
> +	factors->prediv_config = data->prediv_table;
>  	factors->get_factors = data->getter;
>  	factors->recalc = data->recalc;
>  	factors->lock = lock;
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> index 1e63c5b..b1b7745 100644
> --- a/drivers/clk/sunxi/clk-factors.h
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -18,10 +18,16 @@ struct clk_factors_config {
>  	u8 n_start;
>  };
>  
> +struct clk_factors_prediv {
> +	u8 parent_index;
> +	u8 shift;
> +	u8 width;
> +};
> +
>  struct factors_request {
>  	unsigned long rate;
>  	unsigned long parent_rate;
> -	u8 parent_index;
> +	u8 prediv_width;
>  	u8 n;
>  	u8 k;
>  	u8 m;
> @@ -33,6 +39,7 @@ struct factors_data {
>  	int mux;
>  	int muxmask;
>  	const struct clk_factors_config *table;
> +	const struct clk_factors_prediv *prediv_table;
>  	void (*getter)(struct factors_request *req);
>  	void (*recalc)(struct factors_request *req);
>  	const char *name;
> @@ -42,6 +49,7 @@ struct clk_factors {
>  	struct clk_hw hw;
>  	void __iomem *reg;
>  	const struct clk_factors_config *config;
> +	const struct clk_factors_prediv *prediv_config;
>  	void (*get_factors)(struct factors_request *req);
>  	void (*recalc)(struct factors_request *req);
>  	spinlock_t *lock;
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 91de0a0..5a5f26b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -282,8 +282,6 @@ static void sun5i_a13_get_ahb_factors(struct factors_request *req)
>  	req->p = div;
>  }
>  
> -#define SUN6I_AHB1_PARENT_PLL6	3
> -
>  /**
>   * sun6i_a31_get_ahb_factors() - calculates m, p factors for AHB
>   * AHB rate is calculated as follows
> @@ -307,7 +305,7 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
>  	div = DIV_ROUND_UP(req->parent_rate, req->rate);
>  
>  	/* calculate pre-divider if parent is pll6 */
> -	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
> +	if (req->prediv_width) {
>  		if (div < 4)
>  			calcp = 0;
>  		else if (div / 2 < 4)

You should also remove that code from that function. Now that the core
can tell the pre-divider configuration, it can adjust the parent rate
so that you don't have to care anymore.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/7d4f7805/attachment.sig>
