From: gsi@denx.de (Gerhard Sittig)
Date: Sun, 22 Dec 2013 18:52:35 +0100
Subject: [PATCHv12 07/49] clk: divider: add support for low level ops
In-Reply-To: <1387557274-22583-7-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
 <1387557274-22583-7-git-send-email-t-kristo@ti.com>
Message-ID: <20131222175235.GC8064@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ dropped devicetree, we're clock specific here ]

On Fri, Dec 20, 2013 at 18:34 +0200, Tero Kristo wrote:
> 
> Divider clock can now be registered to use low level register access ops.
> Preferred initialization method is via clock description.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/clk-divider.c    |   22 +++++++++++++++++++---
>  include/linux/clk-provider.h |    4 ++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 8cfed5c..887e2d8 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -108,7 +108,12 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div, val;
>  
> -	val = clk_readl(divider->reg) >> divider->shift;
> +	if (divider->ll_ops)
> +		val = divider->ll_ops->clk_readl(divider->reg);
> +	else
> +		val = clk_readl(divider->reg);

Should this not better always use an ll_ops structure, which
either is individual to the clock item, or is "global" for a
platform, yet can get re-registered at runtime (see the comment
on 06/49)?  And why are you referencing clk_readl() instead of
clk_readl_default() which you specifically have introduced in the
previous patch?  Adding a copy of the routine and using both the
copy and the original doesn't look right.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
