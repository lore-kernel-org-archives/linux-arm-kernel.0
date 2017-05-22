From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 May 2017 13:44:46 +0100
Subject: [PATCH v3 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170522073249.d95a6d7050d24e99261ceae6@arm.com>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
 <1495128273-13941-5-git-send-email-will.deacon@arm.com>
 <20170522073249.d95a6d7050d24e99261ceae6@arm.com>
Message-ID: <20170522124446.GE1478@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 22, 2017 at 07:32:49AM -0500, Kim Phillips wrote:
> On Thu, 18 May 2017 18:24:32 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > +/* Perf callbacks */
> > +static int arm_spe_pmu_event_init(struct perf_event *event)
> > +{
> > +	u64 reg;
> > +	struct perf_event_attr *attr = &event->attr;
> > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > +
> > +	/* This is, of course, deeply driver-specific */
> > +	if (attr->type != event->pmu->type)
> > +		return -ENOENT;
> > +

[trimming other return sites]

> I've consistently brought up lack of proper user error messaging in all
> previous submissions of this driver:
> 
... and we've consistently explained why logging such things to dmesg by
default will not fly. As before, while we call these return codes error
values, they are *not* errors in the same sense as pr_err().

> 6 apr 2017 (PATCH v2 series):
> https://lkml.org/lkml/2017/4/6/790

Please consult my replies to this:

https://lkml.org/lkml/2017/4/6/796
https://lkml.org/lkml/2017/4/7/246

... we can add a pr_debug() for these cases, as that will be guarded by
dynamic debug, and won't be pointlessly spamming the dmesg.

Anything beyond that simply will not fly.

> AFAICT, my comments hold, yet the driver still gets resubmitted without
> them being addressed.  How do we get out of this loop?

We've repeatedly explained why the approach you suggest is not feasible.
Perhaps you could try to explain why our approach doesn't seem feasible
to you.

Thanks,
Mark.
