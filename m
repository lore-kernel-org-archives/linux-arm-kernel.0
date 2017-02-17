From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Feb 2017 18:52:44 +0000
Subject: [PATCH V2] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <8ace145be288028fb5faeb90e48a0d64@codeaurora.org>
References: <1487257385-28930-1-git-send-email-agustinv@codeaurora.org>
 <20170216164140.GC588@leverpostej>
 <8ace145be288028fb5faeb90e48a0d64@codeaurora.org>
Message-ID: <20170217185243.GC25876@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 05:01:19PM -0500, Agustin Vega-Frias wrote:
> On 2017-02-16 11:41, Mark Rutland wrote:
> >On Thu, Feb 16, 2017 at 10:03:05AM -0500, Agustin Vega-Frias wrote:
> >>This adds a new dynamic PMU to the Perf Events framework to program
> >>and control the L3 cache PMUs in some Qualcomm Technologies SOCs.

> >At a quick glance, this looks *awfully* similar to the L2 PMU, modulo
> >using MMIO rather than sysreg accesses. The basic shape of the hardware
> >seems the same, and the register offsets are practically identical.
> >
> >I guess that the L2 and L3 are largely the same block?
> >
> >How exactly does this relate to the L2 PMU hardware? Could you please
> >elaborate on any major differences?
> 
> The L2 and L3 blocks are separate. In the current SoC each internal
> cluster shares an L2, but all clusters in the SoC share all the L3
> slices. Logically it is seen as a single, larger L3 cache, shared by
> all CPUs in the system. In spite of this, each physical slice has its
> own PMU. Which slice serves a given memory access is determined by
> a hashing algorithm which means all CPUs might have cache lines on
> every slice.
> 
> >This has similar issues to earlier versions of the L2 PMU driver, such
> >as permitting cross-{slice,pmu} groups, and aggregating per-slice
> >events, which have been addressed in the upstreamed L2 PMU driver.
> 
> We represent this as a single perf PMU that can only be associated
> with a sigle CPU context. We do aggregation here, since logically it
> is a single L3 cache.

Collating the PMUs behind a single logical PMU is fine.

I'm specifically referring to collating events (i.e. hiding separately
controlled counters behind a single perf_event).

Since the L2 slices were cluster-affine, we could manage those on a
per-cpu basis. Here you'd either have to have a config field to select
the slice, or expose each slice as its own PMU.

> >>+static void qcom_l3_cache__64bit_counter_start(struct
> >>perf_event *event)
> >>+{
> >>+	struct l3cache_pmu *socket = to_l3cache_pmu(event->pmu);
> >>+	struct hml3_pmu *slice;
> >>+	int idx = event->hw.idx;
> >>+	u64 value = local64_read(&event->count);
> >>+
> >>+	list_for_each_entry(slice, &socket->pmus, entry) {
> >>+		hml3_pmu__counter_enable_gang(slice, idx+1);
> >>+
> >>+		if (value) {
> >>+			hml3_pmu__counter_set_value(slice, idx+1, value >> 32);
> >>+			hml3_pmu__counter_set_value(slice, idx, (u32)value);
> >>+			value = 0;
> >>+		} else {
> >>+			hml3_pmu__counter_set_value(slice, idx+1, 0);
> >>+			hml3_pmu__counter_set_value(slice, idx, 0);
> >>+		}
> >>+
> >>+		hml3_pmu__counter_set_event(slice, idx+1, 0);
> >>+		hml3_pmu__counter_set_event(slice, idx, get_event_type(event));
> >>+
> >>+		hml3_pmu__counter_enable(slice, idx+1);
> >>+		hml3_pmu__counter_enable(slice, idx);
> >>+	}
> >>+}
> >
> >As with other PMU drivers, NAK to aggregating (separately-controlled)
> >HW events behind a single event. We should not be aggregating across
> >slices as we cannot start/stop those atomically.
> 
> In this case we start the hardware events in all slices. IOW there is a
> one-to-many relationship between perf_events in this perf PMU and events
> in the hardware PMUs.

I understand what is happening here; I'm simply disagreeing with it. We
do not permit event aggregation in this manner. Please see [1].

[...]

> >>+PMU_FORMAT_ATTR(event, "config:0-7");
> >>+PMU_FORMAT_ATTR(lc, "config:32");
> >
> >What is this 'lc' field?
> 
> It means "long counter". We have a feature that allows chaining two
> 32 bit
> hardware counters. This is how a user requests that.

Ok. This will need documentation.

[...]

> >>+static int qcom_l3_cache_pmu_offline_cpu(unsigned int cpu,
> >>struct hlist_node *n)
> >>+{
> >>+	struct l3cache_pmu *socket = hlist_entry_safe(n, struct
> >>l3cache_pmu, node);
> >>+	unsigned int target;
> >>+
> >>+	if (!cpumask_test_and_clear_cpu(cpu, &socket->cpu))
> >>+		return 0;
> >>+	target = cpumask_any_but(cpu_online_mask, cpu);
> >>+	if (target >= nr_cpu_ids)
> >>+		return 0;
> >>+	/*
> >>+	 * TODO: migrate context once core races on event->ctx have
> >>+	 * been fixed.
> >>+	 */
> >>+	cpumask_set_cpu(target, &socket->cpu);
> >>+	return 0;
> >>+}
> >
> >The event->ctx race has been fixed for a while now.
> 
> Great, I was searching for that yesterday, but could not find
> anything and
> assumed it had not been fixed, given that the CCI driver still has this
> comment in it. So it is safe to add the call to
> perf_pmu_migrate_context now?
> >
> >Please follow the example of the L2 PMU's hotplug callback, and also
> >fold the reset into the hotplug callback.
> 
> I agree we will need to do that once we have multi-socket support, but
> would you agree to keep this as-is for the time being?

If you treat the PMU as being affine to cpu_possible_mask you can follow
the same strategy as the L2 PMU driver. Even if it's not strictly
necessary, it avoids a needless difference between the two drivers.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/478424.html
