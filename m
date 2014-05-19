From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 May 2014 11:42:19 +0100
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140519111739.39ae3b82@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
 <20140515142205.GC1499@arm.com>
 <20140519111739.39ae3b82@free-electrons.com>
Message-ID: <20140519104219.GH5113@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:17:39AM +0100, Thomas Petazzoni wrote:
> On Thu, 15 May 2014 15:22:05 +0100, Catalin Marinas wrote:
> > > > >  * On Armada 375/38x (which have single core and dual core variants)
> > > > > 
> > > > >    - The cache policy of pages must be set to "write allocate".
> > > > >    - The SMP and TLB broadcast bits must be set in the Auxiliary
> > > > >      Control Register (the core is a Cortex-A9)
> > > > 
> > > > What about setting this bit in the firmware/bootloader? It's a sane
> > > > initialisation firmware should do.
> > > 
> > > I'm sorry, but I don't buy the "fix your bootloader" argument. For
> > > various reasons:
> > 
> > Well, for arm64 people should get used to this because I'm not taking
> > code for setting up things like SCU and ACTLR during boot.
> 
> I have no problem about the bootloader doing some initialization, so if
> that's a requirement for arm64, no problem. But it should be a
> requirement regardless of the kernel configuration: in the current
> kernel, some initialization is done when CONFIG_SMP is enabled. And now
> that the same initialization is needed in !CONFIG_SMP, I'm asked to do
> it in the bootloader. That's the thing I don't buy.

And that's a hard thing for me to sell for arm32 ;) because of the
current code already doing this.

One of the issues is secure vs non-secure kernel deployment and
secure-only registers like ACTLR (and even SCU). I've seen SoCs for
which the mainline kernel assumes secure mode but it's deployed as
non-secure in the field with out of tree modifications to make it work.
I would rather have a single kernel image for both cases.

> > > Unfortunately, __create_page_tables is called so early that I don't
> > > know if it's possible to access 'struct machine_desc' at this point to
> > > know whether the platform needs shareable pages or not.
> > > 
> > > Also, don't we have the same problem with the TTB_FLAGS_{SMP,UP) ?
> > 
> > I don't think we do because we use the ALT_{SMP,UP} for TTB settings and
> > we have the smp-on-up fixup running before __v7_setup.
> 
> Ok. For Armada 370, I don't need shareable pages. For Armada 380, I
> need shareable pages, but even if the processor is single core, I
> believe it pretends to be SMP in MPIDR.

You'd need to check this.

> > > It's either it's *always* done by the
> > > bootloader and we completely remove the SCU enabling code in the
> > > kernel, and add to the ARM boot protocol that enabling the SCU is the
> > > responsibility of the bootloader, or the kernel does the SCU enabling
> > > in all situations.
> > 
> > I'm always for the former (and that's the case for arm64), though for
> > some older boards it's too late to change.
> 
> Indeed. So how do we move forward?

As I said previously, it's not my call, just a recommendation. It's up
to the arm/arm-soc maintainers to take this. Give the arm32 SMP
initialisation precedent, forcing it for an existing platform is a
harder sell.

Whether we want to set a policy for new arm32 SoCs is for a different
thread.

-- 
Catalin
