From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 11 Aug 2017 14:44:21 +0800
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add thermal nodes for rk3328
 SoC
In-Reply-To: <1501833976-1100-5-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
 <1501833976-1100-5-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <b9f85901-2fb5-d4ed-503c-1c4684d821e7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017?08?04? 16:06, Rocky Hao ??:
> add thermal zone and dynamic CPU power coefficients for rk3328
>
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> ---
> Change in v2:
> - remove gerrit Change-Id
>
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 43 ++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 186fb93fdffd..68829f808320 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -47,6 +47,7 @@
>   #include <dt-bindings/pinctrl/rockchip.h>
>   #include <dt-bindings/power/rk3328-power.h>
>   #include <dt-bindings/soc/rockchip,boot-mode.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	compatible = "rockchip,rk3328";
> @@ -74,6 +75,8 @@
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			reg = <0x0 0x0>;
>   			clocks = <&cru ARMCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <120>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   		};
> @@ -83,6 +86,7 @@
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			reg = <0x0 0x1>;
>   			clocks = <&cru ARMCLK>;
> +			dynamic-power-coefficient = <120>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   		};
> @@ -92,6 +96,7 @@
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			reg = <0x0 0x2>;
>   			clocks = <&cru ARMCLK>;
> +			dynamic-power-coefficient = <120>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   		};
> @@ -101,6 +106,7 @@
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			reg = <0x0 0x3>;
>   			clocks = <&cru ARMCLK>;
> +			dynamic-power-coefficient = <120>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   		};
> @@ -308,6 +314,43 @@
>   		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
> +	thermal-zones {
> +		soc_thermal: soc-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			sustainable-power = <1000>; /* milliwatts */
> +
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				threshold: trip-point0 {
> +					temperature = <70000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +				target: trip-point1 {
> +					temperature = <85000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +				soc_crit: soc-crit {
> +					temperature = <95000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */

The document had already described, maybe we should remove the 
millicelsius/milliseconds/milliwatts here.
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&target>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <4096>;
> +				};
> +			};
> +		};
> +
> +	};
> +
>   	tsadc: tsadc at ff250000 {
>   		compatible = "rockchip,rk3328-tsadc";
>   		reg = <0x0 0xff250000 0x0 0x100>;
