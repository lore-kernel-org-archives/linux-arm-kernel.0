From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Dec 2017 08:26:39 -0800
Subject: [PATCH v2 18/18] perf: arm_spe: Disallow userspace profiling
 when arm_kernel_unmapped_at_el0()
In-Reply-To: <1512059986-21325-19-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-19-git-send-email-will.deacon@arm.com>
Message-ID: <20171201162639.GD19419@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Will Deacon wrote:
> When running with the kernel unmapped whilst at EL0, the virtually-addressed
> SPE buffer is also unmapped, which can lead to buffer faults if userspace
> profiling is enabled.
> 
> This patch prohibits SPE profiling of userspace when
> arm_kernel_unmapped_at_el0().
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 8ce262fc2561..c028db8973a4 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -675,6 +675,13 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	/*
> +	 * If kernelspace is unmapped when running at EL0, then the SPE
> +	 * buffer will fault and prematurely terminate the AUX session.
> +	 */
> +	if (arm64_kernel_unmapped_at_el0() && !attr->exclude_user)
> +		dev_warn_once(&spe_pmu->pdev->dev, "unable to write to profiling buffer from EL0. Try passing \"kaiser=off\" on the kernel command line");

Missing newline on that print?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
