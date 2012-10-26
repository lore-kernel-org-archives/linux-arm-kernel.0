From: pavel@denx.de (Pavel Machek)
Date: Sat, 27 Oct 2012 00:36:54 +0200
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <20121026215136.GC21164@n2100.arm.linux.org.uk>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
 <20121026215136.GC21164@n2100.arm.linux.org.uk>
Message-ID: <20121026223654.GB2597@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > index 17d6eaf..9031a3c 100644
> > --- a/arch/arm/mach-socfpga/headsmp.S
> > +++ b/arch/arm/mach-socfpga/headsmp.S
> > @@ -15,8 +15,10 @@
> >  #define CPU1_START_ADDR 	        0xffd08010
> >  
> >  ENTRY(secondary_trampoline)
> > +#if __LINUX_ARM_ARCH__ >= 7
> >  	movw	r0, #:lower16:CPU1_START_ADDR
> >  	movt  r0, #:upper16:CPU1_START_ADDR
> > +#endif
> 
> If you do that, then it effectively means you don't need these instructions
> and you might as well just delete them... but looking at the following one:
> 
> >  	ldr	r1, [r0]
> 
> it's clear that you do need it.  So you need to find a different solution.
> If the above assembly file can only run on ARMv7, consider putting
> 
> 	.march	armv7
> 
> or similar before it.

My version of gas does not seem to recognize .march

(  AS      arch/arm/mach-socfpga/headsmp.o
arch/arm/mach-socfpga/headsmp.S: Assembler messages:
arch/arm/mach-socfpga/headsmp.S:17: Error: unknown pseudo-op: `.march'
arch/arm/mach-socfpga/headsmp.S:24: Error: selected processor does not
support `movw r0,#:lower16:(0xffd08000+0x10)'
arch/arm/mach-socfpga/headsmp.S:25: Error: selected processor does not
support `movt r0,#:upper16:(0xffd08000+0x10)'
)

This seems to do the trick:

Fix compilation with CPU_V6 option.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index a0fc372..6956e93 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,3 +4,5 @@
 
 obj-y			:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o hotplug.o
+
+AFLAGS_headsmp.o	:= -Wa,-march=armv7-a

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
