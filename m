From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jul 2018 22:56:27 +0200
Subject: [PATCH 3/3] ARM: dts: Add devicetree for Storlink/Storm SL93512R
In-Reply-To: <20180704191759.12577-3-linus.walleij@linaro.org>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-3-linus.walleij@linaro.org>
Message-ID: <20180704205627.GF23469@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 09:17:59PM +0200, Linus Walleij wrote:
> The Storlink Gemini324 EV-Board also known as Storm
> Semiconductor SL93512R_BRD is ground zero for the Gemini
> devices. We add a device tree so we can support it, it
> turns out to be pretty trivial.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/gemini-sl93512r.dts | 325 ++++++++++++++++++++++++++
>  2 files changed, 326 insertions(+)
>  create mode 100644 arch/arm/boot/dts/gemini-sl93512r.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de760d40..a10ef98c6d75 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
>  	gemini-dlink-dns-313.dtb \
>  	gemini-nas4220b.dtb \
>  	gemini-rut1xx.dtb \
> +	gemini-sl93512r.dtb \
>  	gemini-sq201.dtb \
>  	gemini-wbd111.dtb \
>  	gemini-wbd222.dtb
> diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini-sl93512r.dts
> new file mode 100644
> index 000000000000..6160538bbb54
> --- /dev/null
> +++ b/arch/arm/boot/dts/gemini-sl93512r.dts
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the Storm Semiconductor SL93512R_BRD
> + * Gemini reference design, also initially called
> + * "Gemini324 EV-Board" before Storm acquired Storlink Semiconductor.
> + * The series were later acquired by Cortina Systems.
> + */
> +
> +/dts-v1/;
> +
> +#include "gemini.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Storlink Semiconductor Gemini324 EV-Board / Storm Semiconductor SL93512R_BRD";
> +	compatible = "storlink,gemini324", "storm,sl93512r", "cortina,gemini";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	memory at 0 {
> +		/* 64 MB Samsung K4H511638B */
> +		device_type = "memory";
> +		reg = <0x00000000 0x4000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,19200n8 root=/dev/sda1 rw rootwait";
> +		stdout-path = &uart0;

Hi Linus

You should put the baud rate as part of the stdout-patch, not in bootargs.

> +	mdio0: ethernet-phy {

mdio0: mdio

> +		compatible = "virtual,mdio-gpio";
> +		/* Uses MDC and MDIO */
> +		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> +			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* This is a Marvell 88E1111 ethernet transciever */
> +		phy0: ethernet-phy at 1 {
> +			reg = <1>;
> +			device_type = "ethernet-phy";

No device_type please.

> +		};
> +	};
> +
> +	spi {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		/* Check pin collisions */
> +		gpio-sck = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +
> +		switch at 0 {
> +			compatible = "vitesse,vsc7385";
> +			reg = <0>;
> +			/* Specified for 2.5 MHz or below */
> +			spi-max-frequency = <2500000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					label = "lan1";
> +				};
> +				port at 1 {
> +					reg = <1>;
> +					label = "lan2";
> +				};
> +				port at 2 {
> +					reg = <2>;
> +					label = "lan3";
> +				};
> +				port at 3 {
> +					reg = <3>;
> +					label = "lan4";
> +				};
> +				vsc: port at 6 {
> +					reg = <6>;
> +					label = "cpu";
> +					ethernet = <&gmac1>;
> +					phy-mode = "rgmii";
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +						pause;
> +					};
> +				};
> +			};
> +		};
> +	};

> +		ethernet at 60000000 {
> +			status = "okay";
> +
> +			ethernet-port at 0 {
> +				phy-mode = "rgmii";
> +				phy-handle = <&phy0>;
> +			};
> +			ethernet-port at 1 {
> +				phy-mode = "rgmii";
> +				phy-handle = <&vsc>;

This looks odd. The switch port is not a PHY. Normally you use a
fixed-phy.

	Andrew
