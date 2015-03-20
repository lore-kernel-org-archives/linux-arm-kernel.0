From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 20 Mar 2015 17:51:24 -0400
Subject: [PATCH 2/3] ARM: dts: DRA7: Add bandgap and related thermal nodes
In-Reply-To: <1426880861-9266-3-git-send-email-nm@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
 <1426880861-9266-3-git-send-email-nm@ti.com>
Message-ID: <20150320215123.GA7346@developer.amazonguestwifi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 02:47:40PM -0500, Nishanth Menon wrote:
> From: Keerthy <j-keerthy@ti.com>
> 
> Add bandgap and related thermal nodes. The patch adds 5 thermal
> sensors. Only one cooling device for mpu as of now. The sensors are
> the exact same on both dra72 and dra7.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/boot/dts/dra7.dtsi   |   12 ++++++++++++
>  arch/arm/boot/dts/dra72x.dtsi |    9 +++++++++
>  arch/arm/boot/dts/dra74x.dtsi |    9 +++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index eea4a54d6cb3..4b975cc377fd 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -177,6 +177,18 @@
>  			};
>  		};
>  
> +		bandgap: bandgap at 4a0021e0 {
> +			reg = <0x4a0021e0 0xc
> +				0x4a00232c 0xc
> +				0x4a002380 0x2c
> +				0x4a0023C0 0x3c
> +				0x4a002564 0x8
> +				0x4a002574 0x50>;
> +				compatible = "ti,dra752-bandgap";
> +				interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +				#thermal-sensor-cells = <1>;
> +		};
> +
>  		cm_core_aon: cm_core_aon at 4a005000 {
>  			compatible = "ti,dra7-cm-core-aon";
>  			reg = <0x4a005000 0x2000>;
> diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> index e5a3d23a3df1..43bd0709bde9 100644
> --- a/arch/arm/boot/dts/dra72x.dtsi
> +++ b/arch/arm/boot/dts/dra72x.dtsi
> @@ -20,6 +20,11 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
> +
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <2>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  
> @@ -27,4 +32,8 @@
>  		compatible = "arm,cortex-a15-pmu";
>  		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		#include "omap5-cpu-thermal.dtsi"
> +	};
>  };
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
> index 10173fab1a15..4f2c870836fe 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -31,6 +31,11 @@
>  			clock-names = "cpu";
>  
>  			clock-latency = <300000>; /* From omap-cpufreq driver */
> +
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <2>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
> @@ -45,6 +50,10 @@
>  			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	thermal_zones: thermal-zones {
> +		#include "omap5-cpu-thermal.dtsi"
> +	};
> +
>  	ocp {
>  		omap_dwc3_4: omap_dwc3_4 at 48940000 {
>  			compatible = "ti,dwc3";
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/b957ecce/attachment.sig>
