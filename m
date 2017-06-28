From: klaus.goger@theobroma-systems.com (Klaus Goger)
Date: Wed, 28 Jun 2017 16:01:29 +0200
Subject: [PATCH 4/4] arm64: dts: add RK3399-Q7 (Puma) SoM
In-Reply-To: <db92a83b-a80b-6c9f-76dc-646d9155bc20@rock-chips.com>
References: <20170626191854.58253-1-klaus.goger@theobroma-systems.com>
 <20170626191854.58253-5-klaus.goger@theobroma-systems.com>
 <2336478.rsaXP0O2Er@diego>
 <db92a83b-a80b-6c9f-76dc-646d9155bc20@rock-chips.com>
Message-ID: <8378C275-0F65-4B91-A9B8-23E78799F7E5@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> On 28 Jun 2017, at 14:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> 
> Hi
> 
> On 2017/6/28 18:26, Heiko St?bner wrote:
>> Hi Klaus,
>> 
>> [added Kever from Rockchip concerning the cluster1-opps below]
>> 
>> 
>> Am Montag, 26. Juni 2017, 21:18:54 CEST schrieb Klaus Goger:
>>> The RK3399-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
>>> connector) system-on-module from Theobroma Systems, featuring the
>>> Rockchip RK3399.
>>> 
>>> It provides the following feature set:
>>> * up to 4GB DDR3
>>> * on-module SPI-NOR flash
>>> * on-module eMMC (with 8-bit 1.8V interface)
>>> * SD card (on a baseboad) via edge connector
>>> * Gigabit Ethernet with on-module Micrel KSZ9031 GbE PHY
>>> * HDMI/eDP/2x MIPI-DSI
>>> * 2x MIPI-CSI
>>> * USB
>>>   - 1x USB 3.0 dual-role (direct connection)
>>>   - 2x USB 3.0 host + 1x USB 2.0 (on-module USB 3.0 hub)
>>> * on-module STM32 Cortex-M0 companion controller, implementing:
>>>   - low-power RTC functionality (ISL1208 emulation)
>>>   - fan controller (AMC6821 emulation)
>>>   - USB<->CAN bridge controller
>>> 
> 
> I don't find these patches on patchwork of linux-rockchip?
> Anyway, there are some minor inline comment below.

The emails got rejected from lists.infradead.org due an issue in the return-path.
I have to reconfigure my mail setup for git send-mail before sending out a v2.

>>> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
>>> 
>>> ---
>> 
>> [...]
>> 
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +		pinctrl-names = "default";
>>> +
>>> +		module_led {
>> 
>> phandles use underscores, node names are supposed to use dashes "-"
>> 
>>> +			label = "module_led";
>>> +			gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "heartbeat";
>>> +			panic-indicator;
>>> +		};
>>> +
>>> +		sd_card_led {
>>> +			label = "sd_card_led";
>>> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "mmc0";
>>> +		};
>>> +	};
>>> +
>>> +	cluster1_opp: opp-table1 {
>>> +		compatible = "operating-points-v2";
>>> +		opp-shared;
>>> +
>>> +		opp00 {
>>> +			opp-hz = /bits/ 64 <408000000>;
>>> +			opp-microvolt = <800000>;
>>> +			clock-latency-ns = <40000>;
>>> +		};
>>> +		opp01 {
>>> +			opp-hz = /bits/ 64 <600000000>;
>>> +			opp-microvolt = <800000>;
>>> +		};
>>> +		opp02 {
>>> +			opp-hz = /bits/ 64 <816000000>;
>>> +			opp-microvolt = <830000>;
>> 
>> this is 5mV higher than the "official" OPPs used by Rockchip, so
>> I'd like to know its background :-) . Especially as I really would like
>> to keep the number of per-board OPPs minimal.
>> 
>> So does this make the board run more stable or something else?
>> And might this be applicable for all "standard" rk3399 boards?
>> Especially as other OPPs in your list use the regular voltages.
>> 
>> 
>>> +			opp-suspend;
>>> +		};
>>> +		opp03 {
>>> +			opp-hz = /bits/ 64 <1008000000>;
>>> +			opp-microvolt = <880000>;
>> 
>> same as above
>> 
>>> +		};
>>> +		opp04 {
>>> +			opp-hz = /bits/ 64 <1200000000>;
>>> +			opp-microvolt = <950000>;
>>> +		};
>>> +		opp05 {
>>> +			opp-hz = /bits/ 64 <1416000000>;
>>> +			opp-microvolt = <1030000>;
>> 
>> same as above
>> 
>>> +		};
>>> +		opp06 {
>>> +			opp-hz = /bits/ 64 <1608000000>;
>>> +			opp-microvolt = <1100000>;
>>> +		};
>>> +		opp07 {
>>> +			opp-hz = /bits/ 64 <1800000000>;
>>> +			opp-microvolt = <1200000>;
>>> +		};
>>> +		opp08 {
>>> +			opp-hz = /bits/ 64 <1992000000>;
>>> +			opp-microvolt = <1230000>;
>>> +			turbo-mode;
>> 
>> Is this part of the soc-spec or more like wishful thinking? :-)
>> Again with the question in mind if this applies to all rk3399.
>> 
>> 
>>> +		};
>>> +	};
>>> +
>>> +	clkin_gmac: external-gmac-clock {
>>> +		compatible = "fixed-clock";
>>> +		clock-frequency = <125000000>;
>>> +		clock-output-names = "clkin_gmac";
>>> +		#clock-cells = <0>;
>>> +	};
>>> +
>>> +	vcc3v3_sys: vcc3v3-sys {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc3v3_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	vcc5v0_otg: vcc5v0-otg-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		enable-active-high;
>>> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&otg_vbus_drv>;
>> 
>> gpio pinctrl names should generally follow the pin names
>> in schematics. For example on the rk3399-firefly it also
>> had a pinctrl named host_vbus_drv while the pin in the
>> schematics was named vcc5v0_host_en.
>> 
>> Following the schematic names makes it easier in the
>> long run to find and fix things as they occur.
>> 
>> This of course applies to all gpio-pinctrls in this dts.
>> 
>> 
>>> +		regulator-name = "vcc5v0_otg";
>>> +		regulator-always-on;
>>> +	};
>>> +
>>> +	vcc5v0_host: vcc5v0-host-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		enable-active-high;
>>> +		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&vcc5v0_host_en>;
>>> +		regulator-name = "vcc5v0_host";
>>> +		vin-supply = <&vcc5v0_sys>;
>>> +	};
>>> +
>>> +	vcc5v0_sys: vcc5v0-sys {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc5v0_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-max-microvolt = <5000000>;
>>> +	};
>>> +
>>> +	vcc_phy: vcc-phy-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc_phy";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +	};
>> 
>> This looks suspiciously copy-pasted from a vendor devicetree.
>> The firefly used a similar "nonsense"-regulator which I fixed
>> together with other regulators in
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=12335ebaac8639a2745245e5d179f44f3c70fed1
>> 
>> Similar to other regulators above, which also follow naming I fixed
>> on the firefly. Regulators should generally follow the schematics
>> in their naming and also hierarchy.
>> 
>> (debugsfs/regulator/regulator_summary shows a nice graph of them)
>> 
>> This of course applies to all defined regulators.
>> 
>> If your regulator setup actually follows your own schematics then
>> nevermind this comment ;-) .
>> 
>> 
>>> +
>>> +	vdd_log: vdd-log {
>>> +		compatible = "pwm-regulator";
>>> +		pwms = <&pwm2 0 25000 0>;
>>> +		regulator-name = "vdd_log";
>>> +		regulator-min-microvolt = <800000>;
>>> +		regulator-max-microvolt = <1400000>;
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		status = "okay";
>>> +	};
>>> +};
>> 
>>> +&i2c0 {
>>> +	status = "okay";
>>> +	i2c-scl-rising-time-ns = <168>;
>>> +	i2c-scl-falling-time-ns = <4>;
>>> +	clock-frequency = <400000>;
>>> +
>>> +	vdd_gpu: fan535555 at 60 {
>> 
>> vdd_gpu: regulator at 60 {
>> 
>> node names should be generic (aka device category)
>> 
>>> +		compatible = "fcs,fan53555";
>>> +		reg = <0x60>;
>>> +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
>> 
>> not part of the binding right now. While it may be nice to teach
>> the fan53555 to handle the vsel gpio if it is controllable [similar to
>> how the rk808 can do this], this hasn't been implemented yet.
>> 
>> Also applies to vdd_cpu_b below.
>> 
>> 
>>> +		vin-supply = <&vcc5v0_sys>;
>>> +		regulator-compatible = "fan53555-reg";
>> 
>> deprecated property and not really needed.
>> 
>> 
>>> +		regulator-name = "vdd_gpu";
>>> +		regulator-min-microvolt = <600000>;
>>> +		regulator-max-microvolt = <1230000>;
>>> +		regulator-ramp-delay = <1000>;
>>> +		fcs,suspend-voltage-selector = <1>;
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +};
>> 
>> 
>> [...]
>> 
>>> +&pcie0 {
>>> +	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
>>> +	num-lanes = <4>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie_clkreqn>;
>>> +	status = "okay";
>> 
>> vpcie{3v3, 1v8, 0v9}-supply properties?
> 
> These supply are optional which depend on the HW design.
> But pcie_clkreqn doesn't really work. I think we should
> use pcie_clkreqn_cpm instead and fix this for rk3399-evb.dts
> to prevent the further copy-n-paste.

I could add the supply properties but since they where optional and
are generated by dedicated always-on regulators supplied from the
also always on regulator vcc3v3_sys I didn?t see the need for it.
But if anyone to have a full model of the power tree visible in the
devicetree even if not controllable I can add it in v2.

Since the properties are optional maybe we should also change
the dev_info "no xxx regulator found? in pcie-rockchip.c to something
less severe sounding.

>>> +};
>>> +
>> 
>> [...]
>> 
>>> +&sdmmc {
>>> +	clock-frequency = <150000000>;
> 
> we deprecates this now, so please use max-frequency instead.
> 
>>> +	bus-width = <4>;
>>> +	cap-mmc-highspeed;
>>> +	cap-sd-highspeed;
>>> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> 
> Really this board use gpio-based card detect pin?
> 
>>> +	wp-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
>>> +	num-slots = <1>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_gpio &sdmmc_bus4>;
> 
> I guess you don't need sdmmc_gpio and let mmc core request
> this gpio as irq pin from parsing cd-gpios?

I tried to just use the PA7 as SDMMC0_DET but didn?t get any state changes when
removing it or pugging it in after bootup. I tried to follow the mmc code path to see
which of the 3 card detection modes get configured. It looked to me as the CDETECT
register gets used but this would not generate any interrupts and requires polling of the
register. So not using a a gpio card detect requires the broken-cd property for me.
If i overlooked something I?m happy to change it, I was planning to take a look at it later
anyways

> 
>>> +	status = "okay";
>>> +};
> 
> And I would be more happy here to see the present of vqmmc and vmmc
> supply if possible.

Since we are a SoM vmmc would be a property required to be provided from the baseboard
and not part of the module dts.
I will add vqmmc for the I/O voltage supplying APIO#

>>> +
>>> +
>> 
>> double empty line
>> 
>> 
>>> +&spi1 {
>>> +	status = "okay";
>>> +
>>> +	flash: norflash at 0 {
>> 
>> norflash: flash at 0 maybe?
>> 
>> You reference the phandle and at the position it gets referenced
>> the specific name might be more helpful.
>> 
>> 
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +		spi-max-frequency = <50000000>;
>>> +	};
>>> +};
>> 
>> 
>> 
>>> +&pinctrl {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&puma_pin_hog>;
>>> +
>>> +	hog {
>>> +			puma_pin_hog: puma_pin_hog {
>> 
>> puma_pin_hog: puma-pin-hog
>> 
>> Same for more defined pinctrl nodes below that.
>> 
>> 
>> Heiko
>> 
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>> 
> 
> 
> -- 
> Best Regards
> Shawn Lin
