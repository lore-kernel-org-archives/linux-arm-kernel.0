From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Apr 2016 10:18:44 +0200
Subject: [PATCH 9/9] arm64: dts: rockchip: move the rk3368 thermal data
 into rk3368.dtsi
In-Reply-To: <1460950562-20652-10-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-10-git-send-email-wxt@rock-chips.com>
Message-ID: <8615749.P3ApjY2l50@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 18. April 2016, 11:36:01 schrieb Caesar Wang:
> In order to be standard to manage for rockchip SoCs,  move the thermal
> data into rk3368 dtsi, we needn't to add a new file for thermal.
> 
> Fixes commit f990238f859e
> ("arm64: dts: rockchip: Add main thermal info to rk3368.dtsi")
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

I'm pondering this change for some days now and am still undecided :-) 
On the one hand you're right ... this doesn't need to be its own file on the 
other hand it creates churn, but I'm inclined to pick it up.

Can you at least provide another patch doing the same for rk3288, so that we 
really standardize on one form for Rockchip SoCs?


Thanks
Heiko


> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi | 112
> ----------------------- arch/arm64/boot/dts/rockchip/rk3368.dtsi         | 
> 66 ++++++++++++- 2 files changed, 65 insertions(+), 113 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi deleted file mode 100644
> index a10010f..0000000
> --- a/arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi
> +++ /dev/null
> @@ -1,112 +0,0 @@
> -/*
> - * Device Tree Source for RK3368 SoC thermal
> - *
> - * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
> - * Caesar Wang <wxt@rock-chips.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include <dt-bindings/thermal/thermal.h>
> -
> -cpu_thermal: cpu_thermal {
> -	polling-delay-passive = <100>; /* milliseconds */
> -	polling-delay = <5000>; /* milliseconds */
> -
> -	thermal-sensors = <&tsadc 0>;
> -
> -	trips {
> -		cpu_alert0: cpu_alert0 {
> -			temperature = <75000>; /* millicelsius */
> -			hysteresis = <2000>; /* millicelsius */
> -			type = "passive";
> -		};
> -		cpu_alert1: cpu_alert1 {
> -			temperature = <80000>; /* millicelsius */
> -			hysteresis = <2000>; /* millicelsius */
> -			type = "passive";
> -		};
> -		cpu_crit: cpu_crit {
> -			temperature = <95000>; /* millicelsius */
> -			hysteresis = <2000>; /* millicelsius */
> -			type = "critical";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map0 {
> -			trip = <&cpu_alert0>;
> -			cooling-device =
> -				<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -		};
> -		map1 {
> -			trip = <&cpu_alert1>;
> -			cooling-device =
> -				<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> -
> -gpu_thermal: gpu_thermal {
> -	polling-delay-passive = <100>; /* milliseconds */
> -	polling-delay = <5000>; /* milliseconds */
> -
> -	thermal-sensors = <&tsadc 1>;
> -
> -	trips {
> -		gpu_alert0: gpu_alert0 {
> -			temperature = <80000>; /* millicelsius */
> -			hysteresis = <2000>; /* millicelsius */
> -			type = "passive";
> -		};
> -		gpu_crit: gpu_crit {
> -			temperature = <1150000>; /* millicelsius */
> -			hysteresis = <2000>; /* millicelsius */
> -			type = "critical";
> -		};
> -	};
> -
> -	cooling-maps {
> -		map0 {
> -			trip = <&gpu_alert0>;
> -			cooling-device =
> -				<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -		};
> -	};
> -};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368.dtsi index 7056a0f..8b4a7c9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -413,7 +413,71 @@
>  	};
> 
>  	thermal-zones {
> -		#include "rk3368-thermal.dtsi"
> +		cpu {
> +			polling-delay-passive = <100>; /* milliseconds */
> +			polling-delay = <5000>; /* milliseconds */
> +
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					temperature = <75000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +				cpu_alert1: cpu_alert1 {
> +					temperature = <80000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +				cpu_crit: cpu_crit {
> +					temperature = <95000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_alert1>;
> +					cooling-device =
> +					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu {
> +			polling-delay-passive = <100>; /* milliseconds */
> +			polling-delay = <5000>; /* milliseconds */
> +
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				gpu_alert0: gpu_alert0 {
> +					temperature = <80000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +				gpu_crit: gpu_crit {
> +					temperature = <115000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&gpu_alert0>;
> +					cooling-device =
> +					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
>  	};
> 
>  	tsadc: tsadc at ff280000 {
