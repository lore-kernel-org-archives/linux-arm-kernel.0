From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 13:37:46 +0900
Subject: [PATCH v4 3/3] ARM: shmobile: kzm9g-reference: add CPUFreq support
In-Reply-To: <1364153255-20664-4-git-send-email-g.liakhovetski@gmx.de>
References: <1364153255-20664-1-git-send-email-g.liakhovetski@gmx.de>
 <1364153255-20664-4-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130404043746.GD28297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 08:27:35PM +0100, Guennadi Liakhovetski wrote:
> This patch enables the use of the generic cpufreq-cpu0 driver on kzm9g.
> Providing a regulator, a list of OPPs in DT, combined with a virtual
> cpufreq-cpu0 platform device and a clock, attached to it is everything,
> the cpufreq-cpu0 driver needs.

I wonder if it would be possible to re-arange this patch a little.

1) vdd_dvfs is added in this patch but it appears to be used in the
   previous patch in the series. I wonder if this can be resolved
   by re-ordering the patches.

2) It includes both kzm9g board and sh73a0 SoC changes.
   I would prefer if the sh73a0 SoC portion (setup-sh73a0.c)
   was moved into a separate patch. The arm-soc people
   like to have separate board and SoC branches.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v4: add a cpufreq-cpu0 platform device for the new cpufreq-cpu0 
> initialisation procedure
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    6 +++---
>  arch/arm/mach-shmobile/Kconfig               |    2 ++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |    5 +++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index dd1cd80..b6f759e 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -78,10 +78,10 @@
>  		reg = <0x40>;
>  
>  		regulators {
> -			sd1 {
> +			vdd_dvfs: sd1 {
>  				regulator-name = "1.315V CPU";
> -				regulator-min-microvolt = <1315000>;
> -				regulator-max-microvolt = <1335000>;
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1350000>;
>  				regulator-always-on;
>  				regulator-boot-on;
>  			};
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index eb3a7ff..8a0420b 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -134,6 +134,8 @@ config MACH_KZM9G
>  config MACH_KZM9G_REFERENCE
>  	bool "KZM-A9-GT board - Reference Device Tree Implementation"
>  	depends on ARCH_SH73A0
> +	select ARCH_HAS_CPUFREQ
> +	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select SND_SOC_AK4642 if SND_SIMPLE_CARD
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index e8cd93a..0469e84 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -1016,6 +1016,8 @@ static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
>  
>  void __init sh73a0_add_standard_devices_dt(void)
>  {
> +	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
> +
>  	/* clocks are setup late during boot in the case of DT */
>  	sh73a0_clock_init();
>  
> @@ -1023,6 +1025,9 @@ void __init sh73a0_add_standard_devices_dt(void)
>  			     ARRAY_SIZE(sh73a0_devices_dt));
>  	of_platform_populate(NULL, of_default_bus_match_table,
>  			     sh73a0_auxdata_lookup, NULL);
> +
> +	/* Instantiate cpufreq-cpu0 */
> +	platform_device_register_full(&devinfo);
>  }
>  
>  static const char *sh73a0_boards_compat_dt[] __initdata = {
> -- 
> 1.7.2.5
> 
