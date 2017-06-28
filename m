From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 28 Jun 2017 12:40:01 +0200
Subject: [PATCH 4/4] arm64: dts: add RK3399-Q7 (Puma) SoM
In-Reply-To: <2336478.rsaXP0O2Er@diego>
References: <20170626191854.58253-1-klaus.goger@theobroma-systems.com>
 <20170626191854.58253-5-klaus.goger@theobroma-systems.com>
 <2336478.rsaXP0O2Er@diego>
Message-ID: <3F2C0996-F298-4628-BCF3-DE721F3B818D@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 28 Jun 2017, at 12:26, Heiko St?bner <heiko@sntech.de> wrote:
> 
> Hi Klaus,
> 
> [added Kever from Rockchip concerning the cluster1-opps below]
> 
> 
> Am Montag, 26. Juni 2017, 21:18:54 CEST schrieb Klaus Goger:
>> The RK3399-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
>> connector) system-on-module from Theobroma Systems, featuring the
>> Rockchip RK3399.
>> 
>> It provides the following feature set:
>> * up to 4GB DDR3
>> * on-module SPI-NOR flash
>> * on-module eMMC (with 8-bit 1.8V interface)
>> * SD card (on a baseboad) via edge connector
>> * Gigabit Ethernet with on-module Micrel KSZ9031 GbE PHY
>> * HDMI/eDP/2x MIPI-DSI
>> * 2x MIPI-CSI
>> * USB
>>   - 1x USB 3.0 dual-role (direct connection)
>>   - 2x USB 3.0 host + 1x USB 2.0 (on-module USB 3.0 hub)
>> * on-module STM32 Cortex-M0 companion controller, implementing:
>>   - low-power RTC functionality (ISL1208 emulation)
>>   - fan controller (AMC6821 emulation)
>>   - USB<->CAN bridge controller
>> 
>> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
>> 
>> ---
> 
> [...]
> 
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +
>> +		module_led {
> 
> phandles use underscores, node names are supposed to use dashes "-"
> 
>> +			label = "module_led";
>> +			gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			panic-indicator;
>> +		};
>> +
>> +		sd_card_led {
>> +			label = "sd_card_led";
>> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "mmc0";
>> +		};
>> +	};
>> +
>> +	cluster1_opp: opp-table1 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <800000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp01 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <800000>;
>> +		};
>> +		opp02 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <830000>;
> 
> this is 5mV higher than the "official" OPPs used by Rockchip, so
> I'd like to know its background :-) . Especially as I really would like
> to keep the number of per-board OPPs minimal.

The on-board regulators differ and can?t hit the voltages specified
in the original OPP table? this is the next closest value we can
set and is at least what Rockchip uses in the ref-design.

> So does this make the board run more stable or something else?
> And might this be applicable for all "standard" rk3399 boards?
> Especially as other OPPs in your list use the regular voltages.

It avoids ugly issues with OPPs being deactivated due to the the
exact voltage used in the ?official? OPPs not being supported by
our regulator.

We decided against reusing the original OPP table and modifying it
(to use ranges) as that was likely to cause even more harm in the
long term.

>> +			opp-suspend;
>> +		};
>> +		opp03 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <880000>;
> 
> same as above
> 
>> +		};
>> +		opp04 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <950000>;
>> +		};
>> +		opp05 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <1030000>;
> 
> same as above
> 
>> +		};
>> +		opp06 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <1100000>;
>> +		};
>> +		opp07 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <1200000>;
>> +		};
>> +		opp08 {
>> +			opp-hz = /bits/ 64 <1992000000>;
>> +			opp-microvolt = <1230000>;
>> +			turbo-mode;
> 
> Is this part of the soc-spec or more like wishful thinking? :-)
> Again with the question in mind if this applies to all rk3399.

Tested in our lab on a decent population of boards using various
forms of stress-testing (incl. a 6-way and 8-way SPEC).

This one is marked ?turbo-mode? as we do recommend to only
enable it if a (Qseven-style) heat-sink is mounted.

>> +		};
>> +	};
>> +
>> +	clkin_gmac: external-gmac-clock {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "clkin_gmac";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	vcc3v3_sys: vcc3v3-sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	vcc5v0_otg: vcc5v0-otg-regulator {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&otg_vbus_drv>;
> 
> gpio pinctrl names should generally follow the pin names
> in schematics. For example on the rk3399-firefly it also
> had a pinctrl named host_vbus_drv while the pin in the
> schematics was named vcc5v0_host_en.
> 
> Following the schematic names makes it easier in the
> long run to find and fix things as they occur.
> 
> This of course applies to all gpio-pinctrls in this dts.
> 
> 
>> +		regulator-name = "vcc5v0_otg";
>> +		regulator-always-on;
>> +	};
>> +
>> +	vcc5v0_host: vcc5v0-host-regulator {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc5v0_host_en>;
>> +		regulator-name = "vcc5v0_host";
>> +		vin-supply = <&vcc5v0_sys>;
>> +	};
>> +
>> +	vcc5v0_sys: vcc5v0-sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +
>> +	vcc_phy: vcc-phy-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc_phy";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
> 
> This looks suspiciously copy-pasted from a vendor devicetree.
> The firefly used a similar "nonsense"-regulator which I fixed
> together with other regulators in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=12335ebaac8639a2745245e5d179f44f3c70fed1
> 
> Similar to other regulators above, which also follow naming I fixed
> on the firefly. Regulators should generally follow the schematics
> in their naming and also hierarchy.
> 
> (debugsfs/regulator/regulator_summary shows a nice graph of them)
> 
> This of course applies to all defined regulators.
> 
> If your regulator setup actually follows your own schematics then
> nevermind this comment ;-) .
> 
> 
>> +
>> +	vdd_log: vdd-log {
>> +		compatible = "pwm-regulator";
>> +		pwms = <&pwm2 0 25000 0>;
>> +		regulator-name = "vdd_log";
>> +		regulator-min-microvolt = <800000>;
>> +		regulator-max-microvolt = <1400000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		status = "okay";
>> +	};
>> +};
> 
>> +&i2c0 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <168>;
>> +	i2c-scl-falling-time-ns = <4>;
>> +	clock-frequency = <400000>;
>> +
>> +	vdd_gpu: fan535555 at 60 {
> 
> vdd_gpu: regulator at 60 {
> 
> node names should be generic (aka device category)
> 
>> +		compatible = "fcs,fan53555";
>> +		reg = <0x60>;
>> +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> 
> not part of the binding right now. While it may be nice to teach
> the fan53555 to handle the vsel gpio if it is controllable [similar to
> how the rk808 can do this], this hasn't been implemented yet.
> 
> Also applies to vdd_cpu_b below.
> 
> 
>> +		vin-supply = <&vcc5v0_sys>;
>> +		regulator-compatible = "fan53555-reg";
> 
> deprecated property and not really needed.
> 
> 
>> +		regulator-name = "vdd_gpu";
>> +		regulator-min-microvolt = <600000>;
>> +		regulator-max-microvolt = <1230000>;
>> +		regulator-ramp-delay = <1000>;
>> +		fcs,suspend-voltage-selector = <1>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +};
> 
> 
> [...]
> 
>> +&pcie0 {
>> +	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
>> +	num-lanes = <4>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_clkreqn>;
>> +	status = "okay";
> 
> vpcie{3v3, 1v8, 0v9}-supply properties? 
> 
> 
>> +};
>> +
> 
> [...]
> 
>> +&sdmmc {
>> +	clock-frequency = <150000000>;
>> +	bus-width = <4>;
>> +	cap-mmc-highspeed;
>> +	cap-sd-highspeed;
>> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>> +	wp-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
>> +	num-slots = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_gpio &sdmmc_bus4>;
>> +	status = "okay";
>> +};
>> +
>> +
> 
> double empty line
> 
> 
>> +&spi1 {
>> +	status = "okay";
>> +
>> +	flash: norflash at 0 {
> 
> norflash: flash at 0 maybe?
> 
> You reference the phandle and at the position it gets referenced
> the specific name might be more helpful.
> 
> 
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <50000000>;
>> +	};
>> +};
> 
> 
> 
>> +&pinctrl {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&puma_pin_hog>;
>> +
>> +	hog {
>> +			puma_pin_hog: puma_pin_hog {
> 
> puma_pin_hog: puma-pin-hog
> 
> Same for more defined pinctrl nodes below that.
> 
> 
> Heiko
