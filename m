From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Aug 2013 11:53:43 -0400
Subject: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
In-Reply-To: <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130806155343.GU19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Tue, Jul 30, 2013 at 05:44:50PM +0200, Thomas Petazzoni wrote:
> The AXP WiFi AP board is a Marvell platform based on the Armada XP
> MV78230 SoC. It has two mini-PCIe connectors, one USB 3.0 port powered
> by a USB 3.0 controller on PCIe, two Ethernet ports, 1 GB of RAM, 1 GB
> of NAND, 16 MB of SPI flash, one SATA port and one button, two UARTs
> 
> Successfully tested: USB 3.0 port, the mini-PCIe connectors, SPI
> flash, Ethernet ports, SATA port, button, UART.
> 
> Untested: NAND flash, due to lack of mainline support for the Armada
> 370/XP NAND controller for now.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts | 164 ++++++++++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts

When I merge this code with your MBus series I get the following
warning:

  DTC     arch/arm/boot/dts/armada-xp-axpwifiap.dtb
Warning (ranges_format): "ranges" property in /soc has invalid length (32 bytes)
 (parent #address-cells == 2, child #address-cells == 2, #size-cells == 1)

Could you please take a look and provide a separate patch to fix it up?

thx,

Jason.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..66bb64f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-mirabox.dtb \
>  	armada-370-rd.dtb \
> +	armada-xp-axpwifiap.dtb \
>  	armada-xp-db.dtb \
>  	armada-xp-gp.dtb \
>  	armada-xp-openblocks-ax3-4.dtb
> diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> new file mode 100644
> index 0000000..2a542bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> @@ -0,0 +1,164 @@
> +/*
> + * Device Tree file for Marvell RD-AXPWiFiAP.
> + *
> + * Note: this board is shipped with a new generation boot loader that
> + * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
> + * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
> + * used.
> + *
> + * Copyright (C) 2013 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "armada-xp-mv78230.dtsi"
> +
> +/ {
> +	model = "Marvell RD-AXPWiFiAP";
> +	compatible = "marvell,rd-axpwifiap", "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x40000000>; /* 1GB */
> +	};
> +
> +	soc {
> +		ranges = <0          0 0xf1000000 0x100000  /* Internal registers 1MiB */
> +			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
> +
> +		internal-regs {
> +			pinctrl {
> +				pinctrl-0 = <&pmx_phy_int>;
> +				pinctrl-names = "default";
> +
> +				pmx_ge0: pmx-ge0 {
> +					marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> +						       "mpp4", "mpp5", "mpp6", "mpp7",
> +						       "mpp8", "mpp9", "mpp10", "mpp11";
> +					marvell,function = "ge0";
> +				};
> +
> +				pmx_ge1: pmx-ge1 {
> +					marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15",
> +						       "mpp16", "mpp17", "mpp18", "mpp19",
> +						       "mpp20", "mpp21", "mpp22", "mpp23";
> +					marvell,function = "ge1";
> +				};
> +
> +				pmx_keys: pmx-keys {
> +					marvell,pins = "mpp33";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_spi: pmx-spi {
> +					marvell,pins = "mpp36", "mpp37", "mpp38", "mpp39";
> +					marvell,function = "spi";
> +				};
> +
> +				pmx_phy_int: pmx-phy-int {
> +					marvell,pins = "mpp32";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			serial at 12000 {
> +				clock-frequency = <250000000>;
> +				status = "okay";
> +			};
> +
> +			serial at 12100 {
> +				clock-frequency = <250000000>;
> +				status = "okay";
> +			};
> +
> +			sata at a0000 {
> +				nr-ports = <1>;
> +				status = "okay";
> +			};
> +
> +			mdio {
> +				phy0: ethernet-phy at 0 {
> +					reg = <0>;
> +				};
> +
> +				phy1: ethernet-phy at 1 {
> +					reg = <1>;
> +				};
> +			};
> +
> +			ethernet at 70000 {
> +				pinctrl-0 = <&pmx_ge0>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
> +			};
> +			ethernet at 74000 {
> +				pinctrl-0 = <&pmx_ge1>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				phy = <&phy1>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			spi0: spi at 10600 {
> +				status = "okay";
> +				pinctrl-0 = <&pmx_spi>;
> +				pinctrl-names = "default";
> +
> +				spi-flash at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					compatible = "n25q128a13";
> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <108000000>;
> +				};
> +			};
> +
> +			pcie-controller {
> +				status = "okay";
> +
> +				/* First mini-PCIe port */
> +				pcie at 1,0 {
> +					/* Port 0, Lane 0 */
> +					status = "okay";
> +				};
> +
> +				/* Second mini-PCIe port */
> +				pcie at 2,0 {
> +					/* Port 0, Lane 1 */
> +					status = "okay";
> +				};
> +
> +				/* Renesas uPD720202 USB 3.0 controller */
> +				pcie at 3,0 {
> +					/* Port 0, Lane 3 */
> +					status = "okay";
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_keys>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Factory Reset Button";
> +			linux,code = <141>; /* KEY_SETUP */
> +			gpios = <&gpio1 1 1>;
> +		};
> +	};
> +};
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
