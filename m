From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Feb 2018 11:43:14 +0000
Subject: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
In-Reply-To: <90e7ff7d7dc1054db356fb1740ddb990@codeaurora.org>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
 <20180225143802.denbkubqjg2dc7af@salmiak>
 <90e7ff7d7dc1054db356fb1740ddb990@codeaurora.org>
Message-ID: <20180227114313.mtvyo6rdavqfj2hy@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 06:11:45PM -0800, skannan at codeaurora.org wrote:
> On 2018-02-25 06:38, Mark Rutland wrote:
> > On Fri, Feb 23, 2018 at 04:19:38PM -0800, Saravana Kannan wrote:
> > > Some PMUs events can be read from any CPU. So allow the PMU to mark
> > > events as such. For these events, we don't need to reject reads or
> > > make smp calls to the event's CPU and cause unnecessary wake ups.
> > > 
> > > Good examples of such events would be events from caches shared across
> > > all CPUs.
> > 
> > I think that if we need to generalize PERF_EV_CAP_READ_ACTIVE_PKG, it
> > would be
> > better to give events a pointer to a cpumask. That could then cover all
> > cases
> > quite trivially:
> > 
> > static int __perf_event_read_cpu(struct perf_event *event, int
> > event_cpu)
> > {
> > 	int local_cpu = smp_processor_id();
> > 
> > 	if (event->read_mask &&
> > 	    cpumask_test_cpu(local_cpu, event->read_mask))
> > 		event_cpu = local_cpu;
> > 
> > 	return event_cpu;
> > }
> 
> This is a good improvement on my attempt. If I send a patch for this, is
> that something you'd be willing to incorporate into your patch set and make
> sure the DSU pmu driver handles it correctly?

As I commented, I don't think that willl work without more invasive
changes as the DSU PMU's pmu::read() function has side effects on
hwc->prev_count and event_count, and could race with an IRQ handler on
another CPU.

Is the IPI really a problem in practice?

Thanks,
Mark.
