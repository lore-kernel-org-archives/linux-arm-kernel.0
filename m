From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 17 Apr 2014 20:08:40 +0200
Subject: [PATCH 2/4] ARM: Kirkwood: Add DT descriptions for net2big and
 net5big.
In-Reply-To: <1397750938-25381-3-git-send-email-andrew@lunn.ch>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
 <1397750938-25381-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140417180840.GX27979@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 06:08:56PM +0200, Andrew Lunn wrote:
> Describe LaCie 2Big and 5Big Network v2 using device tree.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Here is a very very quick review.

> ---
>  arch/arm/boot/dts/Makefile              |   2 +
>  arch/arm/boot/dts/kirkwood-net2big.dts  |  25 +++++
>  arch/arm/boot/dts/kirkwood-net5big.dts  |  67 ++++++++++++
>  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 182 ++++++++++++++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
> 

...

> diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
> new file mode 100644
> index 000000000000..7ce6006f3ea0
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
> @@ -0,0 +1,182 @@
> +/*
> + * Device Tree common file for LaCie 2Big and 5Big Network v2
> + *
> + * Copyright (C) 2014
> + *
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * Based on netxbig_v2-setup.c,
> + * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> +*/
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};

The 2Big and 5Big Network v2 boards comes with a different amount of
memory: respectively 256MB and 512MB.

> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			status = "ok";
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
> +				compatible = "mxicy,mx25l4005a";
> +				reg = <0>;
> +				spi-max-frequency = <20000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +			};
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * button at 1 and button at 2 represent a three position rocker
> +		 * switch. Thus the conventional KEY_POWER does not fit
> +		 */
> +		button at 1 {
> +			label = "Back power switch (on|auto)";
> +			linux,code = <KEY_ESC>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +		};
> +		button at 2 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <KEY_1>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> +		};
> +		button at 3 {
> +			label = "Function button";
> +			linux,code = <KEY_OPTION>;
> +			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +       	regulators: regulators {
> +                status = "okay";
> +                compatible = "simple-bus";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                pinctrl-names = "default";
> +
> +                regulator at 1 {
> +                        compatible = "regulator-fixed";
> +                        reg = <1>;
> +                        regulator-name = "hdd0power";
> +                        regulator-min-microvolt = <5000000>;
> +                        regulator-max-microvolt = <5000000>;
> +                        enable-active-high;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                        gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +                };
> +
> +                regulator at 2 {
> +                        compatible = "regulator-fixed";
> +                        reg = <2>;
> +                        regulator-name = "hdd1power";
> +                        regulator-min-microvolt = <5000000>;
> +                        regulator-max-microvolt = <5000000>;
> +                        enable-active-high;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                        gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> +                };
> +
> +        };
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		reg = <8>;
> +	};
> +
> +	ethphy1: ethernet-phy at 1 {
> +		reg = <0>;
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
> +&eth1 {
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};

The 2Big Network v2 only have a single Ethernet port.

Thanks for this patch,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/b1e032cc/attachment-0001.sig>
