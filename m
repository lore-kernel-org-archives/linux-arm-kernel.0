From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Mar 2014 14:51:20 -0700
Subject: [PATCH v5 1/7] clk: sunxi: Remove calls to clk_put
In-Reply-To: <1394723659-4995-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394723659-4995-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140324215120.32624.63543@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-03-13 08:14:13)
> Callers of clk_put must disable the clock first. This also means that as long
> as the clock is enabled the driver should hold a reference to that clock.
> Hence, the call to clk_put here are bogus and should be removed.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Looks good to me. There is a balanced clk_put in the module remove
function?

Regards,
Mike

> ---
>  drivers/clk/sunxi/clk-sunxi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 23baad9d934a..7119c02c9fa8 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1290,17 +1290,13 @@ static void __init sunxi_clock_protect(void)
>  
>         /* memory bus clock - sun5i+ */
>         clk = clk_get(NULL, "mbus");
> -       if (!IS_ERR(clk)) {
> +       if (!IS_ERR(clk))
>                 clk_prepare_enable(clk);
> -               clk_put(clk);
> -       }
>  
>         /* DDR clock - sun4i+ */
>         clk = clk_get(NULL, "pll5_ddr");
> -       if (!IS_ERR(clk)) {
> +       if (!IS_ERR(clk))
>                 clk_prepare_enable(clk);
> -               clk_put(clk);
> -       }
>  }
>  
>  static void __init sunxi_init_clocks(void)
> -- 
> 1.9.0
> 
