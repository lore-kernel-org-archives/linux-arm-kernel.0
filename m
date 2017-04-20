From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Apr 2017 09:49:29 +0100
Subject: [PATCH v2] arm64: perf: Use only exclude_kernel attribute when
 kernel is running in HYP
In-Reply-To: <1492623846-29335-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1492623846-29335-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170420084928.GC31436@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:14:06PM +0530, Ganapatrao Kulkarni wrote:
> commit d98ecda (arm64: perf: Count EL2 events if the kernel is running in HYP)
> is returning error for perf syscall with mixed attribute set for exclude_kernel
> and exclude_hv. This change is breaking some applications (observed with hhvm)
> when ran on VHE enabled platforms.
> 
> Adding fix to consider only exclude_kernel attribute when kernel is
> running in HYP. Also adding sysfs file to notify the bhehaviour
> of attribute exclude_hv.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
> 
> Changelog:
> 
> V2:
>  - Changes as per Will Deacon's suggestion.
> 
> V1: Initial patch
> 
>  arch/arm64/kernel/perf_event.c | 28 ++++++++++++++++++++++++----
>  include/linux/perf/arm_pmu.h   |  1 +
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> @@ -871,14 +890,13 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  
>  	if (attr->exclude_idle)
>  		return -EPERM;
> -	if (is_kernel_in_hyp_mode() &&
> -	    attr->exclude_kernel != attr->exclude_hv)
> -		return -EINVAL;
> +	if (is_kernel_in_hyp_mode() && !attr->exclude_kernel)
> +		config_base |= ARMV8_PMU_INCLUDE_EL2;
>  	if (attr->exclude_user)
>  		config_base |= ARMV8_PMU_EXCLUDE_EL0;
>  	if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
>  		config_base |= ARMV8_PMU_EXCLUDE_EL1;
> -	if (!attr->exclude_hv)
> +	if (!is_kernel_in_hyp_mode() && !attr->exclude_hv)
>  		config_base |= ARMV8_PMU_INCLUDE_EL2;

This isn't quite what Will suggested.

The idea was that userspace would read sysfs, then use that to determine
the correct exclusion parameters [1,2]. This logic was not expected to
change; it correctly validates whether we can provide what the user
requests.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499224.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499493.html

>  
>  	/*
> @@ -1008,6 +1026,8 @@ static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
>  		&armv8_pmuv3_events_attr_group;
>  	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
>  		&armv8_pmuv3_format_attr_group;
> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_ATTR] =
> +		&armv8_pmuv3_attr_group;
>  	return armv8pmu_probe_pmu(cpu_pmu);
>  }
>  
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 8462da2..a26ffc7 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -81,6 +81,7 @@ enum armpmu_attr_groups {
>  	ARMPMU_ATTR_GROUP_COMMON,
>  	ARMPMU_ATTR_GROUP_EVENTS,
>  	ARMPMU_ATTR_GROUP_FORMATS,
> +	ARMPMU_ATTR_GROUP_ATTR,
>  	ARMPMU_NR_ATTR_GROUPS
>  };
>  
> -- 
> 1.8.1.4
> 
