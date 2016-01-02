From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 2 Jan 2016 10:26:05 +0900
Subject: [PATCH v2,
 RESEND] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <20151231013511.21505.59601@quark.deferred.io>
References: <1451298058-28910-1-git-send-email-yamada.masahiro@socionext.com>
 <20151231013511.21505.59601@quark.deferred.io>
Message-ID: <CAK7LNARHuogHfsSyXVkkoakOq61xfhYJOa08cC7tvvn1kdPRoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,


2015-12-31 10:35 GMT+09:00 Michael Turquette <mturquette@baylibre.com>:
> Hello Yamada-san,
>
> Quoting Masahiro Yamada (2015-12-28 02:20:58)
>> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
>> new file mode 100644
>> index 0000000..7606f27
>> --- /dev/null
>> +++ b/drivers/clk/uniphier/Kconfig
>> @@ -0,0 +1,35 @@
>> +menuconfig CLK_UNIPHIER
>> +       bool "Clock drivers for UniPhier SoCs"
>> +       depends on ARCH_UNIPHIER
>
> Might want to make the above line:
>
>         depends on ARCH_UNIPHIER || COMPILE_TEST
>
>> +       depends on OF
>> +       default y
>> +       help
>> +         Supports clock drivers for UniPhier SoCs.
>
> Why menuconfig? Can we make this a non-visible config option selected by
> the UniPhier platform?

Yes, I can do that if you like.

Do you prefer to making it flat, like all clocks are shown in the
"Common Clock Framework" menu?

Or, is it better to categorize SoC clocks with "menu" for each SoC family?



>> +
>> +if CLK_UNIPHIER
>
> Please drop the if statement here and have the below options 'depends'
> on CLK_UNIPHIER.

Why is it bad?

I think surrounding all the options with "if CLK_UNIPHIER" ... "endif"
is easier than adding "depends on CLK_UNIPHIER" to each of them.



>> +
>> +config CLK_UNIPHIER_PH1_SLD3
>> +       bool "Clock driver for UniPhier PH1-sLD3 SoC"
>> +       default y
>
> Can you make these drivers into loadable modules? If so you might
> consider tristate.

For some, I can.
For some, I can't (because they must provide an input clock for the timer.)


>> +
>> +static void __init ph1_ld4_clk_init(struct device_node *np)
>> +{
>> +       uniphier_clk_init(np, ph1_ld4_clk_idata);
>> +}
>> +CLK_OF_DECLARE(ph1_ld4_clk, "socionext,ph1-ld4-sysctrl", ph1_ld4_clk_init);
>
> Can you avoid using CLK_OF_DECLARE and instead make this into a
> platform_driver? For examples please see drivers/clk/qcom*.c


For clk-uniphier-peri.c and clk-uniphier-mio.c, yes.
They provide clocks for peripheral devices like USB, MMC, etc., so I
can delay them.


For clk-ph1-*.c, I am afraid I can't.
They provide an input clock for the timer (ARM global timer).
I think they should be initialized very early.


Is platform_driver better than CLK_OF_DECLARE() where it is possible?

I just chose CLK_OF_DECLARE() for consistency
and it seems the majority.



>> +
>> +static void __init uniphier_clk_update_parent_name(struct device_node *np,
>> +                                                  const char **parent_name)
>> +{
>> +       const char *new_name;
>> +       int index;
>> +
>> +       if (!parent_name || !*parent_name)
>> +               return;
>> +
>> +       if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
>> +               return;
>> +
>> +       index = of_property_match_string(np, "clock-names",
>> +                               *parent_name + strlen(UNIPHIER_CLK_EXT));
>> +       new_name = of_clk_get_parent_name(np, index);
>> +       if (new_name)
>> +               *parent_name = new_name;
>
> Where can I find the DT binding description and DTS for this clock
> controller? I'm confused why the parent name function is necessary and
> I'd like to see the data.


clk_register() needs the name strings of parent clocks,
not pointers to parent clocks.
(It looks a bit odd to me, although it allows us to register clocks in
any order.
In stead, we have to think about orphan-walking.)
So, we need to exactly know the names of parent clocks.

Let's assume the clock system that consists of some hardware blocks.


  root_clk: root_clk {
        compatible = "foo-clk";
        reg = <0x10000000 0x1000>;
        #clock-cells = <1>;
  };

  bar_clk {
        compatible = "bar-clk";
        reg = <0x20000000 0x1000>;
        #clock-cells = <1>;
        clock-names = "input"
        clocks = <&root_clk 0>;
   };

  baz_clk {
        compatible = "baz-clk";
        reg = <0x30000000 0x1000>;
        #clock-cells = <1>;
        clock-names = "input"
        clocks = <&root_clk 1>;
   };



The "bar_clk" is a clock provider for other peripherals,
and also a consumer of "root_clk".

The "bar_clk" wants to know the name of index 0 of root_clk
because it is needed when calling clk_register().


Let's say the names of clocks provided root_clk are, "for-bar123", "for-baz456".

The "bar_clk" needs the string "for-bar123", but it does not know.
(Likewise, the "baz_clk" needs the string "for-baz456", but it does not know.)

Of course, I can hard-code "for-bar123" in the driver of "bar_clk",
but I think it is annoying to keep the name synced between the
provider and the consumer.

So, I implemented uniphier_clk_update_parent_name()
to convert the clock-names into the parent clock name.
In this case, this function takes "input" and converts it into "for-bar123".


Is there any good idea to solve this problem?


-- 
Best Regards
Masahiro Yamada
