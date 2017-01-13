From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 13 Jan 2017 12:17:43 -0600
Subject: [RFC PATCH v2 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170113170307.GK3253@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-10-git-send-email-will.deacon@arm.com>
 <20170113104042.169ceea12820d2b6b74b31f9@arm.com>
 <20170113170307.GK3253@arm.com>
Message-ID: <20170113121743.31e09c7242d500d41469a068@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2017 17:03:07 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Fri, Jan 13, 2017 at 10:40:42AM -0600, Kim Phillips wrote:
> > On Fri, 13 Jan 2017 16:03:48 +0000
> > Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > +#define DRVNAME				"arm_spe_pmu"
> > 
> > PMU is implied.  "arm_spe"?
> 
> As stated before, I'm going for consistency here.

me too, but apparently under the user-visible interface domain rather
than the driver source path domain.

> Is it causing any
> real issues on the tooling side?

Intel has a consistent "intel_pt", "intel_bts", and 'pmu' occurs
nowhere in their nomenclature.

Whether good or bad, we currently have "cs_etm".  This patch now gives
us "arm_spe_pmu".  I'm just trying to save the suffix consistency for
now, esp. since IDK how amenable "cs_etm" is to change, and 'perf list'
calls things "PMU event"s anyway.

I think the root cause might be the device tree node's
"arm,arm-spe-pmu-v1" compatiblity string, which I also find
a bit self-redundant ("arm,arm-"), but I'm not familiar with what's
being denoted there either (e.g., if the latter 'arm-' is an arch
reference, then SPE's might be 'armv8'?).  The device tree node isn't
exposed to the user, however.

> > > +	if (is_kernel_in_hyp_mode()) {
> > > +		if (attr->exclude_kernel != attr->exclude_hv)
> > > +			return -EOPNOTSUPP;
> > > +	} else if (!attr->exclude_hv) {
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	reg = arm_spe_event_to_pmsfcr(event);
> > > +	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
> > > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
> > > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> > > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return 0;
> > > +}
> > 
> > Please insert pr_* statements before blindly returning errors before a
> > better facility becomes available.
> 
> That was discussed in the thread I linked to last time:
> 
> https://lkml.org/lkml/2015/8/26/661

ok, thanks for pinpointing the exact message this time.

> and there are good reasons not to add those prints.

Processing that message (indentations are now quoting Peter Zijlstra):

> Not really. That is something that's limited to root. Whereas the
> problem is very much wider than that.

For the purposes of the SPE driver discussion, I'm ok limiting the
context of using the SPE as root.

> If you set one bit wrong in the pretty large perf_event_attr you've got
> a fair chance of getting -EINVAL on trying to create the event. Good
> luck finding what you did wrong.

yes, this is the problem, and the SPE introduces a whole new set of
validity requirements that should be being communicated clearly, e.g.,
its restrictive event frequency specification.

> Any user can create events (for their own tasks), this does not require
> root.

I don't think this is relevant to our discussion.

> Allowing users to flip your @debugging flag would be an insta DoS.

I think this is a reference to the non-root case, and might be mitigated
by either using dynamic or ratelimited pr_ versions if it were.

> Furthermore, its very unfriendly in that you have to (manually) go
> correlate random dmesg output with some program action.

Andrew Morton addresses this, and I did read all other follow-ups and
still conclude that adding pr_ messages is 1000x better than not, for
the user, and at least for the time being.

Kim
