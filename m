From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Apr 2016 14:25:35 +0100
Subject: [PATCH] ARM: kexec: fix crashkernel= handling
In-Reply-To: <20160330132708.GC32738@redhat.com>
References: <E1akqb5-0002LZ-1f@rmk-PC.arm.linux.org.uk>
 <20160330014638.GA6993@dhcp-128-65.nay.redhat.com>
 <20160330123922.GA11351@dhcppc0.redhat.com>
 <20160330130530.GH19428@n2100.arm.linux.org.uk>
 <20160330132708.GC32738@redhat.com>
Message-ID: <20160401132535.GP19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 09:27:08AM -0400, Vivek Goyal wrote:
> On Wed, Mar 30, 2016 at 02:05:30PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Mar 30, 2016 at 06:09:22PM +0530, Pratyush Anand wrote:
> > > On 30/03/2016:09:46:38 AM, Dave Young wrote:
> > > > Hi, Russell
> > > > 
> > > > A long standing issue, but nobody tried to do it. Thank you for bringing up.
> > > > 
> > > > On 03/29/16 at 11:10am, Russell King wrote:
> > > > > When the kernel crashkernel parameter is specified with just a size, we
> > > > > are supposed to allocate a region from RAM to store the crashkernel.
> > > > > However, ARM merely reserves physical address zero with no checking
> > > > > that there is even RAM there.
> > > > > 
> > > > > Fix this by lifting similar code from x86, importing it to ARM with
> > > > > the ARM specific parameters added.
> > > > > 
> > > > > Update the kdump documentation to reflect this change.
> > > > > 
> > > > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > > > ---
> > > > >  Documentation/kdump/kdump.txt | 13 +++----------
> > > > >  arch/arm/kernel/setup.c       | 26 ++++++++++++++++++++++++++
> > > > >  2 files changed, 29 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> > > > > index bc4bd5a44b88..88ff63d5fde3 100644
> > > > > --- a/Documentation/kdump/kdump.txt
> > > > > +++ b/Documentation/kdump/kdump.txt
> > > > > @@ -263,12 +263,6 @@ been removed from the machine.
> > > > >      crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > > > >      range=start-[end]
> > > > >  
> > > > > -Please note, on arm, the offset is required.
> > > > > -    crashkernel=<range1>:<size1>[,<range2>:<size2>,...]@offset
> > > > > -    range=start-[end]
> > > > > -
> > > > > -    'start' is inclusive and 'end' is exclusive.
> > > > > -
> > > > >  For example:
> > > > >  
> > > > >      crashkernel=512M-2G:64M,2G-:128M
> > > > > @@ -307,10 +301,9 @@ Boot into System Kernel
> > > > >     on the memory consumption of the kdump system. In general this is not
> > > > >     dependent on the memory size of the production system.
> > > > >  
> > > > > -   On arm, use "crashkernel=Y at X". Note that the start address of the kernel
> > > > > -   will be aligned to 128MiB (0x08000000), so if the start address is not then
> > > > > -   any space below the alignment point may be overwritten by the dump-capture kernel,
> > > > > -   which means it is possible that the vmcore is not that precise as expected.
> > > > > +   On arm, the use of "crashkernel=Y at X" is no longer necessary; the
> > > > > +   kernel will automatically locate the crash kernel image within the
> > > > > +   first 512MB of RAM if X is not given.
> > > > >  
> > > > >  
> > > > >  Load the Dump-capture Kernel
> > > > > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > > > > index 7d0cba6f1cc5..5d8511c425f0 100644
> > > > > --- a/arch/arm/kernel/setup.c
> > > > > +++ b/arch/arm/kernel/setup.c
> > > > > @@ -938,6 +938,13 @@ static int __init init_machine_late(void)
> > > > >  late_initcall(init_machine_late);
> > > > >  
> > > > >  #ifdef CONFIG_KEXEC
> > > > > +/*
> > > > > + * The crash region must be aligned to 128MB to avoid
> > > > > + * zImage relocating below the reserved region.
> > > > > + */
> > > > > +#define CRASH_ALIGN	(128 << 20)
> > > > > +#define CRASH_ADDR_MAX	(PHYS_OFFSET + (512 << 20))
> > > > 
> > > > Any reason to limit crash mem within the first 512M only? What if one want to
> > > > reserve memory over 512M?
> > > 
> > > When crash base is not give, then may be it can be just checked if memblock
> > > region is memory and not reserved, then allow to reserve. That might help to
> > > remove 512M restriction.
> > 
> > ... and then I'll have to update the commit text.
> > 
> > You may notice that I say that this is mostly taken from the x86
> > implementation.  The x86 implementation also has this 512MB
> > allocation limit, to prevent it being placed too high in physical
> > memory.
> 
> IIRC, x86 had this limitation as they could not support any higher. But
> if ARM can support higher, it would be good to allow that.

Well, if we want to remove it, we then need to sort out a method of
specifying a limit on the address - where platforms physical memory
bridges the 4GB CPU-accessible limit, the crashkernel region must be
allocated below that so that it is boot-time accessible.

Some patches also have boot-time only aliases of RAM, with the normal
alias above 4GB (eg, TI Keystone2) where the running view of RAM is
at 0x800000000, but it has a non-coherent boot alias at 0x80000000.

I've patches which resolve some of the issues there, and making that
change would make this patch dependent on those changes.  So, I
recommend that this patch remains as-is for the time being, and this
issue is addressed in a later patch after the Keystone2 idmap_to_phys()
patches, similar to:

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0a12fcf1aff6..74781e6d4e87 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -962,7 +962,6 @@ late_initcall(init_machine_late);
  * zImage relocating below the reserved region.
  */
 #define CRASH_ALIGN	(128 << 20)
-#define CRASH_ADDR_MAX	(PHYS_OFFSET + (512 << 20))
 
 static inline unsigned long long get_total_mem(void)
 {
@@ -992,7 +991,8 @@ static void __init reserve_crashkernel(void)
 		return;
 
 	if (crash_base <= 0) {
-		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_MAX,
+		unsigned long long crash_max = idmap_to_phys((u32)~0);
+		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
 						    crash_size, CRASH_ALIGN);
 		if (!crash_base) {
 			pr_err("crashkernel reservation failed - No suitable area found.\n");

Right now, I don't want to tie this facility to TI Keystone2 support
as what this patch is doing is something that the ARM kexec support
should have been doing since it was first introduced, so folk may
want to backport this change to stable trees.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
