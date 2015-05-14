From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 13:14:25 +0800
Subject: [PATCH 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <20150512144428.GL10961@lukather>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-3-git-send-email-jenskuske@gmail.com>
 <20150509112718.GT11057@lukather>
 <554F38FA.2030005@gmail.com> <20150512144428.GL10961@lukather>
Message-ID: <CAGb2v663+LrYo0Ke7kDwUnKpyfyxCR6+F2ws2gRaV1D6KFnAyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 10:44 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, May 10, 2015 at 12:54:50PM +0200, Jens Kuske wrote:
>> On 09/05/15 13:27, Maxime Ripard wrote:
>> > On Wed, May 06, 2015 at 11:31:29AM +0200, Jens Kuske wrote:
>> >> The H3 clock control unit is similar to the those of other sun8i family
>> >> members like the A23.
>> >>
>> >> The AHB1 gates got split up into AHB1 and AHB2, with AHB2 clock source
>> >> being muxable between AHB1 and PLL6/2, but still sharing gate registers.
>> >> The documentation isn't totally clear about which devices belong to
>> >> AHB2 now, especially USB EHIC/OHIC, so it is mostly based on Allwinner
>> >> kernel source code.
>> >>
>> >> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
>> >> ---
>> >>  Documentation/devicetree/bindings/clock/sunxi.txt |  7 ++++
>> >>  drivers/clk/sunxi/clk-sunxi.c                     | 46 ++++++++++++++++++++++-
>> >>  2 files changed, 52 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> >> index 4fa11af..4eeb893 100644
>> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> >> @@ -14,6 +14,8 @@ Required properties:
>> >>    "allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
>> >>    "allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
>> >>    "allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
>> >> +  "allwinner,sun8i-h3-pll6-clk" - for the PLL6 clock on H3
>> >> +  "allwinner,sun8i-h3-pll8-clk" - for the PLL8 clock on H3
>> >>    "allwinner,sun9i-a80-gt-clk" - for the GT bus clock on A80
>> >>    "allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
>> >>    "allwinner,sun4i-a10-axi-clk" - for the AXI clock
>> >> @@ -28,8 +30,11 @@ Required properties:
>> >>    "allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
>> >>    "allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
>> >>    "allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
>> >> +  "allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
>> >>    "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>> >>    "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
>> >> +  "allwinner,sun8i-h3-ahb1-gates-clk" - for the AHB1 gates on H3
>> >> +  "allwinner,sun8i-h3-ahb2-gates-clk" - for the AHB2 gates on H3
>> >>    "allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
>> >>    "allwinner,sun9i-a80-ahb1-gates-clk" - for the AHB1 gates on A80
>> >>    "allwinner,sun9i-a80-ahb2-gates-clk" - for the AHB2 gates on A80
>> >> @@ -52,8 +57,10 @@ Required properties:
>> >>    "allwinner,sun6i-a31-apb1-gates-clk" - for the APB1 gates on A31
>> >>    "allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
>> >>    "allwinner,sun8i-a23-apb1-gates-clk" - for the APB1 gates on A23
>> >> +  "allwinner,sun8i-h3-apb1-gates-clk" - for the APB1 gates on H3
>> >>    "allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
>> >>    "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>> >> +  "allwinner,sun8i-h3-apb2-gates-clk" - for the APB2 gates on H3
>> >>    "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
>> >>    "allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>> >>    "allwinner,sun4i-a10-mmc-clk" - for the MMC clock
>> >> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> >> index 7e1e2bd..152a1f7 100644
>> >> --- a/drivers/clk/sunxi/clk-sunxi.c
>> >> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> >> @@ -727,6 +727,12 @@ static const struct factors_data sun5i_a13_ahb_data __initconst = {
>> >>    .getter = sun5i_a13_get_ahb_factors,
>> >>  };
>> >>
>> >> +static const struct factors_data sun8i_h3_pll8_data __initconst = {
>> >> +  .enable = 31,
>> >> +  .table = &sun6i_a31_pll6_config,
>> >> +  .getter = sun6i_a31_get_pll6_factors,
>> >> +};
>> >
>> > This looks like it's just another instance of the A31 pll6.
>> >
>> > In such a case, we don't need to declare a new driver, just reuse the
>> > same compatible.
>>
>> If I reuse pll6 for pll8 I get errors because of the .name = "pll6x2"
>> field, already existing clock or something like that.
>
> Damn. You're obviously right...

I think I have a solution for this.

The current divs clock setup just passes the factors_data directly to
sunxi_factors_register(). What if it did a copy, read the _correct_
name from the DT (since it knows the index) and put it in the copy.

How does that sound?

> Could you add a TODO comment on top then? just so that we know that we
> need to merge this clock with pll6?
>
>> (And pll8 doesn't even have a x2 version)
>
> Judging by the H3 datasheet, it does.
>
>> >>  static const struct factors_data sun4i_apb1_data __initconst = {
>> >>    .mux = 24,
>> >>    .muxmask = BIT(1) | BIT(0),
>> >> @@ -777,6 +783,10 @@ static const struct mux_data sun6i_a31_ahb1_mux_data __initconst = {
>> >>    .shift = 12,
>> >>  };
>> >>
>> >> +static const struct mux_data sun8i_h3_ahb2_mux_data __initconst = {
>> >> +  .shift = 0,
>> >> +};
>> >> +
>> >>  static void __init sunxi_mux_clk_setup(struct device_node *node,
>> >>                                   struct mux_data *data)
>> >>  {
>> >> @@ -892,7 +902,7 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>> >>   * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
>> >>   */
>> >>
>> >> -#define SUNXI_GATES_MAX_SIZE      64
>> >> +#define SUNXI_GATES_MAX_SIZE      160
>> >>
>> >>  struct gates_data {
>> >>    DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
>> >> @@ -926,6 +936,10 @@ static const struct gates_data sun8i_a23_ahb1_gates_data __initconst = {
>> >>    .mask = {0x25386742, 0x2505111},
>> >>  };
>> >>
>> >> +static const struct gates_data sun8i_h3_ahb1_gates_data __initconst = {
>> >> +  .mask = {0x1fbc6760, 0x00701b39, 0x00000000, 0x00000000, 0x00000081},
>> >> +};
>> >> +
>> >
>> > Judging from the user manual, there's a few gates in those 0
>> > registers, is this normal that you don't support them?
>>
>> They are holes for apb1 and apb2. Which is actually pretty ugly.
>
> Ah, right.
>
> So I guess it's completely related to the discussion below.

If the holes are really big, I guess you could split ahb and apb?


ChenYu

>> >>  static const struct gates_data sun9i_a80_ahb0_gates_data __initconst = {
>> >>    .mask = {0xF5F12B},
>> >>  };
>> >> @@ -938,6 +952,10 @@ static const struct gates_data sun9i_a80_ahb2_gates_data __initconst = {
>> >>    .mask = {0x9B7},
>> >>  };
>> >>
>> >> +static const struct gates_data sun8i_h3_ahb2_gates_data __initconst = {
>> >> +  .mask = {0xe0020000},
>> >> +};
>> >> +
>> >
>> > I don't think we should split the ahb1 and ahb2 gates here. It really
>> > looks like it's the same controller.
>> >
>> > The way I'm seeing it would be to have a single clock driver that
>> > would handle both your ahb1 and ahb2 gates.
>> >
>> > It would take two parents, ahb1 and ahb2, obviously, and would take
>> > register depending on the gate w'ere registering either the ahb1 or
>> > the ahb2 parent.
>> >
>> > It seems like there's only a handful of devices in ahb2 anyway, so
>> > that wouldn't make a very long list of devices to declare as childs of
>> > ahb2.
>> >
>>
>> I have thought about adding a bus_gates driver for all ahb1, ahb2, apb1
>> and apb2 gates, as it is done in the user manual.
>>
>> But it would need a pretty big parents array and result in big gate
>> numbers in devicetree, <&bus_gates 112> for uart0 for example.
>>
>> Would this be ok?
>
> I don't see anything wrong with that, as long as we have a clear
> documentation stating where that number comes from.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
