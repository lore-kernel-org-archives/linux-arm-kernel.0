From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 23 Mar 2017 20:19:53 +0100
Subject: [PATCH V8 1/3] irq: Add flags to request_percpu_irq function
In-Reply-To: <20170323185449.GA21359@leverpostej>
References: <1490290924-12958-1-git-send-email-daniel.lezcano@linaro.org>
 <20170323185449.GA21359@leverpostej>
Message-ID: <20170323191953.GC24630@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Mar 23, 2017 at 06:54:52PM +0000, Mark Rutland wrote:
> Hi Daniel,
> 
> On Thu, Mar 23, 2017 at 06:42:01PM +0100, Daniel Lezcano wrote:
> > In the next changes, we track the interrupts but we discard the timers as
> > that does not make sense. The next interrupt on a timer is predictable.
> 
> Sorry, but I could not parse this. 

I meant we are measuring when are happening the interrupts by getting the local
clock in the interrupt handler. But if the interrupts are coming from a timer, it
is not necessary to do that because we already know when they will occur.

So, in order to sort out which interrupt we measure, we use the IRQF_TIMER flag.

Unfortunately, this flag is missing when we do a request_percpu_irq. The
purpose of this patch is to fix that.

> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 9612b84..0f5ab4a 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -661,7 +661,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
> >  
> >  	irq = platform_get_irq(pmu_device, 0);
> >  	if (irq > 0 && irq_is_percpu(irq)) {
> > -		err = request_percpu_irq(irq, handler, "arm-pmu",
> > +		err = request_percpu_irq(irq, 0, handler, "arm-pmu",
> >  					 &hw_events->percpu_pmu);
> >  		if (err) {
> >  			pr_err("unable to request IRQ%d for ARM PMU counters\n",
> 
> Please Cc myself and Will Deacon when modifying the arm_pmu driver, as
> per MAINTAINERS. I only spotted this patch by chance.

Ah, ok, sorry for that. Thanks for spotting this, you should have been Cc'ed by
my cccmd script. I will check that.

> This conflicts with arm_pmu changes I have queued for v4.12 [1].
> 
> So, can we leave the prototype of request_percpu_irq() as-is?
> 
> Why not add a new request_percpu_irq_flags() function, and leave
> request_percpu_irq() as a wrapper for that? e.g.

[ ... ]

> static inline int
> request_percpu_irq(unsigned int irq, irq_handler_t handler,
> 		   const char *devname, void __percpu *percpu_dev_id)
> {
> 	return request_percpu_irq_flags(irq, handler, devname,
> 					percpu_dev_id, 0);
> }
> 
> ... that would avoid having to touch any non-timer driver for now.

Mmh, yes. That's a good suggestion.

> [...]
> 
> > -request_percpu_irq(unsigned int irq, irq_handler_t handler,
> > -		   const char *devname, void __percpu *percpu_dev_id);
> > +request_percpu_irq(unsigned int irq, unsigned long flags,
> > +		   irq_handler_t handler,  const char *devname,
> > +		   void __percpu *percpu_dev_id);
> >  
> 
> Looking at request_irq, the prototype is:
> 
> int __must_check
> request_irq(unsigned int irq, irq_handler_t handler,
> 	    unsigned long flags, const char *name,
> 	    void *dev);
> 
> ... surely it would be better to share the same argument order? i.e.
> 
> int __must_check
> request_percpu_irq(unsigned int irq, irq_handler_t handler,
> 		   unsigned long flags, const char *devname,
> 		   void __percpu *percpu_dev_id);
> 

Agree.

Thanks for the review.

  -- Daniel


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
