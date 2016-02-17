From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Feb 2016 11:13:25 +0900
Subject: [PATCH v2] ARM: dts: Move syscon reboot/poweroff to common dtsi
 for Exynos
In-Reply-To: <1455636348-14277-1-git-send-email-javier@osg.samsung.com>
References: <1455636348-14277-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56C3D745.7050904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2016 00:25, Javier Martinez Canillas wrote:
> All Exynos SoCs have the same syscon reboot and poweroff device nodes so
> there is no need to duplicate the same on each SoC dtsi and can be moved
> to a common dtsi that can be included by all the SoCs dtsi files.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung,com>
> 
> ---
> Hello,
> 
> The patch was tested on an Exynos5800 Peach Pi Chromebook and an
> Exynos5422 Odroid XU4 board. Reboot and poweroff worked for both.
> 
> But testing on Exynos3 and Exynos4 will be highly appreciated.
> 
> Best regards,
> Javier
> 
> Changes in v2:
> - Added Krzysztof Kozlowski's Suggested-by tag.
> - Added Alim Akhtar's Reviewed-by tag.
> - Moved the poweroff and reboot nodes under a soc node (Krzysztof Kozlowski).
> - Include the dtsi after skeleton dtsi in exynos4.dtsi ((Krzysztof Kozlowski).
> 
>  arch/arm/boot/dts/exynos-syscon-restart.dtsi | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250.dtsi            | 15 +--------------
>  arch/arm/boot/dts/exynos4.dtsi               | 15 +--------------
>  arch/arm/boot/dts/exynos5.dtsi               | 15 +--------------
>  arch/arm/boot/dts/exynos5410.dtsi            | 15 +--------------
>  5 files changed, 31 insertions(+), 56 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos-syscon-restart.dtsi
> 
> diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
> new file mode 100644
> index 000000000000..09a2040054ed
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
> @@ -0,0 +1,27 @@
> +/*
> + * Samsung's Exynos SoC syscon reboot/poweroff nodes common definition.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/ {
> +	soc {
> +		compatible = "simple-bus";

The exynos4 does not have soc node. I wonder whether we should provide
here also address and size:
                #address-cells = <1>;
                #size-cells = <1>;
		ranges;

Without this it works fine but that does not look correct enough.

A minor effect of this patch on Exynos4 is that syscon-poweroff/reboot
are now the only children of "soc" simple-bus (rest of platform devices
is not)... but this is not a problem.

Works fine so only the question about cells/ranges remains. Any comments?

Best regards,
Krzysztof


> +
> +		poweroff: syscon-poweroff {
> +			compatible = "syscon-poweroff";
> +			regmap = <&pmu_system_controller>;
> +			offset = <0x330C>; /* PS_HOLD_CONTROL */
> +			mask = <0x5200>; /* reset value */
> +		};
> +
> +		reboot: syscon-reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&pmu_system_controller>;
> +			offset = <0x0400>; /* SWRESET */
> +			mask = <0x1>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 18e3deffbf48..d9c221517935 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -19,6 +19,7 @@
>  
>  #include "skeleton.dtsi"
>  #include "exynos4-cpu-thermal.dtsi"
> +#include "exynos-syscon-restart.dtsi"
>  #include <dt-bindings/clock/exynos3250.h>
>  
>  / {
> @@ -152,20 +153,6 @@
>  			interrupt-parent = <&gic>;
>  		};
>  
> -		poweroff: syscon-poweroff {
> -			compatible = "syscon-poweroff";
> -			regmap = <&pmu_system_controller>;
> -			offset = <0x330C>; /* PS_HOLD_CONTROL */
> -			mask = <0x5200>; /* Reset value */
> -		};
> -
> -		reboot: syscon-reboot {
> -			compatible = "syscon-reboot";
> -			regmap = <&pmu_system_controller>;
> -			offset = <0x0400>; /* SWRESET */
> -			mask = <0x1>;
> -		};
> -
>  		mipi_phy: video-phy at 10020710 {
>  			compatible = "samsung,s5pv210-mipi-video-phy";
>  			#phy-cells = <1>;
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index ca621a92319e..5456094d2f45 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -22,6 +22,7 @@
>  #include <dt-bindings/clock/exynos4.h>
>  #include <dt-bindings/clock/exynos-audss-clk.h>
>  #include "skeleton.dtsi"
> +#include "exynos-syscon-restart.dtsi"
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -163,20 +164,6 @@
>  		interrupt-parent = <&gic>;
>  	};
>  
> -	poweroff: syscon-poweroff {
> -		compatible = "syscon-poweroff";
> -		regmap = <&pmu_system_controller>;
> -		offset = <0x330C>; /* PS_HOLD_CONTROL */
> -		mask = <0x5200>; /* reset value */
> -	};
> -
> -	reboot: syscon-reboot {
> -		compatible = "syscon-reboot";
> -		regmap = <&pmu_system_controller>;
> -		offset = <0x0400>; /* SWRESET */
> -		mask = <0x1>;
> -	};
> -
>  	dsi_0: dsi at 11C80000 {
>  		compatible = "samsung,exynos4210-mipi-dsi";
>  		reg = <0x11C80000 0x10000>;
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index b61d1f637510..92313cac035e 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -14,6 +14,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include "exynos-syscon-restart.dtsi"
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -93,20 +94,6 @@
>  		status = "disabled";
>  	};
>  
> -	poweroff: syscon-poweroff {
> -		compatible = "syscon-poweroff";
> -		regmap = <&pmu_system_controller>;
> -		offset = <0x330C>; /* PS_HOLD_CONTROL */
> -		mask = <0x5200>; /* reset value */
> -	};
> -
> -	reboot: syscon-reboot {
> -		compatible = "syscon-reboot";
> -		regmap = <&pmu_system_controller>;
> -		offset = <0x0400>; /* SWRESET */
> -		mask = <0x1>;
> -	};
> -
>  	fimd: fimd at 14400000 {
>  		compatible = "samsung,exynos5250-fimd";
>  		interrupt-parent = <&combiner>;
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index f3490f567344..fa558674ac76 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -14,6 +14,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include "exynos-syscon-restart.dtsi"
>  #include <dt-bindings/clock/exynos5410.h>
>  
>  / {
> @@ -117,20 +118,6 @@
>  			reg = <0x10040000 0x5000>;
>  		};
>  
> -		poweroff: syscon-poweroff {
> -			compatible = "syscon-poweroff";
> -			regmap = <&pmu_system_controller>;
> -			offset = <0x330C>; /* PS_HOLD_CONTROL */
> -			mask = <0x5200>; /* reset value */
> -		};
> -
> -		reboot: syscon-reboot {
> -			compatible = "syscon-reboot";
> -			regmap = <&pmu_system_controller>;
> -			offset = <0x0400>; /* SWRESET */
> -			mask = <0x1>;
> -		};
> -
>  		mct: mct at 101C0000 {
>  			compatible = "samsung,exynos4210-mct";
>  			reg = <0x101C0000 0xB00>;
> 
