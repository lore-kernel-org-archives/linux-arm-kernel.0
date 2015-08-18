From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 17 Aug 2015 17:26:04 -0700
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <CAGhQ9VwZaM_iWTkQYVTuTiyb6gCG2y6s8WFVySCHt7YHE1qbcA@mail.gmail.com>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <1436651307-24098-2-git-send-email-manabian@gmail.com>
 <20150811204127.31346.16729@quantum>
 <CAGhQ9VwZaM_iWTkQYVTuTiyb6gCG2y6s8WFVySCHt7YHE1qbcA@mail.gmail.com>
Message-ID: <20150818002604.31346.18322@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joachim Eastwood (2015-08-13 13:43:11)
> On 11 August 2015 at 22:41, Michael Turquette <mturquette@baylibre.com> wrote:
> > Hi Joachim,
> >
> > Quoting Joachim Eastwood (2015-07-11 14:48:26)
> >> +static void __init lpc18xx_creg_clk_init(struct device_node *np)
> >> +{
> >> +       const char *clk_32khz_parent;
> >> +       struct regmap *syscon;
> >> +
> >> +       syscon = syscon_node_to_regmap(np->parent);
> >> +       if (IS_ERR(syscon)) {
> >> +               pr_err("%s: syscon lookup failed\n", __func__);
> >> +               return;
> >> +       }
> >> +
> >> +       clk_32khz_parent = of_clk_get_parent_name(np, 0);
> >> +
> >> +       clk_creg[CREG_CLK_32KHZ] =
> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_32KHZ],
> >> +                                     &clk_32khz_parent, syscon);
> >> +
> >> +       clk_creg[CREG_CLK_1KHZ] =
> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_1KHZ],
> >> +                                     &clk_creg_clocks[CREG_CLK_32KHZ].name,
> >> +                                     syscon);
> >> +
> >> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_base_data);
> >> +}
> >> +CLK_OF_DECLARE(lpc18xx_creg_clk, "nxp,lpc1850-creg-clk", lpc18xx_creg_clk_init);
> >
> > I'll ask the same question that Stephen asked in your CCU/CGU driver
> > series: is it necessary to use CLK_OF_DECLARE here or can you use the
> > platform device model?
> 
> The 32 kHz clock from the CREG block is a clock parent to the CGU
> block so it's possible that it will required early. This is all
> depends on how the boot loader initially configures the CGU.
> 
> Currently in the DTS for lpc18xx cgu it has:
> clocks = <&xtal>, <&xtal32>, <...>;
> xtal32 is just a temporary placeholder until the CREG clock is in place.

Well that seems wrong. Is it just a matter of probe order where you try
to probe the cgu driver before the creg driver?

Regards,
Mike

> 
> 
> Note that while it's possible to use the 32k clock together with PLL0
> to generate the main CPU bus clock I doubt it will be common
> configuration. It is however fully possible to do.
> 
> 
> regards,
> Joachim Eastwood
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
