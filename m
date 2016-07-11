From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 11 Jul 2016 15:14:35 -0700
Subject: [PATCH v2 04/10] clk: add Clock driver for nuc970
In-Reply-To: <1468135649-19980-5-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-5-git-send-email-vw@iommu.org>
Message-ID: <146827527560.73491.7859004638616123566@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wan Zongshun (2016-07-10 00:27:24)
> diff --git a/drivers/clk/nuc900/clk-apll.c b/drivers/clk/nuc900/clk-apll.c
> new file mode 100644
> index 0000000..a05aec7
> --- /dev/null
> +++ b/drivers/clk/nuc900/clk-apll.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +
> +#include "clk-ccf.h"

Maybe call it clk-nuc.h?

> +static struct clk_ops clk_apll_ops = {
> +       .recalc_rate = clk_apll_recalc_rate,
> +       .enable = clk_apll_enable,
> +       .disable = clk_apll_disable,

Can you provide a .is_enabled?

> +static void __init nuc970_clocks_init(struct device_node *np)
> +{
> +       int i, ret;
> +
> +       clkctrl = of_iomap(np, 0);
> +       if (!clkctrl)
> +               pr_err("%s: unable to map registers\n", np->full_name);
> +
> +
> +       /* source */
> +       clk[XIN]        = nuc970_clk_fixed("xin", 12000000);
> +       clk[XIN32K]     = nuc970_clk_fixed("xin32k", 32768);
> +       clk[APLL]       = nuc970_clk_apll("apll", "xin", REG_CLK_APLLCON);
> +       clk[UPLL]       = nuc970_clk_upll("upll", "xin", REG_CLK_UPLLCON);
> +       clk[XIN128_DIV] = nuc970_clk_fixed_factor("xin128_div", "xin", 1, 128);
> +       clk[SYS_MUX]    = nuc970_clk_mux("sys_mux", REG_CLK_DIV0, 3, 2,
> +                                        sys_sel_clks,
> +                                        ARRAY_SIZE(sys_sel_clks));

Instead of executing all of these registration functions, how about
initializing your clock data statically, and then simply calling
clk_hw_register?

For an example see the recently merged drivers/clk/meson/gxbb.c

> +       for (i = 0; i < ARRAY_SIZE(clk); i++)
> +               if (IS_ERR(clk[i]))
> +                       pr_err("nuc970 clk %d: register failed with %ld\n",
> +                               i, PTR_ERR(clk[i]));

Better to fail quickly, bail out and unwind your clk registration
instead of trying to register everything and then walk the list looking
for failures.

> +
> +       clk_data.clks = clk;
> +       clk_data.clk_num = ARRAY_SIZE(clk);
> +
> +       ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +       if (ret)
> +               pr_err("Failed to register OF clock provider\n");
> +
> +       /* Register clock device */
> +       clk_register_clkdev(clk[TIMER0_GATE], "timer0", NULL);
> +       clk_register_clkdev(clk[TIMER1_GATE], "timer1", NULL);

Again, look at how the gxbb.c driver does this. Why do you need to call
clk_register_clkdev? You're using of_clk_add_provider above, so that
should be enough to perform lookups.

> +       /* enable some important clocks */
> +       clk_prepare_enable(clk_get(NULL, "cpu"));
> +       clk_prepare_enable(clk_get(NULL, "hclk"));
> +       clk_prepare_enable(clk_get(NULL, "sram"));
> +       clk_prepare_enable(clk_get(NULL, "dram"));
> +       clk_prepare_enable(clk_get(NULL, "ddr_hclk"));

You can use the CLK_IS_CRITICAL flag for these clocks if you want. It
would be better to have drivers that claim them and enable them of
course.

> +}
> +
> +CLK_OF_DECLARE(nuc970_clk, "nuvoton,nuc970-clk", nuc970_clocks_init);

Why do you need to use CLK_OF_DECLARE? Please convert this to a
platform_driver and load it at module_init.

Regards,
Mike
