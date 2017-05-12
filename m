From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 12 May 2017 11:29:33 +0800
Subject: [PATCH] arm64: dts: ls1088a: Add TMU device tree support
In-Reply-To: <1494489680-9544-2-git-send-email-andy.tang@nxp.com>
References: <1494489680-9544-1-git-send-email-andy.tang@nxp.com>
 <1494489680-9544-2-git-send-email-andy.tang@nxp.com>
Message-ID: <20170512032931.GF8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 04:01:20PM +0800, Yuantian Tang wrote:
> Add nodes and properties for thermal management support.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 89 ++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index caecd14..53dc1c1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -44,6 +44,7 @@
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "fsl,ls1088a";
> @@ -61,6 +62,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x0>;
>  			clocks = <&clockgen 1 0>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -89,6 +91,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x100>;
>  			clocks = <&clockgen 1 1>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu5: cpu at 101 {
> @@ -273,6 +276,92 @@
>  			dma-coherent;
>  			status = "disabled";
>  		};
> +
> +		tmu: tmu at 1f80000 {

We sort the devices under simple-bus in order of unit-address.  Please
respect the order when adding new devices.

Shawn

> +			compatible = "fsl,qoriq-tmu";
> +			reg = <0x0 0x1f80000 0x0 0x10000>;
> +			interrupts = <0 23 0x4>;
> +			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
> +			fsl,tmu-calibration =
> +				/* Calibration data group 1 */
> +				<0x00000000 0x00000026
> +				0x00000001 0x0000002d
> +				0x00000002 0x00000032
> +				0x00000003 0x00000039
> +				0x00000004 0x0000003f
> +				0x00000005 0x00000046
> +				0x00000006 0x0000004d
> +				0x00000007 0x00000054
> +				0x00000008 0x0000005a
> +				0x00000009 0x00000061
> +				0x0000000a 0x0000006a
> +				0x0000000b 0x00000071
> +				/* Calibration data group 2 */
> +				0x00010000 0x00000025
> +				0x00010001 0x0000002c
> +				0x00010002 0x00000035
> +				0x00010003 0x0000003d
> +				0x00010004 0x00000045
> +				0x00010005 0x0000004e
> +				0x00010006 0x00000057
> +				0x00010007 0x00000061
> +				0x00010008 0x0000006b
> +				0x00010009 0x00000076
> +				/* Calibration data group 3 */
> +				0x00020000 0x00000029
> +				0x00020001 0x00000033
> +				0x00020002 0x0000003d
> +				0x00020003 0x00000049
> +				0x00020004 0x00000056
> +				0x00020005 0x00000061
> +				0x00020006 0x0000006d
> +				/* Calibration data group 4 */
> +				0x00030000 0x00000021
> +				0x00030001 0x0000002a
> +				0x00030002 0x0000003c
> +				0x00030003 0x0000004e>;
> +			little-endian;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		thermal-zones {
> +			cpu_thermal: cpu-thermal {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <5000>;
> +				thermal-sensors = <&tmu 0>;
> +
> +				trips {
> +					cpu_alert: cpu-alert {
> +						temperature = <85000>;
> +						hysteresis = <2000>;
> +						type = "passive";
> +					};
> +
> +					cpu_crit: cpu-crit {
> +						temperature = <95000>;
> +						hysteresis = <2000>;
> +						type = "critical";
> +					};
> +				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip = <&cpu_alert>;
> +						cooling-device =
> +							<&cpu0 THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>;
> +					};
> +
> +					map1 {
> +						trip = <&cpu_alert>;
> +						cooling-device =
> +							<&cpu4 THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>;
> +					};
> +				};
> +			};
> +		};
> +
>  	};
>  
>  };
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
