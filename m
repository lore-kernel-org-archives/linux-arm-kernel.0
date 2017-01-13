From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 17:03:07 +0000
Subject: [RFC PATCH v2 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170113104042.169ceea12820d2b6b74b31f9@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-10-git-send-email-will.deacon@arm.com>
 <20170113104042.169ceea12820d2b6b74b31f9@arm.com>
Message-ID: <20170113170307.GK3253@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 10:40:42AM -0600, Kim Phillips wrote:
> On Fri, 13 Jan 2017 16:03:48 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > +#define DRVNAME				"arm_spe_pmu"
> 
> PMU is implied.  "arm_spe"?

As stated before, I'm going for consistency here. Is it causing any
real issues on the tooling side?

> > +	if (is_kernel_in_hyp_mode()) {
> > +		if (attr->exclude_kernel != attr->exclude_hv)
> > +			return -EOPNOTSUPP;
> > +	} else if (!attr->exclude_hv) {
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	reg = arm_spe_event_to_pmsfcr(event);
> > +	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> > +		return -EOPNOTSUPP;
> > +
> > +	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> > +		return -EOPNOTSUPP;
> > +
> > +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> 
> Please insert pr_* statements before blindly returning errors before a
> better facility becomes available.

That was discussed in the thread I linked to last time:

https://lkml.org/lkml/2015/8/26/661

and there are good reasons not to add those prints.

Will
