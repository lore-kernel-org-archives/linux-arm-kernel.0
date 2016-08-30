From: dianders@chromium.org (Doug Anderson)
Date: Tue, 30 Aug 2016 13:17:24 -0700
Subject: [PATCH] arm64: dts: rockchip: Explicitly set pclk_pmu_src on
 rk3399
In-Reply-To: <20160830170635.GA129134@google.com>
References: <1472494284-11315-1-git-send-email-dianders@chromium.org>
 <20160829181841.GA8682@localhost> <57C4DA73.5000505@rock-chips.com>
 <4298293.ZqJ4n19bHK@diego> <20160830170635.GA129134@google.com>
Message-ID: <CAD=FV=U9F5uYeZc0m1b0B5KNX5PnP6w+-_tT1bhQf1tEv9TxSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 30, 2016 at 10:06 AM, Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Aug 30, 2016 at 09:05:06AM +0200, Heiko Stuebner wrote:
>> Am Dienstag, 30. August 2016, 08:59:31 schrieb Elaine Zhang:
>> > On 08/30/2016 02:18 AM, Brian Norris wrote:
>> > > On Mon, Aug 29, 2016 at 11:11:24AM -0700, Doug Anderson wrote:
>> > >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> > >> @@ -908,8 +908,8 @@
>> > >>
>> > >>                  reg = <0x0 0xff750000 0x0 0x1000>;
>> > >>                  #clock-cells = <1>;
>> > >>                  #reset-cells = <1>;
>> > >>
>> > >> -                assigned-clocks = <&pmucru PLL_PPLL>;
>> > >> -                assigned-clock-rates = <676000000>;
>> > >> +                assigned-clocks = <&pmucru PLL_PPLL>, <&pmucru PCLK_SRC_PMU>;
>> > >> +                assigned-clock-rates = <676000000>, <112666667>;
>> > >
>> > > I think this makes sense and is a good idea. One alternative would be to
>> > > have the various children actually set a rate that they expect, but
>> > > several of them don't have a separate driver at all, and that would be
>> > > of dubious value anyway I think.
>> >
>> > I agree with you. This clk default div is set in the uboot or coreboot.
>> > And if is need to set in kernel ,I hope the freq is 50M(<48285714>).
>> > This freq can meet the performance,and the power consumption is not too
>> > much.
>>
>> can you maybe also provide a tag like the one Brian did below. Your sentence
>> above indicates that you reviewed and approve, but it's helpful to also state
>> that explicitly :-)

Also, I actually realized that I may want to NAK my own patch and
possibly want to suggest doing the opposite: removing the set of
"PPLL" from the dtsi and moving it into the board .dts files for any
boards that need it.

Specifically on out rk3399 boards we use PWM regulators for all the
major rails in the system.  The firmware inits the PWMs to give the
system a good voltage and then boots the kernel.  The kernel reads the
PWMs to find out what the boot voltage was.

That whole scheme only works if the PWM's clock doesn't get mucked
with at bootup.  ...and the PWM's clock is derived from "pclk_pmu_src"
which comes from PPLL.

So it's actually very important that we _don't_ mess with whatever the
firmware set here and that the firmware set something sane.

> If I understand Elaine correctly, that's not actually a full agreement;
> it looks like a suggestion to change that from 112 MHz to 48.2 MHz. I
> haven't tested that out personally yet, but if that's a formal
> recommendation from Rockchip, we'd like to know more about it :)

Yes, if this is a good idea we should update our firmware to do it.

-Doug
