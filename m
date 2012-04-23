From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 12:33:09 +0000
Subject: [PATCH 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
References: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <201204231233.09423.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Hiroshi DOYU wrote:
> The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> Both Tegra20/30 have this.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>

Please explain in the text above why it's a good idea to have this
driver.


> @@ -122,6 +123,7 @@ void __init tegra20_init_early(void)
>  	tegra_init_cache(0x331, 0x441);
>  	tegra_pmc_init();
>  	tegra_powergate_init();
> +	tegra_ahb_gizmo_init();
>  }
>  #endif
>  #ifdef CONFIG_ARCH_TEGRA_3x_SOC
> @@ -132,5 +134,6 @@ void __init tegra30_init_early(void)
>  	tegra_init_cache(0x441, 0x551);
>  	tegra_pmc_init();
>  	tegra_powergate_init();
> +	tegra_ahb_gizmo_init();
>  }
>  #endif

Does it really have to be "early", rather than an initcall? Why?

> +
> +static inline unsigned long gizmo_readl(unsigned long offset)
> +{
> +	return readl(IO_TO_VIRT(TEGRA_AHB_GIZMO_BASE + offset));
> +}
> +
> +static inline void gizmo_writel(unsigned long value, unsigned long offset)
> +{
> +	writel(value, IO_TO_VIRT(TEGRA_AHB_GIZMO_BASE + offset));
> +}

Please change this to no longer use hardcoded addresses. A good
implementation would scan the device tree for the physical address
and then ioremap the registers in the init function, in order to
save a local __iomem pointer.

	Arnd
