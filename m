From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 11:50:10 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <20140514170456.GC15946@arm.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
Message-ID: <20140515115010.0d6a4d92@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

Thanks for having quickly taken a look.

On Wed, 14 May 2014 18:04:56 +0100, Catalin Marinas wrote:
> On Wed, May 14, 2014 at 04:50:34PM +0100, Thomas Petazzoni wrote:
> > This hardware I/O coherency mechanism needs a set of ARM core
> > requirements to operate properly:
> > 
> >  * On Armada 370 (a single core processor)
> > 
> >    - The cache policy of pages must be set to "write allocate".
> 
> Arguably, I would make this the default for ARMv6+ CPUs even if UP. It's
> a hint that the CPU may or may not ignore but it shouldn't break
> anything (well, maybe some artificial benchmarks designed to show
> that write-allocate caches are bad).

So, something like:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b2..a1d6845 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -57,7 +57,7 @@ pmd_t *top_pmd;
 #define CPOLICY_WRITEBACK      3
 #define CPOLICY_WRITEALLOC     4
 
-static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
+static unsigned int cachepolicy __initdata = CPOLICY_WRITEALLOC;
 static unsigned int ecc_mask __initdata = 0;
 pgprot_t pgprot_user;
 pgprot_t pgprot_kernel;
@@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
                if (cachepolicy > CPOLICY_WRITETHROUGH)
                        cachepolicy = CPOLICY_WRITETHROUGH;
 #endif
+               if (cachepolicy > CPOLICY_WRITEBACK)
+                       cachepolicy = CPOLICY_WRITEBACK;
        }
        if (cpu_arch < CPU_ARCH_ARMv5) {
                if (cachepolicy >= CPOLICY_WRITEALLOC)
                        cachepolicy = CPOLICY_WRITEBACK;
                ecc_mask = 0;
        }
-       if (is_smp())
-               cachepolicy = CPOLICY_WRITEALLOC;
 
        /*
         * Strip out features not present on earlier architectures.


> >  * On Armada 375/38x (which have single core and dual core variants)
> > 
> >    - The cache policy of pages must be set to "write allocate".
> >    - The SMP and TLB broadcast bits must be set in the Auxiliary
> >      Control Register (the core is a Cortex-A9)
> 
> What about setting this bit in the firmware/bootloader? It's a sane
> initialisation firmware should do.

I'm sorry, but I don't buy the "fix your bootloader" argument. For
various reasons:

 - The Linux kernel policy has always been to do *more* things in the
   kernel, to avoid relying on crappy vendor-specific bootloaders, and
   avoid having bugs that cannot be fixed at the kernel level. Going in
   the opposite direction looks completely backward.

 - Doing so means crazy complex dependencies of kernel versions against
   bootloader versions, which are a nightmare for users. Recently for
   example, Olof Johansson (which, you will admit, is not the least
   experienced in ARM stuff) had to struggle a long time to get a
   mainline kernel boot on Allwinner kernel, because it was mandatory
   to upgrade the bootloader to do so. He was annoyed, so you can
   imagine how normal users can be annoyed. For us, platform
   maintainers, who support users of the mainline kernel, it is a
   *complete* pain to have such dependencies of a kernel version
   towards a given bootloader version. We already have enough of such
   bootloader/kernel issues to not add more when there are sane
   solutions that allow the kernel to do its own thing without having
   to make crazy assumptions about what the bootloader has done.

 - The kernel is setting the SMP and TLB broadcast bit already in
   proc-v7.s when the system is SMP. What would these actions have to
   be done in the bootloader when the system is non-SMP, but I/O
   coherent, and done in the kernel when the system is SMP? This
   doesn't make sense.

 - Many platforms, including Marvell ones, use vendor-specific
   bootloaders that are *very* difficult to get fixed. Of course, it
   would be a lot nicer to have mainline U-Boot/Barebox support for
   those platforms, but it's not the case today.

So, really, I would like the kernel to do this.

> >    - The pages must be set as shareable.
> 
> Here you may have some conflict between the initial page tables set in
> __create_page_tables as non-shareable (that's unless MPIDR shows it as
> SMP but I guess not since smp-on-up kicks in).

For Armada 375/385/XP, MPIDR shows SMP, but not for Armada 370 (hence
the issue even when booting CONFIG_SMP=y on Armada 370). As for Armada
380 (which is a single core variant of the Armada 385), I haven't had
access to such platforms, so I'm not sure what the MPIDR will look
like. But since it's single core, most users will want to build
CONFIG_SMP=n for this platform, but still have hardware I/O coherency.

> I have to think a bit
> more about the implications (the ARM ARM has a chapter on mismatched
> memory attributes and I think it talks about shareable vs
> non-shareable).

Unfortunately, __create_page_tables is called so early that I don't
know if it's possible to access 'struct machine_desc' at this point to
know whether the platform needs shareable pages or not.

Also, don't we have the same problem with the TTB_FLAGS_{SMP,UP) ?

> >    - The SCU must be enabled
> 
> Again, could the firmware do this?

See above. If the kernel does it for SMP cases, why wouldn't it do it
also for !SMP I/O coherent cases? It's either it's *always* done by the
bootloader and we completely remove the SCU enabling code in the
kernel, and add to the ARM boot protocol that enabling the SCU is the
responsibility of the bootloader, or the kernel does the SCU enabling
in all situations.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
