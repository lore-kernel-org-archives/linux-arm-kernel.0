From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 17:37:07 +0000
Subject: [PATCH 3/5] arm_pmu: acpi: check for mismatched PPIs
In-Reply-To: <20171101141239.45340-4-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-4-mark.rutland@arm.com>
Message-ID: <20171211173707.GD3275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:12:37PM +0000, Mark Rutland wrote:
> The arm_pmu platform code explicitly checks for mismatched PPIs at probe
> time, while the ACPI code leaves this to the core code. Future
> refactoring will make this difficult for the core code to check, so
> let's have the ACPI code check this explicitly.
> 
> As before, upon a failure we'll continue on without an interrupt. Ho
> hum.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c      | 16 ++++------------
>  drivers/perf/arm_pmu_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 3d6d4c5f2356..e0242103d904 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -557,18 +557,10 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>  	if (!irq)
>  		return 0;
>  
> -	if (irq_is_percpu_devid(irq) && cpumask_empty(&armpmu->active_irqs)) {
> -		err = request_percpu_irq(irq, handler, "arm-pmu",
> -					 &hw_events->percpu_pmu);
> -	} else if (irq_is_percpu_devid(irq)) {
> -		int other_cpu = cpumask_first(&armpmu->active_irqs);
> -		int other_irq = per_cpu(hw_events->irq, other_cpu);
> -
> -		if (irq != other_irq) {
> -			pr_warn("mismatched PPIs detected.\n");
> -			err = -EINVAL;
> -			goto err_out;
> -		}
> +	if (irq_is_percpu_devid(irq)) {
> +		if (cpumask_empty(&armpmu->active_irqs))

Why not leave this as before, with a '&&' operator?

Will
