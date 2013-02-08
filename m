From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 09:47:20 +0200
Subject: [PATCH 1/4] ARM: tegra: Unify tegra{20,30,114}_init_early()
In-Reply-To: <1360308574-19658-2-git-send-email-hdoyu@nvidia.com>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
 <1360308574-19658-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130208074720.GB21879@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 08, 2013 at 09:29:31AM +0200, Hiroshi Doyu wrote:
> @@ -56,18 +56,21 @@ int tegra_cpu_disable(unsigned int cpu)
>  	return cpu == 0 ? -EPERM : 0;
>  }
>  
> -#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> -extern void tegra20_hotplug_shutdown(void);
> -void __init tegra20_hotplug_init(void)
> +void __init tegra_hotplug_init(void)
>  {
> -	tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
> -}
> +	switch (tegra_chip_id) {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +	case TEGRA20:
> +		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
> +		break;
>  #endif
> -
> -#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> -extern void tegra30_hotplug_shutdown(void);
> -void __init tegra30_hotplug_init(void)
> -{
> -	tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
> -}
> +#if defined(CONFIG_ARCH_TEGRA_3x_SOC)

how about using:

#if IS_BUILTIN(CONFIG_ARCH_TEGRA_3x_SOC)

instead ?

> diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
> index 4ffae54..970ebd5 100644
> --- a/arch/arm/mach-tegra/sleep.h
> +++ b/arch/arm/mach-tegra/sleep.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
> + * Copyright (c) 2010-2013, NVIDIA Corporation. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -124,11 +124,11 @@ int tegra_sleep_cpu_finish(unsigned long);
>  void tegra_disable_clean_inv_dcache(void);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -void tegra20_hotplug_init(void);
> -void tegra30_hotplug_init(void);
> +void tegra20_hotplug_shutdown(void);
> +void tegra30_hotplug_shutdown(void);

aren't these two called only by tegra_hotplug_init() now ? That means
they don't need to be exposed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/78dcda85/attachment-0001.sig>
