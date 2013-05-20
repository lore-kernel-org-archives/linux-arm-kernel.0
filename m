From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:21:51 -0400
Subject: [RFC PATCH 4/5] ARM: mv78x00: Add the Device Tree support for
 MV78X00 family
In-Reply-To: <1368999578-19938-5-git-send-email-gregory.clement@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
 <1368999578-19938-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130520172151.GW31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 11:39:37PM +0200, Gregory CLEMENT wrote:
> This commit adds the Device Tree support for the mv78x00 SoC
> family. It adds an mv78x00.dtsi description of the mv78x00 SoC
> 
> So far, the Device Tree contains the interrupt controller, the GPIO
> bank, the UART controllers, the USB host controllers, the SATA
> controllers and the I2C controllers.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/mv78x00.dtsi | 126 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mv78x00.dtsi
> 
> diff --git a/arch/arm/boot/dts/mv78x00.dtsi b/arch/arm/boot/dts/mv78x00.dtsi
> new file mode 100644
> index 0000000..df496f5
> --- /dev/null
> +++ b/arch/arm/boot/dts/mv78x00.dtsi
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (C) 2013 Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "Marvell MV78X00 SoC";
> +	compatible = "marvell,mv78x00";
> +	interrupt-parent = <&intc>;
> +
> +	intc: interrupt-controller {
> +		compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0xf1020210 0x04>,
> +		      <0xf1020214 0x04>,
> +		      <0xf102020c 0x04>;
> +	};
> +
> +	ocp at f1000000 {
> +		compatible = "simple-bus";
> +		ranges = <0x00000000 0xf1000000 0x4000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gpio0: gpio at 10100 {
> +			compatible = "marvell,orion-gpio";
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +			reg = <0x10100 0x40>;
> +			ngpios = <32>;
> +			interrupts = <56>, <57>, <58>, <59>;
> +		};
> +
> +		serial at 12000 {
> +			compatible = "ns16550a";
> +			reg = <0x12000 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <12>;
> +			/* set clock-frequency in board dts */
> +			status = "disabled";
> +		};
> +
> +		serial at 12100 {
> +			compatible = "ns16550a";
> +			reg = <0x12100 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <13>;
> +			/* set clock-frequency in board dts */
> +			status = "disabled";
> +		};
> +
> +		serial at 12200 {
> +			compatible = "ns16550a";
> +			reg = <0x12200 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <14>;
> +			/* set clock-frequency in board dts */
> +			status = "disabled";
> +		};
> +
> +		serial at 12300 {
> +			compatible = "ns16550a";
> +			reg = <0x12300 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <15>;
> +			/* set clock-frequency in board dts */

We should probably add a note to these comments that this is only until
mv78x00 is converted to the clock infrastructure.

thx,

Jason.

> +			status = "disabled";
> +		};
> +
> +
> +		sata at a0000 {
> +			compatible = "marvell,orion-sata";
> +			reg = <0xa0000 0x5000>;
> +			interrupts = <26>;
> +			status = "disabled";
> +		};
> +
> +		i2c at 10000 {
> +			compatible = "marvell,mv64xxx-i2c";
> +			reg = <0x10000 0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <2>;
> +			clock-frequency = <100000>;
> +			status = "disabled";
> +		};
> +
> +		i2c at 11000 {
> +			compatible = "marvell,mv64xxx-i2c";
> +			reg = <0x11000 0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <3>;
> +			clock-frequency = <100000>;
> +			status = "disabled";
> +		};
> +
> +		ehci at 50000 {
> +			compatible = "marvell,orion-ehci";
> +			reg = <0x50000 0x1000>;
> +			interrupts = <16>;
> +			status = "disabled";
> +		};
> +
> +		ehci at 51000 {
> +			compatible = "marvell,orion-ehci";
> +			reg = <0x51000 0x1000>;
> +			interrupts = <17>;
> +			status = "disabled";
> +		};
> +
> +		ehci at 52000 {
> +			compatible = "marvell,orion-ehci";
> +			reg = <0x52000 0x1000>;
> +			interrupts = <18>;
> +			status = "disabled";
> +		};
> +
> +	};
> +};
> -- 
> 1.8.1.2
> 
