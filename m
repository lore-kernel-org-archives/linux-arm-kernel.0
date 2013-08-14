From: nm@ti.com (Nishanth Menon)
Date: Wed, 14 Aug 2013 07:48:24 -0500
Subject: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
In-Reply-To: <1374560679-14666-3-git-send-email-rnayak@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
Message-ID: <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
[..]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 12fa589..e5c804b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>         return ret;
>  }
>
> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
> +                                      struct device_node *np,
> +                                      int *opt_clks_cnt)
> +{
> +       int i, clks_cnt;
> +       const char *clk_name;
> +       const char **opt_clk_names;
> +
> +       clks_cnt = of_property_count_strings(np, "clock-names");
> +       if (!clks_cnt)
> +               return NULL;
> +
> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
> +       if (!opt_clk_names)
> +               return NULL;
> +
> +       for (i = 0; i < clks_cnt; i++) {
> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
> +               if (!strcmp(clk_name, "fck"))

Could we instead parse for names that are "optional,role_name" instead
of assuming anything other than fck is optional clocks?

> +                       continue;
> +               opt_clks_cnt++;
> +               opt_clk_names[i] = clk_name;
> +       }
> +       return opt_clk_names;
> +}
> +
[...]
--
Regards,
Nishanth Menon
