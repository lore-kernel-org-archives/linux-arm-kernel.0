From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Aug 2012 11:34:31 +0000
Subject: [PATCH V4 2/5] clk: mmp: add clock definition for pxa168
In-Reply-To: <1345183330-20244-3-git-send-email-xiechao.mail@gmail.com>
References: <1345183330-20244-1-git-send-email-xiechao.mail@gmail.com>
 <1345183330-20244-3-git-send-email-xiechao.mail@gmail.com>
Message-ID: <201208171134.32195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 August 2012, Chao Xie wrote:
> +void __init pxa168_clk_init(void)
> +{
> +       struct clk *clk;
> +       struct clk *uart_pll;
> +       void __iomem *mpmu_base;
> +       void __iomem *apmu_base;
> +       void __iomem *apbc_base;
> +
> +       mpmu_base = ioremap(APB_PHYS_BASE + 0x50000, SZ_4K);
> +       if (mpmu_base == NULL) {
> +               pr_err("error to ioremap MPMU base\n");
> +               return;
> +       }
> +
> +       apmu_base = ioremap(AXI_PHYS_BASE + 0x82800, SZ_4K);
> +       if (apmu_base == NULL) {
> +               pr_err("error to ioremap APMU base\n");
> +               return;
> +       }
> +
> +       apbc_base = ioremap(APB_PHYS_BASE + 0x15000, SZ_4K);
> +       if (apbc_base == NULL) {
> +               pr_err("error to ioremap APBC base\n");
> +               return;
> +       }

I hadn't noticed this before, but you are hardcoded physical address locations
in the driver, which is not so good since we're trying to move all those
locations to device tree. Maybe someone else has an idea to do this better.

> +       clk = clk_register_fixed_rate(NULL, "clk32", NULL, CLK_IS_ROOT, 3200);
> +       clk_register_clkdev(clk, "clk32", NULL);
> +
> +       clk =
> +           clk_register_fixed_rate(NULL, "vctcxo", NULL, CLK_IS_ROOT,
> +                                   26000000);
> +       clk_register_clkdev(clk, "vctcxo", NULL);
> +
> +       clk =
> +           clk_register_fixed_rate(NULL, "pll1", NULL, CLK_IS_ROOT, 624000000);
> +       clk_register_clkdev(clk, "pll1", NULL);

Ok, so you've managed to remove the array, good!

I'm still not overly happy with the style of newline after "=", that is
very unusual, and only saves you two characters per line. I'd say just move
them each into one line as you did in the first one here. It's less important
to align the arguments to the opening braces if you are trying to stay in the
80 character limit. Another option would be to rename the variable to just
'c' instead of 'clk' ;-)

	Arnd


	Arnd
