From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun, 01 Mar 2015 15:27:12 +0800
Subject: [PATCH 2/2] ARM: dts: add rk3288 PopMetal board
In-Reply-To: <3994534.hxJhVQddEv@diego>
References: <1425034505-25163-1-git-send-email-andy.yan@rock-chips.com>
 <1425034983-25291-1-git-send-email-andy.yan@rock-chips.com>
 <3994534.hxJhVQddEv@diego>
Message-ID: <54F2BF50.80307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:

On 2015?03?01? 01:57, Heiko St?bner wrote:
> Hi Andy,
>
> Am Freitag, 27. Februar 2015, 19:03:03 schrieb Andy Yan:
>> PopMetal is a rockchip rk3288 based board made by ChipSpark,
>> which has many interface such as VGA,HDMI,usb,ir,sdcad and
>> lots of sensors such as gyroscope(L3G4200D),accelerometer(mma8452),
>> compass(AK8963C).
>>
>> This patch add a basic support for this board, which make the board
>> boot into a initramfs shell with sdcard and all sensors enabled
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   arch/arm/boot/dts/rk3288-popmetal.dts | 396
>> ++++++++++++++++++++++++++++++++++ 1 file changed, 396 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/rk3288-popmetal.dts
>>
>> diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts
>> b/arch/arm/boot/dts/rk3288-popmetal.dts new file mode 100644
>> index 0000000..f0c0cd9
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3288-popmetal.dts
>> @@ -0,0 +1,396 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
> could you please put the new file under a gpl2+x11 dual license?
> See the firefly dts files for an example.
>
> Relicensing the of the already existing files is somewhere on my todo list, but
> but at least we shouldn't introduce new restricted files at this point :-) .
>
>
> Licensing with a more permissible license is necessary so that other projects
> can use our dts files too (like the BSDs) and the gpl2 + x11 dual license is
> the current agreed upon combination.
     ok, I will use gpl2+x11 dual license
>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "rk3288.dtsi"
>> +
>> +/ {
>> +	model = "PopMetal-RK3288";
>> +	compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> a blank line here please
    ok
>
>> +	memory{
>> +		reg = <0 0x80000000>;
>> +	};
>> +
>> +	ext_gmac: external-gmac-clock {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "ext_gmac";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		autorepeat;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pwrbtn>;
>> +
>> +		button at 0 {
>> +			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>> +			linux,code = <116>;
>> +			label = "GPIO Key Power";
>> +			linux,input-type = <1>;
>> +			gpio-key,wakeup = <1>;
>> +			debounce-interval = <100>;
>> +		};
>> +	};
>> +
>> +	ir: ir-receiver {
>> +		compatible = "gpio-ir-receiver";
>> +		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&ir_int>;
>> +	};
>> +
>> +};
>> +
>> +&emmc {
>> +	broken-cd;
>> +	bus-width = <8>;
>> +	cap-mmc-highspeed;
>> +	disable-wp;
>> +	non-removable;
>> +	num-slots = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
>> +	status = "okay";
>> +};
>> +
>> +&sdmmc {
>> +	bus-width = <4>;
>> +	cap-mmc-highspeed;
>> +	cap-sd-highspeed;
>> +	card-detect-delay = <200>;
>> +	disable-wp;                     /* wp not hooked up */
>> +	num-slots = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>> +	status = "okay";
>> +};
>> +
>> +&gmac {
>> +	phy-supply = <&vcc_lan>;
>> +	phy-mode = "rgmii";
>> +	clock_in_out = "input";
>> +	snps,reset-gpio = <&gpio4 7 0>;
>> +	snps,reset-active-low;
>> +	snps,reset-delays-us = <0 10000 1000000>;
>> +	assigned-clocks = <&cru SCLK_MAC>;
>> +	assigned-clock-parents = <&ext_gmac>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&rgmii_pins>;
>> +	tx_delay = <0x30>;
>> +	rx_delay = <0x10>;
>> +	status = "ok";
>> +};
>> +
>> +&hdmi {
>> +	ddc-i2c-bus = <&i2c5>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>> +
>> +	rk808: pmic at 1b {
>> +		compatible = "rockchip,rk808";
>> +		reg = <0x1b>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_int &global_pwroff>;
>> +		rockchip,system-power-controller;
>> +		wakeup-source;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "xin32k", "rk808-clkout2";
>> +
>> +		vcc8-supply = <&vcc_18>;
>> +		vcc9-supply = <&vcc_io>;
>> +		vcc10-supply = <&vcc_io>;
>> +		vcc12-supply = <&vcc_io>;
>> +
>> +		regulators {
>> +			vdd_cpu: DCDC_REG1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-name = "vdd_arm";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_gpu: DCDC_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <1250000>;
>> +				regulator-name = "vdd_gpu";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1000000>;
>> +				};
>> +			};
>> +
>> +			vcc_ddr: DCDC_REG3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vcc_ddr";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_io: DCDC_REG4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc_io";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vcc_lan: LDO_REG1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc_lan";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vccio_sd: LDO_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vccio_sd";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_10: LDO_REG3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-name = "vdd_10";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1000000>;
>> +				};
>> +			};
>> +
>> +			vcc18_lcd: LDO_REG4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcc18_lcd";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			ldo5: LDO_REG5 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "ldo5";
>> +			};
>> +
>> +			vdd10_lcd: LDO_REG6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-name = "vdd10_lcd";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1000000>;
>> +				};
>> +			};
>> +
>> +			vcc_18: LDO_REG7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcc_18";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vcca_codec: LDO_REG8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcca_codec";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vcc_wl: SWITCH_REG1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vcc_wl";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_lcd: SWITCH_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vcc_lcd";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
> only for my peace of mind, does the board wake again from suspend with these
> rk808 settings? I.e. while I my rk3288-evb-rk808 wakes sucessfully, I haven't
> been able to wake an act8846 based board (firefly) yet.
    I have not check suspend and wake up yet, I will test it and check 
with Chris Zhong later
>
>> +		};
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>> +
>> +	ak8963: ak8963 at 0d {
>> +		compatible = "asahi-kasei,ak8975";
>> +		reg = <0x0d>;
>> +		interrupt-parent = <&gpio8>;
>> +		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&comp_int>;
>> +	};
>> +
>> +	l3g4200d: l3g4200d at 68 {
>> +		compatible = "st,l3g4200d-gyro";
>> +		st,drdy-int-pin = <2>;
>> +		reg = <0x6b>;
>> +	};
>> +
>> +	mma8452: mma8452 at 1d {
>> +		compatible = "fsl,mma8452";
>> +		reg = <0x1d>;
>> +		interrupt-parent = <&gpio8>;
>> +		interrupts = <0 IRQ_TYPE_EDGE_RISING>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&gsensor_int>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +	status = "okay";
>> +};
>> +
>> +&pinctrl {
>> +	buttons {
>> +	pwrbtn: pwrbtn {
>> +		rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
> pwrbtn needs one indentation more.
>
> Also please sort alphabetically ... "ak8963" before "buttons"
>
   OK, this will be fix in V2
>> +	};
>> +
>> +	ak8963 {
>> +		comp_int: comp-int {
>> +			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	ir {
>> +		ir_int: ir-int {
>> +			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	mma8452 {
>> +		gsensor_int: gsensor-int {
>> +			rockchip,pins = <8 0 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	pmic {
>> +		pmic_int: pmic-int {
>> +			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +};
>> +
>> +&vopb {
>> +	status = "okay";
>> +};
>> +
>> +&vopb_mmu {
>> +	status = "okay";
>> +};
>> +
>> +&vopl {
>> +	status = "okay";
>> +};
>> +
>> +&vopl_mmu {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	status = "okay";
>> +};
> in general looks good. Because of the license issue I need you to submit a v2,
> otherwise I could have fixed the small nitpicks myself.
>
   Thanks very much for your review, I will fix all of them in V2
> Heiko
>
>
>
