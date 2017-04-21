From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 09:46:58 +0800
Subject: [linux-sunxi] Re: [PATCH v2 1/6] clk: sunxi-ng: Add sun4i/sun7i
 CCU driver
In-Reply-To: <20170420195917.GA16113@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
 <20170327075438.cw3d6s7zyeemenwr@lukather> <20170404200919.GA22159@plaes.org>
 <20170407133805.aiythp3hdvuyhcrc@lukather> <20170420195917.GA16113@plaes.org>
Message-ID: <CAGb2v66iNddKty4ObeGuVRDOp1NV-9A6=cg7omGMiDLJe7T_=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 3:59 AM, Priit Laes <plaes@plaes.org> wrote:
> On Fri, Apr 07, 2017 at 03:38:05PM +0200, Maxime Ripard wrote:
>> Hi Priit,
>>
>> On Tue, Apr 04, 2017 at 08:09:19PM +0000, Priit Laes wrote:
>> > > > +/* Not documented on A10 */
>> > > > +static SUNXI_CCU_GATE(pll_periph_sata_clk, "pll-periph-sata", "pll-periph",
>> > > > +                     0x028, BIT(14), 0);
>> > >
>> > > The rate doesn't come from pll-periph directly, does it?
>> >
>> > So it uses hosc (24MHz parent clock) instead of pll-periph?
>>
>> I never looked too much at this, but it looks more like the input is
>> pll-periph-sata itself.
>
> OK, I think I have now fixed most of the issues thanks to Maxime and Chen-Yu
> and I'm almost ready to send out V3.
>
> From my side there is only single issue remaining - how to create "sata-ext"
> clock?
>
> [snip]
> static struct ccu_div pll_periph_sata_clk = {
>         .enable         = BIT(14),
>         .div            = _SUNXI_CCU_DIV(0, 2),
>         .common         = {
>                 .prediv         = 6,
>                 .reg            = 0x028,
>                 .features       = CCU_FEATURE_ALL_PREDIV,
>                 .hw.init        = CLK_HW_INIT("pll-periph-sata",
>                                               "pll-periph-base",
>                                               &ccu_nk_ops, 0),
>         },
> };
>
> static const char* const sata_parents[] = {"pll-periph-sata", "sata-ext"};
> static SUNXI_CCU_MUX_WITH_GATE(sata_clk, "sata", sata_parents,
>                                0x0c8, 24, 1, BIT(31), 0);
> [/snip]
>
> Should I create a fixed-clock node in the dtsi:
>
> sata-ext: clk at 0 {
>         #clock-cells = <0>;
>         compatible = "fixed-clock";
>         clock-frequency = <200000000>;
>         clock-output-names = "sata-ext";
> };

You can just leave it missing. You probably shouldn't register it
if it's not populated. The clk core can cope with missing parents,
as long as they aren't all missing.

>
> And would it also need pio definition?

Nope. It has dedicated pins.

ChenYu
