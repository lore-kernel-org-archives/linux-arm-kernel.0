From: javi.merino@arm.com (Javi Merino)
Date: Wed, 24 Feb 2016 18:28:57 +0000
Subject: [PATCH 3/3] arm64: dts: register Hi6220's thermal zone for power
 allocator
In-Reply-To: <1455983529-9559-4-git-send-email-leo.yan@linaro.org>
References: <1455983529-9559-1-git-send-email-leo.yan@linaro.org>
 <1455983529-9559-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20160224182856.GD3006@e104805>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 11:52:09PM +0800, Leo Yan wrote:
> With profiling Hi6220's power modeling so get dynamic coefficient and
> sustainable power. So pass these parameters from DT.
> 
> Now enable power allocator wit only one actor for CPU part, so directly
> use cluster0's thermal sensor for monitoring temperature.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 50ba1b0..3608a3e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/hi6220-clock.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "hisilicon,hi6220";
> @@ -87,6 +88,7 @@
>  			cooling-max-level = <0>;
>  			#cooling-cells = <2>; /* min followed by max */
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -322,5 +324,39 @@
>  			clock-names = "thermal_clk";
>  			#thermal-sensor-cells = <1>;
>  		};
> +
> +		thermal-zones {
> +
> +			cls0: cls0 {
> +				polling-delay = <1000>;
> +				polling-delay-passive = <100>;
> +				sustainable-power = <3326>;
> +
> +				/* sensor ID */
> +				thermal-sensors = <&tsensor 2>;
> +
> +				trips {
> +					threshold: trip-point at 0 {
> +						temperature = <65000>;
> +						hysteresis = <1000>;

As far as I know, hysteresis is ignored in the thermal subsystem right
now, so you could remove it from both trip points.

> +						type = "passive";
> +					};
> +
> +					target: trip-point at 1 {
> +						temperature = <75000>;
> +						hysteresis = <1000>;
> +						type = "passive";
> +					};
> +				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip = <&target>;
> +						contribution = <1024>;

As Hikey has only one voltage domain, you only have one cpu cooling
device.  "contribution" is only useful when you have more than one
cooling device, as it's relative to the other cooling device's
contribution.  You can remove contribution from here.

Other than this minor stuff, it looks good to me. FWIW,

Reviewed-by: Javi Merino <javi.merino@arm.com>

> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
