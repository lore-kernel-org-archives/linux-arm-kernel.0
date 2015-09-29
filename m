From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 29 Sep 2015 09:10:49 -0300
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20150929091049.39ebc76c@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 29 Sep 2015 13:57:35 +0200
Javier Martinez Canillas <javier@osg.samsung.com> escreveu:

> There are 2 revisions of the Exynos5250 Snow Chromebook that were shipped:
> Rev4 and Rev5. The only difference between these 2 revisions is the codec,
> Rev4 has a max98095 codec while Rev5 has a max98090.
> 
> Mainline only supports Rev4 so this patch moves the common device nodes to
> a DTSI file and adds a DTS for the Exynos5250 Snow Rev5.
> 
> The Snow Rev5 DTS is based on the DTS found in the ChromiumOS 3.8 tree.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>


Tested-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Tested on my Chromebook snow revision 5, with the following its file:

/dts-v1/;

/ {
    description = "Chrome OS kernel image with one or more FDT blobs";
    #address-cells = <1>;
    images {
        kernel at 1{
	    description = "kernel";
            data = /incbin/("arch/arm/boot/zImage");
            type = "kernel_noload";
            arch = "arm";
            os = "linux";
            compression = "none";
            load = <0>;
            entry = <0>;
        };
        fdt at 1{
            description = "exynos5250-snow.dtb";
            data = /incbin/("arch/arm/boot/dts/exynos5250-snow.dtb");
            type = "flat_dt";
            arch = "arm";
            compression = "none";
            hash at 1{
                algo = "sha1";
            };
        };
        fdt at 2{
            description = "exynos5800-peach-pi.dtb";
            data = /incbin/("arch/arm/boot/dts/exynos5800-peach-pi.dtb");
            type = "flat_dt";
            arch = "arm";
            compression = "none";
            hash at 1{
                algo = "sha1";
            };
        };
        fdt at 3{
            description = "exynos5250-snow-rev5.dtb";
            data = /incbin/("arch/arm/boot/dts/exynos5250-snow-rev5.dtb");
            type = "flat_dt";
            arch = "arm";
            compression = "none";
            hash at 1{
                algo = "sha1";
            };
        };
    };
    configurations {
        default = "conf at 1";
        conf at 1{
            kernel = "kernel at 1";
            fdt = "fdt at 1";
        };
        conf at 2{
            kernel = "kernel at 1";
            fdt = "fdt at 2";
        };
        conf at 3{
            kernel = "kernel at 1";
            fdt = "fdt at 3";
        };
    };
};


After this patch, is is now properly detecting the audio chipset:

[    0.897587] max98090 7-0010: MAX98090 REVID=0x43
[    0.900135] max98090 7-0010: use default 2.8v micbias

> 
> ---
> 
> The DTS in the vendor ChromeOS tree are called exynos5250-snow-rev{4,5}.dtb
> but I decided to leave Rev4 as exynos5250-snow.dtb to avoid breaking u-boot
> that has CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow" in snow_defconfig.
> 
> Also, ChromiumOS Rev4 DTS has "google,snow-rev4" in its compatible string
> but was not added in mainline since Rev4 firmware fallbacks to "google,snow"
> and Rev5 searches for "google,snow-rev5". That way the compatible string
> could be consistent with the DTS naming and still be able to pack both Rev4
> and Rev5 FDT in the same FIT image and let the firmware pick the correct FDT.
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 684 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |  47 ++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 666 +------------------------
>  4 files changed, 733 insertions(+), 665 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5436ad479b08..a2408a63b341 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5250-arndale.dtb \
>  	exynos5250-smdk5250.dtb \
>  	exynos5250-snow.dtb \
> +	exynos5250-snow-rev5.dtb \
>  	exynos5250-spring.dtb \
>  	exynos5260-xyref5260.dtb \
>  	exynos5410-smdk5410.dtb \
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> new file mode 100644
> index 000000000000..0a7f408824d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -0,0 +1,684 @@
> +/*
> + * Google Snow board device tree source
> + *
> + * Copyright (c) 2012 Google, Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/maxim,max77686.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
> +#include "exynos5250.dtsi"
> +
> +/ {
> +	aliases {
> +		i2c104 = &i2c_104;
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x80000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=tty1";
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&power_key_irq &lid_irq>;
> +
> +		power {
> +			label = "Power";
> +			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			gpio-key,wakeup;
> +		};
> +
> +		lid-switch {
> +			label = "Lid";
> +			gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <5>; /* EV_SW */
> +			linux,code = <0>; /* SW_LID */
> +			debounce-interval = <1>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	vbat: vbat-fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbat-supply";
> +		regulator-boot-on;
> +	};
> +
> +	i2c-arbitrator {
> +		compatible = "i2c-arb-gpio-challenge";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c-parent = <&{/i2c@12CA0000}>;
> +
> +		our-claim-gpio = <&gpf0 3 GPIO_ACTIVE_LOW>;
> +		their-claim-gpios = <&gpe0 4 GPIO_ACTIVE_LOW>;
> +		slew-delay-us = <10>;
> +		wait-retry-us = <3000>;
> +		wait-free-us = <50000>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&arb_our_claim &arb_their_claim>;
> +
> +		/* Use ID 104 as a hint that we're on physical bus 4 */
> +		i2c_104: i2c at 0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			battery: sbs-battery at b {
> +				compatible = "sbs,sbs-battery";
> +				reg = <0xb>;
> +				sbs,poll-retry-count = <1>;
> +			};
> +
> +			cros_ec: embedded-controller {
> +				compatible = "google,cros-ec-i2c";
> +				reg = <0x1e>;
> +				interrupts = <6 IRQ_TYPE_NONE>;
> +				interrupt-parent = <&gpx1>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&ec_irq>;
> +				wakeup-source;
> +			};
> +
> +			power-regulator {
> +				compatible = "ti,tps65090";
> +				reg = <0x48>;
> +
> +				/*
> +				 * Config irq to disable internal pulls
> +				 * even though we run in polling mode.
> +				 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&tps65090_irq>;
> +
> +				vsys1-supply = <&vbat>;
> +				vsys2-supply = <&vbat>;
> +				vsys3-supply = <&vbat>;
> +				infet1-supply = <&vbat>;
> +				infet2-supply = <&vbat>;
> +				infet3-supply = <&vbat>;
> +				infet4-supply = <&vbat>;
> +				infet5-supply = <&vbat>;
> +				infet6-supply = <&vbat>;
> +				infet7-supply = <&vbat>;
> +				vsys-l1-supply = <&vbat>;
> +				vsys-l2-supply = <&vbat>;
> +
> +				regulators {
> +					dcdc1 {
> +						ti,enable-ext-control;
> +					};
> +					dcdc2 {
> +						ti,enable-ext-control;
> +					};
> +					dcdc3 {
> +						ti,enable-ext-control;
> +					};
> +					fet1: fet1 {
> +						regulator-name = "vcd_led";
> +						ti,overcurrent-wait = <3>;
> +					};
> +					tps65090_fet2: fet2 {
> +						regulator-name = "video_mid";
> +						regulator-always-on;
> +						ti,overcurrent-wait = <3>;
> +					};
> +					fet3 {
> +						regulator-name = "wwan_r";
> +						regulator-always-on;
> +						ti,overcurrent-wait = <3>;
> +					};
> +					fet4 {
> +						regulator-name = "sdcard";
> +						ti,overcurrent-wait = <3>;
> +					};
> +					fet5 {
> +						regulator-name = "camout";
> +						regulator-always-on;
> +						ti,overcurrent-wait = <3>;
> +					};
> +					fet6: fet6 {
> +						regulator-name = "lcd_vdd";
> +						ti,overcurrent-wait = <3>;
> +					};
> +					tps65090_fet7: fet7 {
> +						regulator-name = "video_mid_1a";
> +						regulator-always-on;
> +						ti,overcurrent-wait = <3>;
> +					};
> +					ldo1 {
> +					};
> +					ldo2 {
> +					};
> +				};
> +
> +				charger {
> +					compatible = "ti,tps65090-charger";
> +				};
> +			};
> +		};
> +	};
> +
> +	sound {
> +		samsung,i2s-controller = <&i2s0>;
> +	};
> +
> +	usb3_vbus_reg: regulator-usb3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "P5.0V_USB3CON";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpx2 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3_vbus_en>;
> +		enable-active-high;
> +	};
> +
> +	fixed-rate-clocks {
> +		xxti {
> +			compatible = "samsung,clock-xxti";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 1000000 0>;
> +		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
> +		default-brightness-level = <7>;
> +		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&fet1>;
> +		pinctrl-0 = <&pwm0_out>;
> +		pinctrl-names = "default";
> +	};
> +
> +	panel: panel {
> +		compatible = "auo,b116xw03";
> +		power-supply = <&fet6>;
> +		backlight = <&backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&bridge_out>;
> +			};
> +		};
> +	};
> +
> +	mmc3_pwrseq: mmc3_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpx0 2 GPIO_ACTIVE_LOW>, /* WIFI_RSTn */
> +			      <&gpx0 1 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> +		clocks = <&max77686 MAX77686_CLK_PMIC>;
> +		clock-names = "ext_clock";
> +	};
> +};
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
> +&dp {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp_hpd>;
> +	samsung,color-space = <0>;
> +	samsung,dynamic-range = <0>;
> +	samsung,ycbcr-coeff = <0>;
> +	samsung,color-depth = <1>;
> +	samsung,link-rate = <0x0a>;
> +	samsung,lane-count = <2>;
> +	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
> +
> +	ports {
> +		port at 0 {
> +			dp_out: endpoint {
> +				remote-endpoint = <&bridge_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&ehci {
> +	samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&fimd {
> +	status = "okay";
> +	samsung,invert-vclk;
> +};
> +
> +&hdmi {
> +	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_hpd_irq>;
> +	phy = <&hdmiphy>;
> +	ddc = <&i2c_2>;
> +	hdmi-en-supply = <&tps65090_fet7>;
> +	vdd-supply = <&ldo8_reg>;
> +	vdd_osc-supply = <&ldo10_reg>;
> +	vdd_pll-supply = <&ldo8_reg>;
> +};
> +
> +&i2c_0 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <378000>;
> +
> +	max77686: max77686 at 09 {
> +		compatible = "maxim,max77686";
> +		interrupt-parent = <&gpx3>;
> +		interrupts = <2 IRQ_TYPE_NONE>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&max77686_irq>;
> +		wakeup-source;
> +		reg = <0x09>;
> +		#clock-cells = <1>;
> +
> +		voltage-regulators {
> +			ldo1_reg: LDO1 {
> +				regulator-name = "P1.0V_LDO_OUT1";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "P1.8V_LDO_OUT2";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "P1.8V_LDO_OUT3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo7_reg: LDO7 {
> +				regulator-name = "P1.1V_LDO_OUT7";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo8_reg: LDO8 {
> +				regulator-name = "P1.0V_LDO_OUT8";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "P1.8V_LDO_OUT10";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "P3.0V_LDO_OUT12";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo14_reg: LDO14 {
> +				regulator-name = "P1.8V_LDO_OUT14";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "P1.0V_LDO_OUT15";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo16_reg: LDO16 {
> +				regulator-name = "P1.8V_LDO_OUT16";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			buck1_reg: BUCK1 {
> +				regulator-name = "vdd_mif";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "vdd_arm";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "vdd_int";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				regulator-name = "vdd_g3d";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				regulator-name = "P1.8V_BUCK_OUT5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "P1.35V_BUCK_OUT6";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +			};
> +
> +			buck7_reg: BUCK7 {
> +				regulator-name = "P2.0V_BUCK_OUT7";
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-always-on;
> +			};
> +
> +			buck8_reg: BUCK8 {
> +				regulator-name = "P2.85V_BUCK_OUT8";
> +				regulator-min-microvolt = <2850000>;
> +				regulator-max-microvolt = <2850000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c_1 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <378000>;
> +
> +	trackpad {
> +		reg = <0x67>;
> +		compatible = "cypress,cyapa";
> +		interrupts = <2 IRQ_TYPE_NONE>;
> +		interrupt-parent = <&gpx1>;
> +		wakeup-source;
> +	};
> +};
> +
> +/*
> + * Disabled pullups since external part has its own pullups and
> + * double-pulling gets us out of spec in some cases.
> + */
> +&i2c2_bus {
> +	samsung,pin-pud = <0>;
> +};
> +
> +&i2c_2 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <66000>;
> +
> +	hdmiddc at 50 {
> +		compatible = "samsung,exynos4210-hdmiddc";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_4 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_5 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_7 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <66000>;
> +
> +	ptn3460: lvds-bridge at 20 {
> +		compatible = "nxp,ptn3460";
> +		reg = <0x20>;
> +		powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
> +		edid-emulation = <5>;
> +
> +		ports {
> +			port at 0 {
> +				bridge_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +
> +			port at 1 {
> +				bridge_in: endpoint {
> +					remote-endpoint = <&dp_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c_8 {
> +	status = "okay";
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <378000>;
> +
> +	hdmiphy: hdmiphy at 38 {
> +		compatible = "samsung,exynos4212-hdmiphy";
> +		reg = <0x38>;
> +	};
> +};
> +
> +&i2s0 {
> +	status = "okay";
> +};
> +
> +&mmc_0 {
> +	status = "okay";
> +	num-slots = <1>;
> +	broken-cd;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <2 3>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +};
> +
> +&mmc_2 {
> +	status = "okay";
> +	num-slots = <1>;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <2 3>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> +	bus-width = <4>;
> +	wp-gpios = <&gpc2 1 GPIO_ACTIVE_HIGH>;
> +	cap-sd-highspeed;
> +};
> +
> +/*
> + * On Snow we've got SIP WiFi and so can keep drive strengths low to
> + * reduce EMI.
> + */
> +&mmc_3 {
> +	status = "okay";
> +	num-slots = <1>;
> +	broken-cd;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <2 3>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4 &wifi_en &wifi_rst>;
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	mmc-pwrseq = <&mmc3_pwrseq>;
> +};
> +
> +&pinctrl_0 {
> +	wifi_en: wifi-en {
> +		samsung,pins = "gpx0-1";
> +		samsung,pin-function = <1>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	wifi_rst: wifi-rst {
> +		samsung,pins = "gpx0-2";
> +		samsung,pin-function = <1>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	power_key_irq: power-key-irq {
> +		samsung,pins = "gpx1-3";
> +		samsung,pin-function = <0xf>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	ec_irq: ec-irq {
> +		samsung,pins = "gpx1-6";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	tps65090_irq: tps65090-irq {
> +		samsung,pins = "gpx2-6";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	usb3_vbus_en: usb3-vbus-en {
> +		samsung,pins = "gpx2-7";
> +		samsung,pin-function = <1>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	max77686_irq: max77686-irq {
> +		samsung,pins = "gpx3-2";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	lid_irq: lid-irq {
> +		samsung,pins = "gpx3-5";
> +		samsung,pin-function = <0xf>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	hdmi_hpd_irq: hdmi-hpd-irq {
> +		samsung,pins = "gpx3-7";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <1>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
> +
> +&pinctrl_1 {
> +	arb_their_claim: arb-their-claim {
> +		samsung,pins = "gpe0-4";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <3>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	arb_our_claim: arb-our-claim {
> +		samsung,pins = "gpf0-3";
> +		samsung,pin-function = <1>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
> +
> +&rtc {
> +	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
> +	clock-names = "rtc", "rtc_src";
> +};
> +
> +&sd3_bus4 {
> +	samsung,pin-drv = <0>;
> +};
> +
> +&sd3_clk {
> +	samsung,pin-drv = <0>;
> +};
> +
> +&sd3_cmd {
> +	samsung,pin-pud = <3>;
> +	samsung,pin-drv = <0>;
> +};
> +
> +&spi_1 {
> +	status = "okay";
> +	samsung,spi-src-clk = <0>;
> +	num-cs = <1>;
> +	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usbdrd_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usbdrd_phy {
> +	vbus-supply = <&usb3_vbus_reg>;
> +};
> +
> +#include "cros-ec-keyboard.dtsi"
> diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
> new file mode 100644
> index 000000000000..ce5374547c3f
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
> @@ -0,0 +1,47 @@
> +/*
> + * Google Snow Rev 5+ board device tree source
> + *
> + * Copyright (c) 2012 Google, Inc
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "exynos5250-snow-common.dtsi"
> +
> +/ {
> +	model = "Google Snow Rev 5+";
> +	compatible = "google,snow-rev5", "samsung,exynos5250", "samsung,exynos5";
> +
> +	sound {
> +		compatible = "google,snow-audio-max98090";
> +
> +		samsung,model = "Snow-I2S-MAX98090";
> +		samsung,audio-codec = <&max98090>;
> +	};
> +};
> +
> +&i2c_7 {
> +	max98090: codec at 10 {
> +		compatible = "maxim,max98090";
> +		reg = <0x10>;
> +		interrupts = <4 IRQ_TYPE_NONE>;
> +		interrupt-parent = <&gpx0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&max98090_irq>;
> +	};
> +};
> +
> +&pinctrl_0 {
> +	max98090_irq: max98090-irq {
> +		samsung,pins = "gpx0-4";
> +		samsung,pin-function = <0>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
> +
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 0720caab5511..99c4d2a9fcf9 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -9,506 +9,21 @@
>   */
>  
>  /dts-v1/;
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/maxim,max77686.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/input/input.h>
> -#include "exynos5250.dtsi"
> +#include "exynos5250-snow-common.dtsi"
>  
>  / {
>  	model = "Google Snow";
>  	compatible = "google,snow", "samsung,exynos5250", "samsung,exynos5";
>  
> -	aliases {
> -		i2c104 = &i2c_104;
> -	};
> -
> -	memory {
> -		reg = <0x40000000 0x80000000>;
> -	};
> -
> -	chosen {
> -		bootargs = "console=tty1";
> -		stdout-path = "serial3:115200n8";
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&power_key_irq &lid_irq>;
> -
> -		power {
> -			label = "Power";
> -			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
> -			linux,code = <KEY_POWER>;
> -			gpio-key,wakeup;
> -		};
> -
> -		lid-switch {
> -			label = "Lid";
> -			gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
> -			linux,input-type = <5>; /* EV_SW */
> -			linux,code = <0>; /* SW_LID */
> -			debounce-interval = <1>;
> -			gpio-key,wakeup;
> -		};
> -	};
> -
> -	vbat: vbat-fixed-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vbat-supply";
> -		regulator-boot-on;
> -	};
> -
> -	i2c-arbitrator {
> -		compatible = "i2c-arb-gpio-challenge";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		i2c-parent = <&{/i2c@12CA0000}>;
> -
> -		our-claim-gpio = <&gpf0 3 GPIO_ACTIVE_LOW>;
> -		their-claim-gpios = <&gpe0 4 GPIO_ACTIVE_LOW>;
> -		slew-delay-us = <10>;
> -		wait-retry-us = <3000>;
> -		wait-free-us = <50000>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&arb_our_claim &arb_their_claim>;
> -
> -		/* Use ID 104 as a hint that we're on physical bus 4 */
> -		i2c_104: i2c at 0 {
> -			reg = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			battery: sbs-battery at b {
> -				compatible = "sbs,sbs-battery";
> -				reg = <0xb>;
> -				sbs,poll-retry-count = <1>;
> -			};
> -
> -			cros_ec: embedded-controller {
> -				compatible = "google,cros-ec-i2c";
> -				reg = <0x1e>;
> -				interrupts = <6 IRQ_TYPE_NONE>;
> -				interrupt-parent = <&gpx1>;
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&ec_irq>;
> -				wakeup-source;
> -			};
> -
> -			power-regulator {
> -				compatible = "ti,tps65090";
> -				reg = <0x48>;
> -
> -				/*
> -				 * Config irq to disable internal pulls
> -				 * even though we run in polling mode.
> -				 */
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&tps65090_irq>;
> -
> -				vsys1-supply = <&vbat>;
> -				vsys2-supply = <&vbat>;
> -				vsys3-supply = <&vbat>;
> -				infet1-supply = <&vbat>;
> -				infet2-supply = <&vbat>;
> -				infet3-supply = <&vbat>;
> -				infet4-supply = <&vbat>;
> -				infet5-supply = <&vbat>;
> -				infet6-supply = <&vbat>;
> -				infet7-supply = <&vbat>;
> -				vsys-l1-supply = <&vbat>;
> -				vsys-l2-supply = <&vbat>;
> -
> -				regulators {
> -					dcdc1 {
> -						ti,enable-ext-control;
> -					};
> -					dcdc2 {
> -						ti,enable-ext-control;
> -					};
> -					dcdc3 {
> -						ti,enable-ext-control;
> -					};
> -					fet1: fet1 {
> -						regulator-name = "vcd_led";
> -						ti,overcurrent-wait = <3>;
> -					};
> -					tps65090_fet2: fet2 {
> -						regulator-name = "video_mid";
> -						regulator-always-on;
> -						ti,overcurrent-wait = <3>;
> -					};
> -					fet3 {
> -						regulator-name = "wwan_r";
> -						regulator-always-on;
> -						ti,overcurrent-wait = <3>;
> -					};
> -					fet4 {
> -						regulator-name = "sdcard";
> -						ti,overcurrent-wait = <3>;
> -					};
> -					fet5 {
> -						regulator-name = "camout";
> -						regulator-always-on;
> -						ti,overcurrent-wait = <3>;
> -					};
> -					fet6: fet6 {
> -						regulator-name = "lcd_vdd";
> -						ti,overcurrent-wait = <3>;
> -					};
> -					tps65090_fet7: fet7 {
> -						regulator-name = "video_mid_1a";
> -						regulator-always-on;
> -						ti,overcurrent-wait = <3>;
> -					};
> -					ldo1 {
> -					};
> -					ldo2 {
> -					};
> -				};
> -
> -				charger {
> -					compatible = "ti,tps65090-charger";
> -				};
> -			};
> -		};
> -	};
> -
>  	sound {
>  		compatible = "google,snow-audio-max98095";
>  
>  		samsung,model = "Snow-I2S-MAX98095";
> -		samsung,i2s-controller = <&i2s0>;
>  		samsung,audio-codec = <&max98095>;
>  	};
> -
> -	usb3_vbus_reg: regulator-usb3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "P5.0V_USB3CON";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpx2 7 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usb3_vbus_en>;
> -		enable-active-high;
> -	};
> -
> -	fixed-rate-clocks {
> -		xxti {
> -			compatible = "samsung,clock-xxti";
> -			clock-frequency = <24000000>;
> -		};
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm 0 1000000 0>;
> -		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
> -		default-brightness-level = <7>;
> -		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
> -		power-supply = <&fet1>;
> -		pinctrl-0 = <&pwm0_out>;
> -		pinctrl-names = "default";
> -	};
> -
> -	panel: panel {
> -		compatible = "auo,b116xw03";
> -		power-supply = <&fet6>;
> -		backlight = <&backlight>;
> -
> -		port {
> -			panel_in: endpoint {
> -				remote-endpoint = <&bridge_out>;
> -			};
> -		};
> -	};
> -
> -	mmc3_pwrseq: mmc3_pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		reset-gpios = <&gpx0 2 GPIO_ACTIVE_LOW>, /* WIFI_RSTn */
> -			      <&gpx0 1 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> -		clocks = <&max77686 MAX77686_CLK_PMIC>;
> -		clock-names = "ext_clock";
> -	};
> -};
> -
> -&cpu0 {
> -	cpu0-supply = <&buck2_reg>;
> -};
> -
> -&dp {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&dp_hpd>;
> -	samsung,color-space = <0>;
> -	samsung,dynamic-range = <0>;
> -	samsung,ycbcr-coeff = <0>;
> -	samsung,color-depth = <1>;
> -	samsung,link-rate = <0x0a>;
> -	samsung,lane-count = <2>;
> -	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
> -
> -	ports {
> -		port at 0 {
> -			dp_out: endpoint {
> -				remote-endpoint = <&bridge_in>;
> -			};
> -		};
> -	};
> -};
> -
> -&ehci {
> -	samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&fimd {
> -	status = "okay";
> -	samsung,invert-vclk;
> -};
> -
> -&hdmi {
> -	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_hpd_irq>;
> -	phy = <&hdmiphy>;
> -	ddc = <&i2c_2>;
> -	hdmi-en-supply = <&tps65090_fet7>;
> -	vdd-supply = <&ldo8_reg>;
> -	vdd_osc-supply = <&ldo10_reg>;
> -	vdd_pll-supply = <&ldo8_reg>;
> -};
> -
> -&i2c_0 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <378000>;
> -
> -	max77686: max77686 at 09 {
> -		compatible = "maxim,max77686";
> -		interrupt-parent = <&gpx3>;
> -		interrupts = <2 IRQ_TYPE_NONE>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&max77686_irq>;
> -		wakeup-source;
> -		reg = <0x09>;
> -		#clock-cells = <1>;
> -
> -		voltage-regulators {
> -			ldo1_reg: LDO1 {
> -				regulator-name = "P1.0V_LDO_OUT1";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo2_reg: LDO2 {
> -				regulator-name = "P1.8V_LDO_OUT2";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo3_reg: LDO3 {
> -				regulator-name = "P1.8V_LDO_OUT3";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo7_reg: LDO7 {
> -				regulator-name = "P1.1V_LDO_OUT7";
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1100000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo8_reg: LDO8 {
> -				regulator-name = "P1.0V_LDO_OUT8";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo10_reg: LDO10 {
> -				regulator-name = "P1.8V_LDO_OUT10";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo12_reg: LDO12 {
> -				regulator-name = "P3.0V_LDO_OUT12";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo14_reg: LDO14 {
> -				regulator-name = "P1.8V_LDO_OUT14";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo15_reg: LDO15 {
> -				regulator-name = "P1.0V_LDO_OUT15";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -			};
> -
> -			ldo16_reg: LDO16 {
> -				regulator-name = "P1.8V_LDO_OUT16";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			buck1_reg: BUCK1 {
> -				regulator-name = "vdd_mif";
> -				regulator-min-microvolt = <950000>;
> -				regulator-max-microvolt = <1300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck2_reg: BUCK2 {
> -				regulator-name = "vdd_arm";
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck3_reg: BUCK3 {
> -				regulator-name = "vdd_int";
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck4_reg: BUCK4 {
> -				regulator-name = "vdd_g3d";
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <1300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck5_reg: BUCK5 {
> -				regulator-name = "P1.8V_BUCK_OUT5";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck6_reg: BUCK6 {
> -				regulator-name = "P1.35V_BUCK_OUT6";
> -				regulator-min-microvolt = <1350000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -			};
> -
> -			buck7_reg: BUCK7 {
> -				regulator-name = "P2.0V_BUCK_OUT7";
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-always-on;
> -			};
> -
> -			buck8_reg: BUCK8 {
> -				regulator-name = "P2.85V_BUCK_OUT8";
> -				regulator-min-microvolt = <2850000>;
> -				regulator-max-microvolt = <2850000>;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -};
> -
> -&i2c_1 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <378000>;
> -
> -	trackpad {
> -		reg = <0x67>;
> -		compatible = "cypress,cyapa";
> -		interrupts = <2 IRQ_TYPE_NONE>;
> -		interrupt-parent = <&gpx1>;
> -		wakeup-source;
> -	};
> -};
> -
> -/*
> - * Disabled pullups since external part has its own pullups and
> - * double-pulling gets us out of spec in some cases.
> - */
> -&i2c2_bus {
> -	samsung,pin-pud = <0>;
> -};
> -
> -&i2c_2 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <66000>;
> -
> -	hdmiddc at 50 {
> -		compatible = "samsung,exynos4210-hdmiddc";
> -		reg = <0x50>;
> -	};
> -};
> -
> -&i2c_3 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <66000>;
> -};
> -
> -&i2c_4 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <66000>;
> -};
> -
> -&i2c_5 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <66000>;
>  };
>  
>  &i2c_7 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <66000>;
> -
> -	ptn3460: lvds-bridge at 20 {
> -		compatible = "nxp,ptn3460";
> -		reg = <0x20>;
> -		powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
> -		edid-emulation = <5>;
> -
> -		ports {
> -			port at 0 {
> -				bridge_out: endpoint {
> -					remote-endpoint = <&panel_in>;
> -				};
> -			};
> -
> -			port at 1 {
> -				bridge_in: endpoint {
> -					remote-endpoint = <&dp_out>;
> -				};
> -			};
> -		};
> -	};
> -
>  	max98095: codec at 11 {
>  		compatible = "maxim,max98095";
>  		reg = <0x11>;
> @@ -517,190 +32,11 @@
>  	};
>  };
>  
> -&i2c_8 {
> -	status = "okay";
> -	samsung,i2c-sda-delay = <100>;
> -	samsung,i2c-max-bus-freq = <378000>;
> -
> -	hdmiphy: hdmiphy at 38 {
> -		compatible = "samsung,exynos4212-hdmiphy";
> -		reg = <0x38>;
> -	};
> -};
> -
> -&i2s0 {
> -	status = "okay";
> -};
> -
> -&mmc_0 {
> -	status = "okay";
> -	num-slots = <1>;
> -	broken-cd;
> -	card-detect-delay = <200>;
> -	samsung,dw-mshc-ciu-div = <3>;
> -	samsung,dw-mshc-sdr-timing = <2 3>;
> -	samsung,dw-mshc-ddr-timing = <1 2>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> -	bus-width = <8>;
> -	cap-mmc-highspeed;
> -};
> -
> -&mmc_2 {
> -	status = "okay";
> -	num-slots = <1>;
> -	card-detect-delay = <200>;
> -	samsung,dw-mshc-ciu-div = <3>;
> -	samsung,dw-mshc-sdr-timing = <2 3>;
> -	samsung,dw-mshc-ddr-timing = <1 2>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -	bus-width = <4>;
> -	wp-gpios = <&gpc2 1 GPIO_ACTIVE_HIGH>;
> -	cap-sd-highspeed;
> -};
> -
> -/*
> - * On Snow we've got SIP WiFi and so can keep drive strengths low to
> - * reduce EMI.
> - */
> -&mmc_3 {
> -	status = "okay";
> -	num-slots = <1>;
> -	broken-cd;
> -	cap-sdio-irq;
> -	keep-power-in-suspend;
> -	card-detect-delay = <200>;
> -	samsung,dw-mshc-ciu-div = <3>;
> -	samsung,dw-mshc-sdr-timing = <2 3>;
> -	samsung,dw-mshc-ddr-timing = <1 2>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4 &wifi_en &wifi_rst>;
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	mmc-pwrseq = <&mmc3_pwrseq>;
> -};
> -
>  &pinctrl_0 {
> -	wifi_en: wifi-en {
> -		samsung,pins = "gpx0-1";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	wifi_rst: wifi-rst {
> -		samsung,pins = "gpx0-2";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	power_key_irq: power-key-irq {
> -		samsung,pins = "gpx1-3";
> -		samsung,pin-function = <0xf>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	ec_irq: ec-irq {
> -		samsung,pins = "gpx1-6";
> -		samsung,pin-function = <0>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
>  	max98095_en: max98095-en {
>  		samsung,pins = "gpx1-7";
>  		samsung,pin-function = <0>;
>  		samsung,pin-pud = <3>;
>  		samsung,pin-drv = <0>;
>  	};
> -
> -	tps65090_irq: tps65090-irq {
> -		samsung,pins = "gpx2-6";
> -		samsung,pin-function = <0>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	usb3_vbus_en: usb3-vbus-en {
> -		samsung,pins = "gpx2-7";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	max77686_irq: max77686-irq {
> -		samsung,pins = "gpx3-2";
> -		samsung,pin-function = <0>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	lid_irq: lid-irq {
> -		samsung,pins = "gpx3-5";
> -		samsung,pin-function = <0xf>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	hdmi_hpd_irq: hdmi-hpd-irq {
> -		samsung,pins = "gpx3-7";
> -		samsung,pin-function = <0>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> -	};
>  };
> -
> -&pinctrl_1 {
> -	arb_their_claim: arb-their-claim {
> -		samsung,pins = "gpe0-4";
> -		samsung,pin-function = <0>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> -	};
> -
> -	arb_our_claim: arb-our-claim {
> -		samsung,pins = "gpf0-3";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> -	};
> -};
> -
> -&rtc {
> -	status = "okay";
> -	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
> -	clock-names = "rtc", "rtc_src";
> -};
> -
> -&sd3_bus4 {
> -	samsung,pin-drv = <0>;
> -};
> -
> -&sd3_clk {
> -	samsung,pin-drv = <0>;
> -};
> -
> -&sd3_cmd {
> -	samsung,pin-pud = <3>;
> -	samsung,pin-drv = <0>;
> -};
> -
> -&spi_1 {
> -	status = "okay";
> -	samsung,spi-src-clk = <0>;
> -	num-cs = <1>;
> -	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&usbdrd_dwc3 {
> -	dr_mode = "host";
> -};
> -
> -&usbdrd_phy {
> -	vbus-supply = <&usb3_vbus_reg>;
> -};
> -
> -#include "cros-ec-keyboard.dtsi"
