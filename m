From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 3 Mar 2016 14:20:34 -0700
Subject: [PATCH 1/5] ARM: bcm2835: Define standard pinctrl groups in the
 gpio node.
In-Reply-To: <1456510756-15337-2-git-send-email-eric@anholt.net>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-2-git-send-email-eric@anholt.net>
Message-ID: <56D8AAA2.60907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 11:19 AM, Eric Anholt wrote:
> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> function selects do for the pins, and there are a bunch of obvious
> groupings to be made.  With these created, we'll be able to replace
> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> references to specific groups we want enabled.

> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi

> +			spi0_gpio7: spi0_gpio7 {
> +				brcm,pins = <7 8 9 10 11>;
> +				brcm,function = <BCM2835_FSEL_ALT0>;
> +			};

This is too many pins.

- It includes both MOSI and MISO, although a particular use-case may 
only use 1 of those.

- It includes both chip-select signals, whereas a particular use-case 
may use 0, 1, or 2 of those. This is especially true since IIRC the 
mainline bcm283x SPI driver wants to only use GPIOs for chip-selects, 
not SPI-controller-generated chip-select signals, to avoid some issues 
with the HW generation of these signals.

I believe a similar comment applies to other SPI nodes too.

> +			pcm_gpio18: pcm_gpio18 {
> +				brcm,pins = <18 19 20 21>;
> +				brcm,function = <BCM2835_FSEL_ALT0>;
> +			};

Here too, I wonder if some people might want only one of DIN/DOUT and 
not both?

> +			uart1_gpio36: uart1_gpio36 {
> +				brcm,pins = <36 37 38 39>;
> +				brcm,function = <BCM2835_FSEL_ALT2>;
> +			};

Similarly, I think for UARTS, TX/RX and RTS/CTS should always be in 
different nodes so people can choose 2- or 4-wire mode. Most of the UART 
nodes are already split like this, but this one isn't.

> +			emmc_gpio22: emmc_gpio22 {
> +				brcm,pins = <22 23 24 25 26 27>;
> +				brcm,function = <BCM2835_FSEL_ALT3>;
> +			};

1-wire (1 data wire, plus CLK/CMD) eMMC is possible in theory, although 
I don't know whether it makes sense to support this?
