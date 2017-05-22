From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 22 May 2017 10:45:21 -0500
Subject: [PATCH v3 4/5] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170522124446.GE1478@leverpostej>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
 <1495128273-13941-5-git-send-email-will.deacon@arm.com>
 <20170522073249.d95a6d7050d24e99261ceae6@arm.com>
 <20170522124446.GE1478@leverpostej>
Message-ID: <20170522104521.942a45a207d541edcf738b4c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 13:44:46 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi,

Hi Mark,

> On Mon, May 22, 2017 at 07:32:49AM -0500, Kim Phillips wrote:
> > On Thu, 18 May 2017 18:24:32 +0100
> > Will Deacon <will.deacon@arm.com> wrote:
> > > +/* Perf callbacks */
> > > +static int arm_spe_pmu_event_init(struct perf_event *event)
> > > +{
> > > +	u64 reg;
> > > +	struct perf_event_attr *attr = &event->attr;
> > > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > > +
> > > +	/* This is, of course, deeply driver-specific */
> > > +	if (attr->type != event->pmu->type)
> > > +		return -ENOENT;
> > > +
> 
> [trimming other return sites]

Thanks but other conditions, such as the user specified sample period
check would be more appropriate to be left in for this discussion.

> > I've consistently brought up lack of proper user error messaging in all
> > previous submissions of this driver:
> > 
> ... and we've consistently explained why logging such things to dmesg by
> default will not fly. As before, while we call these return codes error
> values, they are *not* errors in the same sense as pr_err().

I've expressed my disagreement to that matter here:
 
https://lkml.org/lkml/2017/4/7/223
 
yet it got no response.

> > 6 apr 2017 (PATCH v2 series):
> > https://lkml.org/lkml/2017/4/6/790
> 
> Please consult my replies to this:
> 
> https://lkml.org/lkml/2017/4/6/796
> https://lkml.org/lkml/2017/4/7/246
> 
> ... we can add a pr_debug() for these cases, as that will be guarded by
> dynamic debug, and won't be pointlessly spamming the dmesg.
> 
> Anything beyond that simply will not fly.

See above; I responded to those replies, and didn't get a response.  Would you
care to respond to my latest reply in that thread before re-posting?

> > AFAICT, my comments hold, yet the driver still gets resubmitted without
> > them being addressed.  How do we get out of this loop?
> 
> We've repeatedly explained why the approach you suggest is not feasible.
> Perhaps you could try to explain why our approach doesn't seem feasible
> to you.

I don't want SPE users to have to manually instrument the driver
in order to find out what it didn't like about the parameters they
specified.  This problem has already been reported by other early
adopters.  perf itself says "dmesg may provide additional information",
so let's please use it.

Kim
