From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 26 Jul 2017 13:19:46 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
Message-ID: <20170726111946.GA6273@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 04:39:18PM +0100, Suzuki K Poulose wrote:
> On 25/07/17 16:04, Jan Glauber wrote:
> >Add support for the PMU counters on Cavium SOC memory controllers.
> >
> >This patch also adds generic functions to allow supporting more
> >devices with PMU counters.
> >
> >Properties of the LMC PMU counters:
> >- not stoppable
> >- fixed purpose
> >- read-only
> >- one PCI device per memory controller
> >
> >Signed-off-by: Jan Glauber <jglauber@cavium.com>
> >---
> > drivers/perf/Kconfig       |   8 +
> > drivers/perf/Makefile      |   1 +
> > drivers/perf/cavium_pmu.c  | 424 +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/cpuhotplug.h |   1 +
> > 4 files changed, 434 insertions(+)
> > create mode 100644 drivers/perf/cavium_pmu.c
> >
> >diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> >index e5197ff..a46c3f0 100644
> >--- a/drivers/perf/Kconfig
> >+++ b/drivers/perf/Kconfig
> >@@ -43,4 +43,12 @@ config XGENE_PMU
> >         help
> >           Say y if you want to use APM X-Gene SoC performance monitors.
> >
> >+config CAVIUM_PMU
> >+	bool "Cavium SOC PMU"
> 
> Is there any specific reason why this can't be built as a module ?

Yes. I don't know how to load the module automatically. I can't make it
a pci driver as the EDAC driver "owns" the device (and having two
drivers for one device wont work as far as I know). I tried to hook
into the EDAC driver but the EDAC maintainer was not overly welcoming
that approach.

And while it would be possible to have it a s a module I think it is of
no use if it requires manualy loading. But maybe there is a simple
solution I'm missing here?

> 
> >+#define to_pmu_dev(x) container_of((x), struct cvm_pmu_dev, pmu)
> >+
> >+static int cvm_pmu_event_init(struct perf_event *event)
> >+{
> >+	struct hw_perf_event *hwc = &event->hw;
> >+	struct cvm_pmu_dev *pmu_dev;
> >+	struct perf_event *sibling;
> >+
> >+	if (event->attr.type != event->pmu->type)
> >+		return -ENOENT;
> >+
> >+	/* we do not support sampling */
> >+	if (is_sampling_event(event))
> >+		return -EINVAL;
> >+
> >+	/* PMU counters do not support any these bits */
> >+	if (event->attr.exclude_user	||
> >+	    event->attr.exclude_kernel	||
> >+	    event->attr.exclude_host	||
> >+	    event->attr.exclude_guest	||
> >+	    event->attr.exclude_hv	||
> >+	    event->attr.exclude_idle)
> >+		return -EINVAL;
> >+
> >+	pmu_dev = to_pmu_dev(event->pmu);
> >+	if (!pmu_dev->event_valid(event->attr.config))
> >+		return -EINVAL;
> >+
> >+	/*
> >+	 * Forbid groups containing mixed PMUs, software events are acceptable.
> >+	 */
> >+	if (event->group_leader->pmu != event->pmu &&
> >+	    !is_software_event(event->group_leader))
> >+		return -EINVAL;
> >+
> >+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> >+			    group_entry)
> >+		if (sibling->pmu != event->pmu &&
> >+		    !is_software_event(sibling))
> >+			return -EINVAL;
> 
> Do we also need to check if the events in the same group can be scheduled
> at once ? i.e, there is enough resources to schedule the requested events from
> the group.
>

Not sure what you mean, do I need to check for programmable counters
that no more counters are programmed than available?

> >+
> >+	hwc->config = event->attr.config;
> >+	hwc->idx = -1;
> >+	return 0;
> >+}
> >+
> ...
> 
> >+static int cvm_pmu_add(struct perf_event *event, int flags, u64 config_base,
> >+		       u64 event_base)
> >+{
> >+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> >+	struct hw_perf_event *hwc = &event->hw;
> >+
> >+	if (!cmpxchg(&pmu_dev->events[hwc->config], NULL, event))
> >+		hwc->idx = hwc->config;
> >+
> >+	if (hwc->idx == -1)
> >+		return -EBUSY;
> >+
> >+	hwc->config_base = config_base;
> >+	hwc->event_base = event_base;
> >+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> >+
> >+	if (flags & PERF_EF_START)
> >+		pmu_dev->pmu.start(event, PERF_EF_RELOAD);
> >+
> >+	return 0;
> >+}
> >+
> >+static void cvm_pmu_del(struct perf_event *event, int flags)
> >+{
> >+	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> >+	struct hw_perf_event *hwc = &event->hw;
> >+	int i;
> >+
> >+	event->pmu->stop(event, PERF_EF_UPDATE);
> >+
> >+	/*
> >+	 * For programmable counters we need to check where we installed it.
> >+	 * To keep this function generic always test the more complicated
> >+	 * case (free running counters won't need the loop).
> >+	 */
> >+	for (i = 0; i < pmu_dev->num_counters; i++)
> >+		if (cmpxchg(&pmu_dev->events[i], event, NULL) == event)
> >+			break;
> 
> I couldn't see why hwc->config wouldn't give us the index where we installed
> the event in pmu_dev->events. What am I missing ?

Did you see the comment above? It is not yet needed but will be when I
add support for programmable counters. If it is still confusing I can
also remove that for now and add it back later when it is needed.

> >+static int __init cvm_pmu_init(void)
> >+{
> >+	unsigned long implementor = read_cpuid_implementor();
> >+	unsigned int vendor_id = PCI_VENDOR_ID_CAVIUM;
> >+	struct pci_dev *pdev = NULL;
> >+	int rc;
> >+
> >+	if (implementor != ARM_CPU_IMP_CAVIUM)
> >+		return -ENODEV;
> 
> As I mentioned in the beginning, it would be better to modularize it right
> from the start, when we can, than coming back to this at a later point in time.
> 
> Btw, perf_event_update_userpage() is being exported for use from module.
> See [0].
>
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520682.html

Nice, I think I proposed something similar :)

thanks,
Jan

> Cheers
> 
> Suzuki
