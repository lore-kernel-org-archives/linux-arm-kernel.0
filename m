From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 12:03:09 -0400
Subject: [PATCH 1/4] ARM: Kirkwood: Add support for DLink DIR665
In-Reply-To: <1414793613-11798-2-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
 <1414793613-11798-2-git-send-email-andrew@lunn.ch>
Message-ID: <20141101160309.GM15252@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 11:13:30PM +0100, Andrew Lunn wrote:
> From: Claudio Leite <leitec@staticky.com>
> 
> Add a device tree description of the DLINK DIR665 wireless access
> point. The support for the 88E6171 switch will be added in a later
> patch.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> This description was mostly produced by Claudio Leite with a few
> minor cleanups by my.
> ---
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/kirkwood-dir665.dts | 233 ++++++++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-dir665.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 38c89cafa1ab..31529ccc67a0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -104,6 +104,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
>  	kirkwood-d2net.dtb \
>  	kirkwood-db-88f6281.dtb \
>  	kirkwood-db-88f6282.dtb \
> +	kirkwood-dir665.dtb \
>  	kirkwood-dns320.dtb \
>  	kirkwood-dns325.dtb \
>  	kirkwood-dockstar.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
> new file mode 100644
> index 000000000000..ac945ea49940
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-dir665.dts
> @@ -0,0 +1,233 @@
> +/*
> + * Copyright (C) 2014 Claudio Leite <leitec@staticky.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "D-Link DIR-665";
> +	compatible = "dlink,dir-665", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>; /* 128 MB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		stdout-path = &uart0;
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
> +		pinctrl: pin-controller at 10000 {
> +			pinctrl-0 =< &pmx_led_usb
> +				     &pmx_led_internet_blue
> +				     &pmx_led_internet_amber
> +				     &pmx_led_5g &pmx_led_status_blue
> +				     &pmx_led_wps &pmx_led_status_amber
> +				     &pmx_led_24g
> +				     &pmx_btn_restart &pmx_btn_wps>;
> +			pinctrl-names = "default";
> +
> +			pmx_led_usb: pmx-led-usb {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_internet_blue: pmx-led-internet-blue {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_internet_amber: pmx-led-internet-amber {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_5g: pmx-led-5g {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_status_blue: pmx-led-status-blue {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_wps: pmx-led-wps {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_status_amber: pmx-led-status-amber {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_24g: pmx-led-24g {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +			pmx_btn_restart: pmx-btn-restart {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +			pmx_btn_wps: pmx-btn-wps {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +			m25p80 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "mxicy,mx25l12805d";
> +				spi-max-frequency = <50000000>;
> +				reg = <0>;
> +
> +				partition at 0 {
> +					label = "uboot";
> +					reg = <0x0 0x30000>;
> +					read-only;
> +				};
> +
> +				partition at 30000 {
> +					label = "nvram";
> +					reg = <0x30000 0x10000>;
> +					read-only;
> +				};
> +
> +				partition at 40000 {
> +					label = "kernel";
> +					reg = <0x40000 0x180000>;
> +				};
> +
> +				partition at 1c0000 {
> +					label = "rootfs";
> +					reg = <0x1c0000 0xe00000>;
> +				};
> +
> +				cal_data: partition at fc0000 {
> +					label = "cal_data";
> +					reg = <0xfc0000 0x10000>;
> +					read-only;
> +				};
> +
> +				partition at fd0000 {
> +					label = "lang_pack";
> +					reg = <0xfd0000 0x30000>;
> +					read-only;
> +				};
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +		};
> +
> +		ehci at 50000 {
> +			status = "okay";
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		blue-usb {
> +			label = "dir665:blue:usb";
> +			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +		};
> +		blue-internet {
> +			/* Can only be turned on if the Internet
> +			 * Ethernet port has Link
> +			 */
> +			label = "dir665:blue:internet";
> +			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +		};
> +		amber-internet {
> +			label = "dir665:amber:internet";
> +			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +		};
> +		blue-wifi5g {
> +			label = "dir665:blue:5g";
> +			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +		};
> +		blue-status {
> +			label = "dir665:blue:status";
> +			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		};
> +		blue-wps {
> +			label = "dir665:blue:wps";
> +			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		};
> +		amber-status {
> +			label = "dir665:amber:status";
> +			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +		};
> +		blue-24g {
> +			label = "dir665:blue:24g";
> +			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reset {
> +			label = "reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +		};
> +		wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +};
> +
> +/* eth0 is connected to a Marvell 88E6171 switch, without a PHY. So set
> + * fixed speed and duplex. */
> +&eth0 {
> +	status = "okay";
> +
> +	ethernet0-port at 0 {
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};
> +
> +/* eth1 is connected to the switch as well. However DSA only supports a
> + * single CPU port. So leave this port disabled to avoid confusion. */
> +
> +&eth1 {
> +	status = "disabled";
> +};
> +
> +/* There is no battery on the boards, so the RTC does not keep time
> + * when there is now power, making it useless. */

Wow... so much for accurate logging.  At any rate, s/now/no/.  I'll fix
it up when I pull it in if there's nothing else.

thx,

Jason.

> +&rtc {
> +	status = "disabled";
> +};
> -- 
> 2.1.1
> 
