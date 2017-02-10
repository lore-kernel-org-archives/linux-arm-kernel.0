From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Feb 2017 17:59:45 +0800
Subject: [linux-sunxi] Re: [PATCH 5/8] arm64: dts: allwinner: add R_PIO
 node
In-Reply-To: <20170210113215.W9Rqn4js@smtp2m.mail.yandex.net>
References: <20170210113215.W9Rqn4js@smtp2m.mail.yandex.net>
Message-ID: <CAGb2v65L4TBGZo8r=wo_U6grTtutupaoCmZQkNGcyRQoM2EUzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 4:32 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
> 2017?2?10? 16:07? Maxime Ripard <maxime.ripard@free-electrons.com>???
>>
>> On Wed, Feb 08, 2017 at 07:08:46PM +0800, Icenowy Zheng wrote:
>> > 08.02.2017, 18:15, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> > > On Wed, Feb 08, 2017 at 06:00:06PM +0800, Icenowy Zheng wrote:
>> > >>  Allwinner A64 SoC has a R_PIO node like the one in H3.
>> > >>
>> > >>  Add the node as well as needed clocks and resets.
>> > >>
>> > >>  As there's no document for apb0_gates, I only added the R_PIO bit here.
>> > >>
>> > >>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> > >>  ---
>> > >>   arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 40 +++++++++++++++++++++++++++
>> > >>   1 file changed, 40 insertions(+)
>> > >>
>> > >>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> > >>  index 1c64ea2d23f9..4b0baa79554c 100644
>> > >>  --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> > >>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> > >>  @@ -98,6 +98,15 @@
>> > >>                   clock-output-names = "osc32k";
>> > >>           };
>> > >>
>> > >>  + apb0: apb0_clk {
>> > >>  + compatible = "fixed-factor-clock";
>> > >>  + #clock-cells = <0>;
>> > >>  + clock-div = <1>;
>> > >>  + clock-mult = <1>;
>> > >>  + clocks = <&osc24M>;
>> > >>  + clock-output-names = "apb0";
>> > >>  + };
>> > >>  +
>> > >>           psci {
>> > >>                   compatible = "arm,psci-0.2";
>> > >>                   method = "smc";
>> > >>  @@ -392,5 +401,36 @@
>> > >>                           interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>> > >>                                        <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>> > >>                   };
>> > >>  +
>> > >>  + apb0_gates: clk at 1f01428 {
>> > >>  + compatible = "allwinner,sun50i-a64-apb0-gates-clk",
>> > >>  + "allwinner,sun4i-a10-gates-clk";
>> > >>  + reg = <0x01f01428 0x4>;
>> > >>  + #clock-cells = <1>;
>> > >>  + clocks = <&apb0>;
>> > >>  + clock-indices = <0>;
>> > >>  + clock-output-names = "apb0_pio";
>> > >>  + };
>> > >>  +
>> > >>  + apb0_rst: reset at 1f014b0 {
>> > >>  + reg = <0x01f014b0 0x4>;
>> > >>  + compatible = "allwinner,sun6i-a31-clock-reset";
>> > >>  + #reset-cells = <1>;
>> > >>  + };
>> > >
>> > > Please make a sunxi-ng driver for those clocks.
>> >
>> > We have no enough materials to make such a CCU driver.
>> >
>> > Clocks in CPUs are usually undocumented, and difficult to
>> > be collected -- even the clk-sun50iw1.c in BSP do not have
>> > all clocks in CPUs.
>>
>> That's unfortunate, but we can deal with that by simply extending the
>> clocks we have. Nothing too complicated or unconvenient to deal with.
>
> I did a WIP R_CCU driver based on the info on the wiki -- https://github.com/Icenowy/linux/commit/8d215986f4d33ded68c705d4bb152bbb863446c9
>
> Only infomation about H3 and A64 is included, because A31 and A23 PRCM is a MFD, and I have no hackable device with A83T.

The most complex PRCMs (that we know of) are the A80 and the A83T.
Some code can be found for A33 and A64. I cannot find where I got
the information for the A23. I probably assumed it was similar to
the A31.

The parts we know that are constant across SoCs are the register
offsets for the CPUS, APBS, APBS bus gates and reset controls.
The APBS divider is slightly different. Offsets for the gates
and reset controls are fairly standardized, except for the trusted
watchdog on the A80. We can treat the A80 as the canonical source
of possible peripheral gates if you want to do a single driver
for all SoCs.

Also the A8X chips have extra muxes for osc24M not available on
other chips. This should be made available for the main CCU on
them.

As for the ones that already have an MFD binding, it is possible
to support it even with the new driver. It's just going to be
messy as hell.


Regards
ChenYu

>
>>
>> > We should only make it sunxi-ng until it's fully discovered (all
>> > functions in CPUs are functional).
>>
>> No, I expect that by 4.12 we have converted every users to sunxi-ng,
>> PRCM included.
>>
>> Maxime
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux and Kernel engineering
>> http://free-electrons.com
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
