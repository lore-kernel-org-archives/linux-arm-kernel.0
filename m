From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 26 Feb 2015 00:09:41 +0000
Subject: [PATCH] clk: divider: return real rate instead of divider value
In-Reply-To: <2011929.fOsbjMkSp9@diego>
References: <2011929.fOsbjMkSp9@diego>
Message-ID: <CAAG0J9-uHPg-np249ZKf3vrDCUvTvLhRbGZeGXfGqTV-XLByFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2015 at 10:39, Heiko St?bner <heiko@sntech.de> wrote:
> Commit bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> returned only the divider value for read-only dividers instead of the
> actual rate.
>
> Fixes: bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I just created an identical patch, so
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  drivers/clk/clk-divider.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a213455..5b4c018 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -355,7 +355,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
>                 bestdiv = readl(divider->reg) >> divider->shift;
>                 bestdiv &= div_mask(divider->width);
>                 bestdiv = _get_div(divider->table, bestdiv, divider->flags);
> -               return bestdiv;
> +               return DIV_ROUND_UP(*prate, bestdiv);
>         }
>
>         return divider_round_rate(hw, rate, prate, divider->table,
> --
> 2.1.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
