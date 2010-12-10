From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Dec 2010 19:17:20 +0000
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1292004654.13513.38.camel@laptop>
References: <1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins> <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins> <1291988866.6803.171.camel@twins>
	<20101210175645.GB28263@n2100.arm.linux.org.uk>
	<1292004654.13513.38.camel@laptop>
Message-ID: <20101210191720.GC28263@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 07:10:54PM +0100, Peter Zijlstra wrote:
> On Fri, 2010-12-10 at 17:56 +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 10, 2010 at 02:47:46PM +0100, Peter Zijlstra wrote:
> > >  inline void update_rq_clock(struct rq *rq)
> > >  {
> > > -	int cpu = cpu_of(rq);
> > > -	u64 irq_time;
> > > +	s64 delta;
> > >  
> > >  	if (rq->skip_clock_update)
> > >  		return;
> > >  
> > > -	rq->clock = sched_clock_cpu(cpu);
> > > -	irq_time = irq_time_cpu(cpu);
> > > -	if (rq->clock - irq_time > rq->clock_task)
> > > -		rq->clock_task = rq->clock - irq_time;
> > > +	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
> > > +	rq->clock += delta;
> > 
> > Hmm.  Can you tell me how this is different to:
> > 
> > 	new_clock = sched_clock_cpu(cpu_of(rq));
> > 	delta = new_clock - rq->clock;
> > 	rq->clock = new_clock;
> > 
> > which I think may be simpler in terms of 64-bit math for 32-bit compilers
> > to deal with?
> 
> Its not, I could write it like that, the only reason I didn't is because
> it uses an extra variable. If gcc on 32bit targets really generates
> hideous code for it I'll happily change it.

Well, I can't tell you what kind of code this produces on ARM, as it
doesn't appear to apply to any kernel I've tried.  So, I assume it's
against some scheduler development tree rather than Linus' tree?
