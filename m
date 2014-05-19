From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 11:17:39 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <20140515142205.GC1499@arm.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
 <20140515142205.GC1499@arm.com>
Message-ID: <20140519111739.39ae3b82@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Thu, 15 May 2014 15:22:05 +0100, Catalin Marinas wrote:

> > -static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
> > +static unsigned int cachepolicy __initdata = CPOLICY_WRITEALLOC;
> >  static unsigned int ecc_mask __initdata = 0;
> >  pgprot_t pgprot_user;
> >  pgprot_t pgprot_kernel;
> > @@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
> >                 if (cachepolicy > CPOLICY_WRITETHROUGH)
> >                         cachepolicy = CPOLICY_WRITETHROUGH;
> >  #endif
> > +               if (cachepolicy > CPOLICY_WRITEBACK)
> > +                       cachepolicy = CPOLICY_WRITEBACK;
> >         }
> 
> There is some more clean-up to do in this file as there are other
> assumptions about cachepolicy. For example, early_cachepolicy() sets it
> back to writeback (and possibly the initial kernel mapping to avoid
> aliases, though having the same type, just the allocation hint doesn't
> really cause problems).

Ok.

> > > >  * On Armada 375/38x (which have single core and dual core variants)
> > > > 
> > > >    - The cache policy of pages must be set to "write allocate".
> > > >    - The SMP and TLB broadcast bits must be set in the Auxiliary
> > > >      Control Register (the core is a Cortex-A9)
> > > 
> > > What about setting this bit in the firmware/bootloader? It's a sane
> > > initialisation firmware should do.
> > 
> > I'm sorry, but I don't buy the "fix your bootloader" argument. For
> > various reasons:
> 
> Well, for arm64 people should get used to this because I'm not taking
> code for setting up things like SCU and ACTLR during boot.

I have no problem about the bootloader doing some initialization, so if
that's a requirement for arm64, no problem. But it should be a
requirement regardless of the kernel configuration: in the current
kernel, some initialization is done when CONFIG_SMP is enabled. And now
that the same initialization is needed in !CONFIG_SMP, I'm asked to do
it in the bootloader. That's the thing I don't buy.

> >  - The Linux kernel policy has always been to do *more* things in the
> >    kernel, to avoid relying on crappy vendor-specific bootloaders, and
> >    avoid having bugs that cannot be fixed at the kernel level. Going in
> >    the opposite direction looks completely backward.
> 
> There is no written policy here for how close to the hardware reset the
> kernel should run. With the same arguments people may want to initialise
> the DRAM controller in Linux while booting in SRAM temporarily (or
> ROM/flash + XIP).

Indeed.

> But in this particular case, let's look at ACTLR. It's a secure-only
> register, so what if someone decides to deploy Linux as a non-secure OS
> on this platform? Do you add a config option to have a different kernel
> build?

The ACTLR *is* currently accessed by the Linux kernel to set the SMP
bit and TLB broadcast bit. So the potential problem you're pointing
already exists, and is not made worse by the patches I'm proposing.

> >  - Doing so means crazy complex dependencies of kernel versions against
> >    bootloader versions, which are a nightmare for users.
> 
> Because we didn't have a clear policy here, the secure extensions came
> in later when we were already doing things like this. It's more
> difficult to enforce it now but we face such issues regularly. For
> example, on several occasions we had TI asking for per-SoC CPU
> initialisation (possibly as addition to __v7_setup) for specific SMC
> calls to the firmware which breaks single Image.
> 
> It make sense a lot of sense to place sane initialisation in a
> SoC-specific firmware/bootloader but whether we want to enforce such
> policy is Russell's call.

Again, you're forgetting that I'm not asking to add *additional*
initialization. All the initialization I'm looking at is *already* done
by the kernel today. All what my patches are doing is make this
initialization also happen in other situations than just CONFIG_SMP.

> > Unfortunately, __create_page_tables is called so early that I don't
> > know if it's possible to access 'struct machine_desc' at this point to
> > know whether the platform needs shareable pages or not.
> > 
> > Also, don't we have the same problem with the TTB_FLAGS_{SMP,UP) ?
> 
> I don't think we do because we use the ALT_{SMP,UP} for TTB settings and
> we have the smp-on-up fixup running before __v7_setup.

Ok. For Armada 370, I don't need shareable pages. For Armada 380, I
need shareable pages, but even if the processor is single core, I
believe it pretends to be SMP in MPIDR.

> > > >    - The SCU must be enabled
> > > 
> > > Again, could the firmware do this?
> > 
> > See above. If the kernel does it for SMP cases, why wouldn't it do it
> > also for !SMP I/O coherent cases?
> 
> The I/O coherency is an SoC property rather than an ARM architecture
> property. I want to separate the two so that the kernel can boot a
> significant part assuming sane architecture settings. Once you have DT
> available and start loading device drivers, you are in the SoC realm and
> you can do whatever initialisation for buses, interconnects, but not
> going back to change architected settings.

But, yes, but I don't see how it relates with the discussion here, and
how it solves the problem. Could you be more specific?

> > It's either it's *always* done by the
> > bootloader and we completely remove the SCU enabling code in the
> > kernel, and add to the ARM boot protocol that enabling the SCU is the
> > responsibility of the bootloader, or the kernel does the SCU enabling
> > in all situations.
> 
> I'm always for the former (and that's the case for arm64), though for
> some older boards it's too late to change.

Indeed. So how do we move forward?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
