From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Feb 2015 15:27:18 +0000
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmgvQLSOXGHmDhFKKV+UGLGeZXf2dpOYWzALYTRsYp9D7g@mail.gmail.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
 <20150206104420.GB9921@leverpostej>
 <CAAS=xmhcfeQjfyizJa38k+08pbY5WFOZH0a1wEx+gwqgVe0MXw@mail.gmail.com>
 <20150210133734.GC9432@leverpostej>
 <CAAS=xmgvQLSOXGHmDhFKKV+UGLGeZXf2dpOYWzALYTRsYp9D7g@mail.gmail.com>
Message-ID: <20150210152718.GE9432@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> >> > Are we certain of the split between components the PSCI implementation
> >> >> > must touch and those the kernel must touch?
> >> >> >
> >> >> >> Also add dts file to support HiKey development board which
> >> >> >> based on Hi6220 SoC and document the devicetree bindings.
> >> >> >>
> >> >> >> These dts files will be changed later and more nodes will be
> >> >> >> added to describe other devices.
> >> >> >
> >> >> > How is this going to be changed other than the addition of nodes?
> >> >> >
> >> >> > Will this DTB continue to work in future? Or do you intend to make
> >> >> > changes that will break support?
> >> >> My original idea is: use spin-table for SMP now, when firmware is OK to
> >> >> support PSCI, we submit another patch to replace the spin-table with PSCI.
> >> >
> >> > For any users who have not updated their FW, this will break booting.
> >> >
> >> > This is why I suggest having hte bootloader/FW fill this in as it should
> >> > know what enable-method the FW supports.
> >> >
> >> >> If DTB should continue to work in the future, we really need to remove
> >> >> the spin-table
> >> >> from current dts file, how about just enable one core now?
> >> >>
> >> >> Which one do you favor or any other suggestion?
> >> >
> >> > If spin-table is just for testing while you await PSCI, drop spin-table
> >> > from the dts for now.
> >> So, just booting one core may be the right choice now, right?
> >
> > Without an enable-method for secondary CPUs, that will be all that's
> > possible. If your FW/bootlaoder injects the appropriate enable-method,
> > then you could gain spin-table based SMP bringup while awaiting PSCI,
> > without there being a DTB compatibility issue.
> For DTB compatibility issue, how about just describe one core in dts
> file? when PSCI
> is OK, we can add the CPU topology to the dts file again.

Given that we won't boot secondary CPUs without an enable-method, we
could leave them in, but in a currently-unusable state. That would allow
a bootloader to patch in the relevant properties to boot them.

If you add the nodes later with PSCI properties, users with existing
firmware will expect their board to boot. So I'd recommendd that the
bootloader patches that in, or that the firmware is ready prior to this
being merged. I suspect that the former is more likely to be possible.

> > [...]
> >
> >> >> >> +             pm_ctrl: pm_ctrl {
> >> >> >> +                     compatible = "hisilicon,pmctrl", "syscon";
> >> >> >> +                     #address-cells = <1>;
> >> >> >> +                     #size-cells = <1>;
> >> >> >> +                     reg = <0x0 0xf7032000 0x0 0x1000>;
> >> >> >> +                     ranges = <0 0x0 0xf7032000 0x1000>;
> >> >> >> +
> >> >> >> +                     clock_power: clock3 at 0 {
> >> >> >> +                             compatible = "hisilicon,hi6220-clock-power";
> >> >> >> +                             reg = <0 0x1000>;
> >> >> >> +                             #clock-cells = <1>;
> >> >> >> +                     };
> >> >> >> +             };
> >> >> >
> >> >> > I really doesn't see the point in having a sub-device that covers the
> >> >> > entirely of the register space of the containing node, and that being
> >> >> > the case I am extremely concerned that the containers are marked as
> >> >> > syscon compatible.
> >> >> The SoC clocks are designed and placed under different system controllers,
> >> >> so I define corresponding nodes under different controllers for clock operation.
> >> >
> >> > What I'm concerned wit hhere is that the pm_ctrl node and the clock3 at 0
> >> > sub-node have the _exact_ same register space.
> >> >
> >> > Given this should mean that the clock3 at 0 node owns that register space,
> >> > having the container node export this as syscon does not make sense. And
> >> > the split between pm_ctrl and clock3@) doesn't seem to make sense given
> >> > they cover the same space.
> >> I understand your worry and will find the max offset of those clocks
> >> under this controller.
> >>
> >> >
> >> > As I asked before, why is pm_ctrl marked as a syscon, and what's the
> >> > point of the separate sub-node?
> >> There is no big difference between pm_ctrl and other controller,  they
> >> are all designed as
> >> the base address to control some functions of other modules (certainly
> >> include some clock gates).
> >
> > Are they just different instances of the same IP block, or are there
> > fundamental differences between them?
> You can understand it as a different instance of the same IP block,
> there is no fundamental
> differences between them.

Ok. If that's the case each should have the same compatible string.

Thanks,
Mark.
