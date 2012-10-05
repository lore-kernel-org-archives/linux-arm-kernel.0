From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Oct 2012 16:23:25 -0700
Subject: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
In-Reply-To: <20121005230908.GC15246@n2100.arm.linux.org.uk>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <20121005230908.GC15246@n2100.arm.linux.org.uk>
Message-ID: <20121005232325.GV3874@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121005 16:10]:
> On Fri, Oct 05, 2012 at 01:08:22PM -0700, Tony Lindgren wrote:
> > Just bisected this down in linux-next for breaking booting of
> > my omap2420 ARMv6 based n8x0..
> > 
> > > --- a/arch/arm/kernel/head.S
> > > +++ b/arch/arm/kernel/head.S
> > > @@ -83,8 +83,12 @@ ENTRY(stext)
> > >   THUMB(	.thumb			)	@ switch to Thumb now.
> > >   THUMB(1:			)
> > >  
> > > -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> > > -						@ and irqs disabled
> > > +#ifdef CONFIG_ARM_VIRT_EXT
> > > +	bl	__hyp_stub_install
> > > +#endif
> > > +	@ ensure svc mode and all interrupts masked
> > > +	safe_svcmode_maskall r9
> > > +
> > >  	mrc	p15, 0, r9, c0, c0		@ get processor id
> > >  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
> > >  	movs	r10, r5				@ invalid processor (r5=0)?
> > 
> > ..and looks like undoing this part fixes it. Any ideas?
> > 
> > I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
> > ARMv6 but that does not help.
> 
> You really should Cc me when you hit something like this.  I was
> thinking about sending my tree (which contains these changes) this
> evening but if they're breaking stuff, I'd prefer to delay that
> stuff at least for a while.

Sorry was planning to cc you for sure but forgot. Got any ideas
what to try to fix this?

Tony
