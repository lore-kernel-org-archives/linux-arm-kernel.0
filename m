From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 09:43:59 +0100
Subject: [PATCH] ARM: dts: sun8i: h3: Add dts file for Libre Computer
 Board ALL-H3-CC H3 ver.
In-Reply-To: <20171128041211.17375-1-wens@csie.org>
References: <20171128041211.17375-1-wens@csie.org>
Message-ID: <20171128084359.rzplftb3z53cgukp@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 28, 2017 at 12:12:11PM +0800, Chen-Yu Tsai wrote:
> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
> Pi B+ form factor single board computer based on the Allwinner H3 SoC.
> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
> and connectors are in the exact same position as on the Raspberry Pi B+.
> 
> Raspberry Pi B+ like peripherals supported on this board include:
> 
>   - Power input through micro-USB connector (without USB OTG)
>   - Native 100 Mbps ethernet using the internal PHY, as opposed to
>     USB-based on the RPi
>   - 4x USB 2.0 host ports, directly connected to the SoC, as opposed to
>     being connected through a USB 2.0 hub on the RPi
>   - TV and audio output on a 3.5mm TRRS jack
>   - HDMI output
>   - Micro-SD card slot
>   - Standard RPi B+ GPIO header, with the standard peripherals routed to
>     the same pins.
> 
>     * 5V, 3.3V power, and ground
>     * I2C0 on the H3 is routed to I2C1 pins on the RPi header
>     * I2C1 on the H3 is routed to I2C0 pins on the RPi header
>     * UART1 on the H3 is routed to UART0 pins on the RPi header
>     * SPI0 on the H3 is routed to SPI0 pins on the RPi header,
>       with GPIO pin PA17 replacing the missing Chip Select 1
>     * I2S1 on the H3 is routed to PCM pins on the RPi header
> 
>   - Additional peripherals from the H3 are available on different pins.
>     These include I2S0, JTAG, PWM1, SPDIF, SPI1, and UART3
> 
> In addition, there are a number of new features:
> 
>   - Console UART header
>   - Consumer IR receiver
>   - Camera interface (not compatible with RPi)
>   - Onboard microphone
>   - eMMC expansion module port
>   - Heatsink mounting holes
> 
> This patch adds a dts file for this board that enables all "onboard"
> peripherals currently supported. This means no display or camera
> support.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> There are two other variants [1] of this board, with different SoCs and
> DRAM configuration. But the board remains the same, thanks to the SoCs
> being pin compatible.
> 
> Do we need different board compatible strings?

Yes.

> FWIW the soc compatible string already encodes the soc variant, and
> the DRAM stuff is handled by the bootloader. The filename also has
> the SoC family and chip name.  The displayed board model also has
> the SoC variant included. The board itself is named "ALL-H3-CC".

The point of a board compatible is to identify the way a board
behaves. If we ever need to make any quirks for one particular board,
we have to have a compatible that uniquely identifies it.

However, we can have an intermediate compatible as well to catch all
those similar boards.

Something like:
   compatible = "libretech,h3-tritium", "libretech,tritium", "allwinner,sun8i-h3";

> I'm asking as we have the same issue with the Bananapi M2+ [2], where
> they've released new variants with different SoCs and DRAM capacities
> using the same board. Not sure if they are commercially available though.

You can have a look at the way we handled all the q8 tablets that were
pretty much in the same case. It's been working quite well.

> Last, the LED polarity is wrong. This is due to the EMAC driver not
> following the DT binding and looking for the "allwinner,leds-active-low"
> under the PHY node, instead of the EMAC node. I've notified Corentin of
> this issue.

The DT should be correct, even if the code isn't. This seems to be a
driver bug that should be fixed, but we don't want to change the DT.

> [1] https://www.kickstarter.com/projects/librecomputer/libre-computer-board-tritium-sbc-linux-android-7-n
> [2] http://www.banana-pi.org/m2plus.html
> ---
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 196 +++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3c139c63098f..aa68f719692f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -953,6 +953,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-h2-plus-orangepi-zero.dtb \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
> +	sun8i-h3-libretech-all-h3-cc.dtb \

Any reason to use the code name and not the "marketing" name?

>  	sun8i-h3-nanopi-m1.dtb	\
>  	sun8i-h3-nanopi-m1-plus.dtb \
>  	sun8i-h3-nanopi-neo.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> new file mode 100644
> index 000000000000..6f544e007f71
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +/dts-v1/;
> +#include "sun8i-h3.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Libre Computer Board ALL-H3-CC H3";
> +	compatible = "libretech,all-h3-cc", "allwinner,sun8i-h3";
> +
> +	aliases {
> +		ethernet0 = &emac;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pwr_led {
> +			label = "librecomputer:pwr";

You should have the color there too.

> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
> +			default-state = "on";
> +		};
> +
> +		status_led {
> +			label = "librecomputer:status";

Same thing here.

> +			gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		recovery {
> +			label = "recovery";
> +			linux,code = <BTN_0>;

How did you pick that keycode?

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/0a936996/attachment.sig>
