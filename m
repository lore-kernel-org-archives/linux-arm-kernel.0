From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Apr 2012 18:20:48 +0200
Subject: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
In-Reply-To: <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
References: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
 <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
Message-ID: <4F885260.9080900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xu Hong,

Some comments below...

(you may also include devicetree-discuss at lists.ozlabs.org as well)

On 04/12/2012 08:26 AM, Hong Xu :
> Added AT91SAM9N12 SoC DT file, as well as the board definition file
> for AT91SAM9N12-EK
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9n12.dtsi  |  223 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9n12ek.dts |  111 +++++++++++++++++
>  2 files changed, 334 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> new file mode 100644
> index 0000000..e86372d
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -0,0 +1,223 @@
> +/*
> + * at91sam9n12.dtsi - Device Tree include file for AT91SAM9N12 SoC
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Hong Xu <hong.xu@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9N12 SoC";
> +	compatible = "atmel,at91sam9n12";
> +	interrupt-parent = <&aic>;
> +
> +	aliases {
> +		serial0 = &dbgu;
> +		serial1 = &usart0;
> +		serial2 = &usart1;
> +		serial3 = &usart2;
> +		serial4 = &usart3;
> +		gpio0 = &pioA;
> +		gpio1 = &pioB;
> +		gpio2 = &pioC;
> +		gpio3 = &pioD;
> +		tcb0 = &tcb0;
> +		tcb1 = &tcb1;
> +	};
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,arm926ejs";
> +		};
> +	};
> +
> +	memory at 20000000 {
> +		reg = <0x20000000 0x10000000>;
> +	};
> +
> +	ahb {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		apb {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			aic: interrupt-controller at fffff000 {
> +				#interrupt-cells = <2>;
> +				compatible = "atmel,at91rm9200-aic";
> +				interrupt-controller;
> +				interrupt-parent;
> +				reg = <0xfffff000 0x200>;
> +			};
> +
> +			ramc0: ramc at ffffe800 {
> +				compatible = "atmel,at91sam9g45-ddramc";
> +				reg = <0xffffe800 0x200>;
> +			};
> +
> +			pmc: pmc at fffffc00 {
> +				compatible = "atmel,at91rm9200-pmc";
> +				reg = <0xfffffc00 0x100>;
> +			};
> +
> +			rstc at fffffe00 {
> +				compatible = "atmel,at91sam9g45-rstc";
> +				reg = <0xfffffe00 0x10>;
> +			};
> +
> +			pit: timer at fffffe30 {
> +				compatible = "atmel,at91sam9260-pit";
> +				reg = <0xfffffe30 0xf>;
> +				interrupts = <1 4>;
> +			};
> +
> +
> +			shdwc at fffffe10 {
> +				compatible = "atmel,at91sam9n12-shdwc";

I think that shdwc is compatible with "atmel,at91sam9x5-shdwc", is not it?


> +				reg = <0xfffffe10 0x10>;
> +			};
> +
> +			tcb0: timer at f8008000 {
> +				compatible = "atmel,at91sam9n12-tcb";

Here also, I suspect a compatibility with: "atmel,at91sam9x5-tcb"

> +				reg = <0xf8008000 0x100>;
> +				interrupts = <17 4>;
> +			};
> +
> +			tcb1: timer at f800c000 {
> +				compatible = "atmel,at91sam9n12-tcb";

Ditto.

> +				reg = <0xf800c000 0x100>;
> +				interrupts = <17 4>;
> +			};
> +
> +			dma: dma-controller at ffffec00 {
> +				compatible = "atmel,at91sam9g45-dma";
> +				reg = <0xffffec00 0x200>;
> +				interrupts = <20 4>;
> +			};
> +
> +			pioA: gpio at fffff400 {
> +				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +				reg = <0xfffff400 0x100>;
> +				interrupts = <2 4>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +			};
> +
> +			pioB: gpio at fffff600 {
> +				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +				reg = <0xfffff600 0x100>;
> +				interrupts = <2 4>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +			};
> +
> +			pioC: gpio at fffff800 {
> +				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +				reg = <0xfffff800 0x100>;
> +				interrupts = <3 4>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +			};
> +
> +			pioD: gpio at fffffa00 {
> +				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +				reg = <0xfffffa00 0x100>;
> +				interrupts = <3 4>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +			};
> +
> +			dbgu: serial at fffff200 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xfffff200 0x200>;
> +				interrupts = <1 4>;
> +				status = "disabled";
> +			};
> +
> +			usart0: serial at f801c000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf801c000 0x4000>;
> +				interrupts = <5 4>;
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
> +				status = "disabled";
> +			};
> +
> +			usart1: serial at f8020000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8020000 0x4000>;
> +				interrupts = <6 4>;
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
> +				status = "disabled";
> +			};
> +
> +			usart2: serial at f8024000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8024000 0x4000>;
> +				interrupts = <7 4>;
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
> +				status = "disabled";
> +			};
> +
> +			usart3: serial at f8028000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8028000 0x4000>;
> +				interrupts = <8 4>;
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
> +				status = "disabled";
> +			};
> +		};
> +
> +		nand0: nand at 40000000 {
> +			compatible = "atmel,at91rm9200-nand";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = < 0x40000000 0x10000000
> +				0xffffe000 0x00000600
> +				0xffffe600 0x00000200
> +				0x00100000 0x00100000
> +			       >;
> +			atmel,nand-addr-offset = <21>;
> +			atmel,nand-cmd-offset = <22>;
> +			gpios = <&pioD 5 0
> +				 &pioD 4 0
> +				 0
> +				>;
> +			status = "disabled";
> +		};
> +
> +		usb0: ohci at 00500000 {
> +			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> +			reg = <0x00500000 0x00100000>;
> +			interrupts = <22 4>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	i2c at 0 {
> +		compatible = "i2c-gpio";
> +		gpios = <&pioA 30 0 /* sda */
> +			 &pioA 31 0 /* scl */
> +			>;
> +		i2c-gpio,sda-open-drain;
> +		i2c-gpio,scl-open-drain;
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> new file mode 100644
> index 0000000..56b012f
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -0,0 +1,111 @@
> +/*
> + * at91sam9n12ek.dts - Device Tree file for AT91SAM9N12-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Hong Xu <hong.xu@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9n12.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9N12-EK";
> +	compatible = "atmel,at91sam9n12ek", "atmel,at91sam9n12", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "mem=128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2";
> +	};
> +
> +	memory at 20000000 {
> +		reg = <0x20000000 0x10000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <16000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			tcb0: timer at f8008000 {
> +				status = "okay";

No need for this node, tcb0 is already enabled.

> +			};
> +
> +			tcb1: timer at f800c000 {
> +				status = "okay";

Ditto.

> +			};
> +		};
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";

No, HW PMECC code is not included in mainline yet. You should submit
9n12 with sw ECC for the moment. We will change this argument afterwards.


> +			/*
> +			nand-on-flash-bbt;
> +			*/

You can keep this one, or remove it completely.

> +			atmel,pmecc-cap = <2>;
> +			atmel,sector-size = <512>;

Later for those PMECC related bindings. You can submit them with the
PMECC series BTW.

> +			status = "okay";
> +
> +			boot at 0 {
> +				label = "bootstrap/uboot/kernel";
> +				reg = <0x0 0x400000>;
> +			};
> +
> +			rootfs at 400000 {
> +				label = "rootfs";
> +				reg = <0x400000 0x3C00000>;
> +			};
> +
> +			data at 4000000 {
> +				label = "data";
> +				reg = <0x4000000 0xC000000>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		d8 {
> +			label = "d8";
> +			gpios = <&pioB 4 1>;
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		d9 {
> +			label = "d6";
> +			gpios = <&pioB 5 1>;
> +			linux,default-trigger = "nand-disk";
> +		};
> +
> +		d10 {
> +			label = "d7";
> +			gpios = <&pioB 6 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		enter {
> +			label = "Enter";
> +			gpios = <&pioB 4 1>;
> +			linux,code = <28>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};

Bye,
-- 
Nicolas Ferre
