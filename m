From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Oct 2018 10:04:11 +0100
Subject: [PATCH 1/6] arm64: perf: Reject stand-alone CHAIN events for PMUv3
In-Reply-To: <3fdfb5d5-b667-e797-3605-7557cc810f90@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
 <1539189115-16221-2-git-send-email-will.deacon@arm.com>
 <3fdfb5d5-b667-e797-3605-7557cc810f90@arm.com>
Message-ID: <20181011090410.GA20836@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 06:30:13PM +0100, Suzuki K Poulose wrote:
> On 10/10/18 17:31, Will Deacon wrote:
> >It doesn't make sense for a perf event to be configured as a CHAIN event
> >in isolation, so extend the arm_pmu structure with a ->filter_match()
> >function to allow the backend PMU implementation to reject CHAIN events
> >early.
> >
> >Cc: <stable@vger.kernel.org>
> >Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> 
> 
> >---
> >  arch/arm64/kernel/perf_event.c | 7 +++++++
> >  drivers/perf/arm_pmu.c         | 8 +++++++-
> >  include/linux/perf/arm_pmu.h   | 1 +
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> >index 8e38d5267f22..e213f8e867f6 100644
> >--- a/arch/arm64/kernel/perf_event.c
> >+++ b/arch/arm64/kernel/perf_event.c
> >@@ -966,6 +966,12 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
> >  	return 0;
> >  }
> >+static int armv8pmu_filter_match(struct perf_event *event)
> >+{
> >+	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
> >+	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
> >+}
> >+
> 
> The patch looks correct. I guess we could handle it via the existing
> map_event(), avoiding another arch specific callback.

I initially implemented it using ->map_event(), but that has weird
interactions with groups where other events in the group following the
CHAIN event will not count, but previous events will. This means that the
perf behaviour depends on the order in which you specify the events, which
is really confusing!

> Either way,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks.

Will
