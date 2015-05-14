From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 May 2015 12:04:28 +0100
Subject: [PATCH] bus: arm-ccn: Handle correctly no-more-cpus case
In-Reply-To: <1431600624-10965-1-git-send-email-pawel.moll@arm.com>
References: <20150514101344.GA20531@mwanda>
 <1431600624-10965-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20150514110428.GA494@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 11:50:24AM +0100, Pawel Moll wrote:
> When migrating events the driver picks another cpu using
> cpumask_any_but() function, which returns value >= nr_cpu_ids
> when there is none available, not a negative value as the code
> assumed. Fixed now.

The fix looks good to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Does this need to be CC'd to stable? What does perf_pmu_migrate_context
do when passed a target >= nr_cpus?

The original bug seems to have been copied over from arm-cci.c, which
will need the same fix. That appears to be my fault -- I'd mostly been
following the x86 uncore PMU drivers, but they figure out the target CPU
in a different way for which -1 is a sane error case.

I'll spin a patch for arm-cci.c momentarily.

Thanks,
Mark.

> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> Another day, another arm-ccn.c update...
> 
> This time Dan's static checker spotted unsigned int target
> being expected to carry negative values. Fixed now.
> 
> Interestingly enough, cpumask_any_but() implementation (and its
> normal prototype) returns int, but version for NR_CPUS == 1 case,
> inlined in linux/cpumask.h returns unsigned int...
> 
>  drivers/bus/arm-ccn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> index 7d9879e..cc322fb 100644
> --- a/drivers/bus/arm-ccn.c
> +++ b/drivers/bus/arm-ccn.c
> @@ -1184,7 +1184,7 @@ static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
>  		if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
>  			break;
>  		target = cpumask_any_but(cpu_online_mask, cpu);
> -		if (target < 0)
> +		if (target >= nr_cpu_ids)
>  			break;
>  		perf_pmu_migrate_context(&dt->pmu, cpu, target);
>  		cpumask_set_cpu(target, &dt->cpu);
> -- 
> 2.1.0
> 
