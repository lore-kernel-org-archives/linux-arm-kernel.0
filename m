From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 18:29:38 +0100
Subject: [PATCH 2/3] drivers/perf: arm_pmu: Defer the setting of
 __oprofile_cpu_pmu
In-Reply-To: <20160531162834.GR24936@arm.com>
References: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
 <1464694883-26298-3-git-send-email-julien.grall@arm.com>
 <20160531162834.GR24936@arm.com>
Message-ID: <20160531172937.GG4254@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 05:28:34PM +0100, Will Deacon wrote:
> On Tue, May 31, 2016 at 12:41:22PM +0100, Julien Grall wrote:
> > The global variable __oprofile_cpu_pmu is set before the PMU is fully
> > initialized. If an error occurs before the end of the initialization,
> > the PMU will be freed and the variable will contain an invalid pointer.
> > 
> > This will result in a kernel crash when perf will be used.
> > 
> > Fix it by moving the setting of __oprofile_cpu_pmu when the PMU is fully
> > initialized (i.e when it is no longer possible to fail).
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  drivers/perf/arm_pmu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Should this one go to -stable too?

I think so.

The bug has been there at least since 76b8a0e4c8bda5f0 ("ARM: perf:
handle armpmu_register failing"), in v3.8...

Prior to that we wouldn't free the PMU, but it might not have been
initialised correctly.

Thanks,
Mark.
 
> Will
> 
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 6401f0c..95614d2 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -992,9 +992,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
> >  
> >  	armpmu_init(pmu);
> >  
> > -	if (!__oprofile_cpu_pmu)
> > -		__oprofile_cpu_pmu = pmu;
> > -
> >  	pmu->plat_device = pdev;
> >  
> >  	if (node && (of_id = of_match_node(of_table, pdev->dev.of_node))) {
> > @@ -1030,6 +1027,9 @@ int arm_pmu_device_probe(struct platform_device *pdev,
> >  	if (ret)
> >  		goto out_destroy;
> >  
> > +	if (!__oprofile_cpu_pmu)
> > +		__oprofile_cpu_pmu = pmu;
> > +
> >  	pr_info("enabled with %s PMU driver, %d counters available\n",
> >  			pmu->name, pmu->num_events);
> >  
> > -- 
> > 1.9.1
> > 
> 
