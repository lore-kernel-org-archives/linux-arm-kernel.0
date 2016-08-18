From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 11:08:40 -0700
Subject: [PATCH v2 1/2] ARM: dts: Add MDM9615 dtsi
In-Reply-To: <1471525661-2563-2-git-send-email-narmstrong@baylibre.com>
References: <1471525661-2563-1-git-send-email-narmstrong@baylibre.com>
 <1471525661-2563-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160818180840.GE361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Neil Armstrong wrote:
> +
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-mdm9615.h>
> +#include <dt-bindings/reset/qcom,gcc-mdm9615.h>
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +#include <dt-bindings/soc/qcom,gsbi.h>
> +
> +/ {
> +	model = "Qualcomm MDM9615";
> +	compatible = "qcom,mdm9615";
> +	interrupt-parent = <&intc>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 14 0x304>;

What's this interrupt for? 0x304 seems wrong as well, because 0x3
would mean two CPUs and this is a SPI and not a PPI?

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
> +	};
> +
> +	clocks {
> +		cxo_board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "cxo_board";

This is unnecessary as it's the same name as the node name.

> +		};
> +	};
> +
> +	soc: soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +		L2: l2-cache {
> +			compatible = "arm,pl310-cache";
> +			reg = <0x02040000 0x1000>;
> +			arm,data-latency = <2 2 0>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		intc: interrupt-controller at 2000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x02000000 0x1000>,
> +			      <0x02002000 0x1000>;
> +		};
> +
> +		timer at 200a000 {
> +			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			interrupts = <GIC_PPI 1 0x301>,
> +				     <GIC_PPI 2 0x301>,
> +				     <GIC_PPI 3 0x301>;

0x101 for all those flags?

> +			reg = <0x0200a000 0x100>;
> +			clock-frequency = <27000000>,
> +					  <32768>;
> +			cpu-offset = <0x80000>;
> +		};
> +
> +		msmgpio: pinctrl at 800000 {
> +			compatible = "qcom,mdm9615-pinctrl", "syscon";

What's the syscon for?

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x800000 0x4000>;
> +		};
> +
> +		gcc: clock-controller at 900000 {
> +			compatible = "qcom,gcc-mdm9615";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			reg = <0x900000 0x4000>;
> +		};
> +
> +		lcc: clock-controller at 28000000 {
> +			compatible = "qcom,lcc-mdm9615";
> +			reg = <0x28000000 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		l2cc: clock-controller at 2011000 {
> +			compatible = "syscon";
> +			reg = <0x02011000 0x1000>;
> +		};
> +
> +		rng at 1a500000 {
> +			compatible = "qcom,prng";
> +			reg = <0x1a500000 0x200>;
> +			clocks = <&gcc PRNG_CLK>;
> +			clock-names = "core";
> +			assigned-clocks = <&gcc PRNG_CLK>;
> +			assigned-clock-rates = <32000000>;
> +		};
> +
> +		vsdcc_fixed: vsdcc-regulator {
> +			compatible = "regulator-fixed";
> +			regulator-name = "SDCC Power";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <2700000>;
> +			regulator-always-on;
> +		};

This should go into the root under a "regulators" node.

> +
> +		gsbi2: gsbi at 16100000 {
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <2>;
> +			reg = <0x16100000 0x100>;
> +			clocks = <&gcc GSBI2_H_CLK>;
> +			clock-names = "iface";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			gsbi2_i2c: i2c at 16180000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x16180000 0x1000>;
> +				interrupts = <GIC_SPI 149 IRQ_TYPE_NONE>;

There should be a trigger type... high perhaps?

> +
> +				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +		};
> +
> +		gsbi3: gsbi at 16200000 {
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <3>;
> +			reg = <0x16200000 0x100>;
> +			clocks = <&gcc GSBI3_H_CLK>;
> +			clock-names = "iface";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			gsbi3_spi: spi at 16280000 {
> +				compatible = "qcom,spi-qup-v1.1.1";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x16280000 0x1000>;
> +				interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
> +				spi-max-frequency = <24000000>;
> +
> +				clocks = <&gcc GSBI3_QUP_CLK>, <&gcc GSBI3_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +		};
> +
> +		gsbi4: gsbi at 16300000 {
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <4>;
> +			reg = <0x16300000 0x100>;
> +			clocks = <&gcc GSBI4_H_CLK>;
> +			clock-names = "iface";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi4_serial: serial at 16340000 {
> +				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> +				reg = <0x16340000 0x1000>,
> +				      <0x16300000 0x1000>;
> +				interrupts = <GIC_SPI 152 IRQ_TYPE_NONE>;
> +				clocks = <&gcc GSBI4_UART_CLK>, <&gcc GSBI4_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +		};
> +
> +		gsbi5: gsbi at 16400000 {
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <5>;
> +			reg = <0x16400000 0x100>;
> +			clocks = <&gcc GSBI5_H_CLK>;
> +			clock-names = "iface";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi5_i2c: i2c at 16480000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x16480000 0x1000>;
> +				interrupts = <GIC_SPI 155 IRQ_TYPE_NONE>;
> +
> +				/* QUP clock is not initialized, set rate */
> +				assigned-clocks = <&gcc GSBI5_QUP_CLK>;
> +				assigned-clock-rates = <24000000>;
> +
> +				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +
> +			gsbi5_serial: serial at 16440000 {
> +				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> +				reg = <0x16440000 0x1000>,
> +				      <0x16400000 0x1000>;
> +				interrupts = <GIC_SPI 154 IRQ_TYPE_NONE>;
> +				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +		};
> +
> +		qcom,ssbi at 500000 {
> +			compatible = "qcom,ssbi";
> +			reg = <0x500000 0x1000>;
> +			qcom,controller-type = "pmic-arbiter";
> +
> +			pmicintc: pmic at 0 {
> +				compatible = "qcom,pm8018", "qcom,pm8921";

I know that DT specifies most specific compatible first, but when
the generic compatible is part number specific as well it never
feels right to me. I guess I'll have to get over this.

> +				interrupts = <GIC_PPI 226 IRQ_TYPE_NONE>;
> +				#interrupt-cells = <2>;
> +				interrupt-controller;
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Can we have interrupt-parent = <&pmicintc> here instead of in
every node?

> +
> +				pwrkey at 1c {
> +					compatible = "qcom,pm8018-pwrkey", "qcom,pm8921-pwrkey";
> +					reg = <0x1c>;
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
> +						     <51 IRQ_TYPE_EDGE_RISING>;
> +					debounce = <15625>;
> +					pull-up;
> +				};
> +
> +				pmicmpp: mpp at 50 {
> +					compatible = "qcom,pm8018-mpp";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <24 IRQ_TYPE_EDGE_RISING>,
> +						     <25 IRQ_TYPE_EDGE_RISING>,
> +						     <26 IRQ_TYPE_EDGE_RISING>,
> +						     <27 IRQ_TYPE_EDGE_RISING>,
> +						     <28 IRQ_TYPE_EDGE_RISING>,
> +						     <29 IRQ_TYPE_EDGE_RISING>;

We've recently been reminded that these should all be IRQ_TYPE_NONE. Also add the qcom,ssbi-mpp compatible please.

> +					reg = <0x50>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +				};
> +
> +				rtc at 11d {
> +					compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
> +					reg = <0x11d>;
> +					allow-set-time;
> +				};
> +
> +				pmicgpio: gpio at 150 {
> +					compatible = "qcom,pm8018-gpio";
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <24 IRQ_TYPE_EDGE_RISING>,
> +						     <25 IRQ_TYPE_EDGE_RISING>,
> +						     <26 IRQ_TYPE_EDGE_RISING>,
> +						     <27 IRQ_TYPE_EDGE_RISING>,
> +						     <28 IRQ_TYPE_EDGE_RISING>,
> +						     <29 IRQ_TYPE_EDGE_RISING>;

Same IRQ_TYPE_NONE comment. Also, add the qcom,ssbi-gpio
compatible please.

> +					gpio-controller;
> +					#gpio-cells = <2>;
> +				};
> +			};
> +		};
> +
> +		sdcc1bam:dma at 12182000{

Add some space here:

		sdcc1bam: dma at 12180000 {

> +			compatible = "qcom,bam-v1.3.0";
> +			reg = <0x12182000 0x8000>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_NONE>;
> +			clocks = <&gcc SDC1_H_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +
> +		sdcc2bam:dma at 12142000{

ditto.

> +			compatible = "qcom,bam-v1.3.0";
> +			reg = <0x12142000 0x8000>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_NONE>;

There should really be some flags.

> +			clocks = <&gcc SDC2_H_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
