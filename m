From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 10:54:17 +0100
Subject: [PATCH v2 01/10] arm: zynq: Use standard timer binding
In-Reply-To: <20130327093714.GF16139@pengutronix.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <dcbc38c6f1e319a31693ef0d69195fafc42a5de0.1364319776.git.michal.simek@xilinx.com>
 <20130326201401.GA19679@pengutronix.de>
 <CAHTX3d+OPOmjCTBkgiSy5mjbLw+zEOe9G39g0kDmn=pWFdcrUA@mail.gmail.com>
 <20130327090434.GE16139@pengutronix.de>
 <CAHTX3dJxs3-X-ACMdAERuhCWMj=GadPXbrOm19KW08jaRVwBBA@mail.gmail.com>
 <20130327093714.GF16139@pengutronix.de>
Message-ID: <CAHTX3dK0T3cV6_P-oG9Ra=8Pw4hURpeZVY7vFyxK1Gm=PhRzYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> On Wed, Mar 27, 2013 at 10:25:30AM +0100, Michal Simek wrote:
>> 2013/3/27 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>> > On Wed, Mar 27, 2013 at 08:40:36AM +0100, Michal Simek wrote:
>> >> 2013/3/26 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>> >> > On Tue, Mar 26, 2013 at 06:43:33PM +0100, Michal Simek wrote:
>> >> >> Use cdns,ttc because this driver is Cadence Rev06
>> >> >> Triple Timer Counter and everybody can use it
>> >> >> without xilinx specific function name or probing.
>> >> >>
>> >> >> Also use standard dt description for timer
>> >> >> and also prepare for moving to clocksource
>> >> >> initialization.
>> >> >>
>> >> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> >> >> ---
>> >> >> v2: Update year in copyright
>> >> >>     Fix typo fault
>> >> >>     Remove all zynq specific names
>> >> >>
>> >> >> Steffen: I have done this change based on our discussion.
>> >> >> Moving to generic location will be done in the next patch.
>> >> >>
>> >> >> Josh: We have talked about this change at ELC.
>> >> >> Using standard dt binding as other timers.
>> >> >>
>> >> >> I have also discussed this with Rob some time ago.
>> >> >> https://patchwork.kernel.org/patch/2112791/
>> >> >> ---
>> >> >>  arch/arm/boot/dts/zynq-7000.dtsi |   45 +------
>> >> >>  arch/arm/boot/dts/zynq-zc702.dts |   10 --
>> >> >>  arch/arm/mach-zynq/common.c      |    1 +
>> >> >>  arch/arm/mach-zynq/timer.c       |  261 +++++++++++++++++++++++++++-----------
>> >> >>  4 files changed, 195 insertions(+), 122 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> >> >> index 5914b56..51243db 100644
>> >> >> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> >> >> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> >> >> @@ -111,56 +111,23 @@
>> >> >>               };
>> >> >>
>> >> >>               ttc0: ttc0 at f8001000 {
>> >> >> -                     #address-cells = <1>;
>> >> >> -                     #size-cells = <0>;
>> >> >> -                     compatible = "xlnx,ttc";
>> >> >> +                     interrupt-parent = <&intc>;
>> >> >> +                     interrupts = < 0 10 4 0 11 4 0 12 4 >;
>> >> >> +                     compatible = "cdns,ttc";
>> >> >>                       reg = <0xF8001000 0x1000>;
>> >> >>                       clocks = <&cpu_clk 3>;
>> >> >>                       clock-names = "cpu_1x";
>> >> >>                       clock-ranges;
>> >> >> -
>> >> >> -                     ttc0_0: ttc0.0 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <0>;
>> >> >> -                             interrupts = <0 10 4>;
>> >> >> -                     };
>> >> >> -                     ttc0_1: ttc0.1 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <1>;
>> >> >> -                             interrupts = <0 11 4>;
>> >> >> -                     };
>> >> >> -                     ttc0_2: ttc0.2 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <2>;
>> >> >> -                             interrupts = <0 12 4>;
>> >> >> -                     };
>> >> >>               };
>> >> >>
>> >> >>               ttc1: ttc1 at f8002000 {
>> >> >> -                     #interrupt-parent = <&intc>;
>> >> >> -                     #address-cells = <1>;
>> >> >> -                     #size-cells = <0>;
>> >> >> -                     compatible = "xlnx,ttc";
>> >> >> +                     interrupt-parent = <&intc>;
>> >> >> +                     interrupts = < 0 37 4 0 38 4 0 39 4 >;
>> >> >> +                     compatible = "cdns,ttc";
>> >> >>                       reg = <0xF8002000 0x1000>;
>> >> >>                       clocks = <&cpu_clk 3>;
>> >> >>                       clock-names = "cpu_1x";
>> >> >>                       clock-ranges;
>> >> >> -
>> >> >> -                     ttc1_0: ttc1.0 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <0>;
>> >> >> -                             interrupts = <0 37 4>;
>> >> >> -                     };
>> >> >> -                     ttc1_1: ttc1.1 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <1>;
>> >> >> -                             interrupts = <0 38 4>;
>> >> >> -                     };
>> >> >> -                     ttc1_2: ttc1.2 {
>> >> >> -                             status = "disabled";
>> >> >> -                             reg = <2>;
>> >> >> -                             interrupts = <0 39 4>;
>> >> >> -                     };
>> >> >>               };
>> >> >>       };
>> >> >>  };
>> >> >
>> >> > Hi Michal!
>> >> >
>> >> > Thought about this a little more. I'm not seeing the improvment this gives us.
>> >> > The ttcs give us 6 counters that could be used however one likes. Linux wants
>> >> > a clocksource and clockevent provider, but I could use the Cortex timer as
>> >> > clocksource and would only have to sacrifice one of the 6 counters.
>> >> > With this patch I have to sacrifice 3 counters and would only use 2 of them.
>> >> > Then there is pinmuxing. That can be handled by one driver, so I think that is
>> >> > doable with both versions and I think I'm okay with that.
>> >> > So what am I missing? Why would I want it like this and not the way it is right
>> >> > now?
>> >>
>> >> There is a big move because previous DT description was incorrect.
>> >> Device-tree should describe hardware and there is no something like
>> >> ttc-counter-clocksource or ttc-counter-clockevent compatible driver.
>> >> Every ttc counter can be used as clocksource or clockevent.
>> >> Changing/Setting compatible properties for linux purpose is not correct.
>> >>
>> >
>> > That is correct. DT describes the HW and the TTC includes three counters that
>> > could be used in any way a HW vendor likes. How would you decide that with
>> > just the driver?
>> > The compatible property is uncommon and might even be wrong. How about adding
>> > for example a mode-property like usb does for otg,peripheral,host?
>>
>> I don't think that this is right thing to do.
>> Rob: What do you think?
>>
>> > Suppose I have some obscure board with a Zynq on it, that has ttc1_0 setup to
>> > count some external signal and ttc1_1 counts some signal from the PL. I mean
>> > it is possible to configure the SoC in that way, no?!
>>
>> If you are on ttc1 then it should be fine because ttc0 should be probed first
>> and ttc1 is not allocated but look below.
>>
>> > I would than have a board-specific dts where I would somehow have to describe
>> > this setup and mark the different ttcs accordingly.
>>
>> I understand your setup and I am not aware if there is any standard
>> way how to handles
>> other timers in the system to be able to work with them via standard api.
>> What do you use? UIO for ttc setup and reading it back?
>>
>
> Oh, I don't have this setup. I'm just imagining things and how we could then
> handle this setup, if it ever occurs. When this binding is fixed it is fixed.
> At the moment it might be okay to rework this, as current mainline only works
> under certain circumstances and there is probably no one really using it as of yet.
>
>> > What I'm going for is, what is wrong in having the subnodes in ttc and
>> > then iterate over these subnodes in the driver and registering the first two
>> > ttcs that I find and that support being used as clocksource/event?
>>
>> I understand your concern but the question is how to describe this in
>> dts in a proper way.
>> Compatible property - no
>
> Agreed.
>
>> Based on aliases order - possible but based on my discussion with Rob
>> probably no
>
> Agreed.
>
>> Additional mode options - it is also suggesting Linux specific usage.
>>
>
> Hm, it would specify the capabilities of the ttc. Other users of the DT
> might be interested in this info, too. I'm not saying it is the best/only
> solution.

But the capabilities for all 2 ttc (6 timers) will be the same because
they are the same
and all of them can do the same things.

I am definitely willing to find out any generic solution and the reason
for this patch is that the current dt description is not correct and based
on my discussion with Rob this was the solution which others are also using.

In the valid case you have described above there are some things which can
be easy to handle on zynq - if you know that the first two timers are used
by linux because of the code then changing input to 3rd timer your hw design
should be possible (not sure if ttc can handle input but in generic
case definitely yes).

But I can imagine case where the system has some limitations and for this
purpose you have to use the first counter and currently you have no option
how to describe this in the device-tree.
It means there should be any user input to the system to say - not to
use this timer
for Linux purpose. And DTS is only one user input to the kernel that's why
it should be written there.
Describe this in chosen node?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
