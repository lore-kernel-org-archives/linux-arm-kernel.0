From: mturquette@linaro.org (Michael Turquette)
Date: Sun, 12 Apr 2015 21:37:25 -0700
Subject: [PATCH] clk: at91: pll: fix input range validity check
In-Reply-To: <1427594023-9697-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1427594023-9697-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150413043725.19585.5717@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-03-28 18:53:43)
> The PLL impose a certain input range to work correctly, but it appears that
> this input range does not apply on the input clock (or parent clock) but
> on the input clock after it has passed the PLL divisor.
> Fix the implementation accordingly.
> 
> Cc: <stable@vger.kernel.org> # v3.14+
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Jonas Andersson <jonas@microbit.se>

Hi Boris,

OK, so this patch along with your two previous submissions kind of
tackle some of items I mentioned earlier today[0].

Does this patch, combined with your two prior patches[1][2] resolve the
issue you brought up in your "Propagating clock rate constraints"
thread[3]?

[0] http://lkml.kernel.org/r/<20150412235021.19585.27431@quantum>
[1] http://lkml.kernel.org/r/<1427593728-9366-1-git-send-email-boris.brezillon@free-electrons.com>
[2] http://lkml.kernel.org/r/<1427593533-9019-1-git-send-email-boris.brezillon@free-electrons.com>
[3] http://lkml.kernel.org/r/<20150327004054.2f6f34ee@bbrezillon>

Regards,
Mike

> ---
>  drivers/clk/at91/clk-pll.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 6ec79db..cbbe403 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -173,8 +173,7 @@ static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
>         int i = 0;
>  
>         /* Check if parent_rate is a valid input rate */
> -       if (parent_rate < characteristics->input.min ||
> -           parent_rate > characteristics->input.max)
> +       if (parent_rate < characteristics->input.min)
>                 return -ERANGE;
>  
>         /*
> @@ -187,6 +186,15 @@ static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
>         if (!mindiv)
>                 mindiv = 1;
>  
> +       if (parent_rate > characteristics->input.max) {
> +               tmpdiv = DIV_ROUND_UP(parent_rate, characteristics->input.max);
> +               if (tmpdiv > PLL_DIV_MAX)
> +                       return -ERANGE;
> +
> +               if (tmpdiv > mindiv)
> +                       mindiv = tmpdiv;
> +       }
> +
>         /*
>          * Calculate the maximum divider which is limited by PLL register
>          * layout (limited by the MUL or DIV field size).
> -- 
> 1.9.1
> 
