From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 21:00:06 -0600
Subject: [PATCH 4/6] ARM: bcm476x: Add stub clock driver
In-Reply-To: <20121007015407.154476821@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015407.154476821@gmail.com>
Message-ID: <50739336.1000805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> This is the minimal clock support required for the boot, a more complete
> implementation will follow (shortly).

> Index: b/drivers/clk/clk-bcm476x.c

> +/*
> + * These are fixed clocks (and device tree doesn't support clk!).
> + *
> + * They're probably not all root clocks and it may be possible to
> + * turn them on and off but until this is mapped out better it's
> + * the only way they can be used.
> + */
> +DEFINE_CLK_FIXED_RATE(sys_pclk,   CLK_IS_ROOT, 312000000, 0);
> +DEFINE_CLK_FIXED_RATE(apb_pclk,   CLK_IS_ROOT, 156000000, 0);
> +DEFINE_CLK_FIXED_RATE(uart0_pclk, CLK_IS_ROOT, 78000000, 0);
> +DEFINE_CLK_FIXED_RATE(uart1_pclk, CLK_IS_ROOT, 78000000, 0);
> +DEFINE_CLK_FIXED_RATE(uart2_pclk, CLK_IS_ROOT, 78000000, 0);
> +
> +static struct clk_lookup lookups[] = {
> +	{ .con_id = "sys_pclk", .clk = &sys_pclk },
> +	{ .con_id = "apb_pclk", .clk = &apb_pclk },
> +	{ .dev_id = "c0000.uart0", .clk = &uart0_pclk },
> +	{ .dev_id = "c1000.uart1", .clk = &uart1_pclk },
> +	{ .dev_id = "b2000.uart2", .clk = &uart2_pclk },
> +};

Mike Turquette (common clk maintainer) objected to this form of static
clock initialization when I originally posted the bcm2835 patches.
Instead, please see how it got re-written dynamically:

https://git.kernel.org/?p=linux/kernel/git/swarren/linux-rpi.git;a=blob;f=drivers/clk/clk-bcm2835.c;h=67ad16b20b8119cc079e63d5dc7a9da0c79c567c;hb=f680f25c635a1a4327bef34fcbe1e9e3777b546c

(or, see linux-next or Linus Torvald's tree)

Also, please be aware of an error-handling bug there; see:

https://lkml.org/lkml/2012/10/7/75
