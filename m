From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 15:45:48 +0100
Subject: [PATCH 2/3] drivers/perf: arm_pmu: add arm_pmu_device_remove
In-Reply-To: <20161221133854.GU3124@twins.programming.kicks-ass.net>
References: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
 <20161221101935.17178-3-alexander.stein@systec-electronic.com>
 <20161221133854.GU3124@twins.programming.kicks-ass.net>
Message-ID: <1724522.5tsCXqVGvj@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 December 2016 14:38:54, Peter Zijlstra wrote:
> On Wed, Dec 21, 2016 at 11:19:34AM +0100, Alexander Stein wrote:
> > Add ARM PMU removal function. This will be required by perf event drivers
> > when option DEBUG_TEST_DRIVER_REMOVE is enabled.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> > 
> >  drivers/perf/arm_pmu.c       | 14 ++++++++++++++
> >  include/linux/perf/arm_pmu.h |  2 ++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index a9bbdbf..b7ddc4c 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -1022,6 +1022,7 @@ int arm_pmu_device_probe(struct platform_device
> > *pdev,> 
> >  	armpmu_init(pmu);
> >  	
> >  	pmu->plat_device = pdev;
> > 
> > +	platform_set_drvdata(pdev, pmu);
> > 
> >  	if (node && (of_id = of_match_node(of_table, pdev->dev.of_node))) {
> >  	
> >  		init_fn = of_id->data;
> > 
> > @@ -1073,6 +1074,19 @@ int arm_pmu_device_probe(struct platform_device
> > *pdev,> 
> >  	return ret;
> >  
> >  }
> > 
> > +int arm_pmu_device_remove(struct platform_device *pdev)
> > +{
> > +	struct arm_pmu *pmu = platform_get_drvdata(pdev);
> > +
> > +	__oprofile_cpu_pmu = NULL;
> > +
> > +	perf_pmu_unregister(&pmu->pmu);
> > +
> > +	cpu_pmu_destroy(pmu);
> > +
> > +	return 0;
> > +}
> 
> So normally, if there are events that use this pmu, we hold a reference
> on its module, which avoids removal from happening.
> 
> How is that guarantee made by DEBUG_TEST_DRIVER_REMOVE ? Or will it
> simply kill everything even though there's active events for the PMU?

AFAICS you won't be able to hold any reference until this test remove is done. 
This feature is implemented in really_probe(). If the driver is successfully 
probed it will be removed and probed again.
But reading that part of the code I stumbled over suppress_bind_attrs which 
would prevent this procedure. After some grepping I found commit 80c6397c3 
("clk: oxnas: make it explicitly non-modular").
Essentially setting
> .suppress_bind_attrs = true
in the platform_driver.
IMHO this seems far better than to add some remove functions only for testing 
a non-removable driver. I'll come up with a 2nd series, patch 1/3 is still 
valid.

Best regards,
Alexander
