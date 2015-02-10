From: wangbintian@gmail.com (Brent Wang)
Date: Tue, 10 Feb 2015 22:20:46 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150210133734.GC9432@leverpostej>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
 <20150206104420.GB9921@leverpostej>
 <CAAS=xmhcfeQjfyizJa38k+08pbY5WFOZH0a1wEx+gwqgVe0MXw@mail.gmail.com>
 <20150210133734.GC9432@leverpostej>
Message-ID: <CAAS=xmgvQLSOXGHmDhFKKV+UGLGeZXf2dpOYWzALYTRsYp9D7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

2015-02-10 21:37 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Feb 06, 2015 at 03:37:52PM +0000, Brent Wang wrote:
>> Hello Mark,
>>
>> 2015-02-06 18:44 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
>> > On Fri, Feb 06, 2015 at 08:42:22AM +0000, Brent Wang wrote:
>> >> Hello Mark,
>> >>
>> >> 2015-02-06 3:30 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
>> >> > On Thu, Feb 05, 2015 at 09:24:37AM +0000, Bintian Wang wrote:
>> >> >> Add initial dtsi file to support Hisilicon Hi6220 SoC with
>> >> >> support of Octal core CPUs in two clusters and each cluster
>> >> >> has quard Cortex-A53.
>> >> >>
>> >> >> We now use the "spin-table" method for SMP, and it will be
>> >> >> changed to PSCI later.
>> >> >
>> >> > If that's the case, please don't place the enable-method and related
>> >> > properties in this file. Get your bootloader to add the appropriate
>> >> > properties for its boot protocol.
>> >> >
>> >> > When is PSCI likely to appear?
>> >> PSCI is under development.
>> >
>> > Sure. Do you have an estimate as to when it will appear?
>> Another team will do the job, I can not give my estimation now.
>
> Ok.
>
>> > What are you using for your PSCI implementation? The ARM Trusted
>> > Firmware?
>> Yes, ATF.
>> >
>> > How are you testing it?
>> I think cpu hotplug can test it.
>>
>> >
>> >> > Are we certain of the split between components the PSCI implementation
>> >> > must touch and those the kernel must touch?
>> >> >
>> >> >> Also add dts file to support HiKey development board which
>> >> >> based on Hi6220 SoC and document the devicetree bindings.
>> >> >>
>> >> >> These dts files will be changed later and more nodes will be
>> >> >> added to describe other devices.
>> >> >
>> >> > How is this going to be changed other than the addition of nodes?
>> >> >
>> >> > Will this DTB continue to work in future? Or do you intend to make
>> >> > changes that will break support?
>> >> My original idea is: use spin-table for SMP now, when firmware is OK to
>> >> support PSCI, we submit another patch to replace the spin-table with PSCI.
>> >
>> > For any users who have not updated their FW, this will break booting.
>> >
>> > This is why I suggest having hte bootloader/FW fill this in as it should
>> > know what enable-method the FW supports.
>> >
>> >> If DTB should continue to work in the future, we really need to remove
>> >> the spin-table
>> >> from current dts file, how about just enable one core now?
>> >>
>> >> Which one do you favor or any other suggestion?
>> >
>> > If spin-table is just for testing while you await PSCI, drop spin-table
>> > from the dts for now.
>> So, just booting one core may be the right choice now, right?
>
> Without an enable-method for secondary CPUs, that will be all that's
> possible. If your FW/bootlaoder injects the appropriate enable-method,
> then you could gain spin-table based SMP bringup while awaiting PSCI,
> without there being a DTB compatibility issue.
For DTB compatibility issue, how about just describe one core in dts
file? when PSCI
is OK, we can add the CPU topology to the dts file again.

>
> [...]
>
>> >> >> +             pm_ctrl: pm_ctrl {
>> >> >> +                     compatible = "hisilicon,pmctrl", "syscon";
>> >> >> +                     #address-cells = <1>;
>> >> >> +                     #size-cells = <1>;
>> >> >> +                     reg = <0x0 0xf7032000 0x0 0x1000>;
>> >> >> +                     ranges = <0 0x0 0xf7032000 0x1000>;
>> >> >> +
>> >> >> +                     clock_power: clock3 at 0 {
>> >> >> +                             compatible = "hisilicon,hi6220-clock-power";
>> >> >> +                             reg = <0 0x1000>;
>> >> >> +                             #clock-cells = <1>;
>> >> >> +                     };
>> >> >> +             };
>> >> >
>> >> > I really doesn't see the point in having a sub-device that covers the
>> >> > entirely of the register space of the containing node, and that being
>> >> > the case I am extremely concerned that the containers are marked as
>> >> > syscon compatible.
>> >> The SoC clocks are designed and placed under different system controllers,
>> >> so I define corresponding nodes under different controllers for clock operation.
>> >
>> > What I'm concerned wit hhere is that the pm_ctrl node and the clock3 at 0
>> > sub-node have the _exact_ same register space.
>> >
>> > Given this should mean that the clock3 at 0 node owns that register space,
>> > having the container node export this as syscon does not make sense. And
>> > the split between pm_ctrl and clock3@) doesn't seem to make sense given
>> > they cover the same space.
>> I understand your worry and will find the max offset of those clocks
>> under this controller.
>>
>> >
>> > As I asked before, why is pm_ctrl marked as a syscon, and what's the
>> > point of the separate sub-node?
>> There is no big difference between pm_ctrl and other controller,  they
>> are all designed as
>> the base address to control some functions of other modules (certainly
>> include some clock gates).
>
> Are they just different instances of the same IP block, or are there
> fundamental differences between them?
You can understand it as a different instance of the same IP block,
there is no fundamental
differences between them.

>
>> Maybe only one node is enough, not one node plus one sub-node ?
>
> At least in the case above, I cannot see a reason to have more than a
> single node without a child.
I will fix to one node in next version.

Thank you Mark,

BR,

Bintian

>
> Thanks,
> Mark.
