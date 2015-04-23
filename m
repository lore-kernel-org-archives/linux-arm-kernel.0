From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Apr 2015 15:11:23 +0100
Subject: [PATCH 1/4] ARM: perf: don't warn about missing
 interrupt-affinity property for PPIs
In-Reply-To: <20150423140223.GI1652@arm.com>
References: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
 <20150423140058.GF29702@leverpostej>
 <20150423140223.GI1652@arm.com>
Message-ID: <20150423141123.GA24465@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 03:02:24PM +0100, Will Deacon wrote:
> On Thu, Apr 23, 2015 at 03:01:00PM +0100, Mark Rutland wrote:
> > On Thu, Apr 23, 2015 at 02:50:30PM +0100, Will Deacon wrote:
> > > PPIs are affine by nature, so the interrupt-affinity property is not
> > > used and therefore we shouldn't print a warning in its absence.
> > > 
> > > Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/kernel/perf_event_cpu.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> > > index 91c7ba182dcd..becf7ad6eddc 100644
> > > --- a/arch/arm/kernel/perf_event_cpu.c
> > > +++ b/arch/arm/kernel/perf_event_cpu.c
> > > @@ -303,12 +303,17 @@ static int probe_current_pmu(struct arm_pmu *pmu)
> > >  
> > >  static int of_pmu_irq_cfg(struct platform_device *pdev)
> > >  {
> > > -	int i;
> > > +	int i, irq;
> > >  	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
> > >  
> > >  	if (!irqs)
> > >  		return -ENOMEM;
> > >  
> > > +	/* Don't bother with PPIs; they're already affine */
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq >= 0 && irq_is_percpu(irq))
> > > +		return 0;
> > 
> > Is 0 still a valid IRQ on any ARM platforms?
> 
> I just went for consistency with the cpu_pmu_{request,free}_irq paths.

Ah, ok. That makes sense.

I guess that also applies to the arm64 part, so feel free to add my ack
to both.

Mark.
