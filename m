From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 18 Sep 2015 09:21:17 +0200
Subject: [PATCH v2] clk:mxs: Fix bug on frequency divider
In-Reply-To: <1441010707-17178-1-git-send-email-victorien.vedrine@ophrys.net>
References: <55BBB1AC.6070102@codeaurora.org>
 <1441010707-17178-1-git-send-email-victorien.vedrine@ophrys.net>
Message-ID: <55FBBB6D.4010805@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Shawn's new address
+linux-arm-kernel

> On drivers/clk/mxs/clk-frac.c, the function clk_frac_round_rate returned a bad
> result. The division before multiplication computes a wrong value ; the
> calculation is inverted to fix the problem. The second issue is that the exact
> rate have decimals and they are truncate. The consequence is that the function
> clk_frac_set_rate (which use the result of clk_frac_round_rate) computes a
> wrong value for the register (the rate generated can be closer to the desired
> rate). The correction is : if there is decimal to the result, it is rounded to
> the next larger integer.
> On drivers/clk/mxs/clk-frac.c, the function clk_frac_recalc_rate returned
> a bad result. The multiplication is made before the division to compute a
> correct value.
>
> Signed-off-by: Victorien Vedrine <victorien.vedrine@ophrys.net>
> ---
>  drivers/clk/mxs/clk-frac.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mxs/clk-frac.c b/drivers/clk/mxs/clk-frac.c
> index e6aa6b5..b3fa7fa 100644
> --- a/drivers/clk/mxs/clk-frac.c
> +++ b/drivers/clk/mxs/clk-frac.c
> @@ -42,11 +42,13 @@ static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
>  {
>  	struct clk_frac *frac = to_clk_frac(hw);
>  	u32 div;
> +	u64 tmp_rate;
>  
>  	div = readl_relaxed(frac->reg) >> frac->shift;
>  	div &= (1 << frac->width) - 1;
>  
> -	return (parent_rate >> frac->width) * div;
> +	tmp_rate = (u64)parent_rate * div;
> +	return tmp_rate >> frac->width;
>  }
>  
>  static long clk_frac_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -55,7 +57,7 @@ static long clk_frac_round_rate(struct clk_hw *hw, unsigned long rate,
>  	struct clk_frac *frac = to_clk_frac(hw);
>  	unsigned long parent_rate = *prate;
>  	u32 div;
> -	u64 tmp;
> +	u64 tmp, tmp_rate, result;
>  
>  	if (rate > parent_rate)
>  		return -EINVAL;
> @@ -68,7 +70,11 @@ static long clk_frac_round_rate(struct clk_hw *hw, unsigned long rate,
>  	if (!div)
>  		return -EINVAL;
>  
> -	return (parent_rate >> frac->width) * div;
> +	tmp_rate = (u64)parent_rate * div;
> +	result = tmp_rate >> frac->width;
> +	if ((result << frac->width) < tmp_rate)
> +		result += 1;
> +	return result;
>  }
>  
>  static int clk_frac_set_rate(struct clk_hw *hw, unsigned long rate,
