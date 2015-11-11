From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 11 Nov 2015 11:30:40 +0200
Subject: How to implement common clk in multi function controller?
In-Reply-To: <CAK7LNASM+tJpd-kBHGHe7TXWm4i-UEfbq7T3dn99p2fKFwtxAA@mail.gmail.com>
References: <CAK7LNASM+tJpd-kBHGHe7TXWm4i-UEfbq7T3dn99p2fKFwtxAA@mail.gmail.com>
Message-ID: <56430AC0.5090707@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On 11.11.2015 05:16, Masahiro Yamada wrote:
> Hi.
> 
> I am implementing clk and reset drivers for my SoCs.
> (drivers/clk/uniphier/* and drivers/reset/uniphier/*)
> 
> 
> In my SoCs, one hardware block contains various
> registers for both clock and reset controlling.
> (so, it is like a MFD system controller device).
> I think it is a common case.
> 

I met the same problem with LPC32xx clocks, one hardware block
contains clock controller, power controller, wakeup
controllers and partially pinmux and dma configuration.

I've sent a mmio version for review some time ago, but I had
to change interface to regmap recently.

> I am guessing my device tree would be like follows:
> (one syscon device contains clk and rst devices under it)
> 
> syscon {
>      compatible = "socionext,uniphier-syscon",
>                  "syscon", "simple-mfd";
>      reg = <...   ...>;
> 
>      clk_ctrl {
>             .compatible = "socionext,uniphier-clkctrl";
>             #clock-cells = <1>;
>      };
> 
>      rst_ctrl {
>              .compatible = "socionext,uniphier-rstctrl";
>              #reset-cells = <1>;
>      };
> };
> 

Eventually I implement the same layout, but replace "syscon" and
"simple-mfd" with "simple-bus" only.

For a single interface syscon_node_to_regmap() I don't see a point to
add a dependency on MFD and syscon.

> 
> One problem I noticed was,
> we are supposed to use regmap for register access
> if we use syscon.
>
> OTOH, common clk APIs such as clk-gate, clk-divider
> expect simple register access via writel()/readl().
> 
> Is it a good idea to expand such APIs to regmap?

It might be a good idea.

> 
> Of course, I could my own uniphier/clk-gate.c
> to use regmap as other SoCs do.
> 
> But, I think regmap is general demand, so
> I am wondering if it could be supported in common parts.
> 
> Or, any other good solution exists?
>

I had to copy low-level parts from clk-gate, clk-divider and clk-mux to
my driver and reimplement them on regmap API, of course I won't call
this as a good solution, but if regmap is unavoidable, that's what remains.

--
With best wishes,
Vladimir
