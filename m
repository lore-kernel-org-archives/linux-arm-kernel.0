From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 17:27:23 +0200
Subject: [RFC PATCH v9 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <c6d79504-dfa8-a3fe-bd2b-20ac867e2514@arm.com>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-6-jglauber@cavium.com>
 <09997d9f-0003-0eb0-63d1-9b31e26e2229@arm.com>
 <20170831113508.GE15906@hc>
 <c6d79504-dfa8-a3fe-bd2b-20ac867e2514@arm.com>
Message-ID: <20170831152723.GA23982@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 02:26:22PM +0100, Suzuki K Poulose wrote:
> On 31/08/17 12:35, Jan Glauber wrote:
> >On Wed, Aug 30, 2017 at 11:03:00AM +0100, Suzuki K Poulose wrote:
> >>On 29/08/17 14:12, Jan Glauber wrote:

[...]

> >>>+/* LMC events */
> >>>+#define LMC_EVENT_IFB_CNT		0x1d0
> >>>+#define LMC_EVENT_OPS_CNT		0x1d8
> >>>+#define LMC_EVENT_DCLK_CNT		0x1e0
> >>>+#define LMC_EVENT_BANK_CONFLICT1	0x360
> >>>+#define LMC_EVENT_BANK_CONFLICT2	0x368
> >>>+
> >>>+#define CVM_PMU_LMC_EVENT_ATTR(_name, _id)						\
> >>>+	&((struct perf_pmu_events_attr[]) {						\
> >>>+		{									\
> >>>+			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
> >>>+			_id,								\
> >>>+			"lmc_event=" __stringify(_id),					\
> >>>+		}									\
> >>>+	})[0].attr.attr
> >>>+
> >>>+/* map counter numbers to register offsets */
> >>>+static int lmc_events[] = {
> >>>+	LMC_EVENT_IFB_CNT,
> >>>+	LMC_EVENT_OPS_CNT,
> >>>+	LMC_EVENT_DCLK_CNT,
> >>>+	LMC_EVENT_BANK_CONFLICT1,
> >>>+	LMC_EVENT_BANK_CONFLICT2,
> >>>+};
> >>>+
> >>>+static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
> >>>+{
> >>>+	struct hw_perf_event *hwc = &event->hw;
> >>>+
> >>>+	return cvm_pmu_add(event, flags, LMC_CONFIG_OFFSET,
> >>>+			   lmc_events[hwc->config]);
> >>>+}
> >>>+
> >>
> >>Is there any reason why we can't use the LMC event code directly
> >>here, avoiding the mapping altogether ?
> >
> >I wanted to avoid exposing the raw numbers (0x1d0 - 0x368) here.
> 
> Thats the primarily the reason why we expose the "aliases" in events/.
> The other problem with adding another layer of mapping is, you are preventing
> someone from actually mapping the raw code used by the perf tool (which is now
> a mapping index) to the real raw code used by the hardware unless they have
> the kernel source handy. If you choose to expose the raw numbers, like *all*
> the other PMUs, the user can map it by looking up the manual.

So what would that do to the config bits? Currently they are:
PMU_FORMAT_ATTR(lmc_event, "config:0-2");

Should I have config:0-9 then? Wouldn't that be confusing as there are
only 5 events?

Also I need to be very careful as we need to prevent a user from
accessing anything else then the counters. I can do that with the
event_valid callback though.

thanks,
Jan

> Cheers
> Suzuki
