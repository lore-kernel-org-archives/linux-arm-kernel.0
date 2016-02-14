From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 14 Feb 2016 15:44:53 +0900
Subject: [PATCH] ARM: dts: Move syscon reboot/poweroff to common dtsi for
 Exynos
In-Reply-To: <1455042606-10075-1-git-send-email-javier@osg.samsung.com>
References: <1455042606-10075-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56C02265.40103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 10.02.2016 o 03:30, Javier Martinez Canillas pisze:
> All Exynos SoCs have the same syscon reboot and poweroff device nodes so
> there is no need to duplicate the same on each SoC dtsi and can be moved
> to a common dtsi that can be included by all the SoCs dtsi files.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Hello,
> 
> The patch was tested on an Exynos5800 Peach Pi Chromebook and an
> Exynos5422 Odroid XU4 board. Reboot and poweroff worked for both.
> 
> But testing on Exynos3 and Exynos4 will be highly appreciated.

Would you be so kind and add my suggested-by (since it comes from
https://wiki.tizen.org/wiki/Exynos_Mainline_Kernel_TODO :) )

I'll test it on Exynos4 at work and then apply... but few comments below:

> 
> Best regards,
> Javier
> 
>  arch/arm/boot/dts/exynos-syscon-restart.dtsi | 23 +++++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250.dtsi            | 15 +--------------
>  arch/arm/boot/dts/exynos4.dtsi               | 15 +--------------
>  arch/arm/boot/dts/exynos5.dtsi               | 15 +--------------
>  arch/arm/boot/dts/exynos5410.dtsi            | 15 +--------------
>  5 files changed, 27 insertions(+), 56 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos-syscon-restart.dtsi
> 
> diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
> new file mode 100644
> index 000000000000..2b8acf554881
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
> @@ -0,0 +1,23 @@
> +/*
> + * Samsung's Exynos SoC syscon reboot/poweroff nodes common definition.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/ {

In some of the DTSI this was under "soc" node, not at top-level.
Unfortunately we do not have consistency here - some DTSI have "soc",
some not. Anyway I think we should move to "soc" version.

> +	poweroff: syscon-poweroff {
> +		compatible = "syscon-poweroff";
> +		regmap = <&pmu_system_controller>;
> +		offset = <0x330C>; /* PS_HOLD_CONTROL */
> +		mask = <0x5200>; /* reset value */
> +	};
> +
> +	reboot: syscon-reboot {
> +		compatible = "syscon-reboot";
> +		regmap = <&pmu_system_controller>;
> +		offset = <0x0400>; /* SWRESET */
> +		mask = <0x1>;
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
> index ca621a92319e..e6f6939ccdfa 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -21,6 +21,7 @@
>  
>  #include <dt-bindings/clock/exynos4.h>
>  #include <dt-bindings/clock/exynos-audss-clk.h>
> +#include "exynos-syscon-restart.dtsi"

Just to keep it consistent and logic - include after skeleton.

Best regards,
Krzysztof
