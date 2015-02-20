From: frediano.ziglio@huawei.com (Frediano Ziglio)
Date: Fri, 20 Feb 2015 15:30:27 +0000
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <5508993.D0LPBJ6sy7@wuerfel>
References: <54B48D5E.6050902@hisilicon.com> <4774908.c54zTnV4pN@wuerfel>
 <B944B469BF5302468AC6EB05E56CC70DB3BAA8@lhreml503-mbs.china.huawei.com>
 <5508993.D0LPBJ6sy7@wuerfel>
Message-ID: <B944B469BF5302468AC6EB05E56CC70D1A5AFC0C@lhreml503-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Tuesday 13 January 2015 14:18:16 Frediano Ziglio wrote:
> > > On Tuesday 13 January 2015 18:28:32 Wei Xu wrote:
> > > >
> > > > > Generally speaking it's not ok to change firmware interfaces in
> > > > > an incompatible way. The preferred way to handle this would be
> > > > > to have the firmware that puts the boot wrapper into a
> different
> > > > > place also update this property, if at all possible.
> > > >
> > > > I very agreed with you.
> > > >
> > > > But before we have two kind of firmwares one is boot from SVC
> > > > supporting PXE/NAND/SATA/GRUB booting and the other is boot from
> > > > HYP just supporting NAND booting.
> > > > This time we updated the firmware and made it boot from HYP
> > > supporting
> > > > PXE/NAND/SATA/GRUB as we hoped(thanks for Alex's supporting!).
> > > >
> > > > Since we have to publish a new firmware I think it is a chance to
> > > > update the dts of kernel. How do you think about it?
> > >
> > > The intention is certainly good. If you expect no further
> > > incompatible changes, how about adding another .dts file for this
> > > machine that can work with the old firmware?
> >
> > Would much prefer to have PSCI support instead directly in the
> firmware.
> 
> Makes sense, yes. Is there a timeline for how soon that can be done? If
> we can do it soon enough, we could simply skip this intermediate step
> but instead keep using the original dts with the old firmware and the
> future dts that advertises PSCI support, both in the kernel, but not a
> third one with the partially improved interface here.
> 
> 	Arnd

I finished updating boot wrapper for D01 to support PSCI and more changes. You can find at https://github.com/freddy77/bootwrapper/tree/psci.

This boot loader is expected to be loader at old (0x10c00000) location but it automatically move itself at 0xe00f0000 (code is position independent). This to be able to avoid memory reservation in the DTB file. The PSCI protocol support version 0.2 using smc instruction, I just removed boot wrapper specification in DTS and added

        psci {
                compatible = "arm,psci-0.2", "arm,psci";
                method = "smc";

                cpu_off = <0x84000002>;
                cpu_on  = <0x84000003>;
        };

(this setting is compatible with either version 0.1 or 0.2). Linux and Xen works correctly. It's so compatible with old and new versions of UEFI. Newer kernel should use PSCI and can safely overwrite initial memory (if bootwrapper is loaded at 0x10c00000). Old kernel will use boot wrapper at 0x10c00000 which is protected.

Some issues:
- does not protect memory in secure mode (not a regression, old code are placed into ram without protecting);
- SMC does not test reason (but cannot be called only by EL1/EL2 unless EL2 forbid, not hard to fix however);
- PSCI CPU_ON require that CPU is set to same exception level as caller. Actually it always set CPU in HYP mode (just discovered, not hard to fix);
- I was not able to stably turn off snoop in fabric leading the clusters partially on. Actually code to turn off snoop is commented out. Doing so I'm able to hot unplug and plug any number of CPUs.

Frediano
