From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 23 Nov 2018 14:31:13 +0000
Subject: [PATCH 09/10] drivers/perf: perf/core: generalise event
 exclusion checking with perf macro
In-Reply-To: <20181119160352.ua2lx72l754imiek@lakrids.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-10-git-send-email-andrew.murray@arm.com>
 <20181119160352.ua2lx72l754imiek@lakrids.cambridge.arm.com>
Message-ID: <20181123143113.GA1617@e119886-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 04:03:52PM +0000, Mark Rutland wrote:
> On Fri, Nov 16, 2018 at 10:24:12AM +0000, Andrew Murray wrote:
> > Replace checking of perf event exclusion flags with perf macro.
> > 
> > This is a functional change as exclude_host and exclude_guest are added
> > in the following files:
> > 
> >  - drivers/perf/qcom_l2_pmu.c
> >  - drivers/perf/qcom_l3_pmu.c
> >  - drivers/perf/arm_pmu.c
> > 
> > And exclude_idle and exclude_hv are added in these files:
> > 
> >  - drivers/perf/xgene_pmu.c
> 
> FWIW, that all sounds fine to me.
> 
> Assuming you fix up the 'macro' nit:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> ... unless we go for Peter's core cap for this.

Yeah I'm going to re-spin with the core cap approach - but thanks anyway.

Thanks,

Andrew Murray

> 
> Thanks,
> Mark.
> 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  drivers/perf/arm-cci.c                   | 7 +------
> >  drivers/perf/arm-ccn.c                   | 5 +----
> >  drivers/perf/arm_dsu_pmu.c               | 7 +------
> >  drivers/perf/arm_pmu.c                   | 9 +--------
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 7 +------
> >  drivers/perf/qcom_l2_pmu.c               | 3 +--
> >  drivers/perf/qcom_l3_pmu.c               | 3 +--
> >  drivers/perf/xgene_pmu.c                 | 3 +--
> >  8 files changed, 8 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > index 1bfeb16..d749f19 100644
> > --- a/drivers/perf/arm-cci.c
> > +++ b/drivers/perf/arm-cci.c
> > @@ -1328,12 +1328,7 @@ static int cci_pmu_event_init(struct perf_event *event)
> >  		return -EOPNOTSUPP;
> >  
> >  	/* We have no filtering of any kind */
> > -	if (event->attr.exclude_user	||
> > -	    event->attr.exclude_kernel	||
> > -	    event->attr.exclude_hv	||
> > -	    event->attr.exclude_idle	||
> > -	    event->attr.exclude_host	||
> > -	    event->attr.exclude_guest)
> > +	if (event_has_exclude_flags(event))
> >  		return -EINVAL;
> >  
> >  	/*
> > diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> > index 7dd850e..9a22a95 100644
> > --- a/drivers/perf/arm-ccn.c
> > +++ b/drivers/perf/arm-ccn.c
> > @@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > -	if (has_branch_stack(event) || event->attr.exclude_user ||
> > -			event->attr.exclude_kernel || event->attr.exclude_hv ||
> > -			event->attr.exclude_idle || event->attr.exclude_host ||
> > -			event->attr.exclude_guest) {
> > +	if (has_branch_stack(event) || event_has_exclude_flags(event)) {
> >  		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> > index 660cb8a..300ff3d 100644
> > --- a/drivers/perf/arm_dsu_pmu.c
> > +++ b/drivers/perf/arm_dsu_pmu.c
> > @@ -563,12 +563,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
> >  	}
> >  
> >  	if (has_branch_stack(event) ||
> > -	    event->attr.exclude_user ||
> > -	    event->attr.exclude_kernel ||
> > -	    event->attr.exclude_hv ||
> > -	    event->attr.exclude_idle ||
> > -	    event->attr.exclude_host ||
> > -	    event->attr.exclude_guest) {
> > +	    event_has_exclude_flags(event)) {
> >  		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 7f01f6f..a03634f 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -357,13 +357,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
> >  }
> >  
> >  static int
> > -event_requires_mode_exclusion(struct perf_event_attr *attr)
> > -{
> > -	return attr->exclude_idle || attr->exclude_user ||
> > -	       attr->exclude_kernel || attr->exclude_hv;
> > -}
> > -
> > -static int
> >  __hw_perf_event_init(struct perf_event *event)
> >  {
> >  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > @@ -395,7 +388,7 @@ __hw_perf_event_init(struct perf_event *event)
> >  	 */
> >  	if ((!armpmu->set_event_filter ||
> >  	     armpmu->set_event_filter(hwc, &event->attr)) &&
> > -	     event_requires_mode_exclusion(&event->attr)) {
> > +	     event_has_exclude_flags(event)) {
> >  		pr_debug("ARM performance counters do not support "
> >  			 "mode exclusion\n");
> >  		return -EOPNOTSUPP;
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > index 9efd241..d3edff9 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > @@ -143,12 +143,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
> >  		return -EOPNOTSUPP;
> >  
> >  	/* counters do not have these bits */
> > -	if (event->attr.exclude_user	||
> > -	    event->attr.exclude_kernel	||
> > -	    event->attr.exclude_host	||
> > -	    event->attr.exclude_guest	||
> > -	    event->attr.exclude_hv	||
> > -	    event->attr.exclude_idle)
> > +	if (event_has_exclude_flags(event))
> >  		return -EINVAL;
> >  
> >  	/*
> > diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> > index 842135c..d7d85a2 100644
> > --- a/drivers/perf/qcom_l2_pmu.c
> > +++ b/drivers/perf/qcom_l2_pmu.c
> > @@ -510,8 +510,7 @@ static int l2_cache_event_init(struct perf_event *event)
> >  	}
> >  
> >  	/* We cannot filter accurately so we just don't allow it. */
> > -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> > -	    event->attr.exclude_hv || event->attr.exclude_idle) {
> > +	if (event_has_exclude_flags(event)) {
> >  		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
> >  				    "Can't exclude execution levels\n");
> >  		return -EOPNOTSUPP;
> > diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> > index 2dc63d6..f27af67 100644
> > --- a/drivers/perf/qcom_l3_pmu.c
> > +++ b/drivers/perf/qcom_l3_pmu.c
> > @@ -497,8 +497,7 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
> >  	/*
> >  	 * There are no per-counter mode filters in the PMU.
> >  	 */
> > -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> > -	    event->attr.exclude_hv || event->attr.exclude_idle)
> > +	if (event_has_exclude_flags(event))
> >  		return -EINVAL;
> >  
> >  	/*
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index 0e31f13..1fcd5a0 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -915,8 +915,7 @@ static int xgene_perf_event_init(struct perf_event *event)
> >  		return -EINVAL;
> >  
> >  	/* SOC counters do not have usr/os/guest/host bits */
> > -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> > -	    event->attr.exclude_host || event->attr.exclude_guest)
> > +	if (event_has_exclude_flags(event))
> >  		return -EINVAL;
> >  
> >  	if (event->cpu < 0)
> > -- 
> > 2.7.4
> > 
