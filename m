From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Nov 2015 17:47:50 +0800
Subject: How to implement common clk in multi function controller?
In-Reply-To: <CAK7LNASM+tJpd-kBHGHe7TXWm4i-UEfbq7T3dn99p2fKFwtxAA@mail.gmail.com>
References: <CAK7LNASM+tJpd-kBHGHe7TXWm4i-UEfbq7T3dn99p2fKFwtxAA@mail.gmail.com>
Message-ID: <CAGb2v669XZQy6=MCdLBHZrjcS4GVn_0FqbHJ-pYeba-BL5VYtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 11, 2015 at 11:16 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
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

sunxi uses a "instance per register" design, that is each
register corresponds to one (or more, in rare cases) clock
or reset control. Each will get a separate device node in
the DT.

For registers that have both clocks and resets, they are
combined in a single driver if it makes sense (for example
serving the same set of peripherals).

See drivers/clk/sunxi/clk-usb.c for such a driver.


Regards
ChenYu

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
>
>
> One problem I noticed was,
> we are supposed to use regmap for register access
> if we use syscon.
>
> OTOH, common clk APIs such as clk-gate, clk-divider
> expect simple register access via writel()/readl().
>
> Is it a good idea to expand such APIs to regmap?
>
>
> Of course, I could my own uniphier/clk-gate.c
> to use regmap as other SoCs do.
>
> But, I think regmap is general demand, so
> I am wondering if it could be supported in common parts.
>
> Or, any other good solution exists?
>
>
>
> --
> Best Regards
> Masahiro Yamada
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
