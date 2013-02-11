From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 16:54:03 -0700
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <1360562743-21689-3-git-send-email-hdoyu@nvidia.com>
References: <1360562743-21689-1-git-send-email-hdoyu@nvidia.com>
 <1360562743-21689-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <5119849B.1070300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2013 11:05 PM, Hiroshi Doyu wrote:
> Unify board-dt-tegra{30,114} to the Tegra20 DT board file, "tegra.c".

> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile

>  obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
>  obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
>  
> -obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra.o
> -obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
> -obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra114.o
> +obj-y					+= tegra.o
> +

I think I'd be tempted to move that line together with all the others
that don't depend on some config option.

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

> -static struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
> +static struct of_dev_auxdata tegra_auxdata_lookup[] __initdata = {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  	OF_DEV_AUXDATA("nvidia,tegra20-ehci", 0xC5000000, "tegra-ehci.0",
>  		       &tegra_ehci1_pdata),
>  	OF_DEV_AUXDATA("nvidia,tegra20-ehci", 0xC5004000, "tegra-ehci.1",
>  		       &tegra_ehci2_pdata),
>  	OF_DEV_AUXDATA("nvidia,tegra20-ehci", 0xC5008000, "tegra-ehci.2",
>  		       &tegra_ehci3_pdata),
> +#endif
>  	{}
>  };

Why ifdef? This is certainly small enough that it shouldn't matter for
any Tegra30- or Tegra114-kernel, and it's hopefully going away very
soon, so I'd prefer to drop the addition of the ifdefs to avoid any
conflicts with any other changes to that table.

>  static void __init trimslice_init(void)
>  {
> -#ifdef CONFIG_TEGRA_PCI
>  	int ret;
>  
>  	ret = tegra_pcie_init(true, true);
>  	if (ret)
>  		pr_err("tegra_pci_init() failed: %d\n", ret);
> -#endif
>  }
>  
>  static void __init harmony_init(void)
>  {
> -#ifdef CONFIG_TEGRA_PCI
>  	int ret;
>  
>  	ret = harmony_pcie_init();
>  	if (ret)
>  		pr_err("harmony_pcie_init() failed: %d\n", ret);
> -#endif
>  }

Why drop those ifdefs? Does the code still compile (link) if built for
Tegra30-only or Tegra114-only, where the Tegra PCI driver won't be
enabled, and hence those functions don't exist?

>  static void __init paz00_init(void)
> @@ -129,6 +128,9 @@ static void __init tegra_dt_init_late(void)
>  
>  	tegra_init_late();
>  
> +	if (IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> +		return;

I don't think that's going to help any link issues, so I'd drop it and
keep this function simple. After all, what if someone wants to add some
non-PCI-related entry into board_init_funcs[]?

> -static const char *tegra20_dt_board_compat[] = {
> +static const char * const tegra_dt_board_compat[] = {
>  	"nvidia,tegra20",
> +	"nvidia,tegra30",
> +	"nvidia,tegra114",
>  	NULL
>  };

It'd be best to add the newer values first. It shouldn't matter, but
currently does at least for device compatible matching, so we may as
well be consistent here.
