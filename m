From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Jul 2013 10:16:48 +0200
Subject: [PATCH 4/5] ARM: bcm4760: Add stub clock driver
In-Reply-To: <20130721002714.459727324@gmail.com>
References: <20130721002320.730568671@gmail.com>
 <20130721002714.459727324@gmail.com>
Message-ID: <201307211016.49274.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 July 2013, Domenico Andreoli wrote:
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/bcm4760.h>
> +
> +void __init bcm4760_init_clocks(void)
> +{
> +       struct clk *clk;
> +
> +       clk = clk_register_fixed_rate(NULL, "pclk", NULL, CLK_IS_ROOT, 78000000);
> +       if (IS_ERR(clk))
> +               pr_err("pclk not registered\n");
> +
> +       if (clk_register_clkdev(clk, NULL, "c0000.uart0"))
> +               pr_err("uart0 clk alias not registered\n");
> +       if (clk_register_clkdev(clk, NULL, "c1000.uart1"))
> +               pr_err("uart1 clk alias not registered\n");
> +       if (clk_register_clkdev(clk, NULL, "b2000.uart2"))
> +               pr_err("uart2 clk alias not registered\n");
> +}


Since these are all fixed-rate clocks, I think what you should do here is to
put them into the device tree as compatible="fixed-clock" and remove the code
here.

	Arnd
