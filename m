From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Oct 2009 14:59:36 -0400 (EDT)
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910271937.57146.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271857.35371.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271407020.10545@xanadu.home>
	<200910271937.57146.jpihet@mvista.com>
Message-ID: <alpine.LFD.2.00.0910271454110.10545@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2009, Jean Pihet wrote:

> On Tuesday 27 October 2009 19:08:07 Nicolas Pitre wrote:
> > On Tue, 27 Oct 2009, Jean Pihet wrote:
> > > diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> > > index f330974..4366cc0 100644
> > > --- a/arch/arm/kernel/signal.c
> > > +++ b/arch/arm/kernel/signal.c
> > > @@ -676,8 +676,14 @@ static int do_signal(sigset_t *oldset, struct
> > > pt_regs *regs, int syscall)
> > >  				regs->ARM_sp -= 4;
> > >  				usp = (u32 __user *)regs->ARM_sp;
> > >
> > > -				put_user(regs->ARM_pc, usp);
> > > -				regs->ARM_pc = KERN_RESTART_CODE;
> > > +				if (put_user(regs->ARM_pc, usp) == 0) {
> > > +					flush_icache_range((unsigned long)usp,
> > > +						(unsigned long)(usp + 1));
> >
> > Why are you flushing the icache?  There is no code on the stack anymore.
> Yes indeed there is no more code modified.
> Side question: does the put_user requires a flush of some sort? If not, why?

No because it stores data into the d-cache directly at the virtual 
address to be used by user space.  Previously the d-cache needed to 
be cleaned for data to hit main memory and the i-cache invalidated for 
the newly stored _code_ to be seen by the instruction path.  Since there 
is no code involved anymore the cache flushes are useless.

> Is it OK to re-send a patch with the call to flush_icache_range removed?

Yes.


Nicolas
