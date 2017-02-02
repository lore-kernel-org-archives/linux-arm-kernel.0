From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 1 Feb 2017 21:12:00 -0800
Subject: [PATCH v5 1/3] dt: bindings: add documentation for zx2967 family
 thermal sensor
In-Reply-To: <1484714522-26651-1-git-send-email-baoyou.xie@linaro.org>
References: <1484714522-26651-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170202051159.GB7360@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Bao,

On Wed, Jan 18, 2017 at 12:42:00PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  .../devicetree/bindings/thermal/zx2967-thermal.txt | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> new file mode 100644
> index 0000000..a96c8b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> @@ -0,0 +1,109 @@
> +* ZTE zx2967 family Thermal
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx296718-thermal
> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "gate" for the topcrm clock.
> +	       "pclk" for the apb clock.
> +- #thermal-sensor-cells: must be 0.
> +
> +Example for tempsensor:
> +
> +	tempsensor: tempsensor at 148a000 {
> +		compatible = "zte,zx296718-thermal";
> +		reg = <0x0148a000 0x20>;
> +		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
> +		clock-names = "gate", "pclk";
> +		#thermal-sensor-cells = <0>;
> +	};
> +
> +Example for cooling device:
> +
> +	cooling_dev: cooling_dev {
> +		cluster0_cooling_dev: cluster0-cooling-dev {
> +			#cooling-cells = <2>;
> +			cpumask = <0xf>;
> +			capacitance = <1500>;
> +		};
> +
> +	cluster1_cooling_dev: cluster1-cooling-dev {
> +			#cooling-cells = <2>;
> +			cpumask = <0x30>;
> +			capacitance = <2000>;
> +		};
> +	};
> +
> +Example for thermal zones:
> +
> +	thermal-zones {
> +		zx296718_thermal: zx296718_thermal {
> +			polling-delay-passive = <500>;
> +			polling-delay = <1000>;
> +			sustainable-power = <6500>;
> +
> +			thermal-sensors = <&tempsensor 0>;

You may want to also add here:
			coefficients = <1951  -922>;

Those will be populated in your tz->tzp->slope and tz->tz->offset.
Then you can read the already parsed data in your driver
in your .get_temp() callback, for example.

Can you please check if the above works for you?


BR,

Eduardo
