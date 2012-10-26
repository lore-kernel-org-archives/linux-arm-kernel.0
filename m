From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Oct 2012 23:43:59 +0100
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <20121026223654.GB2597@elf.ucw.cz>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
 <20121026215136.GC21164@n2100.arm.linux.org.uk>
 <20121026223654.GB2597@elf.ucw.cz>
Message-ID: <20121026224358.GD21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 12:36:54AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > index 17d6eaf..9031a3c 100644
> > > --- a/arch/arm/mach-socfpga/headsmp.S
> > > +++ b/arch/arm/mach-socfpga/headsmp.S
> > > @@ -15,8 +15,10 @@
> > >  #define CPU1_START_ADDR 	        0xffd08010
> > >  
> > >  ENTRY(secondary_trampoline)
> > > +#if __LINUX_ARM_ARCH__ >= 7
> > >  	movw	r0, #:lower16:CPU1_START_ADDR
> > >  	movt  r0, #:upper16:CPU1_START_ADDR
> > > +#endif
> > 
> > If you do that, then it effectively means you don't need these instructions
> > and you might as well just delete them... but looking at the following one:
> > 
> > >  	ldr	r1, [r0]
> > 
> > it's clear that you do need it.  So you need to find a different solution.
> > If the above assembly file can only run on ARMv7, consider putting
> > 
> > 	.march	armv7
> > 
> > or similar before it.
> 
> My version of gas does not seem to recognize .march

Ah, that's because it's .arch not .march.  Please could you check with
.arch instead.  If proven successful we should move the existing
AFLAGS_xxx.o Makefile stuff into the assembly files concerned.
