From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 11:43:25 +0000
Subject: [PATCH v6 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <58D4C006.2010907@gmail.com>
References: <1489127325-112821-1-git-send-email-anurup.m@huawei.com>
 <20170321171605.GB29116@leverpostej> <58D4C006.2010907@gmail.com>
Message-ID: <20170324114325.GC22771@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 12:13:18PM +0530, Anurup M wrote:
> On Tuesday 21 March 2017 10:46 PM, Mark Rutland wrote:
> >On Fri, Mar 10, 2017 at 01:28:45AM -0500, Anurup M wrote:

> >>+/* The counter overflow IRQ is not supported for some PMUs
> >>+ * use hrtimer to periodically poll and avoid overflow
> >>+ */
> >>+static enum hrtimer_restart hisi_hrtimer_callback(struct hrtimer *hrtimer)
> >>+{
> >>+	struct hisi_pmu *hisi_pmu = container_of(hrtimer,
> >>+						 struct hisi_pmu, hrtimer);
> >>+	struct perf_event *event;
> >>+	struct hw_perf_event *hwc;
> >>+	unsigned long flags;
> >>+
> >>+	/* Return if no active events */
> >>+	if (!hisi_pmu->num_active)
> >>+		return HRTIMER_NORESTART;
> >>+
> >>+	local_irq_save(flags);
> >>+
> >>+	/* Update event count for each active event */
> >>+	list_for_each_entry(event, &hisi_pmu->active_list, active_entry) {
> >>+		hwc = &event->hw;
> >>+		/* Read hardware counter and update the Perf event counter */
> >>+		hisi_pmu->ops->event_update(event, hwc, GET_CNTR_IDX(hwc));
> >>+	}
> >How do we ensure that we don't take the interrupt in the middle of a
> >sequence of accesses to the HW?
> 
> The L3 cache and MN PMU does not use the overflow IRQ and it does
> not occur here
> as the interrupt Mask register is by default masked in hardware.

I was referring to the timer interrupt which backs the hrtimer.

i.e. how do we guarantee that hisi_hrtimer_callback() is not called
while we are in the middle of a RMW sequence? Are interrupts disabled
for all of those seqeunces?

Thanks,
Mark.
