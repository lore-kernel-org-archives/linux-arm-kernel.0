From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 11:52:57 -0600
Subject: [PATCH 2/3] ARM: tegra: refactor the pmc_pm_set function
In-Reply-To: <1363163246-26368-2-git-send-email-josephl@nvidia.com>
References: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
 <1363163246-26368-2-git-send-email-josephl@nvidia.com>
Message-ID: <5140BCF9.2070900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 02:27 AM, Joseph Lo wrote:
> The pmc_pm_set function was designed for SoC to configure the related
> settings when system going to some low power modes (e.g. platform
> suspend or CPU idle powered-down mode). We refactor the function to make
> it work on the usage.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

> +#include <linux/clk-provider.h>

This code isn't a clock-provider, and hence shouldn't include that
header file.

> +void tegra_pmc_pm_set(enum tegra_suspend_mode mode)

> +	switch (mode) {
> +	case TEGRA_SUSPEND_LP2:
> +		rate = __clk_get_rate(tegra_pclk);

Doesn't regular clk_get_rate() work here?

> @@ -234,6 +229,9 @@ void tegra_pmc_suspend_init(void)
>  {
>  	u32 reg;
>  
> +	tegra_pclk = clk_get_sys(NULL, "pclk");
> +	WARN_ON(IS_ERR(tegra_pclk));

Shouldn't this instead error out and/or disable any system suspend
modes? Otherwise, tegra_pmc_pm_set() is going to call
clk_get_rate(tegra_pclk), and tegra_pclk won't be a valid clock object.

Also, can you use regular clk_get() rather than clk_get_sys()? That'd
need a clocks property in the PMC DT node.

I guess I see now that this series does actually depend on the suspend
series. However, stuff like:

> -u32 tegra_pmc_get_cpu_good_time(void)
> -{
> -	return pmc_pm_data.cpu_good_time;
> -}
> -
> -u32 tegra_pmc_get_cpu_off_time(void)
> -{
> -	return pmc_pm_data.cpu_off_time;
> -}

... was actually added in that series, so if you put this series first,
or merged the two series with these patches first, you could end up
avoiding some churn.
