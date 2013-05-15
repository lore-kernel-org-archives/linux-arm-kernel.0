From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 May 2013 16:57:45 -0600
Subject: [PATCH 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <1368613644-11863-4-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-4-git-send-email-josephl@nvidia.com>
Message-ID: <519412E9.2080905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 04:27 AM, Joseph Lo wrote:
> Tegra114 is an ARM Cortex-A15 based SoC and some of the flow controller

I don't think the CPU type is the issue here. The issue is simply that
Tegra114's flow controller is different. Mentioning the CPU type seems
misleading.

> hardware behavior and configurations are different with other Tegra series.
> We fix the common resume function of tegra_resume to make it can work on
> Tegra114 by checking SoC ID. And also checking CPU primary part number to
> isolate the support code for Cortex A9 and A15.

> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S

> -#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +#ifndef CONFIG_ARCH_TEGRA_2x_SOC
>  	/* Are we on Tegra20? */
>  	tegra_check_soc_id TEGRA20, TEGRA_APB_MISC_BASE, r6, r7
>  	beq	1f				@ Yes
>  	/* Clear the flow controller flags for this CPU. */
> -	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
> -	ldr	r1, [r2]
> +	cpu_to_csr_req r1, r0

Where is cpu_to_csr_req defined? grep can't find it in next-20130513,
and I don't see it added in this series.

This presumably changes behaviour on Tegra30; will this cause problems?

> +	mov32	r2, TEGRA_FLOW_CTRL_BASE
> +	ldr	r1, [r2, r1]
>  	/* Clear event & intr flag */
>  	orr	r1, r1, \
>  		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
> -	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
> +	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, & bitmaps

What does this change do; does the commend need updating to describe the
new bits that are set?
