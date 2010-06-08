From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jun 2010 14:36:05 +0100
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <20100608132940.GA6874@desktop>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100421131149.GB9408@desktop> <20100608132940.GA6874@desktop>
Message-ID: <20100608133605.GG25370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 08, 2010 at 09:29:40PM +0800, anfei wrote:
> Hi Russell,
> 
> On Wed, Apr 21, 2010 at 09:11:49PM +0800, anfei wrote:
> > Patch updated, and with comment log.
> > 
> > ===
> > ARM: Proper prefetch abort handling on pre-ARMv6
> > 
> > Instruction faults on pre-ARMv6 CPUs are interpreted as
> > a 'translation fault', but do_translation_fault doesn't
> > handle well if user mode trying to run instruction above
> > TASK_SIZE, and result in the infinite retry of that
> > instruction.
> > 
> > Signed-off-by: Anfei Zhou <anfei.zhou@gmail.com>
> > ---
> >  arch/arm/mm/fault.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 9d40c34..8ad75e9 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -393,6 +393,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
> >  	if (addr < TASK_SIZE)
> >  		return do_page_fault(addr, fsr, regs);
> >  
> > +	if (user_mode(regs))
> > +		goto bad_area;
> > +
> >  	index = pgd_index(addr);
> >  
> >  	/*
> 
> This patch is still not into the mainline, will you plan to apply it?

I had, but as it isn't in the patch system, it got buried and forgotten.
Could you submit it to the patch system please?  Just emailing it in
a similar manner to that above, but with a subject of
"Proper prefetch abort handling on pre-ARMv6" and an additional
"KernelVersion: 2.6.whatever" line to the patch system should suffice.
