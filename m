From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Oct 2014 14:25:02 -0700
Subject: [PATCH 2/8] arm: perf: make PMU probing data-driven
In-Reply-To: <1413897084-19715-3-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-3-git-send-email-mark.rutland@arm.com>
Message-ID: <5446CF2E.4070301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 06:11 AM, Mark Rutland wrote:
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index 4bf4cce..79c1cf4 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -241,48 +241,34 @@ static struct platform_device_id cpu_pmu_plat_device_ids[] = {
>  	{},
>  };
>  
> +static struct pmu_probe_info pmu_probe_table[] = {

const?

> +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
> +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
> +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
> +	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
> +	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
> +	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
> +	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V1, xscale1pmu_init),
> +	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V2, xscale2pmu_init),
> +	{ /* sentinel value */ }
> +};
> +
>  /*
>   * CPU PMU identification and probing.
>   */
>  static int probe_current_pmu(struct arm_pmu *pmu)
>  {
>  	int cpu = get_cpu();
> +	unsigned int cpuid = read_cpuid_id();
>  	int ret = -ENODEV;
> +	struct pmu_probe_info *info;
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	pr_info("probing PMU on CPU %d", cpu);

Why drop the newline? Looks like all the other prints in this file are
missing the newline.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
