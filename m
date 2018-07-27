From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 27 Jul 2018 09:50:17 -0700
Subject: [PATCH] clk: Add functions to get optional clocks
In-Reply-To: <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <153271021758.48062.12757198387330928176@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Phil Edworthy (2018-07-27 08:38:12)
> On 25 July 2018 23:37, Stephen Boyd wrote:
> > Short answer is they don't. I'd still prefer we have this API though.
> > 
> > Can you rework this patch to be a little more invasive into the
> > clk_get() path, perhaps by reworking __of_clk_get_by_name() a little to
> > take an 'optional' argument, so that it only returns NULL when the clk is
> > looked up from DT? The fallback path in clkdev where we have a DT based
> > system looking up a clk through clkdev lookups doesn't seem to be a real
> > scenario that we should worry about here. I think sometimes people use
> > clkdev lookups when they're migrating to DT systems and things aren't wired
> > up properly in DT, but that isn't the norm.
> Do you mean something like this:
> 
[...]
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 907202b..830209a 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -771,6 +771,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
> +struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
>  static inline struct clk *of_clk_get(struct device_node *np, int index)
> 
> ---
> A lot of drivers use devm_clk_get() so I think a devm_clk_get_optional()
> version would be useful. That would probably need an additional
> clk_get_optional() function.
> 

Yes, this would be the first patch, and then the second patch would add
clk_get_optional() and devm_clk_get_optional(). We shouldn't encourage
consumers to move from device based to DT node based clk_get() for the
optional clk API.
