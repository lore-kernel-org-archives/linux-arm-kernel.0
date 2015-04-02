From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 2 Apr 2015 20:40:31 +0200
Subject: [PATCH v5 3/4] clk: Provide always-on clock support
In-Reply-To: <1427891304-20160-4-git-send-email-lee.jones@linaro.org>
References: <1427891304-20160-1-git-send-email-lee.jones@linaro.org>
 <1427891304-20160-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CAMuHMdX+ST-iJpoiYQLFBpPGJb6uo_69JkdhWL9n7MrJ_a+RqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 1, 2015 at 2:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -116,6 +116,43 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>         return 0;
>  }
>
> +static int __set_clk_always_on(struct device_node *node, bool clk_supplier)
> +{
> +       struct of_phandle_args clkspec;
> +       struct clk *clk;
> +       struct property *prop;
> +       const __be32 *cur;
> +       uint32_t index;
> +       int ret;
> +
> +       if (!clk_supplier)
> +               return 0;
> +
> +       of_property_for_each_u32(node, "clock-always-on", prop, cur, index) {
> +               clkspec.np = node;
> +               clkspec.args_count = 1;
> +               clkspec.args[0] = index;
> +
> +               clk = of_clk_get_by_clkspec(&clkspec);

As of commit 306c342f9cb1 ("clk: Replace of_clk_get_by_clkspec() with
of_clk_get_from_provider()") in -next, you must use of_clk_get_from_provider()
instead.

> +               if (IS_ERR(clk)) {
> +                       pr_err("clk: couldn't get clock %d for %s\n",

"%u"  (index is uint32_t)

> +                               index, node->full_name);
> +                       return PTR_ERR(clk);
> +               }
> +
> +               ret = clk_prepare_enable(clk);
> +               if (ret) {
> +                       pr_err("Failed to enable clock %d for %s: %d\n",

%u

> +                              index, node->full_name, ret);
> +                       return ret;
> +               }
> +
> +               pr_debug("Set clock %s as always-on\n", __clk_get_name(clk));

As of commit 4716bafa1f63 ("lib/vsprintf: Add %pC{,n,r} format specifiers
for clocks") in -next, you can use "%pC" to print the clock's name.

> +       }
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
