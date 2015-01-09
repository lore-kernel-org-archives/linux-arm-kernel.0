From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 9 Jan 2015 14:10:18 -0400
Subject: [PATCH v2 3/9] ARM: dts: sun7i: Add cpu thermal zones to dtsi
In-Reply-To: <1420798676-22856-4-git-send-email-wens@csie.org>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-4-git-send-email-wens@csie.org>
Message-ID: <20150109181016.GC9510@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:17:50PM +0800, Chen-Yu Tsai wrote:
> The core temperature sensor now supports thermal zones. Add a thermal
> zone mapping for the cpus with passive cooling (cpufreq throttling).
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This patch looks fine to me:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
> 
> changes since v1:
> 
>     - Use thermal dt bindings macros in cooling-device
> 
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index c2e964939991..61780b144745 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -50,6 +50,7 @@
>  #include "skeleton.dtsi"
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include <dt-bindings/dma/sun4i-a10.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
> @@ -116,6 +117,38 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal {
> +			/* milliseconds */
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&rtp>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu_crit {
> +					/* milliCelsius */
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	memory {
>  		reg = <0x40000000 0x80000000>;
>  	};
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/c497d679/attachment.sig>
