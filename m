From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Dec 2014 17:07:26 +0100
Subject: [PATCH 5/5] ARM: mvebu: Add Armada 385 Access Point Development
 Board support
In-Reply-To: <1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141205170726.2e2335af@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Fri,  5 Dec 2014 15:44:58 +0100, Maxime Ripard wrote:

> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> +			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000	/* CESA0: PHYS=0xf1100000
> +									   size 64K */
> +			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;	/* CESA1: PHYS=0xf1110000
> +									   size 64K */

Those two last ranges are not needed, and may not necessarily match what
we decide to do with the crypto engine support later on.

> +			mdio at 72004 {
> +				pinctrl-names = <&phy_pins>;

These are not really "PHY" pins, but rather MDIO pins.

> +			pinctrl at 18000 {
> +				ge0_pins: ge-pins-0 {
> +					marvell,pins = "mpp6", "mpp7", "mpp8",
> +						       "mpp9", "mpp10", "mpp11",
> +						       "mpp12", "mpp13", "mpp14",
> +						       "mpp15", "mpp16", "mpp17";
> +					marvell,function = "ge0";
> +				};

This seems like the normal pin muxing for RGMII, so maybe we should
simply do like we did for Armada 370: have a ge0-rgmii-pins definition
in the .dtsi file.

> +				i2c0_pins: i2c-pins-0 {
> +					marvell,pins = "mpp2", "mpp3";
> +					marvell,function = "i2c0";
> +				};

Same question here, maybe define it in .dtsi ?

> +
> +				phy_pins: phy-pins {
> +					marvell,pins = "mpp4", "mpp5";
> +					marvell,function = "ge";
> +				};

Same here.

> +
> +				ref_clk0_pins: ref-clk-pins-0 {
> +					marvell,pins = "mpp45";
> +					marvell,function = "ref";
> +				};
> +
> +				spi1_pins: spi-pins-1 {
> +					marvell,pins = "mpp56", "mpp57", "mpp58",
> +						       "mpp59";
> +					marvell,function = "spi1";
> +				};
> +
> +				uart0_pins: uart-pins-0 {
> +					marvell,pins = "mpp0", "mpp1";
> +					marvell,function = "ua0";
> +				};
> +
> +				uart1_pins: uart-pins-1 {
> +					marvell,pins = "mpp19", "mpp20";
> +					marvell,function = "ua1";
> +				};
> +
> +				xhci0_vbus_pins: xhci0-vbus-pins {
> +					marvell,pins = "mpp44";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			ethernet at 30000 {
> +				status = "okay";
> +				phy = <&phy1>;
> +				phy-mode = "sgmii";
> +			};
> +
> +			ethernet at 34000 {
> +				status = "okay";
> +				phy = <&phy2>;
> +				phy-mode = "sgmii";
> +			};
> +
> +			ethernet at 70000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&ge0_pins>, <&ref_clk0_pins>;

Maybe a short comment about what this ref_clk0_pins is useful for would
be nice.

> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			usb3 at f0000 {
> +				status = "okay";
> +			};

The board also has an USB2 connector, did you try enabling it?

> +		};
> +
> +		pcie-controller {
> +			status = "okay";
> +			/*
> +			 * The two PCIe units are accessible through
> +			 * standard PCIe slots on the board.

Two, or three ? :-)

> +			 */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			pcie at 2,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			pcie at 3,0 {
> +				/* Port 2, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	reg_xhci0_vbus: xhci0-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&xhci0_vbus_pins>;
> +		regulator-name = "xhci0-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +	};

Maybe you could connect this to the USB controller by using the
usb-nop-xceiv thing (which acts as a dummy USB PHY, if I understood
correctly) ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
