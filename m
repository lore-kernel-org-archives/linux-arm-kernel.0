From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 14:15:20 -0500
Subject: [PATCH v2 4/5] ARM: mvebu: Add dts file describing HP T5325
 thin client
In-Reply-To: <1393264898-28939-5-git-send-email-andrew@lunn.ch>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <1393264898-28939-5-git-send-email-andrew@lunn.ch>
Message-ID: <20140224191520.GF1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject should be "ARM: kirkwood: ..."

On Mon, Feb 24, 2014 at 07:01:37PM +0100, Andrew Lunn wrote:
> Describe the T5325 using device tree properties, where possible.  The
> first version of this file was produced by Thomas Petazzoni.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-t5325.dts | 209 +++++++++++++++++++++++++++++++++++
>  1 file changed, 209 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-t5325.dts
> 
> diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
> new file mode 100644
> index 000000000000..8df357d822ca
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-t5325.dts
> @@ -0,0 +1,209 @@
> +/*
> + * Device Tree file for HP t5325 Thin Client"
> + *
> + * Copyright (C) 2014
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> +*/
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "HP t5325 Thin Client";
> +	compatible = "hp,t5325", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_i2s &pmx_sysrst>;
> +			pinctrl-names = "default";
> +
> +			pmx_button_power: pmx-button_power {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_off: pmx-power-off {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led: pmx-led {
> +				marvell,pins = "mpp21";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_usb_sata_power_enable: pmx-usb-sata-power-enable {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +
> +			/*
> +                         * Redefined from kirkwood-6281.dtsi, because
> +			 * we don't use SPI CS on MPP0, but on MPP7.
> +			 */

wonky leading whitespace.

> +			pmx_spi: pmx-spi {
> +				marvell,pins = "mpp1", "mpp2", "mpp3", "mpp7";
> +				marvell,function = "spi";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			pmx_i2s: pmx-i2s {
> +				marvell,pins = "mpp39", "mpp40", "mpp41", "mpp42",
> +					       "mpp43";
> +				marvell,function = "audio";
> +			};
> +		};
> +
> +		spi at 10600 {
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +
> +			flash at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "st,m25p80";
> +				spi-max-frequency = <86000000>;
> +				reg = <0>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +
> +				partition at 1 {
> +					reg = <0x80000 0x40000>;
> +					label = "SSD firmware";
> +				};
> +
> +				partition at 2 {
> +					reg = <0xc0000 0x10000>;
> +					label = "u-boot env";
> +				};
> +
> +				partition at 3 {
> +					reg = <0xd0000 0x10000>;
> +					label = "permanent u-boot env";
> +				};
> +
> +				partition at 4 {
> +					reg = <0xd0000 0x10000>;
> +					label = "permanent u-boot env";
> +				};
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			alc5621: alc5621 at 1a {
> +				compatible = "realtek,alc5621";
> +				reg = <0x1a>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +		audio: audio-controller at a0000 {
> +			status = "okay";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_usb_sata_power_enable>;
> +		pinctrl-names = "default";
> +
> +		usb_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB-SATA Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_button_power>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_power_off>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy {
> +		device_type = "ethernet-phy";
> +                reg = <8>;

leading whitespace again.

thx,

Jason.

> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> -- 
> 1.8.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
