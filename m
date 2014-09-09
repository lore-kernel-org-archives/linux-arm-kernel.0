From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 09 Sep 2014 13:51:07 -0700
Subject: [PATCH] clk/efm32gg: fix dt init prototype
In-Reply-To: <1406558301-17866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1406558301-17866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140909205107.19023.84737@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Uwe Kleine-K?nig (2014-07-28 07:38:21)
> Since commit 54196ccbe0ba (of: consolidate linker section OF match table
> declarations) which went into 3.16-rc1 the following compiler warning is
> generated:
> 
>         In file included from drivers/clk/clk-efm32gg.c:12:0: include/linux/of.h:772:20:
>         warning: comparison of distinct pointer types lacks a cast [enabled by default]
>                 .data = (fn == (fn_type)NULL) ? fn : fn  }
>                             ^
>         include/linux/of.h:785:3: note: in expansion of macro '_OF_DECLARE'
>            _OF_DECLARE(table, name, compat, fn, of_init_fn_1)
>            ^
>         include/linux/clk-provider.h:545:42: note: in expansion of macro 'OF_DECLARE_1'
>          #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
>                                                   ^
>         drivers/clk/clk-efm32gg.c:81:1: note: in expansion of macro 'CLK_OF_DECLARE'
>          CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
>          ^
> 
> Fix it by making efm32gg_cmu_init return void.
> 
> Cc: Rob Herring <robh@kernel.org>
> Reported-by: Bryan Hundven <bryanhundven@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied to clk-fixes.

Regards,
Mike

> ---
> Hello,
> 
> I feel a bit uneasy about not checking the return value of of_clk_add_provider.
> Should I add another warning there?
> 
> Best regards
> Uwe
> 
>  drivers/clk/clk-efm32gg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-efm32gg.c b/drivers/clk/clk-efm32gg.c
> index bac2ddf49d02..73a8d0ff530c 100644
> --- a/drivers/clk/clk-efm32gg.c
> +++ b/drivers/clk/clk-efm32gg.c
> @@ -22,7 +22,7 @@ static struct clk_onecell_data clk_data = {
>         .clk_num = ARRAY_SIZE(clk),
>  };
>  
> -static int __init efm32gg_cmu_init(struct device_node *np)
> +static void __init efm32gg_cmu_init(struct device_node *np)
>  {
>         int i;
>         void __iomem *base;
> @@ -33,7 +33,7 @@ static int __init efm32gg_cmu_init(struct device_node *np)
>         base = of_iomap(np, 0);
>         if (!base) {
>                 pr_warn("Failed to map address range for efm32gg,cmu node\n");
> -               return -EADDRNOTAVAIL;
> +               return;
>         }
>  
>         clk[clk_HFXO] = clk_register_fixed_rate(NULL, "HFXO", NULL,
> @@ -76,6 +76,6 @@ static int __init efm32gg_cmu_init(struct device_node *np)
>         clk[clk_HFPERCLKDAC0] = clk_register_gate(NULL, "HFPERCLK.DAC0",
>                         "HFXO", 0, base + CMU_HFPERCLKEN0, 17, 0, NULL);
>  
> -       return of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  }
>  CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
> -- 
> 2.0.0
> 
