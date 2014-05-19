From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 13:17:57 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <20140519104219.GH5113@arm.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
 <20140515142205.GC1499@arm.com>
 <20140519111739.39ae3b82@free-electrons.com>
 <20140519104219.GH5113@arm.com>
Message-ID: <20140519131757.20021784@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On Mon, 19 May 2014 11:42:19 +0100, Catalin Marinas wrote:

> > I have no problem about the bootloader doing some initialization, so if
> > that's a requirement for arm64, no problem. But it should be a
> > requirement regardless of the kernel configuration: in the current
> > kernel, some initialization is done when CONFIG_SMP is enabled. And now
> > that the same initialization is needed in !CONFIG_SMP, I'm asked to do
> > it in the bootloader. That's the thing I don't buy.
> 
> And that's a hard thing for me to sell for arm32 ;) because of the
> current code already doing this.
> 
> One of the issues is secure vs non-secure kernel deployment and
> secure-only registers like ACTLR (and even SCU). I've seen SoCs for
> which the mainline kernel assumes secure mode but it's deployed as
> non-secure in the field with out of tree modifications to make it work.
> I would rather have a single kernel image for both cases.

As things are today, I believe the Armada 370/XP/375/38x are always
booted in secure mode. Couldn't the kernel detect if it's running
secure or non-secure. If it's running secure, it can do all the ACTLR
configuration (and other things that require being in secure mode). If
it's running non-secure, then it doesn't do this configuration, and
assumes the firmware/bootloader did it.

> > > > Unfortunately, __create_page_tables is called so early that I don't
> > > > know if it's possible to access 'struct machine_desc' at this point to
> > > > know whether the platform needs shareable pages or not.
> > > > 
> > > > Also, don't we have the same problem with the TTB_FLAGS_{SMP,UP) ?
> > > 
> > > I don't think we do because we use the ALT_{SMP,UP} for TTB settings and
> > > we have the smp-on-up fixup running before __v7_setup.
> > 
> > Ok. For Armada 370, I don't need shareable pages. For Armada 380, I
> > need shareable pages, but even if the processor is single core, I
> > believe it pretends to be SMP in MPIDR.
> 
> You'd need to check this.

I got the confirmation. *But* this is only going to affect CONFIG_SMP
builds. Armada 380 being single core, we want I/O coherency to work on
it in !CONFIG_SMP configurations. And in !CONFIG_SMP configuration,
it's always ALT_UP() that is used, regardless of what MPIDR says. And
therefore the TTB_FLAGS_UP will be used.

> > > I'm always for the former (and that's the case for arm64), though for
> > > some older boards it's too late to change.
> > 
> > Indeed. So how do we move forward?
> 
> As I said previously, it's not my call, just a recommendation. It's up
> to the arm/arm-soc maintainers to take this. Give the arm32 SMP
> initialisation precedent, forcing it for an existing platform is a
> harder sell.

Ok. So I should keep going with the approach proposed in my patch
series, obviously after fixing the various other comments that were
posted?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
