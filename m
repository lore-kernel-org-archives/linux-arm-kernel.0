From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Oct 2016 17:28:57 +0530
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <1477075018-20176-6-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
Message-ID: <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
> This adds a device tree definition file for LEGO MINDSTORMS EV3.

Thanks for the patch!

> 
> What is working:
> 
> * Pin muxing
> * MicroSD card reader
> * UART on input port 1
> 
> What is partially working:
> 
> * Buttons - working after GPIO fix
> * LEDs - working after GPIO fix
> * Poweroff/reset - working after GPIO fix

Is the GPIO fix something that will go in v4.9-rc cycle ?

> * Flash memory - driver loads but can't read the block devices - this is
>   probably due to the fact that we are not able to configure the SPI to
>   use DMA via device tree

Hmm, I would not have expected PIO mode to be so inefficient that you
are unable to even read the block device.

> * EEPROM - there seems to be a hardware bug that causes the first byte
>   read to be corrupted - this can be worked around by adding an I2C stop
>   between writing the register and reading the data, but the at24 driver
>   does not have an option to do this
> 
> What is not working/to be added later:
> 
> * Display - waiting for "tiny DRM" to be mainlined
> * Speaker - needs new PWM sound driver
> * USB - waiting for OHCI and MUSB device tree support to be mainlined
> * ADC - needs new iio driver
> * GPIOs - broken because of recent changes to core gpio driver
> * Bluetooth - needs new driver for sequencing power/enable/clock
> * Input and output ports - need some sort of new phy or extcon driver
> * Battery - needs new power supply driver (depends on ADC iio driver)
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/Makefile     |   3 +-
>  arch/arm/boot/dts/lego-ev3.dts | 454 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 456 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/lego-ev3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f80f5b7..5f91c1a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -116,7 +116,8 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
>  dtb-$(CONFIG_ARCH_DAVINCI) += \
>  	da850-lcdk.dtb \
>  	da850-enbw-cmc.dtb \
> -	da850-evm.dtb
> +	da850-evm.dtb \
> +	lego-ev3.dtb
>  dtb-$(CONFIG_ARCH_DIGICOLOR) += \
>  	cx92755_equinox.dtb
>  dtb-$(CONFIG_ARCH_EFM32) += \
> diff --git a/arch/arm/boot/dts/lego-ev3.dts b/arch/arm/boot/dts/lego-ev3.dts
> new file mode 100644
> index 0000000..a6b4c7d
> --- /dev/null
> +++ b/arch/arm/boot/dts/lego-ev3.dts
> @@ -0,0 +1,454 @@
> +/*
> + * Device tree for LEGO MINDSTORMS EV3
> + *
> + * Copyright (C) 2016 David Lechner <david@lechnology.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation, version 2.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +#include "da850.dtsi"
> +
> +/ {
> +	compatible = "lego,ev3", "ti,da850";
> +	model = "LEGO MINDSTORMS EV3";
> +
> +	soc at 1c00000 {
> +		/*
> +		 * (ab)using pinctrl-single to disable all internal pullups/
> +		 * pulldowns on I/O.
> +		 */
> +		pinmux at 22c00c {
> +			compatible = "pinctrl-single";
> +			reg = <0x22c00c 0x4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-single,bit-per-mux;
> +			pinctrl-single,register-width = <32>;
> +			pinctrl-single,function-mask = <0xf>;
> +			/*
> +			 * There is a bug in pinctrl-single that prevents us
> +			 * from setting function-mask to 1, so doing things
> +			 * in groups of 4. Doesn't really matter since we are
> +			 * disabling all at once anyway.
> +			 */
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pupu_disable>;
> +
> +			pupu_disable: pinmux_all_pins {
> +				pinctrl-single,bits = <
> +					0x0 0x00000000 0xffffffff
> +				>;
> +			};

Sigh. This is quite an abuse :)

I know we don't have a good way to configure this in kernel today. And I
am surprised we never had to care about disabling pullups so far. Can
you clarify why you need it? I assume there is some contention you want
to avoid, but on which interface?

I dont think this can be done this way using pinctrl-single. A small
driver to handle pullup/down control for da850 may have to be added to
drivers/pinctrl. It will be better to check with Linus Walleij on his
thoughts using a new thread ccing the pinctrl subsystem list as well.

[...]

> +	in1_pins: pinmux_in1_pins {
> +		pinctrl-single,bits = <
> +			/* GP0[15] */
> +			0x0 0x00000008 0x0000000f
> +			/* GP0[2] */
> +			0x4 0x00800000 0x00f00000
> +			/* GP2[2] */
> +			0x18 0x00800000 0x00f00000
> +			/* GP8[10], GP8[11] */
> +			0x48 0x88000000 0xff000000
> +		>;
> +	};

I see that this is not really used. Can you add these when you actually
use them. Looks like that applies to some other definitions like this below.

> +&ehrpwm1 {
> +	status = "disabled";

Hmm, disabled? Can you add this node when you actually use it?

> +	pinctrl-names = "default";
> +	/* MBPWM, MAPWM */
> +	pinctrl-0 = <&ehrpwm1a_pins>, <&ehrpwm1b_pins>;
> +};
> +
> +&ecap1 {
> +	status = "disabled";

same here and other places below.

> +	pinctrl-names = "default";
> +	/* MDPWM */
> +	pinctrl-0 = <&ecap1_pins>;
> +};
> +
> +&spi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>, <&spi0_cs3_pin>;
> +	dmas = <&edma0 14 0>, <&edma0 15 0>;
> +	dma-names = "rx", "tx";
> +
> +	spi-flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q128a13", "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +		ti,spi-wdelay = <8>;
> +
> +		partition at 0 {
> +			label = "U-Boot";
> +			reg = <0 0x40000>;

Thats 256KB for U-Boot and MLO (I assume in concatenated AIS image). Is
that sufficient for future too? Moving partitions later is tough ask
because that means users will lose data when they upgrade the kernel
because of partitions moving around. Just a suggestion to keep future
U-Boot bloat in mind and not use a "just fits" number.

> +		};
> +
> +		partition at 40000 {
> +			label = "U-Boot Env";
> +			reg = <0x40000 0x10000>;
> +		};
> +
> +		partition at 50000 {
> +			label = "Kernel";
> +			reg = <0x50000 0x200000>;
> +		};
> +
> +		partition at 250000 {
> +			label = "Filesystem";
> +			reg = <0x250000 0xa50000>;
> +		};
> +
> +		partition at cb0000 {
> +			label = "Storage";
> +			reg = <0xcb0000 0x2f0000>;
> +		};
> +	};
> +
> +	/* TODO: ADC goes here */

I would drop this comment.

> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins>, <&spi1_cs0_pin>;
> +
> +	/* TODO: LCD Display goes here */

Add this node when you actually have display working.

Thanks,
Sekhar
