From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Feb 2013 15:05:17 +0200
Subject: [PATCH 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
In-Reply-To: <1361515491-16199-2-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-2-git-send-email-josephl@nvidia.com>
Message-ID: <20130222130516.GW23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 07:44:48AM +0100, Joseph Lo wrote:
> The Tegra kernel only support boot from DT now. Clean up the PMC driver
> to support DT only, that includes:
> 
> * remove the ifdef of CONFIG_OF
> * replace the static mapping of PMC addr to map from DT
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm/mach-tegra/pmc.c | 56 +++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> index d4fdb5f..2315e25 100644
> --- a/arch/arm/mach-tegra/pmc.c
> +++ b/arch/arm/mach-tegra/pmc.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
> + * Copyright (C) 2012,2013 NVIDIA CORPORATION. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -16,59 +16,59 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -
> -#include "iomap.h"
> +#include <linux/of_address.h>
>  
>  #define PMC_CTRL		0x0
>  #define PMC_CTRL_INTR_LOW	(1 << 17)
>  
> +static void __iomem *tegra_pmc_base;
> +static bool tegra_pmc_invert_interrupt;
> +
>  static inline u32 tegra_pmc_readl(u32 reg)
>  {
> -	return readl(IO_ADDRESS(TEGRA_PMC_BASE + reg));
> +	return readl_relaxed(tegra_pmc_base + reg);
>  }
>  
>  static inline void tegra_pmc_writel(u32 val, u32 reg)
>  {
> -	writel(val, IO_ADDRESS(TEGRA_PMC_BASE + reg));
> +	writel_relaxed(val, (tegra_pmc_base + reg));
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id matches[] __initconst = {
>  	{ .compatible = "nvidia,tegra20-pmc" },
>  	{ }

At least an extra entry for tegra114-pmc is necessary here. tegra114.dtsi only
has:

pmc {
	compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
	reg = <0x7000e400 0x400>;
};

otherwise the system will crash early during boot.

Cheers,

Peter.
