From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 15:04:12 +0000
Subject: [PATCH v2 1/7] ARM: perf_event: Support percpu irqs for the CPU
 PMU
In-Reply-To: <20140115205427.GB26193@codeaurora.org>
References: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
 <1389808535-23852-2-git-send-email-sboyd@codeaurora.org>
 <20140115205427.GB26193@codeaurora.org>
Message-ID: <20140117150411.GI16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jan 15, 2014 at 08:54:27PM +0000, Stephen Boyd wrote:
> On 01/15, Stephen Boyd wrote:
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index 789d846a9184..e76750980b38 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -295,9 +297,15 @@ validate_group(struct perf_event *event)
> >  
> >  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
> >  {
> > -	struct arm_pmu *armpmu = (struct arm_pmu *) dev;
> > -	struct platform_device *plat_device = armpmu->plat_device;
> > -	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
> > +	struct arm_pmu *armpmu;
> > +	struct platform_device *plat_device;
> > +	struct arm_pmu_platdata *plat;
> > +
> > +	if (irq_is_percpu(irq))
> > +		dev = *(struct arm_pmu_cpu **)dev;
> 
> Oh. I just realized that struct arm_pmu_cpu doesn't even exist. This
> still compiles though because we're dealing with a void pointer.
> 
> Perhaps its better to just do
> 
> 	dev = *(void **)dev;
> 
> here. Can you fix that up when applying? Otherwise I'll do it on
> the next send if there are more comments.

Shouldn't that actually be some per_cpu accessor like this_cpu_ptr?

Will
