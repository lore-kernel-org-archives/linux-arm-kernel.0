From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2016 14:22:46 +0100
Subject: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160615132246.GL24029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 05:23:32PM -0500, Jeremy Linton wrote:
> Its possible that an ACPI system has multiple CPU types in it
> with differing PMU counters. Use the newly provided acpi_pmu routines
> to detect that case, and instantiate more than one set of counters.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c      |  7 +++-
>  drivers/perf/arm_pmu_acpi.c | 98 ++++++++++++++++++++-------------------------
>  2 files changed, 50 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 865a9db..97007ec 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -1049,7 +1049,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  		if (!ret)
>  			ret = init_fn(pmu);
>  	} else {
> -		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
> +		if (acpi_disabled) {
> +			/* use the current cpu. */
> +			ret = probe_plat_pmu(pmu, probe_table,
> +					     read_cpuid_id());
> +		} else
> +			ret = probe_plat_pmu(pmu, probe_table, pdev->id);
>  	}
>  
>  	if (ret) {
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index a257fc0..8f9bea3 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -35,6 +35,11 @@ struct pmu_types {

[...]

> +	pmus = kcalloc(num_possible_cpus(), sizeof(struct pmu_types),
> +		       GFP_KERNEL);
> +
> +	if (pmus) {
> +		arm_pmu_acpi_determine_cpu_types(pmus);
> +
> +		for (j = 0; pmus[j].cpu_count; j++) {
> +			pr_devel("CPU type %X, count %d\n", pmus[j].cpu_type,
> +				 pmus[j].cpu_count);
> +			res = kcalloc(pmus[j].cpu_count,
> +				      sizeof(struct resource), GFP_KERNEL);

Given that you already have dynamic allocation in here, why not use a
linked-list for the pmus list, and avoid having a potentially huge temporary
data structure?

Will
