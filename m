From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 19:17:46 +0200
Subject: [PATCH v2] ARM: rockchip: convert smp bringup to
 CPU_METHOD_OF_DECLARE
In-Reply-To: <1878147.CvhHSZhTas@diego>
References: <1632873.urGeGsUMPH@diego> <2151573.evmqdkWnet@diego>
 <1878147.CvhHSZhTas@diego>
Message-ID: <155552153.z5UXrbJMBi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 27. M?rz 2014, 01:06:32 schrieb Heiko St?bner:
> With the newly introduced CPU_METHOD_OF_DECLARE is not necessary anymore
> to reference the relevant smp_ops in the board file, but instead it can
> simply be set by the enable-method property of the cpu nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

more responses to this? [or maybe even an ack :-) ? ]


Thanks
Heiko

> ---
> changes since v1:
>   - add a short description to the enable-method binding
> 
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  arch/arm/boot/dts/rk3066a.dtsi                 | 1 +
>  arch/arm/boot/dts/rk3188.dtsi                  | 1 +
>  arch/arm/mach-rockchip/core.h                  | 2 --
>  arch/arm/mach-rockchip/platsmp.c               | 3 ++-
>  arch/arm/mach-rockchip/rockchip.c              | 1 -
>  6 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> b/Documentation/devicetree/bindings/arm/cpus.txt index 333f4ae..f52a9ac
> 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described
> below. "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "rockchip,rk3066-smp" - cpu-core handling of Socs
> +					from Rockchip starting with rk3066
> 
>  	- cpu-release-addr
>  		Usage: required for systems that have an "enable-method"
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 4d4dfbb..90b354d 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -24,6 +24,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		enable-method = "rockchip,rk3066-smp";
> 
>  		cpu at 0 {
>  			device_type = "cpu";
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index bb36596..7ad5103 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -24,6 +24,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		enable-method = "rockchip,rk3066-smp";
> 
>  		cpu at 0 {
>  			device_type = "cpu";
> diff --git a/arch/arm/mach-rockchip/core.h b/arch/arm/mach-rockchip/core.h
> index e2e7c9d..39bca96 100644
> --- a/arch/arm/mach-rockchip/core.h
> +++ b/arch/arm/mach-rockchip/core.h
> @@ -18,5 +18,3 @@ extern char rockchip_secondary_trampoline_end;
> 
>  extern unsigned long rockchip_boot_fn;
>  extern void rockchip_secondary_startup(void);
> -
> -extern struct smp_operations rockchip_smp_ops;
> diff --git a/arch/arm/mach-rockchip/platsmp.c
> b/arch/arm/mach-rockchip/platsmp.c index dbfa5a2..a18b7f2 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -178,7 +178,8 @@ static void __init rockchip_smp_prepare_cpus(unsigned
> int max_cpus) pmu_set_power_domain(0 + i, false);
>  }
> 
> -struct smp_operations rockchip_smp_ops __initdata = {
> +static struct smp_operations rockchip_smp_ops __initdata = {
>  	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
>  	.smp_boot_secondary	= rockchip_boot_secondary,
>  };
> +CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp",
> &rockchip_smp_ops); diff --git a/arch/arm/mach-rockchip/rockchip.c
> b/arch/arm/mach-rockchip/rockchip.c index d211d6f..4499b0a 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -39,7 +39,6 @@ static const char * const rockchip_board_dt_compat[] = {
>  };
> 
>  DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> -	.smp		= smp_ops(rockchip_smp_ops),
>  	.init_machine	= rockchip_dt_init,
>  	.dt_compat	= rockchip_board_dt_compat,
>  MACHINE_END
