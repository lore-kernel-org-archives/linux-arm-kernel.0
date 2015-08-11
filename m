From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Aug 2015 13:41:27 -0700
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <1436651307-24098-2-git-send-email-manabian@gmail.com>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <1436651307-24098-2-git-send-email-manabian@gmail.com>
Message-ID: <20150811204127.31346.16729@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

Quoting Joachim Eastwood (2015-07-11 14:48:26)
> +static void __init lpc18xx_creg_clk_init(struct device_node *np)
> +{
> +       const char *clk_32khz_parent;
> +       struct regmap *syscon;
> +
> +       syscon = syscon_node_to_regmap(np->parent);
> +       if (IS_ERR(syscon)) {
> +               pr_err("%s: syscon lookup failed\n", __func__);
> +               return;
> +       }
> +
> +       clk_32khz_parent = of_clk_get_parent_name(np, 0);
> +
> +       clk_creg[CREG_CLK_32KHZ] =
> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_32KHZ],
> +                                     &clk_32khz_parent, syscon);
> +
> +       clk_creg[CREG_CLK_1KHZ] =
> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_1KHZ],
> +                                     &clk_creg_clocks[CREG_CLK_32KHZ].name,
> +                                     syscon);
> +
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_base_data);
> +}
> +CLK_OF_DECLARE(lpc18xx_creg_clk, "nxp,lpc1850-creg-clk", lpc18xx_creg_clk_init);

I'll ask the same question that Stephen asked in your CCU/CGU driver
series: is it necessary to use CLK_OF_DECLARE here or can you use the
platform device model?

Thanks,
Mike
