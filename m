From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 04 Jan 2016 00:36:29 -0800
Subject: [PATCH v2,
 RESEND] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <CAK7LNARHuogHfsSyXVkkoakOq61xfhYJOa08cC7tvvn1kdPRoQ@mail.gmail.com>
References: <1451298058-28910-1-git-send-email-yamada.masahiro@socionext.com>
 <20151231013511.21505.59601@quark.deferred.io>
 <CAK7LNARHuogHfsSyXVkkoakOq61xfhYJOa08cC7tvvn1kdPRoQ@mail.gmail.com>
Message-ID: <20160104083629.15239.29413@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Masahiro Yamada (2016-01-01 17:26:05)
> Hi Michael,
> 
> 
> 2015-12-31 10:35 GMT+09:00 Michael Turquette <mturquette@baylibre.com>:
> > Hello Yamada-san,
> >
> > Quoting Masahiro Yamada (2015-12-28 02:20:58)
> >> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
> >> new file mode 100644
> >> index 0000000..7606f27
> >> --- /dev/null
> >> +++ b/drivers/clk/uniphier/Kconfig
> >> @@ -0,0 +1,35 @@
> >> +menuconfig CLK_UNIPHIER
> >> +       bool "Clock drivers for UniPhier SoCs"
> >> +       depends on ARCH_UNIPHIER
> >
> > Might want to make the above line:
> >
> >         depends on ARCH_UNIPHIER || COMPILE_TEST
> >
> >> +       depends on OF
> >> +       default y
> >> +       help
> >> +         Supports clock drivers for UniPhier SoCs.
> >
> > Why menuconfig? Can we make this a non-visible config option selected by
> > the UniPhier platform?
> 
> Yes, I can do that if you like.

Thanks, and the other questions I asked in my previous reply are
relevant here: can you make these into platform_drivers and compile them
as loadable modules? That would be ideal.

> 
> Do you prefer to making it flat, like all clocks are shown in the
> "Common Clock Framework" menu?
> 
> Or, is it better to categorize SoC clocks with "menu" for each SoC family?

The precedent is to do it flat. I'm fine with a menu though. Your
choice.

> 
> 
> 
> >> +
> >> +if CLK_UNIPHIER
> >
> > Please drop the if statement here and have the below options 'depends'
> > on CLK_UNIPHIER.
> 
> Why is it bad?
> 
> I think surrounding all the options with "if CLK_UNIPHIER" ... "endif"
> is easier than adding "depends on CLK_UNIPHIER" to each of them.

I find it more readable to clearly define the dependencies for each
config option.

> 
> 
> 
> >> +
> >> +config CLK_UNIPHIER_PH1_SLD3
> >> +       bool "Clock driver for UniPhier PH1-sLD3 SoC"
> >> +       default y
> >
> > Can you make these drivers into loadable modules? If so you might
> > consider tristate.
> 
> For some, I can.
> For some, I can't (because they must provide an input clock for the timer.)
> 
> 
> >> +
> >> +static void __init ph1_ld4_clk_init(struct device_node *np)
> >> +{
> >> +       uniphier_clk_init(np, ph1_ld4_clk_idata);
> >> +}
> >> +CLK_OF_DECLARE(ph1_ld4_clk, "socionext,ph1-ld4-sysctrl", ph1_ld4_clk_init);
> >
> > Can you avoid using CLK_OF_DECLARE and instead make this into a
> > platform_driver? For examples please see drivers/clk/qcom*.c
> 
> 
> For clk-uniphier-peri.c and clk-uniphier-mio.c, yes.
> They provide clocks for peripheral devices like USB, MMC, etc., so I
> can delay them.
> 
> 
> For clk-ph1-*.c, I am afraid I can't.
> They provide an input clock for the timer (ARM global timer).
> I think they should be initialized very early.
> 
> 
> Is platform_driver better than CLK_OF_DECLARE() where it is possible?

Yes.

> 
> I just chose CLK_OF_DECLARE() for consistency
> and it seems the majority.

I'm trying to change that.

> 
> 
> 
> >> +
> >> +static void __init uniphier_clk_update_parent_name(struct device_node *np,
> >> +                                                  const char **parent_name)
> >> +{
> >> +       const char *new_name;
> >> +       int index;
> >> +
> >> +       if (!parent_name || !*parent_name)
> >> +               return;
> >> +
> >> +       if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
> >> +               return;
> >> +
> >> +       index = of_property_match_string(np, "clock-names",
> >> +                               *parent_name + strlen(UNIPHIER_CLK_EXT));
> >> +       new_name = of_clk_get_parent_name(np, index);
> >> +       if (new_name)
> >> +               *parent_name = new_name;
> >
> > Where can I find the DT binding description and DTS for this clock
> > controller?

Any update on the above question? I wasn't able to find the DT binding
description anywhere.

> I'm confused why the parent name function is necessary and
> > I'd like to see the data.
> 
> 
> clk_register() needs the name strings of parent clocks,
> not pointers to parent clocks.
> (It looks a bit odd to me, although it allows us to register clocks in
> any order.
> In stead, we have to think about orphan-walking.)

Actually, I'd like to allow a clk_register() that takes pointers to
struct clk_core for the parent. This is useful for registering clocks
whose parents are inside the same clock provider/generator/driver.

We might still need the clock parent names for registering parents across
the clock provider/generator/driver boundary. Or maybe not ... Since we
can use the phandle to fetch a struct clk_core for a clock that has
already been registered. But these are ideas for the future.

> So, we need to exactly know the names of parent clocks.
> 
> Let's assume the clock system that consists of some hardware blocks.
> 
> 
>   root_clk: root_clk {
>         compatible = "foo-clk";
>         reg = <0x10000000 0x1000>;
>         #clock-cells = <1>;
>   };
> 
>   bar_clk {
>         compatible = "bar-clk";
>         reg = <0x20000000 0x1000>;
>         #clock-cells = <1>;
>         clock-names = "input"
>         clocks = <&root_clk 0>;
>    };
> 
>   baz_clk {
>         compatible = "baz-clk";
>         reg = <0x30000000 0x1000>;
>         #clock-cells = <1>;
>         clock-names = "input"
>         clocks = <&root_clk 1>;
>    };
> 
> 
> 
> The "bar_clk" is a clock provider for other peripherals,
> and also a consumer of "root_clk".
> 
> The "bar_clk" wants to know the name of index 0 of root_clk
> because it is needed when calling clk_register().
> 
> 
> Let's say the names of clocks provided root_clk are, "for-bar123", "for-baz456".
> 
> The "bar_clk" needs the string "for-bar123", but it does not know.
> (Likewise, the "baz_clk" needs the string "for-baz456", but it does not know.)
> 
> Of course, I can hard-code "for-bar123" in the driver of "bar_clk",
> but I think it is annoying to keep the name synced between the
> provider and the consumer.

For on-chip clock providers and consumers it is usually safe to
hard-code the names since the clock configuration of the IC/SoC is
well-defined. For making board-level connections it is less safe.

Still, many clk drivers do indeed hard-code the string names for their
parent clocks.

> 
> So, I implemented uniphier_clk_update_parent_name()
> to convert the clock-names into the parent clock name.
> In this case, this function takes "input" and converts it into "for-bar123".
> 
> 
> Is there any good idea to solve this problem?

Well, using the clock-output-names DT property in conjunction with
of_clk_get_parent_name() solves this for you in a common way. However I
would like to get rid of clock-output-names in the future. In general
I'm working slowy to reduce the reliance on clock string names, but it
is a long-term side project.

How bad is it for you to hard-code the string names in your driver? Are
the foo, bar and baz clock providers all on the same chip?

Regards,
Mike

> 
> 
> -- 
> Best Regards
> Masahiro Yamada
