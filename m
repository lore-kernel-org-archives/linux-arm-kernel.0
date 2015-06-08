From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:43:34 +0100
Subject: [PATCH v5 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433747496-7642-2-git-send-email-wxt@rock-chips.com>
References: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
 <1433747496-7642-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20150608094334.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 03:11:34PM +0800, Caesar Wang wrote:
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 5b4ca3c..bd40852 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -72,6 +72,7 @@ static struct reset_control *rockchip_get_core_reset(int cpu)
>  static int pmu_set_power_domain(int pd, bool on)
>  {
>  	u32 val = (on) ? 0 : BIT(pd);
> +	struct reset_control *rstc = rockchip_get_core_reset(pd);
>  	int ret;
>  
>  	/*
> @@ -80,20 +81,15 @@ static int pmu_set_power_domain(int pd, bool on)
>  	 * processor is powered down.
>  	 */
>  	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
> -		struct reset_control *rstc = rockchip_get_core_reset(pd);
> -
> +		/* We only require the reset on the RK3288 at the moment */
>  		if (IS_ERR(rstc)) {
>  			pr_err("%s: could not get reset control for core %d\n",
>  			       __func__, pd);
>  			return PTR_ERR(rstc);
>  		}
>  
> -		if (on)
> -			reset_control_deassert(rstc);
> -		else
> +		if (!on)
>  			reset_control_assert(rstc);
> -
> -		reset_control_put(rstc);
>  	}

Do we need the CPU part number check for the assertion/deassertion of
the reset control?  Surely the DT provides this where appropriate and
omits it where it's inappropriate?

If so, I'd separate out the decision whether to error out from the
decision whether to assert the reset control, like this:

	if (IS_ERR(rstc) && read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
		pr_err("%s: could not get reset control for core %d\n",
		       __func__, pd);
		return PTR_ERR(rstc);
	}

	if (!IS_ERR(rstc) && !on)
		reset_control_assert(rstc);

or maybe:

	if (IS_ERR(rstc) && PTR_ERR(rstc) != -ENOENT) {
		pr_err("%s: could not get reset control for core %d: %d\n",
		       __func__, pd, PTR_ERR(rstc));
		return PTR_ERR(rstc);
	}

	if (!IS_ERR(rstc) && !on)
		reset_control_assert(rstc);

which lets you detect whether of_reset_control_get() failed because the
reset control was not present (and thus not required) vs failed for some
other reason - and this means that the issue of whether the reset
control is used is entirely up to the supplied DT file.

>  
>  	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
> @@ -112,6 +108,12 @@ static int pmu_set_power_domain(int pd, bool on)
>  		}
>  	}
>  
> +	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9 && on)
> +		reset_control_deassert(rstc);
> +
> +	if (!IS_ERR(rstc))
> +		reset_control_put(rstc);
> +

and here:
	if (!IS_ERR(rstc)) {
		if (on)
			reset_control_deassert(rstc);
		reset_control_put(rstc);
	}

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
