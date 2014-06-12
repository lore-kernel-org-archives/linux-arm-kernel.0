From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Jun 2014 15:03:34 +0200
Subject: [PATCH] ARM: dts: Initial ODROID U2 support
In-Reply-To: <1402577077-7835-1-git-send-email-drake@endlessm.com>
References: <1402577077-7835-1-git-send-email-drake@endlessm.com>
Message-ID: <5399A526.6040303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-06-12 14:44, Daniel Drake wrote:
> This dts adds initial support for the popular ODROID U2/U3 development
> boards based on Exynos4412.
>
> This file comes from larger work by Alban Browaeys, but I removed the
> items that aren't immediately working on mainline kernels yet (USB,
> HDMI, etc).
>
> This leaves us with a reasonable starting point for further development:
> basic bootup and shutdown works, plus LED, eMMC, SD, and serial.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Thanks for posting, however I have already prepared dts for Odroid X2
and U3 with complete USB support. HDMI needs a few little tweaks, but I
hope it can be also merged soon.

I'm waiting for v3.16-rc1 to rebase them onto latest mainline and post
here. I will check if I can integrate your patch to them.

You can check some earlier version in the following git:
https://review.tizen.org/git/?p=platform/kernel/linux-3.10.git;a=shortlog;h=refs/heads/tizen

> ---
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/exynos4412-odroidu2.dts | 468 ++++++++++++++++++++++++++++++
>   2 files changed, 469 insertions(+)
>   create mode 100644 arch/arm/boot/dts/exynos4412-odroidu2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5986ff6..bd89b23 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>   	exynos4210-smdkv310.dtb \
>   	exynos4210-trats.dtb \
>   	exynos4210-universal_c210.dtb \
> +	exynos4412-odroidu2.dtb \
>   	exynos4412-odroidx.dtb \
>   	exynos4412-origen.dtb \
>   	exynos4412-smdk4412.dtb \
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu2.dts b/arch/arm/boot/dts/exynos4412-odroidu2.dts
> new file mode 100644
> index 0000000..a164522
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4412-odroidu2.dts
> @@ -0,0 +1,468 @@
> +/*
> + * Hardkernel's Exynos4412 based ODROID-U2 board device tree source
> + *
> + * Copyright (c) 2013 Alban Browaeys <prahal@yahoo.com>
> + *
> + * Based on exynos4412-odroidx.dts
> + * Copyright (c) 2012 Dongjin Kim <tobetter@gmail.com>
> + *
> + * Based on exynos4412-origen.dts
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Device tree source file for Hardkernel's ODROID-U2 board which is based on
> + * Samsung's Exynos4412 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include "exynos4412.dtsi"
> +
> +/ {
> +	model = "Hardkernel ODROID-U2/U3 board based on Exynos4412";
> +	compatible = "hardkernel,odroid-u2", "samsung,exynos4412", "samsung,exynos4";
> +
> +	chosen {
> +		bootargs = "console=ttySAC1,115200";
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x80000000>;
> +	};
> +
> +	firmware at 0203F000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x0203F000 0x1000>;
> +	};
> +
> +	watchdog at 10060000 {
> +		status = "okay";
> +	};
> +
> +	g2d at 10800000 {
> +		status = "okay";
> +	};
> +
> +	fixed-rate-clocks {
> +		xxti {
> +			compatible = "samsung,clock-xxti", "fixed-clock";
> +			clock-frequency = <0>;
> +		};
> +
> +		xusbxti {
> +			compatible = "samsung,clock-xusbxti", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led1 {
> +			label = "led1:heart";
> +			gpios = <&gpc1 0 1>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	mmc at 12550000 {
> +		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8 &sd4_nreset_out>;
> +		pinctrl-names = "default";
> +		vmmc-supply = <&ldo20_reg &ldo22_reg>;
> +		status = "okay";
> +
> +		num-slots = <1>;
> +		supports-highspeed;
> +		broken-cd;
> +		keep-power-in-suspend;
> +		non-removable;
> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 1>;
> +		samsung,dw-mshc-ddr-timing = <2 1>;
> +		samsung,dw-mshc-hwreset-gpio = <&gpk1 2 1>;
> +
> +		slot at 0 {
> +			reg = <0>;
> +			bus-width = <8>;
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +
> +		reg_p3v3: p3v3 at 0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "p3v3_en";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpa1 1 3>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		reg_sysvdd: p5v0 at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "p5v0";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		spkvdd:jack at 2 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "spkvdd-supply";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			vin-supply = <&reg_sysvdd>;
> +		};
> +	};
> +
> +	pinctrl at 11000000 {
> +		sd4_nreset_out: sd4-nreset-out {
> +			samsung,pins = "gpk1-2";
> +			samsung,pin-function = <4>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};
> +
> +		eint26: ext-int26 {
> +			samsung,pins = "gpx3-2";
> +			samsung,pin-function = <0xf>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};
> +	};
> +
> +	sdhci at 12530000 {
> +		bus-width = <4>;
> +		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> +		pinctrl-names = "default";
> +		vmmc-supply = <&ldo4_reg &ldo21_reg>;
> +		status = "okay";
> +	};
> +
> +	serial at 13800000 {
> +		status = "okay";
> +	};
> +
> +	serial at 13810000 {
> +		status = "okay";
> +	};
> +
> +	serial at 13820000 {
> +		status = "okay";
> +	};
> +
> +	serial at 13830000 {
> +		status = "okay";
> +	};
> +
> +	i2c_0: i2c at 13860000 {
> +		pinctrl-0 = <&i2c0_bus>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +
> +		samsung,i2c-sda-delay = <100>;
> +		samsung,i2c-slave-addr = <0x10>;
> +		samsung,i2c-max-bus-freq = <400000>;
> +
> +		max77686_pmic at 09 {
> +			compatible = "maxim,max77686";
> +			interrupts-extended = <&gpx3 2 1>, <&gpx1 2 1>;
> +			reg = <0x09>;
> +			pinctrl-0 = <&eint26>;
> +			pinctrl-names = "default";
> +			#clock-cells = <1>;
> +
> +			voltage-regulators {
> +				ldo1_reg: ldo1 {
> +					regulator-compatible = "LDO1";
> +					regulator-name = "VDD_ALIVE_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo2_reg: ldo2 {
> +					regulator-compatible = "LDO2";
> +					regulator-name = "VDDQ_M1_2_1.8V";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo3_reg: ldo3 {
> +					regulator-compatible = "LDO3";
> +					regulator-name = "VDDQ_EXT_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo4_reg: ldo4 {
> +					regulator-compatible = "LDO4";
> +					regulator-name = "VDDQ_MMC2_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo5_reg: ldo5 {
> +					regulator-compatible = "LDO5";
> +					regulator-name = "VDDQ_MMC1_3_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo6_reg: ldo6 {
> +					regulator-compatible = "LDO6";
> +					regulator-name = "VDD10_MPLL_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo7_reg: ldo7 {
> +					regulator-compatible = "LDO7";
> +					regulator-name = "VDD10_EPLL_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo8_reg: ldo8 {
> +					regulator-compatible = "LDO8";
> +					regulator-name = "VDD10_MIPI_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo9_reg: ldo9 {
> +					regulator-compatible = "LDO9";
> +					regulator-name = "VT_CORE_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +				};
> +
> +				ldo10_reg: ldo10 {
> +					regulator-compatible = "LDO10";
> +					regulator-name = "VDD18_MIPI_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-boot-on;
> +				};
> +
> +				ldo11_reg: ldo11 {
> +					regulator-compatible = "LDO11";
> +					regulator-name = "VDD18_ABB1_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo12_reg: ldo12 {
> +					regulator-compatible = "LDO12";
> +					regulator-name = "VDD33_USB_3.3V";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldo13_reg: ldo13 {
> +					regulator-compatible = "LDO13";
> +					regulator-name = "VDDQ_C2C_W_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo14_reg: ldo14 {
> +					regulator-compatible = "LDO14";
> +					regulator-name = "VDD18_ABB0_2_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo15_reg: ldo15 {
> +					regulator-compatible = "LDO15";
> +					regulator-name = "VDD10_HSIC_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldo16_reg: ldo16 {
> +					regulator-compatible = "LDO16";
> +					regulator-name = "VDD18_HSIC_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo17_reg: ldo17 {
> +					regulator-compatible = "LDO17";
> +					regulator-name = "VDDQ_CAM_1.2V";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo18_reg: ldo18 {
> +					regulator-compatible = "LDO18";
> +					regulator-name = "VDDQ_ISP_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				ldo19_reg: ldo19 {
> +					regulator-compatible = "LDO19";
> +					regulator-name = "VT_CAM_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				ldo20_reg: ldo20 {
> +					regulator-compatible = "LDO20";
> +					regulator-name = "LDO20_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-boot-on;
> +				};
> +
> +				ldo21_reg: ldo21 {
> +					regulator-compatible = "LDO21";
> +					regulator-name = "LDO21_3.3V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo22_reg: ldo22 {
> +					regulator-compatible = "LDO22";
> +					regulator-name = "VMEM_VDD_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo23_reg: ldo23 {
> +					regulator-compatible = "LDO23";
> +					regulator-name = "VDD_TOUCH_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +				};
> +
> +				ldo24_reg: ldo24 {
> +					regulator-compatible = "LDO24";
> +					regulator-name = "VDD_TOUCHLED_3.3V";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +				};
> +
> +				ldo25_reg: ldo25 {
> +					regulator-compatible = "LDO25";
> +					regulator-name = "VDDQ_LCD_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo26_reg: ldo26 {
> +					regulator-compatible = "LDO26";
> +					regulator-name = "VDD_MOTOR_3.0V";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +				};
> +
> +				buck1_reg: buck1 {
> +					regulator-compatible = "BUCK1";
> +					regulator-name = "vdd_mif";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				buck2_reg: buck2 {
> +					regulator-compatible = "BUCK2";
> +					regulator-name = "vdd_arm";
> +					regulator-min-microvolt = <800000>;
> +					regulator-max-microvolt = <1500000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				buck3_reg: buck3 {
> +					regulator-compatible = "BUCK3";
> +					regulator-name = "vdd_int";
> +					regulator-min-microvolt = <1125000>;
> +					regulator-max-microvolt = <1125000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				buck4_reg: buck4 {
> +					regulator-compatible = "BUCK4";
> +					regulator-name = "vdd_g3d";
> +					regulator-min-microvolt = <850000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				buck5_reg: buck5 {
> +					regulator-compatible = "BUCK5";
> +					regulator-name = "VDDQ_CKEM1_2_1.2V";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +				};
> +
> +				buck6_reg: buck6 {
> +					regulator-compatible = "BUCK6";
> +					regulator-name = "BUCK6_1.35V";
> +					regulator-min-microvolt = <1350000>;
> +					regulator-max-microvolt = <1350000>;
> +					regulator-always-on;
> +				};
> +
> +				buck7_reg: buck7 {
> +					regulator-compatible = "BUCK7";
> +					regulator-name = "BUCK7_2.0V";
> +					regulator-min-microvolt = <2000000>;
> +					regulator-max-microvolt = <2000000>;
> +					regulator-always-on;
> +				};
> +
> +				buck8_reg: buck8 {
> +					regulator-compatible = "BUCK8";
> +					regulator-name = "BUCK8_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				buck9_reg: buck9 {
> +					regulator-compatible = "BUCK9";
> +					regulator-name = "BUCK9_1.2V";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +				};
> +			};
> +		};
> +	};
> +};

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
