From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 17:26:25 +0100
Subject: [PATCH] drivers/perf: arm_pmu: Request PMU SPIs with IRQF_PER_CPU
In-Reply-To: <1500996975-28857-1-git-send-email-will.deacon@arm.com>
References: <1500996975-28857-1-git-send-email-will.deacon@arm.com>
Message-ID: <20170725162624.GE12749@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 04:36:15PM +0100, Will Deacon wrote:
> Since the PMU register interface is banked per CPU, CPU PMU interrrupts
> cannot be handled by a CPU other than the one with the PMU asserting the
> interrupt. This means that migrating PMU SPIs, as we do during a CPU
> hotplug operation doesn't make any sense and can lead to the IRQ being
> disabled entirely if we route a spurious IRQ to the new affinity target.
> 
> This has been observed in practice on AMD Seattle, where CPUs on the
> non-boot cluster appear to take a spurious PMU IRQ when coming online,
> which is routed to CPU0 where it cannot be handled.
> 
> This patch passes IRQF_PERCPU for PMU SPIs and forcefullt sets their

forcefully

> affinity prior to requesting them, ensuring that they cannot
> be migrated during hotplug events.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Fixes: 3cf7ee98b848 ("drivers/perf: arm_pmu: move irq request/free into probe")
> Signed-off-by: Will Deacon <will.deacon@arm.com>

The patch itself looks good to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_pmu.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index dc459eb1246b..fa18e4858141 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -569,22 +569,32 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>  		if (irq != other_irq) {
>  			pr_warn("mismatched PPIs detected.\n");
>  			err = -EINVAL;
> +			goto err_out;
>  		}
>  	} else {
> +		err = irq_force_affinity(irq, cpumask_of(cpu));
> +
> +		if (err && num_possible_cpus() > 1) {
> +			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
> +				irq, cpu);
> +			goto err_out;
> +		}
> +
>  		err = request_irq(irq, handler,
> -				  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
> +				  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				  "arm-pmu",
>  				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
>  	}
>  
> -	if (err) {
> -		pr_err("unable to request IRQ%d for ARM PMU counters\n",
> -			irq);
> -		return err;
> -	}
> +	if (err)
> +		goto err_out;
>  
>  	cpumask_set_cpu(cpu, &armpmu->active_irqs);
> -
>  	return 0;
> +
> +err_out:
> +	pr_err("unable to request IRQ%d for ARM PMU counters\n", irq);
> +	return err;
>  }
>  
>  int armpmu_request_irqs(struct arm_pmu *armpmu)
> @@ -628,12 +638,6 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  			enable_percpu_irq(irq, IRQ_TYPE_NONE);
>  			return 0;
>  		}
> -
> -		if (irq_force_affinity(irq, cpumask_of(cpu)) &&
> -		    num_possible_cpus() > 1) {
> -			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
> -				irq, cpu);
> -		}
>  	}
>  
>  	return 0;
> -- 
> 2.1.4
> 
