From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 11 Nov 2015 12:16:27 +0900
Subject: How to implement common clk in multi function controller?
Message-ID: <CAK7LNASM+tJpd-kBHGHe7TXWm4i-UEfbq7T3dn99p2fKFwtxAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

I am implementing clk and reset drivers for my SoCs.
(drivers/clk/uniphier/* and drivers/reset/uniphier/*)


In my SoCs, one hardware block contains various
registers for both clock and reset controlling.
(so, it is like a MFD system controller device).
I think it is a common case.


I am guessing my device tree would be like follows:
(one syscon device contains clk and rst devices under it)

syscon {
     compatible = "socionext,uniphier-syscon",
                 "syscon", "simple-mfd";
     reg = <...   ...>;

     clk_ctrl {
            .compatible = "socionext,uniphier-clkctrl";
            #clock-cells = <1>;
     };

     rst_ctrl {
             .compatible = "socionext,uniphier-rstctrl";
             #reset-cells = <1>;
     };
};



One problem I noticed was,
we are supposed to use regmap for register access
if we use syscon.

OTOH, common clk APIs such as clk-gate, clk-divider
expect simple register access via writel()/readl().

Is it a good idea to expand such APIs to regmap?


Of course, I could my own uniphier/clk-gate.c
to use regmap as other SoCs do.

But, I think regmap is general demand, so
I am wondering if it could be supported in common parts.

Or, any other good solution exists?



-- 
Best Regards
Masahiro Yamada
