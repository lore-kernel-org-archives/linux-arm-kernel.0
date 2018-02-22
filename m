From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 11:33:53 +0000
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <5A8E2BCE.3050509@codeaurora.org>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A8E2BCE.3050509@codeaurora.org>
Message-ID: <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 06:32:46PM -0800, Saravana Kannan wrote:
> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> > +static int dsu_pmu_event_init(struct perf_event *event)
> > +{
> > +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> > +
> > +	if (event->attr.type != event->pmu->type)
> > +		return -ENOENT;
> 
> You are checking if the caller set the attr.type "correctly".

This is necessary for the case where perf_init_event() falls back to
iterating over the list of PMUs, if event->attr.type wasn't found in the
idr.

Without this, we'd erroneously check events intended for other PMUs.
So this is correct, and necessary.

[...]

> > +static int dsu_pmu_device_probe(struct platform_device *pdev)

> > +	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
> 
> You are passing in -1 here. Which means the event type is assigned by the
> perf framework. perf framework uses idr_alloc(&pmu_idr, ...) to get the id.
> So the id assigned is going to depend on the probe order among the different
> PMU drivers in the board/platform. So, this seems pretty random.

The dynamic IDs are supposed to by looked up by name.

Each PMU has a folder: /sys/bus/event_source/devices/$PMU

... with /sys/bus/event_source/devices/$PMU/type giving the type.

> How is the caller supposed to know what to set the "type" to?

The perf tools understand this already. If you do:

perf stat -e $PMU/config=0xf00/

... they will look up the type for that PMU and use it automatically.

> You also can't just delete the check in dsu_pmu_event_init() because the
> event numbers you expose overlap with the per-CPU event numbers.

The type check is necessary and cannot be deleted. It provides a
namespace for the event IDs.

> I'm not exactly sure if we can add entries to perf_type_id. If that's
> allowed maybe we need to add something line PERF_TYPE_DSU and use that?
> 
> Or if that's not allowed then would it be better to offset the DSU PMU
> events by some number (say 0x1000) and then delete the event type check or
> pass PERF_TYPE_RAW to perf_pmu_register()?

As above, neither of these should be necessary.

Thanks,
Mark.
