From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 May 2015 12:26:09 +0100
Subject: [PATCH] bus: arm-ccn: Handle correctly no-more-cpus case
In-Reply-To: <20150514110428.GA494@leverpostej>
References: <20150514101344.GA20531@mwanda>
 <1431600624-10965-1-git-send-email-pawel.moll@arm.com>
 <20150514110428.GA494@leverpostej>
Message-ID: <20150514112608.GC494@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 12:04:28PM +0100, Mark Rutland wrote:
> On Thu, May 14, 2015 at 11:50:24AM +0100, Pawel Moll wrote:
> > When migrating events the driver picks another cpu using
> > cpumask_any_but() function, which returns value >= nr_cpu_ids
> > when there is none available, not a negative value as the code
> > assumed. Fixed now.
> 
> The fix looks good to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Does this need to be CC'd to stable? What does perf_pmu_migrate_context
> do when passed a target >= nr_cpus?

Never mind, it looks like we can never encounter that case anyway. In
the case of kexec or reset we won't notify CPU_DOWN_PREPARE on the final
CPU, and we can't hotplug the final CPU.

Which means that the target check is irrelevant as we should always get
a valid cpu back from cpumask_any_but in the cases we'll call it. So we
could just delete it entirely, assuming I haven't missed a
CPU_DOWN_PREPARE notification path...

Mark.

> > diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> > index 7d9879e..cc322fb 100644
> > --- a/drivers/bus/arm-ccn.c
> > +++ b/drivers/bus/arm-ccn.c
> > @@ -1184,7 +1184,7 @@ static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
> >  		if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
> >  			break;
> >  		target = cpumask_any_but(cpu_online_mask, cpu);
> > -		if (target < 0)
> > +		if (target >= nr_cpu_ids)
> >  			break;
> >  		perf_pmu_migrate_context(&dt->pmu, cpu, target);
> >  		cpumask_set_cpu(target, &dt->cpu);
> > -- 
> > 2.1.0
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
