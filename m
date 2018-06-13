From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jun 2018 22:47:35 +0100
Subject: [PATCH 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable
 invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <330ff593-4663-5393-74b3-55bf1f199561@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-4-nm@ti.com>
 <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
 <20180613173634.GC17671@n2100.armlinux.org.uk>
 <330ff593-4663-5393-74b3-55bf1f199561@gmail.com>
Message-ID: <20180613214735.GD17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 10:36:56PM +0200, Marek Vasut wrote:
> On 06/13/2018 07:36 PM, Russell King - ARM Linux wrote:
> > On Wed, Jun 13, 2018 at 01:06:13AM +0200, Marek Vasut wrote:
> >> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
> >>> Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
> >>> function to setup the bits, we are able to override the settings.
> >>>
> >>> Without this enabled, Linux kernel reports:
> >>> CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
> >>>
> >>> With this enabled, Linux kernel reports:
> >>> CPU0: Spectre v2: using ICIALLU workaround
> >>>
> >>> NOTE: This by itself does not enable the workaround for CPU1 (on
> >>> OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.
> >>>
> >>> Signed-off-by: Nishanth Menon <nm@ti.com>
> >>> ---
> >>>  arch/arm/mach-omap2/Kconfig | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >>> index 3bb1ecb58de0..77820cc8d1e4 100644
> >>> --- a/arch/arm/mach-omap2/Kconfig
> >>> +++ b/arch/arm/mach-omap2/Kconfig
> >>> @@ -53,6 +53,7 @@ config OMAP54XX
> >>>  	bool "OMAP54XX SoC"
> >>>  	select ARM_ERRATA_798870
> >>>  	select SYS_THUMB_BUILD
> >>> +	select ARM_CORTEX_A15_CVE_2017_5715
> >>>  	imply NAND_OMAP_ELM
> >>>  	imply NAND_OMAP_GPMC
> >>>  	imply SPL_DISPLAY_PRINT
> >>>
> >>
> >> Can this be enabled for all CA15 systems somehow ? I am sure there are
> >> more that are vulnerable.
> > 
> > I think you're missing the point.
> 
> Please read the patch again.

Stop this madness - I /know/ precisely what _this_ patch is doing.
My reply was to *your* comment about extending it "for all CA15
systems".

> This enables it only for a specific SoC. My point being, this should be
> enabled for all SoCs with CA15, not just some select few.

Let's try again... the short answer: NO.

The long answer:

Enabling IBE does *not* universally solve the problem for all SoCs
using CA15.  It merely enables the instructions required for
workarounds in the *kernel* part of the system to take effect.  That
leaves the rest of the system *vulnerable*.

Just in the same way that we have to apply the workarounds /not only/
at the kernel level, but also the hypervisor level for KVM to prevent
KVM being vulnerable, the workarounds _also_ need to be appled at
secure firmware level, as I tried to explain.

Nishanth's OMAP5 case is kind of special because, from what he's
said (a) there's nothing in the secure world that really matters,
and (b) there's nothing that can be done to fix the secure world
because that firmware is in ROM and can never be changed.

That isn't true "for all CA15 systems", and if we're wanting
systems to be properly fixed, then fixing the problem properly
(by fixing the secure world to set IBE *and* implement the
workarounds there) is the right thing.

Setting the IBE bit in the kernel for all CA15 means that, while
we solve the kernel part (and KVM part), the secure world will
remain vulnerable if it has no protection - and worse, people
probably haven't thought enough about this, or know enough about it,
to realise that the vulnerability still exists all the time that any
part of the system has not been fixed.  So, having the kernel print
a warning is critical.

If it was just the case that the kernel was all that was affected,
then KVM wouldn't have needed to be fixed, but the reality is it
needed to be fixed and has been.  The same applies to the secure
world.

Think about this: if you can trick the secure world into speculatively
executing a set of gadgets by manipulating the ARM register values
passed to the SMC call to read secure world memory - or any memory
you shouldn't have access to (like the kernel) then setting the IBE
bit and having the kernel fixes in place is completely meaningless.
As I said below, the system _remains_ vulnerable.

Take a look at the work going on with ARM64 syscalls - they're now
explicitly zeroing all registers on entry that are not an explicit
argument to any syscall.  The reason is to prevent userspace doing
exactly what I've described above, except with the kernel.

So, should we extend it "for all CA15 systems".  No, definitely not
without knowing exactly what the situation is for each and every one.
Having it done in firmware - the same firmware that switches the
CPU out of secure mode - is the right answer where it's possible to
do so.  That won't happen if we apply a "fix" to set IBE as a big
hammer to the kernel.

> > Spectre affects the _entire_ system.  Working around it in just the
> > kernel does not mean that the system is no longer vulnerable.
> > 
> > Fixing the "system" means implementing the fixes also in the secure
> > world, which on A15 and A8 also means setting the IBE bit there.  If
> > the IBE bit is set in the secure world, it will also be set in the
> > non-secure world.
> > 
> > The fact that the kernel is complaining is telling you that the
> > system as a whole does not have the workarounds in place to mitigate
> > against the vulnerability.  Merely setting the IBE bit via some
> > secure API doesn't "magically" fix the secure world.
> > 
> > So, even if you were to set the IBE bit via some magic secure API,
> > the fact still remains: even with these workarounds in place, as I
> > understand it, the _system as a whole_ remains vulnerable - you
> > might as well _not_ have the kernel workarounds.

And the long answer is basically what I said ^^^^^ there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
