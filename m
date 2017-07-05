From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Jul 2017 09:43:10 +0200
Subject: [PATCH v5 1/6] clk: sunxi-ng: div: Add support for fixed
 post-divider
In-Reply-To: <805048a548031cafc890e6ea06ee773bdfb199d0.1499197129.git-series.plaes@plaes.org>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <805048a548031cafc890e6ea06ee773bdfb199d0.1499197129.git-series.plaes@plaes.org>
Message-ID: <20170705074310.b6ycyf27htv5gkxm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 11:04:56PM +0300, Priit Laes wrote:
> SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
> 6 is fixed post-divider.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/ccu_div.c | 18 ++++++++++++++++--
>  drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
> index c0e5c10..054b12a 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.c
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -21,6 +21,9 @@ static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
>  {
>  	struct ccu_div *cd = data;
>  
> +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +		rate /= cd->fixed_post_div;
> +
>  	return divider_round_rate_parent(&cd->common.hw, parent,
>  					 rate, parent_rate,
>  					 cd->div.table, cd->div.width,

This doesn't work.

The rate formula is
rate = parent / div / 6

Which is equivalent to
div = rate * 6 / parent

You should be multiplying the rate, not dividing it (or dividing the
parent, but then you'll also need to multiply it back after the call
to divider_round_rate_parent).

Consider this, some driver wants to set a rate of 100MHz on this
clock. The parent is 1.2GHz, and you have your postdiv of 6.

The divider we want to compute is 2, obviously.

You're doing here:
rate / 6 = parent / div

Which means that you'll end up trying to find the divider between
1.2GHz and 16.6666MHz, which is going to be 72.

> @@ -62,8 +65,13 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
>  						  parent_rate);
>  
> -	return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> -				   cd->div.flags);
> +	val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> +				  cd->div.flags);
> +
> +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +		val /= cd->fixed_post_div;
> +
> +	return val;
>  }
>  
>  static int ccu_div_determine_rate(struct clk_hw *hw,
> @@ -71,6 +79,9 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
>  {
>  	struct ccu_div *cd = hw_to_ccu_div(hw);
>  
> +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +		req->rate *= cd->fixed_post_div;
> +

I guess this is why you never really saw the issue. Combined with your
division in ccu_div_round_rate, it produces the exact rate you were
given as an argument.

>  	return ccu_mux_helper_determine_rate(&cd->common, &cd->mux,
>  					     req, ccu_div_round_rate, cd);
>  }
> @@ -89,6 +100,9 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
>  	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
>  			      cd->div.flags);
>  
> +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +		val /= cd->fixed_post_div;
> +

If you multiply the rate before calling divider_get_val, you won't
have to do the division of the divider, with all the rounding
weirdness it might create.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170705/4fbf8943/attachment.sig>
