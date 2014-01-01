From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 1 Jan 2014 16:41:16 -0500
Subject: [RFC PATCH 1/3] arm: mvebu: add new dts file for old variant
 of Openblocks AX3-4
In-Reply-To: <1388508293-9141-2-git-send-email-gregory.clement@free-electrons.com>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
 <1388508293-9141-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140101214116.GY19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

Sorry, but we seem to have a fundamental mis-understanding here.  First,
whatever we end up deciding for the compatible strings needs to be
documented.  Which seems to have not made it into this series.

Second, I'm having trouble explaining this (in my head), so I'm adding
the DT ml so hopefully someone there can chime in.

AFAICT, the marvell,mv78230-i2c compatible string, added in v3.12, refers
to the IP block on the A0 revision of the SoC.  Since we have set that,
we've discovered that the A0 revision has an errata where offloading
doesn't work.  The B0 revision of the SoC has fixed offloading for i2c.

In my mind, this means that we should create a fix for the driver to
disable offloading unless it can determine it's running B0 or newer.
This is easy once we nail down the compatible strings.

The second thing we need to do is update the binding documentation so
that the devicetree can describe the hardware accurately.  I think we
should keep 'marvell,mv78230-i2c' as it is (the driver fix mentioned
above will disable offloading), and add a new compatible
string, 'marvell,mv78230-b0-i2c'.  The driver can then be updated to
enable offloading when it sees this compatible string, or it can
determine the SoC revision itself (via mach code).

Third, we need to be able to differentiate between the two shipped
AX3-4 boards by openblocks.  I think this should follow the same pattern
we decide for the i2c compatible string.  So, if we go with my proposal,
we would have plathome,openblocks-ax3-4 and
plathome,openblocks-ax3-4-b0.

Basically, I'm really uneasy about dropping marvell,mv78230-i2c and
essentially re-defining it to marvell,mv78230-a0-i2c.  It feels like
it's breaking backwards compatibility.  But I'm having trouble clearly
describing how Gregory's proposed change exactly does break backwards
compatibility.  Can a DT maintainer explain it more clearly than I?

thx,

Jason.

PS- Well, this ended up being a toppost.  Oops.  Sorry.

On Tue, Dec 31, 2013 at 05:44:51PM +0100, Gregory CLEMENT wrote:
> The first variants of Openblocks AX3-4 used the revision A0 of the
> Armada XP SoCs. These early variants have issues related to the i2c
> controller which prevent to use the offload mechanism and lead to a
> kernel hang during boot.
> 
> The new dts file uses the compatible string marvell,mv78230-a0-i2c for
> the i2c controller, thanks to this the driver disable the offload
> mechanism and the kernel no more hangs on these boards.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts |  40 +++++
>  .../dts/armada-xp-common-openblocks-ax3-4.dtsi     | 177 +++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 164 +------------------
>  3 files changed, 218 insertions(+), 163 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-common-openblocks-ax3-4.dtsi
> 
> diff --git a/arch/arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts
> new file mode 100644
> index 000000000000..b3ea65255c19
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts
> @@ -0,0 +1,40 @@
> +/*
> + * Device Tree file for OpenBlocks AX3-4 board with A0 SoC
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "armada-xp-common-openblocks-ax3-4.dtsi"
> +
> +/ {
> +	model = "PlatHome OpenBlocks AX3-4 board (A0 SoC)";
> +	compatible = "plathome,openblocks-ax3-4", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x00000000 0 0xC0000000>; /* 3 GB */
> +	};
> +
> +	soc {
> +
> +		internal-regs {
> +			i2c at 11000 {
> +				compatible = "marvell,mv78230-a0-i2c", "marvell,mv64xxx-i2c";
> +			};
> +			i2c at 11100 {
> +				compatible = "marvell,mv78230-a0-i2c", "marvell,mv64xxx-i2c";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/armada-xp-common-openblocks-ax3-4.dtsi b/arch/arm/boot/dts/armada-xp-common-openblocks-ax3-4.dtsi
> new file mode 100644
> index 000000000000..0d452b07baf5
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-common-openblocks-ax3-4.dtsi
> @@ -0,0 +1,177 @@
> +/*
> + * Device Tree file for OpenBlocks AX3-4 board
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include "armada-xp-mv78260.dtsi"
> +
> +/ {
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> +			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> +
> +		devbus-bootcs {
> +			status = "okay";
> +
> +			/* Device Bus parameters are required */
> +
> +			/* Read parameters */
> +			devbus,bus-width    = <8>;
> +			devbus,turn-off-ps  = <60000>;
> +			devbus,badr-skew-ps = <0>;
> +			devbus,acc-first-ps = <124000>;
> +			devbus,acc-next-ps  = <248000>;
> +			devbus,rd-setup-ps  = <0>;
> +			devbus,rd-hold-ps   = <0>;
> +
> +			/* Write parameters */
> +			devbus,sync-enable = <0>;
> +			devbus,wr-high-ps  = <60000>;
> +			devbus,wr-low-ps   = <60000>;
> +			devbus,ale-wr-ps   = <60000>;
> +
> +			/* NOR 128 MiB */
> +			nor at 0 {
> +				compatible = "cfi-flash";
> +				reg = <0 0x8000000>;
> +				bank-width = <2>;
> +			};
> +		};
> +
> +		pcie-controller {
> +			status = "okay";
> +			/* Internal mini-PCIe connector */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			serial at 12000 {
> +				clock-frequency = <250000000>;
> +				status = "okay";
> +			};
> +			serial at 12100 {
> +				clock-frequency = <250000000>;
> +				status = "okay";
> +			};
> +			pinctrl {
> +				led_pins: led-pins-0 {
> +					marvell,pins = "mpp49", "mpp51", "mpp53";
> +					marvell,function = "gpio";
> +				};
> +			};
> +			leds {
> +				compatible = "gpio-leds";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&led_pins>;
> +
> +				red_led {
> +					label = "red_led";
> +					gpios = <&gpio1 17 1>;
> +					default-state = "off";
> +				};
> +
> +				yellow_led {
> +					label = "yellow_led";
> +					gpios = <&gpio1 19 1>;
> +					default-state = "off";
> +				};
> +
> +				green_led {
> +					label = "green_led";
> +					gpios = <&gpio1 21 1>;
> +					default-state = "off";
> +					linux,default-trigger = "heartbeat";
> +				};
> +			};
> +
> +			gpio_keys {
> +				compatible = "gpio-keys";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				button at 1 {
> +					label = "Init Button";
> +					linux,code = <116>;
> +					gpios = <&gpio1 28 0>;
> +				};
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
> +
> +				phy2: ethernet-phy at 2 {
> +					reg = <2>;
> +				};
> +
> +				phy3: ethernet-phy at 3 {
> +					reg = <3>;
> +				};
> +			};
> +
> +			ethernet at 70000 {
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "sgmii";
> +			};
> +			ethernet at 74000 {
> +				status = "okay";
> +				phy = <&phy1>;
> +				phy-mode = "sgmii";
> +			};
> +			ethernet at 30000 {
> +				status = "okay";
> +				phy = <&phy2>;
> +				phy-mode = "sgmii";
> +			};
> +			ethernet at 34000 {
> +				status = "okay";
> +				phy = <&phy3>;
> +				phy-mode = "sgmii";
> +			};
> +			i2c at 11000 {
> +				status = "okay";
> +				clock-frequency = <400000>;
> +			};
> +			i2c at 11100 {
> +				status = "okay";
> +				clock-frequency = <400000>;
> +
> +				s35390a: s35390a at 30 {
> +					compatible = "s35390a";
> +					reg = <0x30>;
> +				};
> +			};
> +			sata at a0000 {
> +				nr-ports = <2>;
> +				status = "okay";
> +			};
> +
> +			/* Front side USB 0 */
> +			usb at 50000 {
> +				status = "okay";
> +			};
> +
> +			/* Front side USB 1 */
> +			usb at 51000 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> index 5695afcc04bf..1983de77c3ff 100644
> --- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> +++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> @@ -11,7 +11,7 @@
>   */
>  
>  /dts-v1/;
> -#include "armada-xp-mv78260.dtsi"
> +#include "armada-xp-common-openblocks-ax3-4.dtsi"
>  
>  / {
>  	model = "PlatHome OpenBlocks AX3-4 board";
> @@ -25,166 +25,4 @@
>  		device_type = "memory";
>  		reg = <0 0x00000000 0 0xC0000000>; /* 3 GB */
>  	};
> -
> -	soc {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> -			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> -			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> -
> -		devbus-bootcs {
> -			status = "okay";
> -
> -			/* Device Bus parameters are required */
> -
> -			/* Read parameters */
> -			devbus,bus-width    = <8>;
> -			devbus,turn-off-ps  = <60000>;
> -			devbus,badr-skew-ps = <0>;
> -			devbus,acc-first-ps = <124000>;
> -			devbus,acc-next-ps  = <248000>;
> -			devbus,rd-setup-ps  = <0>;
> -			devbus,rd-hold-ps   = <0>;
> -
> -			/* Write parameters */
> -			devbus,sync-enable = <0>;
> -			devbus,wr-high-ps  = <60000>;
> -			devbus,wr-low-ps   = <60000>;
> -			devbus,ale-wr-ps   = <60000>;
> -
> -			/* NOR 128 MiB */
> -			nor at 0 {
> -				compatible = "cfi-flash";
> -				reg = <0 0x8000000>;
> -				bank-width = <2>;
> -			};
> -		};
> -
> -		pcie-controller {
> -			status = "okay";
> -			/* Internal mini-PCIe connector */
> -			pcie at 1,0 {
> -				/* Port 0, Lane 0 */
> -				status = "okay";
> -			};
> -		};
> -
> -		internal-regs {
> -			serial at 12000 {
> -				clock-frequency = <250000000>;
> -				status = "okay";
> -			};
> -			serial at 12100 {
> -				clock-frequency = <250000000>;
> -				status = "okay";
> -			};
> -			pinctrl {
> -				led_pins: led-pins-0 {
> -					marvell,pins = "mpp49", "mpp51", "mpp53";
> -					marvell,function = "gpio";
> -				};
> -			};
> -			leds {
> -				compatible = "gpio-leds";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&led_pins>;
> -
> -				red_led {
> -					label = "red_led";
> -					gpios = <&gpio1 17 1>;
> -					default-state = "off";
> -				};
> -
> -				yellow_led {
> -					label = "yellow_led";
> -					gpios = <&gpio1 19 1>;
> -					default-state = "off";
> -				};
> -
> -				green_led {
> -					label = "green_led";
> -					gpios = <&gpio1 21 1>;
> -					default-state = "off";
> -					linux,default-trigger = "heartbeat";
> -				};
> -			};
> -
> -			gpio_keys {
> -				compatible = "gpio-keys";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				button at 1 {
> -					label = "Init Button";
> -					linux,code = <116>;
> -					gpios = <&gpio1 28 0>;
> -				};
> -			};
> -
> -			mdio {
> -				phy0: ethernet-phy at 0 {
> -					reg = <0>;
> -				};
> -
> -				phy1: ethernet-phy at 1 {
> -					reg = <1>;
> -				};
> -
> -				phy2: ethernet-phy at 2 {
> -					reg = <2>;
> -				};
> -
> -				phy3: ethernet-phy at 3 {
> -					reg = <3>;
> -				};
> -			};
> -
> -			ethernet at 70000 {
> -				status = "okay";
> -				phy = <&phy0>;
> -				phy-mode = "sgmii";
> -			};
> -			ethernet at 74000 {
> -				status = "okay";
> -				phy = <&phy1>;
> -				phy-mode = "sgmii";
> -			};
> -			ethernet at 30000 {
> -				status = "okay";
> -				phy = <&phy2>;
> -				phy-mode = "sgmii";
> -			};
> -			ethernet at 34000 {
> -				status = "okay";
> -				phy = <&phy3>;
> -				phy-mode = "sgmii";
> -			};
> -			i2c at 11000 {
> -				status = "okay";
> -				clock-frequency = <400000>;
> -			};
> -			i2c at 11100 {
> -				status = "okay";
> -				clock-frequency = <400000>;
> -
> -				s35390a: s35390a at 30 {
> -					compatible = "s35390a";
> -					reg = <0x30>;
> -				};
> -			};
> -			sata at a0000 {
> -				nr-ports = <2>;
> -				status = "okay";
> -			};
> -
> -			/* Front side USB 0 */
> -			usb at 50000 {
> -				status = "okay";
> -			};
> -
> -			/* Front side USB 1 */
> -			usb at 51000 {
> -				status = "okay";
> -			};
> -		};
> -	};
>  };
> -- 
> 1.8.1.2
> 
