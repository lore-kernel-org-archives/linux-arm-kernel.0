From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jun 2016 17:00:40 +0100
Subject: [PATCH v4 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <CACgAJHyprybnpQuKqvD9rXstQBwoeVG+uGtEBp-pppcfSGMKgQ@mail.gmail.com>
References: <1466618819-2697-1-git-send-email-ttnguyen@apm.com>
 <1466618819-2697-4-git-send-email-ttnguyen@apm.com>
 <20160623143201.GI8836@leverpostej>
 <CACgAJHyprybnpQuKqvD9rXstQBwoeVG+uGtEBp-pppcfSGMKgQ@mail.gmail.com>
Message-ID: <20160627160036.GB29321@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 10:54:20AM -0700, Tai Tri Nguyen wrote:
> On Thu, Jun 23, 2016 at 7:32 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jun 22, 2016 at 11:06:58AM -0700, Tai Nguyen wrote:
> > > +#define _GET_CNTR(ev)     (ev->hw.extra_reg.reg)
> > > +#define _GET_EVENTID(ev)  (ev->hw.config & 0xFFULL)
> > > +#define _GET_AGENTID(ev)  (ev->hw.extra_reg.config & 0xFFFFFFFFULL)
> > > +#define _GET_AGENT1ID(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFFFFFULL)
> >
> > I don't think you need to use the extra_reg fields for this. It's a
> > little bit confusing to use them, as the extra_reg (and branch_reg)
> > fields are for separately allocated PMU state.
> >
> > _GET_CNTR can use hw_perf_event::idx,  and _GET_AGENT*_ID can use
> > config_base.
> 
> I need a 64 bit field for GET_AGENT*ID. The config_base is only 32 bit.
> Can you please suggest another field?

Judging by <linux/perf_event.h> config_base is an unsigned long, which
will be 64 bit for arm64, which is the only place this is used.

So unless I've missed something, that should be ok, no?

> > > +static u64 xgene_perf_event_update(struct perf_event *event)
> > > +{
> > > +     struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> > > +     struct hw_perf_event *hwc = &event->hw;
> > > +     u64 delta, prev_raw_count, new_raw_count;
> > > +
> > > +again:
> > > +     prev_raw_count = local64_read(&hwc->prev_count);
> > > +     new_raw_count = pmu_dev->max_period;
> >
> > I don't understand this. Why are we not reading the counter here?
> >
> > This means that the irq handler won't be reading the counter, which
> > means we're throwing away events, and I suspect other cases are broken
> > too.
> >
> 
> When the overflow interrupt occurs, the PMU counter wraps to 0 and
> continues to run.
> This event_update function is called only to handle the The PMU
> counter overflow interrupt occurs.
> I'm assuming that when the overflow happens, the read back counter
> value is the max period.

Well, it could be a larger value depending on the latency.

> Is this assumption incorrect? Do you have any suggestion what I should
> do. Because if I read the counter register,
> it returns the minor wrapped around value.
> Or should it be: new_count = counter read + max period?

We handle the wraparound when we caluclate the delta below. By setting
the interrupt to occur within half of the max period (as per the arm-cci
driver), we avoid (with a high degree of certainty) the risk of
overtaking the prev raw count again before handlnig the IRQ.

The raw_* values above should be the *raw* values from the HW, as their
names imply.

> > > +     if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> > > +                         new_raw_count) != prev_raw_count)
> > > +             goto again;
> > > +
> > > +     delta = (new_raw_count - prev_raw_count) & pmu_dev->max_period;
> > > +
> > > +     local64_add(delta, &event->count);
> > > +     local64_sub(delta, &hwc->period_left);
> >
> > Given we aren't sampling, does the period left matter? It looks like
> > drivers are inconsistent w.r.t. this, and I'm not immediately sure :(
> 
> I tried to drop it and  the perf event count still works properly for me.
> I'll remove it.

[...]

> > > +static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
> > > +{
> > > +     struct xgene_pmu_dev_ctx *ctx, *temp_ctx;
> > > +     struct xgene_pmu *xgene_pmu = dev_id;
> > > +     u32 val;
> > > +
> > > +     xgene_pmu_mask_int(xgene_pmu);
> >
> > Why do you need to mask the IRQ? This handler is called in hard IRQ
> > context.
> 
> Right. Let me change to use raw_spin_lock_irqsave here.

Interesting; I see we do that in the CCI PMU driver. What are we trying
to protect?

We don't do that in the CPU PMU drivers, and I'm missng something here.
Hopefully I'm just being thick...

Thanks,
Mark.
