From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 09 Sep 2014 13:22:57 +0200
Subject: [PATCH] ARM: dts: Add rk808 PMIC to rk3288-evb-rk808
In-Reply-To: <1409074123-17449-1-git-send-email-dianders@chromium.org>
References: <1409074123-17449-1-git-send-email-dianders@chromium.org>
Message-ID: <23122191.L4GLoISGbk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. August 2014, 10:28:43 schrieb Doug Anderson:
> This adds initial support.  For now, regulators are always on and we
> don't specify the input supply for all of the regulators.

The basic rk808 mfd including the bindings got accepted, so

Added to v3.18-next/dts branch with the small modification described below

> 
> Signed-off-by: huang lin <hl@rock-chips.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> This patch is based on Chris's WIP rk808 series.
> 
>  arch/arm/boot/dts/rk3288-evb-rk808.dts | 131
> +++++++++++++++++++++++++++++++++ 1 file changed, 131 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts
> b/arch/arm/boot/dts/rk3288-evb-rk808.dts index 9a88b6c..513c88e 100644
> --- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
> +++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> @@ -16,3 +16,134 @@
>  / {
>  	compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
>  };
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rk808: pmic at 1b {
> +		compatible = "rockchip,rk808";
> +		clock-output-names = "xin32k", "rk808-clkout2";

I moved the clock-output-names below the #clock-cells and the reg from below 
to here.



> +		interrupt-parent = <&gpio0>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		reg = <0x1b>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +
> +		vcc8-supply = <&vcc_18>;
> +		vcc9-supply = <&vcc_io>;
> +		vcc10-supply = <&vcc_io>;
> +		vcc12-supply = <&vcc_io>;
> +		vddio-supply = <&vccio_pmu>;
> +
> +		regulators {
> +			vdd_cpu: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-name = "vdd_arm";
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1250000>;
> +				regulator-name = "vdd_gpu";
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_ddr";
> +			};
> +
> +			vcc_io: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_io";
> +			};
> +
> +			vccio_pmu: LDO_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_pmu";
> +			};
> +
> +			vcc_tp: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_tp";
> +			};
> +
> +			vdd_10: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-name = "vdd_10";
> +			};
> +
> +			vcc18_lcd: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc18_lcd";
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd";
> +			};
> +
> +			vdd10_lcd: LDO_REG6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-name = "vdd10_lcd";
> +			};
> +
> +			vcc_18: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_18";
> +			};
> +
> +			vcca_codec: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcca_codec";
> +			};
> +
> +			vcc_wl: SWITCH_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_wl";
> +			};
> +
> +			vcc_lcd: SWITCH_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_lcd";
> +			};
> +		};
> +	};
> +};
