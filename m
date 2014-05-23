From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 23 May 2014 14:39:15 -0700
Subject: [PATCH] clk: divider: Fix table round up function
In-Reply-To: <1399481332-9550-1-git-send-email-maxime.coquelin@st.com>
References: <1399481332-9550-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140523213915.23136.16939@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime COQUELIN (2014-05-07 09:48:52)
> Commit 1d9fe6b97 ("clk: divider: Fix best div calculation for power-of-two and
> table dividers") introduces a regression in its _table_round_up function.
> 
> When the divider passed to this function is greater than the max divider
> available in the table, this function returns table's max divider.
> Problem is that it causes an infinite loop in clk_divider_bestdiv() because
> _next_div() will never return a value greater than maxdiv.
> 
> Instead of returning table's max divider, this patch returns INT_MAX.
> 
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Reported-by: Shawn Guo <shawn.guo@freescale.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Cc: Mike Turquette <mike.turquette@linaro.org>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Pulled into clk-fixes for -rc7.

Regards,
Mike

> ---
>  drivers/clk/clk-divider.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index b3c8396..cf9114a 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -158,7 +158,7 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
>  static int _round_up_table(const struct clk_div_table *table, int div)
>  {
>         const struct clk_div_table *clkt;
> -       int up = _get_table_maxdiv(table);
> +       int up = INT_MAX;
>  
>         for (clkt = table; clkt->div; clkt++) {
>                 if (clkt->div == div)
> -- 
> 1.9.1
> 
