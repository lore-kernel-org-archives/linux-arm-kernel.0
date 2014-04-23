From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:39:02 +0200
Subject: [PATCH v6 3/8] ARM: sunxi: Move the clock protection to machine
 hooks
In-Reply-To: <1397724379-15398-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397724379-15398-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201404231439.02913.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014, Maxime Ripard wrote:
> Since we start to have a lot of clocks to protect, some of them in a few boards
> only, it becomes difficult to handle the clock protection without having to add
> per machine exceptions.
> 
> Move these where they belong, in the machine definition code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I don't like the fact that these are required to be hardcoded
anywhere in source code.

> +#include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
>  
> @@ -19,9 +20,17 @@
>  
>  static void __init sun4i_dt_init(void)
>  {
> +       struct clk *clk;
> +
>         sunxi_setup_restart();
>  
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +
> +       /* Make sure the clocks we absolutely need are enabled */
> +       /* DDR clock */
> +       clk = clk_get(NULL, "pll5_ddr");
> +       if (!IS_ERR(clk))
> +               clk_prepare_enable(clk);
>  }

Isn't there already DT syntax to do the same? If not, should there be?

	Arnd
