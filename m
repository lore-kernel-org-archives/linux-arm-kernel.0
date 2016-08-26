From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 26 Aug 2016 10:55:02 -0700
Subject: [PATCH v3 1/2] ARM: dts: Add MDM9615 dtsi
In-Reply-To: <1471951850-29842-2-git-send-email-narmstrong@baylibre.com>
References: <1471951850-29842-1-git-send-email-narmstrong@baylibre.com>
 <1471951850-29842-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160826175502.GY19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23, Neil Armstrong wrote:
> diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> new file mode 100644
> index 0000000..e30bfbd
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> +/ {
> +	model = "Qualcomm MDM9615";
> +	compatible = "qcom,mdm9615";
> +	interrupt-parent = <&intc>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a5";
> +			device_type = "cpu";
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	cpu-pmu {
> +		compatible = "arm,cortex-a5-pmu";
> +		interrupts = <GIC_SPI 10 0x304>;

Should be 0x104? Or GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH?

> +	};
> +
> +	clocks {
> +		cxo_board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +	};
> +
> +	regulators {

This doesn't need to be a simple bus? so that the child devices
probe? That's good if so.

> +		vsdcc_fixed: vsdcc-regulator {
> +			compatible = "regulator-fixed";
> +			regulator-name = "SDCC Power";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <2700000>;
> +			regulator-always-on;
> +		};
> +	};
> +
> +	soc: soc {
[...]
> +		L2: l2-cache {

Missing unit address.

> +			compatible = "arm,pl310-cache";
> +			reg = <0x02040000 0x1000>;
> +			arm,data-latency = <2 2 0>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
[..]
> +
> +		qcom,ssbi at 500000 {
> +			compatible = "qcom,ssbi";
> +			reg = <0x500000 0x1000>;
> +			qcom,controller-type = "pmic-arbiter";
> +
> +			pmicintc: pmic at 0 {
> +				compatible = "qcom,pm8018", "qcom,pm8921";
> +				interrupts = <GIC_PPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +				#interrupt-cells = <2>;
> +				interrupt-controller;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				pwrkey at 1c {
> +					compatible = "qcom,pm8018-pwrkey", "qcom,pm8921-pwrkey";
> +					reg = <0x1c>;
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <50 IRQ_TYPE_NONE>,
> +						     <51 IRQ_TYPE_NONE>;

IRQ_TYPE_EDGE_RISING?

> +					debounce = <15625>;
> +					pull-up;
> +				};
> +
> +				pmicmpp: mpp at 50 {
> +					compatible = "qcom,pm8018-mpp", "qcom,ssbi-mpp";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <24 IRQ_TYPE_NONE>,
> +						     <25 IRQ_TYPE_NONE>,
> +						     <26 IRQ_TYPE_NONE>,
> +						     <27 IRQ_TYPE_NONE>,
> +						     <28 IRQ_TYPE_NONE>,
> +						     <29 IRQ_TYPE_NONE>;

These are right though.

> +					reg = <0x50>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +				};
> +
> +				rtc at 11d {
> +					compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <39 IRQ_TYPE_NONE>;

IRQ_TYPE_EDGE_RISING?

> +					reg = <0x11d>;
> +					allow-set-time;
> +				};
> +
> +				pmicgpio: gpio at 150 {
> +					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <24 IRQ_TYPE_NONE>,
> +						     <25 IRQ_TYPE_NONE>,
> +						     <26 IRQ_TYPE_NONE>,
> +						     <27 IRQ_TYPE_NONE>,
> +						     <28 IRQ_TYPE_NONE>,
> +						     <29 IRQ_TYPE_NONE>;

These are right though.

> +					gpio-controller;
> +					#gpio-cells = <2>;
> +				};
> +			};
> +		};
> +
> +		rpm: rpm at 108000 {
> +			compatible = "qcom,rpm-mdm9615";
> +			reg = <0x108000 0x1000>;
> +
> +			qcom,ipc = <&l2cc 0x8 2>;
> +
> +			interrupts = <0 19 0>, <0 21 0>, <0 22 0>;

IRQ_TYPE_EDGE_RISING and GIC_SPI?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
