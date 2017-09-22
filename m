From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Sep 2017 11:54:06 +0100
Subject: [PATCH] drivers/perf: arm_pmu_acpi: Release memory obtained by
 kasprintf
In-Reply-To: <f3b19a8ba9ca69fe84b0d980b6337a33a1da907d.1505884534.git.arvind.yadav.cs@gmail.com>
References: <f3b19a8ba9ca69fe84b0d980b6337a33a1da907d.1505884534.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170922105405.GD23365@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 12:26:38PM +0530, Arvind Yadav wrote:
> Free memory region, if arm_pmu_acpi_probe is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/perf/arm_pmu_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 0a9b787..3303dd8 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -235,6 +235,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
>  		ret = armpmu_register(pmu);
>  		if (ret) {
>  			pr_warn("Failed to register PMU for CPU%d\n", cpu);
> +			kfree(pmu->name);
>  			return ret;
>  		}
>  	}

It's a bit weird that we bail out of the loop on the first failing CPU, but
you've not changed that behaviour so your patch looks fine in isolation:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin: can you pick this up as a fix, please?

Will
