From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 08:34:40 +0100
Subject: [PATCH v2 01/16] clk: sunxi-ng: Add check for minimal rate to NM
 PLLs
In-Reply-To: <20180227222701.9716-2-jernej.skrabec@siol.net>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-2-jernej.skrabec@siol.net>
Message-ID: <20180228073440.6ejo3wjdqag6h4nl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 27, 2018 at 11:26:46PM +0100, Jernej Skrabec wrote:
> Some NM PLLs doesn't work well when their output clock rate is set below
> certain rate.
> 
> Add support for that constrain.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_nm.c | 11 +++++++----
>  drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index a16de092bf94..7fc743c78c1b 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -20,7 +20,7 @@ struct _ccu_nm {
>  };
>  
>  static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
> -			     struct _ccu_nm *nm)
> +			     unsigned long min_rate, struct _ccu_nm *nm)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_m = 0;
> @@ -30,7 +30,7 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
>  		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
>  			unsigned long tmp_rate = parent * _n  / _m;
>  
> -			if (tmp_rate > rate)
> +			if (tmp_rate > rate || tmp_rate < min_rate)
>  				continue;
>  
>  			if ((rate - tmp_rate) < (rate - best_rate)) {
> @@ -117,6 +117,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nm->fixed_post_div;
>  
> +	if (rate < nm->min_rate)
> +		rate = nm->min_rate;
> +

I guess you can just return there. There's no point in trying to find
the factors at this point, since the minimum should be a value that
can be reached.

>  	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
>  		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  			rate /= nm->fixed_post_div;
> @@ -134,7 +137,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
>  	_nm.min_m = 1;
>  	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
>  
> -	ccu_nm_find_best(*parent_rate, rate, &_nm);
> +	ccu_nm_find_best(*parent_rate, rate, nm->min_rate, &_nm);

Therefore, you don't need to change the prototype there either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/81221c2e/attachment.sig>
