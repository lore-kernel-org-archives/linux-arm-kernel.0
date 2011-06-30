From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 10:27:02 +0100
Subject: [PATCH 11/23] ARM: entry: avoid enabling interrupts in
	prefetch/data abort handlers
In-Reply-To: <20110629200522.GB12421@e102144-lin.cambridge.arm.com>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
	<E1Qbqyh-0002Fh-3Y@rmk-PC.arm.linux.org.uk>
	<20110629200522.GB12421@e102144-lin.cambridge.arm.com>
Message-ID: <20110630092702.GS21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 09:05:23PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> This looks good, thanks. Minor comment inline.
> 
> On Wed, Jun 29, 2011 at 10:22:35AM +0100, Russell King - ARM Linux wrote:
> > Avoid enabling interrupts if the parent context had interrupts enabled
> > in the abort handler assembly code, and move this into the breakpoint/
> > page/alignment fault handlers instead.
> > 
> > This gets rid of some special-casing for the breakpoint fault handlers
> > from the low level abort handler path.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/kernel/entry-armv.S    |   43 +++++++++++++++++---------------------
> >  arch/arm/kernel/entry-header.S  |   19 -----------------
> >  arch/arm/kernel/hw_breakpoint.c |    6 +++-
> >  arch/arm/mm/alignment.c         |    3 ++
> >  arch/arm/mm/fault.c             |    4 +++
> >  5 files changed, 30 insertions(+), 45 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> > index 87acc25..b813e1e 100644
> > --- a/arch/arm/kernel/hw_breakpoint.c
> > +++ b/arch/arm/kernel/hw_breakpoint.c
> > @@ -804,8 +804,10 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
> >  	int ret = 0;
> >  	u32 dscr;
> >  
> > -	/* We must be called with preemption disabled. */
> > -	WARN_ON(preemptible());
> > +	preempt_disable();
> > +
> > +	if (interrupts_enabled(regs))
> > +		local_irq_enable();
> >  
> >  	/* We only handle watchpoints and hardware breakpoints. */
> >  	ARM_DBG_READ(c1, 0, dscr);
> 
> Could you also update the comments for this function too please? There's one
> immediately before the function that states we are called with preemption
> disabled and there's another one where we re-enable preemption stating that
> it was disabled by the low-level exception handling code.

I'll change the one before the function thusly s/preemption/interrupts/ 
and remove the other entirely because it no longer serves much purpose.
Ok?
