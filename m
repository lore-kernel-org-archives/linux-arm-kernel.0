From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Jan 2015 16:57:05 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150106155705.GB23784@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 04:28:20PM +0100, Maxime Ripard wrote:

Hi Maxime

> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-ap.dts
> @@ -0,0 +1,140 @@
> +/*
> + * Device Tree file for Marvell Armada 385 Access Point Development board
> + * (DB-88F6820-AP)
> + *
> + *  Copyright (C) 2014 Marvell
> + *
> + * Nadav Haklai <nadavh@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

Gregory is in the process of dual licensing some of the other mvebu DT
files. This one is single license. Should it be dual?

> +
> +/dts-v1/;
> +#include "armada-385.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Marvell Armada 385 Access Point Development Board";
> +	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada38x";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";

Humm, ttyS0? Then why add the LL_DEBUG via UART1?

Maybe add

stdout-path = &uart1;

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000>; /* 2GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
> +
> +		internal-regs {
> +			spi1: spi at 10680 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&spi1_pins>;
> +				status = "okay";
> +
> +				spi-flash at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					compatible = "st,m25p128";
> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <108000000>;
> +				};
> +			};
> +
> +			i2c0: i2c at 11000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c0_pins>;
> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};
> +
> +			i2c1: i2c at 11100 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};

Is there anything on these two i2c busses? If not, why enable them and
increase the clock speed?

> +			mdio at 72004 {
> +				pinctrl-names = <&mdio_pins>;
> +
> +				phy0: ethernet-phy at 0 {
> +					reg = <1>;
> +				};
> +
> +				phy1: ethernet-phy at 1 {
> +					reg = <6>;
> +				};
> +
> +				phy2: ethernet-phy at 2 {
> +					reg = <4>;
> +				};
> +			};
> +
> +			uart0: serial at 12000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart0_pins>;
> +				status = "okay";
> +			};
> +
> +			uart1: serial at 12100 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart1_pins>;
> +				status = "okay";
> +			};

If it is not obvious from the silk screen, could you describe which
connector this uart is on, what pins are what?

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
> +
> +				/*
> +				 * The Reference Clock 0 is used to
> +				 * provide a clock to the PHY
> +				 */

Does this clock need enabling? Should it be listed in the clocks
property?

Thanks
	Andrew

> +				pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
> +			};
> +		};
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/*
> +			 * The three PCIe units are accessible through
> +			 * standard mini-PCIe slots on the board.
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
> +};
> -- 
> 2.2.1
> 
