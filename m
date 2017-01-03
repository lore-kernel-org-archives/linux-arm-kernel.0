From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 15:06:08 +0800
Subject: [PATCH V2] arm64:dts:ls1046a: Add TMU device tree support
In-Reply-To: <1483425739-15404-1-git-send-email-hongtao.jia@nxp.com>
References: <1483425739-15404-1-git-send-email-hongtao.jia@nxp.com>
Message-ID: <20170103070607.GW20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 02:42:19PM +0800, Jia Hongtao wrote:
> Also add nodes and properties for thermal management support.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>

The subject prefix is still not so right.  There should be a space after
each colon.

> ---
> Changes for V2:
> * Update the subject title according to Shawn Guo's comment.
> * Add comments for calibration data groups.
> * Update "thermal-zones" property in a unified style with platform dts.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 83 ++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 38806ca..df53a4a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -45,6 +45,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "fsl,ls1046a";
> @@ -67,6 +68,7 @@
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&l2>;
>  			cpu-idle-states = <&CPU_PH20>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -279,6 +281,87 @@
>  			clocks = <&sysclk>;
>  		};
>  
> +		tmu: tmu at 1f00000 {
> +			compatible = "fsl,qoriq-tmu";
> +			reg = <0x0 0x1f00000 0x0 0x10000>;
> +			interrupts = <0 33 0x4>;
> +			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
> +			fsl,tmu-calibration =
> +				/* Calibration data group 1*/
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
> +
> +				/* Calibration data group 2*/

The single line comment format is /* blabla */.  There are space at both
beginning and end of the text.

Also I am asking that we use the single line comment to replace the
blank line, which is still there.

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
> +
> +				/* Calibration data group 3*/
> +				0x00020000 0x00000029
> +				0x00020001 0x00000033
> +				0x00020002 0x0000003d
> +				0x00020003 0x00000049
> +				0x00020004 0x00000056
> +				0x00020005 0x00000061
> +				0x00020006 0x0000006d
> +
> +				/* Calibration data group 4*/
> +				0x00030000 0x00000021
> +				0x00030001 0x0000002a
> +				0x00030002 0x0000003c
> +				0x00030003 0x0000004e>;

Here is the format on my mind:

			fsl,tmu-calibration = <
				/* Calibration data group 1 */
				0x00000000 0x00000026
				0x00000001 0x0000002d
				0x00000002 0x00000032
				0x00000003 0x00000039
				0x00000004 0x0000003f
				0x00000005 0x00000046
				0x00000006 0x0000004d
				0x00000007 0x00000054
				0x00000008 0x0000005a
				0x00000009 0x00000061
				0x0000000a 0x0000006a
				0x0000000b 0x00000071
				/* Calibration data group 2 */
				0x00010000 0x00000025
				0x00010001 0x0000002c
				0x00010002 0x00000035
				0x00010003 0x0000003d
				0x00010004 0x00000045
				0x00010005 0x0000004e
				0x00010006 0x00000057
				0x00010007 0x00000061
				0x00010008 0x0000006b
				0x00010009 0x00000076
				/* Calibration data group 3 */
				0x00020000 0x00000029
				0x00020001 0x00000033
				0x00020002 0x0000003d
				0x00020003 0x00000049
				0x00020004 0x00000056
				0x00020005 0x00000061
				0x00020006 0x0000006d
				/* Calibration data group 4 */
				0x00030000 0x00000021
				0x00030001 0x0000002a
				0x00030002 0x0000003c
				0x00030003 0x0000004e
			>;

Shawn

> +			big-endian;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		thermal-zones {
> +			cpu_thermal: cpu-thermal {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <5000>;
> +				thermal-sensors = <&tmu 3>;
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
> +				};
> +			};
> +		};
> +
>  		dspi: dspi at 2100000 {
>  			compatible = "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
> -- 
> 2.1.0.27.g96db324
> 
