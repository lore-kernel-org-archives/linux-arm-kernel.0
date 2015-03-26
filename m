From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Mar 2015 08:26:17 +0000
Subject: [PATCH v10 1/2] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1424431168-25157-2-git-send-email-wens@csie.org>
References: <1424431168-25157-1-git-send-email-wens@csie.org>
 <1424431168-25157-2-git-send-email-wens@csie.org>
Message-ID: <20150326082617.GB5951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Feb 2015, Chen-Yu Tsai wrote:

> From: Carlo Caione <carlo@caione.org>
> 
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> [wens at csie.org: clarify interrupt source for the axp PMIC]
> [wens at csie.org: explain dcdc-workmode in detail and trim lines to 80 chars]
> [wens at csie.org: make regulator supplies optional if using unregulated input]
> [wens at csie.org: use cubieboard2 regulator nodes as example]
> [wens at csie.org: x-powers,dcdc-workmode default changed to 'current hardware
>                 setting']
> [wens at csie.org: reorganized regulator related properties into separate
>                 section.]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 000000000000..98685f291a72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,96 @@
> +AXP202/AXP209 device tree bindings
> +
> +The axp20x family current members :
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible: "x-powers,axp202" or "x-powers,axp209"
> +- reg: The I2C slave address for the AXP chip
> +- interrupt-parent: The parent interrupt controller
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> +- interrupt-controller: axp20x has its own internal IRQs
> +- #interrupt-cells: Should be set to 1
> +
> +Optional properties:
> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> +		      (range: 750-1875). Default: 1.5MHz
> +- <input>-supply: a phandle to the regulator supply node. May be omitted if
> +		  inputs are unregulated, such as using the IPSOUT output
> +		  from the PMIC.
> +
> +- regulators: A node that houses a sub-node for each regulator. Regulators
> +	      not used but preferred to be managed by the OS should be
> +	      listed as well.
> +	      See Documentation/devicetree/bindings/regulator/regulator.txt
> +	      for more information on standard regulator bindings.
> +
> +Optional properties for DCDC regulators:
> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
> +			  Default: Current hardware setting
> +			  The DCDC regulators work in a mixed PWM/PFM mode,
> +			  using PFM under light loads and switching to PWM
> +			  for heavier loads. Forcing PWM mode trades efficiency
> +			  under light loads for lower output noise. This
> +			  probably makes sense for HiFi audio related
> +			  applications that aren't battery constrained.
> +
> +
> +AXP202/AXP209 regulators, type, and corresponding input supply names:
> +
> +Regulator	  Type		  Supply Name		  Notes
> +---------	  ----		  -----------		  -----
> +DCDC2		: DC-DC buck	: vin2-supply
> +DCDC3		: DC-DC	buck	: vin3-supply
> +LDO1		: LDO		: acin-supply		: always on
> +LDO2		: LDO		: ldo24in-supply	: shared supply
> +LDO3		: LDO		: ldo3in-supply
> +LDO4		: LDO		: ldo24in-supply	: shared supply
> +LDO5		: LDO		: ldo5in-supply
> +
> +Example:
> +
> +axp209: pmic at 34 {
> +	compatible = "x-powers,axp209";
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq = <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-name = "vdd-cpu";
> +		};
> +
> +		vdd_int_dll: dcdc3 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-name = "vdd-int-dll";
> +		};
> +
> +		vdd_rtc: ldo1 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-name = "vdd-rtc";
> +		};
> +
> +		avcc: ldo2 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-name = "avcc";
> +		};
> +
> +		ldo3 {
> +			/* unused but preferred to be managed by OS */
> +		};
> +	};
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
