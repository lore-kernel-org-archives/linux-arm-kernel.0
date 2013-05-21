From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 May 2013 10:15:48 -0600
Subject: [PATCH] ARM: tegra: add cpu_disable for hotplug
In-Reply-To: <1369131215-2920-1-git-send-email-josephl@nvidia.com>
References: <1369131215-2920-1-git-send-email-josephl@nvidia.com>
Message-ID: <519B9DB4.7070106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 04:13 AM, Joseph Lo wrote:
> The Tegra114 could hotplug the CPU0, but the common cpu_disable didn't
> support that. Adding a Tegra specific cpu_disable function for it.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c

> +int tegra_cpu_disable(unsigned int cpu)
> +{
> +	switch (tegra_chip_id) {
> +	case TEGRA114:
> +		return 0;
> +	default:
> +		return cpu == 0 ? -EPERM : 0;
> +	}
> +}

Do we expect all/most future chips to support hotplug of CPU0? Or at
least, fewer chips to have the restriction than not? If so, it might be
more forward-looking to write that as:

if (tegra_chip_id == TEGRA30)
    return cpu == 0 ? -EPERM : 0;

return 0;

?
