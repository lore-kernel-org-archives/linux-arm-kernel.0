From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 26 Jan 2012 12:25:53 -0800
Subject: [PATCH v1 3/8] ARM: tegra: rework Tegra secondary CPU core bringup
In-Reply-To: <1327597641-7519-4-git-send-email-pdeschrijver@nvidia.com>
References: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
 <1327597641-7519-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB8246B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, January 26, 2012 10:07 AM:
> Prepare the Tegra secondary CPU core bringup code for other Tegra variants.
> The reset handler is also generalized to allow for future introduction of
> powersaving modes which turn off the CPU cores.

> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S

>  ENTRY(tegra_secondary_startup)
...
> +	enable_coresight r0

> +ENTRY(__tegra_cpu_reset_handler)
> +
> +#if DEBUG_CPU_RESET_HANDLER
> +	enable_coresight r0
> +	b	.
> +#endif

I'm not sure why the macro call enable_coresight is ifdef'd in one place
but not the other... Should just the instruction "b ." be inside the
ifdef?

> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c

> +static void tegra_cpu_reset_handler_enable(void)

> +	/*
> +	 * Prevent further modifications to the physical reset vector.
> +	 *  NOTE: Has no effect on chips prior to Tegra30.
> +	 */
> +	reg = readl(sb_ctrl);
> +	reg |= 2;
> +	writel(reg, sb_ctrl);
> +	wmb();

Should we skip that on Tegra20 then?

> +void __init tegra_cpu_reset_handler_init(void)
> +{
> +	unsigned long *cpu_reset_data_start, *cpu_reset_data_end;

Those variables are unused.

-- 
nvpublic
