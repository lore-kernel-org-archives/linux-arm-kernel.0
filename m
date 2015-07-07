From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 7 Jul 2015 23:10:37 +0800
Subject: [PATCH] arm64: dts: mt8173: add clock_null
In-Reply-To: <20150707143621.GW18700@pengutronix.de>
References: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
 <20150707130732.GD18561@pengutronix.de>
 <CAGS+omCgSjLZ2Ae5DqfmEm-2BrxQqw2ztxUCxBSngNSXxabtbg@mail.gmail.com>
 <20150707143621.GW18700@pengutronix.de>
Message-ID: <CAGS+omChOC-EYsmA5ytT+ho0UXvcL1-mjK4Z8=EgboKzwWmtyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 7, 2015 at 10:36 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Jul 07, 2015 at 10:15:29PM +0800, Daniel Kurtz wrote:
>> On Tue, Jul 7, 2015 at 9:07 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Thu, Jun 18, 2015 at 01:29:11PM +0800, Eddie Huang wrote:
>> >> Add clk_null, which represents clocks that can not / need not
>> >> controlled by software.
>> >> There are many clocks' parent set to clk_null.
>> >>
>> >> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>> >> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> >> ---
>> >> Base on 4.1-rc1
>> >>
>> >> Change-Id: I4db9b40d07e28f54f7bae9b676316cbd6a962124
>> >> ---
>> >>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> >> index 924fdb6..4798f44 100644
>> >> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> >> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> >> @@ -81,6 +81,12 @@
>> >>               cpu_on        = <0x84000003>;
>> >>       };
>> >>
>> >> +     clk_null: clk_null {
>> >> +             compatible = "fixed-clock";
>> >> +             clock-frequency = <0>;
>> >> +             #clock-cells = <0>;
>> >> +     };
>> >
>> > The discussion around this patch shows that we don't want to have this
>> > clock in the device tree as it is not a hardware description.
>> >
>> > Ok, fine. Eddie, you told us that the rate of the current clk_null children
>> > is not interesting. What's the motivation to send this patch anyway
>> > then? Why can't you keep its children on the orphan list where they are
>> > already now?
>> >
>> > Another possibility would be to instantiate the clk_null clock from C
>> > code rather than from the device tree. This way we wouldn't put any
>> > wrong descriptions into the device tree and still can implement the
>> > support for the real parent clocks when we actually need them.
>>
>> Some device nodes, like mmc, use a clk_null phandle as one of their clocks:
>>
>> mmc1: mmc at 11240000 {
>>         compatible = "mediatek,mt8173-mmc",
>>                      "mediatek,mt8135-mmc";
>>         reg = <0 0x11240000 0 0x1000>;
>>         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>>         clocks = <&pericfg CLK_PERI_MSDC30_1>,
>>                  <&clk_null>;
>>         clock-names = "source", "hclk";
>>         status = "disabled";
>> };
>
> This is another case than the one we discussed about. In the case above
> I motivated using a dummy clock since the clock exists in the system,
> but is not software controllable. To abstract this from the driver
> (which needs this clock since it exists) we here have the dummy clock.
> However, of course I can't prove the clock is indeed not software
> controllable; that's only the information I have.

I was trying to answer your question "What's the motivation to send
this patch anyway?".
The motivation is to send follow on patches that use the clk_null
phandle.  We need to provide some clock as the mmc1's hclk.  I do not
understand why this has to be "clk_null", though.  It seems like this
should be a real clock coming from one of the real clock_controller
nodes.  After all, the mmc driver is going to be enabling/disabling
this clock for power savings at runtime.  What does that even mean for
clk_null ?

Sorry, I'm not exactly sure what you are saying in your last reply.

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
