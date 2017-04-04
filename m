From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Apr 2017 12:18:26 +0100
Subject: [PATCH] arm64: perf: Count EL2 events if either of kernel and
 hyp are not excluded
In-Reply-To: <1491302455-5939-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1491302455-5939-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170404111826.GD14898@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 04:10:55PM +0530, Ganapatrao Kulkarni wrote:
> commit d98ecda (arm64: perf: Count EL2 events if the kernel is running in HYP)
> is returning error for perf syscall with mixed attribute set for exclude_kernel
> and exlude_hv.
> 
> This change is breaking some applications (observed with hhvm) when
> ran with VHE enabled. Adding change to enable EL2 event counting,
> if either of or both of exclude_kernel and exlude_hv are not set.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  arch/arm64/kernel/perf_event.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Hmm. When we have VHE, we can't distinguish between hypervisor and kernel,
so this patch doesn't seem right to me. The code currently requires
both exclude_kernel and exclude_hv to be clear before we enable profiling
EL2, otherwise we're failing to exclude samples that were asked to be
excluded.

Will

> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index daf95919..ea5848a 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -871,15 +871,20 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  
>  	if (attr->exclude_idle)
>  		return -EPERM;
> -	if (is_kernel_in_hyp_mode() &&
> -	    attr->exclude_kernel != attr->exclude_hv)
> -		return -EINVAL;
> +	if (is_kernel_in_hyp_mode()) {
> +		/* include EL2 events, if either of not excluded */
> +		if ((attr->exclude_kernel != attr->exclude_hv) ||
> +				!attr->exclude_kernel ||
> +				!attr->exclude_hv)
> +			config_base |= ARMV8_PMU_INCLUDE_EL2;
> +	} else {
> +		if (attr->exclude_kernel)
> +			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> +		if (!attr->exclude_hv)
> +			config_base |= ARMV8_PMU_INCLUDE_EL2;
> +	}
>  	if (attr->exclude_user)
>  		config_base |= ARMV8_PMU_EXCLUDE_EL0;
> -	if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
> -		config_base |= ARMV8_PMU_EXCLUDE_EL1;
> -	if (!attr->exclude_hv)
> -		config_base |= ARMV8_PMU_INCLUDE_EL2;
>  
>  	/*
>  	 * Install the filter into config_base as this is used to
> -- 
> 1.8.1.4
> 
