From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Oct 2012 14:20:31 -0400 (EDT)
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <201210221412.19486.arnd@arndb.de>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <20121022003350.GL2509@verge.net.au> <20121022015126.GA10587@verge.net.au>
 <201210221412.19486.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1210221041450.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2012, Arnd Bergmann wrote:

> (adding Nico, who did a lot of the work to get rid of PLAT_PHYS_OFFSET)
> 
> On Monday 22 October 2012, Simon Horman wrote:
> > On Mon, Oct 22, 2012 at 09:33:51AM +0900, Simon Horman wrote:
> > > On Fri, Oct 19, 2012 at 08:18:50AM +0000, Arnd Bergmann wrote:
> > > > On Friday 19 October 2012, Simon Horman wrote:
> > > > > * A more significant problem seems to be the use of CONFIG_MEMORY_START
> > > > >   to define PLAT_PHYS_OFFSET in arch/arm/mach-shmobile/include/mach/memory.h
> > > > > 
> > > > >   I'm not sure that I see an easy way to get around this one.
> > > > 
> > > > ARM_PATCH_PHYS_VIRT should take care of this, have you tried it?
> > 
> > I believe that this leaves mach-shmobile with three areas
> > where CONFIG_MEMORY_START/PLAT_PHYS_OFFSET is used.
> 
> Hmm, I just noticed that in fact shmobile is the only remaining
> platform that uses CONFIG_MEMORY_START with a per-board or per-soc
> setting.
> 
> > * arch/arm/mach-shmobile/headsmp.S
> > 
> >   This uses PLAT_PHYS_OFFSET.
> > 
> >   I believe this can be replaced with a run-time calculation. Though I
> >   haven't thought about the details yet.

What about this (untested):

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index b202c12725..9293319fcb 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -64,18 +64,23 @@ ENTRY(v7_invalidate_l1)
 	mov	pc, lr
 ENDPROC(v7_invalidate_l1)
 
-ENTRY(shmobile_invalidate_start)
+ENTRY(shmobile_secondary_entry)
 	bl	v7_invalidate_l1
 	b	secondary_startup
-ENDPROC(shmobile_invalidate_start)
+ENDPROC(shmobile_secondary_entry)
 
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
  * We need _long_ jump to the physical address.
+ * the loaded address is initialized to the physical address of
+ * shmobile_secondary_entry
+ * in platform_secondary_init().
  */
+	.data
 	.align  12
+	.arm
 ENTRY(shmobile_secondary_vector)
 	ldr     pc, 1f
-1:	.long   shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
+1:	.long   0
 ENDPROC(shmobile_secondary_vector)
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index fde0d23121..356f82da16 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -76,8 +76,14 @@ int shmobile_platform_cpu_kill(unsigned int cpu)
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
+	long shmobile_secondary_address;
+
 	trace_hardirqs_off();
 
+	shmobile_secondary_address = (long *)(shmobile_secondary_vector) + 1;
+	*shmobile_secondary_address = virt_to_phys(shmobile_secondary_entry);
+	__cpuc_flush_dcache_area(shmobile_secondary_address, sizeof(long));
+
 	if (is_sh73a0())
 		sh73a0_secondary_init(cpu);
 

> > * arch/arm/boot/compressed/head-shmobile.S
> > 
> >   This makes use of CONFIG_MEMORY_START.
> >   This is only used if CONFIG_ZBOOT_ROM is set.
> > 
> >   I'm unsure if this can be replaced with a run-time calculation or not.
> >   But regardless it is only used if CONFIG_ZBOOT_ROM is set, which is not
> >   the default at this time.

This code is meant to be executed from ROM which means a very tailored 
kernel configuration.  In that case it makes little sense to have 
CONFIG_ARM_PATCH_PHYS_VIRT nor CONFIG_AUTO_ZRELADDR turned on anyway.

> Right, you can probably make CONFIG_ZBOOT_ROM_MMCIF and
> CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI depend on !ARM_PATCH_PHYS_VIRT

The right dependency would be CONFIG_AUTO_ZRELADDR, not 
ARM_PATCH_PHYS_VIRT.  The later concerns the final kernel image, not the 
decompressor.

> > * arch/arm/mach-shmobile/Makefile.boot
> > 
> >  This makes use of CONFIG_MEMORY_START to set zreladdr.
> > 
> >  I believe that the solution to this is to make use of CONFIG_AUTO_ZRELADDR.
> >  However, it is not yet clear to me how that can be used in conjunction
> >  with a uImage.  As I understand it the boot loader on many of our boards,
> >  including the Marzen board which is my first target for this work, boot
> >  uImage imagess.
> 
> If this doesn't work, we probably also need to find a solution to
> build multiple uImage files from the same vmlinux when building a
> multiplatform kernel.

The right solution to the U-Boot problem is to remove uImage creation 
from the kernel entirely.  The U-Boot image format should be created at 
_installation_ time, not at build time.  The fact that the U-Boot image 
format is (or was until very recently) inflexible is not Linux's fault.

If the uImage build target is to remain in the kernel, it should be 
marked incompatible with a multi-arch config.  There is no point 
distributing a multi-arch kernel image when wrapped into a uImage 
format.


Nicolas
