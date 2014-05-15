From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 15:22:05 +0100
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140515115010.0d6a4d92@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
Message-ID: <20140515142205.GC1499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:50:10AM +0100, Thomas Petazzoni wrote:
> On Wed, 14 May 2014 18:04:56 +0100, Catalin Marinas wrote:
> > On Wed, May 14, 2014 at 04:50:34PM +0100, Thomas Petazzoni wrote:
> > > This hardware I/O coherency mechanism needs a set of ARM core
> > > requirements to operate properly:
> > > 
> > >  * On Armada 370 (a single core processor)
> > > 
> > >    - The cache policy of pages must be set to "write allocate".
> > 
> > Arguably, I would make this the default for ARMv6+ CPUs even if UP. It's
> > a hint that the CPU may or may not ignore but it shouldn't break
> > anything (well, maybe some artificial benchmarks designed to show
> > that write-allocate caches are bad).
> 
> So, something like:
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index b68c6b2..a1d6845 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -57,7 +57,7 @@ pmd_t *top_pmd;
>  #define CPOLICY_WRITEBACK      3
>  #define CPOLICY_WRITEALLOC     4
>  
> -static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
> +static unsigned int cachepolicy __initdata = CPOLICY_WRITEALLOC;
>  static unsigned int ecc_mask __initdata = 0;
>  pgprot_t pgprot_user;
>  pgprot_t pgprot_kernel;
> @@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
>                 if (cachepolicy > CPOLICY_WRITETHROUGH)
>                         cachepolicy = CPOLICY_WRITETHROUGH;
>  #endif
> +               if (cachepolicy > CPOLICY_WRITEBACK)
> +                       cachepolicy = CPOLICY_WRITEBACK;
>         }

There is some more clean-up to do in this file as there are other
assumptions about cachepolicy. For example, early_cachepolicy() sets it
back to writeback (and possibly the initial kernel mapping to avoid
aliases, though having the same type, just the allocation hint doesn't
really cause problems).

> > >  * On Armada 375/38x (which have single core and dual core variants)
> > > 
> > >    - The cache policy of pages must be set to "write allocate".
> > >    - The SMP and TLB broadcast bits must be set in the Auxiliary
> > >      Control Register (the core is a Cortex-A9)
> > 
> > What about setting this bit in the firmware/bootloader? It's a sane
> > initialisation firmware should do.
> 
> I'm sorry, but I don't buy the "fix your bootloader" argument. For
> various reasons:

Well, for arm64 people should get used to this because I'm not taking
code for setting up things like SCU and ACTLR during boot.

>  - The Linux kernel policy has always been to do *more* things in the
>    kernel, to avoid relying on crappy vendor-specific bootloaders, and
>    avoid having bugs that cannot be fixed at the kernel level. Going in
>    the opposite direction looks completely backward.

There is no written policy here for how close to the hardware reset the
kernel should run. With the same arguments people may want to initialise
the DRAM controller in Linux while booting in SRAM temporarily (or
ROM/flash + XIP).

But in this particular case, let's look at ACTLR. It's a secure-only
register, so what if someone decides to deploy Linux as a non-secure OS
on this platform? Do you add a config option to have a different kernel
build?

>  - Doing so means crazy complex dependencies of kernel versions against
>    bootloader versions, which are a nightmare for users.

Because we didn't have a clear policy here, the secure extensions came
in later when we were already doing things like this. It's more
difficult to enforce it now but we face such issues regularly. For
example, on several occasions we had TI asking for per-SoC CPU
initialisation (possibly as addition to __v7_setup) for specific SMC
calls to the firmware which breaks single Image.

It make sense a lot of sense to place sane initialisation in a
SoC-specific firmware/bootloader but whether we want to enforce such
policy is Russell's call.

>  - The kernel is setting the SMP and TLB broadcast bit already in
>    proc-v7.s when the system is SMP. What would these actions have to
>    be done in the bootloader when the system is non-SMP, but I/O
>    coherent, and done in the kernel when the system is SMP? This
>    doesn't make sense.

Because of historical reasons, we can't remove the ACTLR setting in
proc-v7.S, as much as I would like. But when Linux runs in non-secure
mode, such initialisation is already done by firmware, so it's not
unheard of in the 32-bit ARM world.

> > >    - The pages must be set as shareable.
> > 
> > Here you may have some conflict between the initial page tables set in
> > __create_page_tables as non-shareable (that's unless MPIDR shows it as
> > SMP but I guess not since smp-on-up kicks in).
[...]
> > I have to think a bit
> > more about the implications (the ARM ARM has a chapter on mismatched
> > memory attributes and I think it talks about shareable vs
> > non-shareable).
> 
> Unfortunately, __create_page_tables is called so early that I don't
> know if it's possible to access 'struct machine_desc' at this point to
> know whether the platform needs shareable pages or not.
> 
> Also, don't we have the same problem with the TTB_FLAGS_{SMP,UP) ?

I don't think we do because we use the ALT_{SMP,UP} for TTB settings and
we have the smp-on-up fixup running before __v7_setup.

> > >    - The SCU must be enabled
> > 
> > Again, could the firmware do this?
> 
> See above. If the kernel does it for SMP cases, why wouldn't it do it
> also for !SMP I/O coherent cases?

The I/O coherency is an SoC property rather than an ARM architecture
property. I want to separate the two so that the kernel can boot a
significant part assuming sane architecture settings. Once you have DT
available and start loading device drivers, you are in the SoC realm and
you can do whatever initialisation for buses, interconnects, but not
going back to change architected settings.

> It's either it's *always* done by the
> bootloader and we completely remove the SCU enabling code in the
> kernel, and add to the ARM boot protocol that enabling the SCU is the
> responsibility of the bootloader, or the kernel does the SCU enabling
> in all situations.

I'm always for the former (and that's the case for arm64), though for
some older boards it's too late to change.

-- 
Catalin
