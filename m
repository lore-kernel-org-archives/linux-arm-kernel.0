From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 12 Jul 2017 20:44:51 +0200
Subject: [PATCH 4/4] arm64: dts: rockchip: update the thermal zones for
 RK3399 SoCs
In-Reply-To: <1499840971-20392-5-git-send-email-wxt@rock-chips.com>
References: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
 <1499840971-20392-5-git-send-email-wxt@rock-chips.com>
Message-ID: <1962948.PJPnbPYrr4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 12. Juli 2017, 14:29:30 CEST schrieb Caesar Wang:
> As RK3399 had used the Power allocator thermal governor by default,
> enabled this to manage thermals by dynamically allocating and limiting
> power to devices.

Does this still run with other thermal governors? The devicetree describes
the hardware, but should not mandate or exclude specific implementations.


> Also, this patch supported the dynamic-power-coefficient/sustainable_power
> and GPU's power model for needed parameters with thermal IPA.

As written below, this doesn't look like a reviewed binding (otherwise
please point me to the binding patch), but even if it is a real binding
it should get its separate patch.


> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 62 +++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 8c6438b..139f58c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -147,7 +147,7 @@
>  			enable-method = "psci";
>  			#cooling-cells = <2>; /* min followed by max */
>  			clocks = <&cru ARMCLKB>;
> -			dynamic-power-coefficient = <100>;
> +			dynamic-power-coefficient = <436>;
>  		};
>  
>  		cpu_b1: cpu at 101 {
> @@ -156,7 +156,7 @@
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			clocks = <&cru ARMCLKB>;
> -			dynamic-power-coefficient = <100>;
> +			dynamic-power-coefficient = <436>;
>  		};
>  	};
>  
> @@ -690,24 +690,25 @@
>  	};
>  
>  	thermal_zones: thermal-zones {
> -		cpu_thermal: cpu {
> +		soc_thermal: soc-thermal {
>  			polling-delay-passive = <100>;
>  			polling-delay = <1000>;
> +			sustainable-power = <1000>;
>  
>  			thermal-sensors = <&tsadc 0>;
>  
>  			trips {
> -				cpu_alert0: cpu_alert0 {
> +				threshold: trip-point at 0 {

foo at 0 will produce warnings when used without reg property. Also,
why all that renaming, the previous names sounded fine to me.


>  					temperature = <70000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> -				cpu_alert1: cpu_alert1 {
> -					temperature = <75000>;
> +				target: trip-point at 1 {
> +					temperature = <85000>;

When raising the target-temperature to 85 degrees I really
do expect some sort of reassurement in the commit message
why that is really safe - especially when the old limit was 10 degrees
lower.

>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> -				cpu_crit: cpu_crit {
> +				soc_crit: soc-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -716,45 +717,31 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert0>;
> +					trip = <&target>;
>  					cooling-device =
> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <4096>;
>  				};
>  				map1 {
> -					trip = <&cpu_alert1>;
> +					trip = <&target>;

Is it correct to use the _same_ trip point all the time? ... what about
the threshold and soc_crit ones?

>  					cooling-device =
> -						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +				map2 {
> +					trip = <&target>;
> +					cooling-device =
> +						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <4096>;
>  				};
>  			};
>  		};
>  
> -		gpu_thermal: gpu {
> +		gpu_thermal: gpu-thermal {
>  			polling-delay-passive = <100>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsadc 1>;
> -
> -			trips {
> -				gpu_alert0: gpu_alert0 {
> -					temperature = <75000>;
> -					hysteresis = <2000>;
> -					type = "passive";
> -				};
> -				gpu_crit: gpu_crit {
> -					temperature = <95000>;
> -					hysteresis = <2000>;
> -					type = "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&gpu_alert0>;
> -					cooling-device =
> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  	};
>  
> @@ -1455,8 +1442,17 @@
>  		interrupt-names = "GPU", "JOB", "MMU";
>  		clocks = <&cru ACLK_GPU>;
>  		clock-names = "clk_mali";
> +		#cooling-cells = <2>;
>  		power-domains = <&power RK3399_PD_GPU>;
>  		status = "disabled";
> +
> +		gpu_power_model: power_model {
> +			compatible = "arm,mali-simple-power-model";

Is this binding documented / reviewed somewhere? Because it looks
quite suspcicious :-) .


Heiko

> +			static-coefficient = <1079403>;
> +			dynamic-coefficient = <977>;
> +			ts = <32000 4700 (-80) 2>;
> +			thermal-zone = "gpu-thermal";
> +		};
>  	};
>  
>  	pinctrl: pinctrl {
> 
