From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 11:06:40 +0100
Subject: [PATCH 3/8] arm: perf: use IDR types for CPU PMUs
In-Reply-To: <5446CF3E.70807@codeaurora.org>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-4-git-send-email-mark.rutland@arm.com>
 <5446CF3E.70807@codeaurora.org>
Message-ID: <20141022100639.GB22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 10:25:18PM +0100, Stephen Boyd wrote:
> On 10/21/2014 06:11 AM, Mark Rutland wrote:
> >  arch/arm/kernel/perf_event.c     | 6 +++++-
> >  arch/arm/kernel/perf_event_cpu.c | 2 +-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index ae96b98..f0bbd3d 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -77,8 +77,12 @@ armpmu_map_event(struct perf_event *event,
> >  		 u32 raw_event_mask)
> >  {
> >  	u64 config = event->attr.config;
> > +	int type = event->attr.type;
> 
> Can we use u32 here to match the userspace ABI and avoid any signed vs.
> unsigned oddness?

I'd used int to match the definition of struct pmu::type (and elsewhere
in the perf core code, e.g. the int type parameter to
perf_pmu_register).

> >  
> > -	switch (event->attr.type) {
> > +	if (type >= PERF_TYPE_MAX && type == event->pmu->type)

I'll get rid of the check against PERF_TYPE_MAX here -- it's redundant
given we're about to check equivalence with event->pmu->type anyway.

With that removed we only check for equivalence between the userspace
provided type and any kernelspace type fields (which should all be in
the range [0,INT_MAX]), rather than greater/less than comparisons. So I
think we should be ok.

Does that make sense?

Thanks,
Mark.

> > +		return armpmu_map_raw_event(raw_event_mask, config);
> > +
> > +	switch (type) {
> >  	case PERF_TYPE_HARDWARE:
> >  		return armpmu_map_hw_event(event_map, config);
> >  	case PERF_TYPE_HW_CACHE:
> >
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
