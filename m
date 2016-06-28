From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 12:13:55 +0100
Subject: [PATCH v4 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <CACgAJHzM-hzJJDr-HzZyDQ0SUg0PEd5SYKo8YPnRCDCVA9JuJg@mail.gmail.com>
References: <1466618819-2697-1-git-send-email-ttnguyen@apm.com>
 <1466618819-2697-4-git-send-email-ttnguyen@apm.com>
 <20160623143201.GI8836@leverpostej>
 <CACgAJHyprybnpQuKqvD9rXstQBwoeVG+uGtEBp-pppcfSGMKgQ@mail.gmail.com>
 <20160627160036.GB29321@leverpostej>
 <CACgAJHzM-hzJJDr-HzZyDQ0SUg0PEd5SYKo8YPnRCDCVA9JuJg@mail.gmail.com>
Message-ID: <20160628111355.GI31744@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 10:54:07AM -0700, Tai Tri Nguyen wrote:
> On Mon, Jun 27, 2016 at 9:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Sat, Jun 25, 2016 at 10:54:20AM -0700, Tai Tri Nguyen wrote:
> >> On Thu, Jun 23, 2016 at 7:32 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Jun 22, 2016 at 11:06:58AM -0700, Tai Nguyen wrote:
> >> > > +static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
> >> > > +{
> >> > > +     struct xgene_pmu_dev_ctx *ctx, *temp_ctx;
> >> > > +     struct xgene_pmu *xgene_pmu = dev_id;
> >> > > +     u32 val;
> >> > > +
> >> > > +     xgene_pmu_mask_int(xgene_pmu);
> >> >
> >> > Why do you need to mask the IRQ? This handler is called in hard IRQ
> >> > context.
> >>
> >> Right. Let me change to use raw_spin_lock_irqsave here.
> >
> > Interesting; I see we do that in the CCI PMU driver. What are we trying
> > to protect?
> >
> > We don't do that in the CPU PMU drivers, and I'm missng something here.
> > Hopefully I'm just being thick...
> 
> For me, we can't guarantee that the interrupt doesn't happen on the other CPUs.
> The irqbalancer may change the SMP affinity.

The perf core requires things to occur on the same CPU for correct
synchronisation.

If an IRQ balancer can change the IRQ affinity behind our back, we have
much bigger problems that affect other uncore PMU drivers.

Marc, is there a sensible way to prevent irq balancers from changing the
affinity of an IRQ, e.g. a kernel-side pinning mechanism, or some way we
can be notified and reject changes?

Thanks,
Mark.
