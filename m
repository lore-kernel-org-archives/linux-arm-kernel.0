From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Jan 2011 14:59:30 +0200
Subject: Build breakage with omap2plus_defconfig
In-Reply-To: <8663c7bb00ba574693af177a10e24043@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
	<8663c7bb00ba574693af177a10e24043@mail.gmail.com>
Message-ID: <20110107125929.GD9592@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 06:18:51PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Felipe Balbi
> > Sent: Friday, January 07, 2011 6:09 PM
> > To: Russell King; Tony Lindgren
> > Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List
> > Subject: Build breakage with omap2plus_defconfig
> >
> > Hi all,
> >
> > Today's Linus' tree (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails
> > to
> > build with omap2plus_defconfig:
> >
> > $ crossmake
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[1]: `include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/arm/kernel/swp_emulate.o
> > /tmp/cc2V7p5j.s: Assembler messages:
> > /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM
> > mode `ldrexb r3,[r4]'
> > /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM
> > mode `strexb r0,r2,[r4]'
> 
> Well it's not toolchain issue but the omap2plus_defconfig which
> selects ARMv6 and ARMV7 together.
> 
> If you remove ARCH_OMAP2 from build, it will go through.

I like Catalin's approach:

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 49db8b3..0fe2389 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -644,7 +644,7 @@ config ARM_THUMBEE
 
 config SWP_EMULATE
        bool "Emulate SWP/SWPB instructions"
-       depends on CPU_V7
+       depends on CPU_V7 && !CPU_V6
        select HAVE_PROC_CPU if PROC_FS
        default y if SMP
        help

Simple.

-- 
balbi
