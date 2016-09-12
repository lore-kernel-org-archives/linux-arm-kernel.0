From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 12 Sep 2016 20:19:16 +0200 (CEST)
Subject: [PATCH v2 2/6] ARM: dts: bcm283x: Define standard pinctrl
 groups in the gpio node.
In-Reply-To: <1473668576-22256-3-git-send-email-kraxel@redhat.com>
References: <1473668576-22256-1-git-send-email-kraxel@redhat.com>
 <1473668576-22256-3-git-send-email-kraxel@redhat.com>
Message-ID: <1273800480.83718.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerd,

> Gerd Hoffmann <kraxel@redhat.com> hat am 12. September 2016 um 10:22
> geschrieben:
> 
> 
> From: Eric Anholt <eric@anholt.net>
> 
> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> function selects do for the pins, and there are a bunch of obvious
> groupings to be made.  With these created, we'll be able to replace
> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> references to specific groups we want enabled.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> 
> squashed in:
>   ARM: dts: bcm283x: Add the emmc pin group to bcm283x.dtsi.
>   ARM: dts: bcm283x: Add a group for mapping pins 48-53 to sdhost.
>   ARM: dts: bcm283x: Add a new EMMC pin group from the downstream tree.
> 
> fixups by kraxel:
>   * fix spi0 name
>   * sort & group entries
>   * use pull defines
>   * add dpi group

this looks like a changelog. Please move this at the proper place before the
first "diff" and specify the version.

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 203
> +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 4d9f3ab..7b03b63 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -131,6 +131,209 @@
>  
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> +
> +			/* Defines pin muxing groups according to
> +			 * BCM2835-ARM-Peripherals.pdf page 102.
> +			 *
> +			 * While each pin can have its mux selected
> +			 * for various functions individually, some
> +			 * groups only make sense to switch to a
> +			 * particular function together.
> +			 */
> +			dpi_gpio4: dpi_gpio4 {
> +				brcm,pins = <0 1 2 3 4 5 6 7 8 9 10 11
> +					     12 13 14 15 16 17 18 19
> +					     20 21 22 23 24 25 26 27>;
> +				brcm,function = <BCM2835_FSEL_ALT2>;
> +			};

s/dpi_gpio4/dpi_gpio0

> +			emmc_gpio22: emmc_gpio22 {
> +				brcm,pins = <22 23 24 25 26 27>;
> +				brcm,function = <BCM2835_FSEL_ALT3>;
> +			};
> +			emmc_gpio34: emmc_gpio34 {
> +				brcm,pins = <34 35 36 37 38 39>;
> +				brcm,function = <BCM2835_FSEL_ALT3>;
> +				brcm,pull = <BCM2835_PUD_OFF
> +					     BCM2835_PUD_UP
> +					     BCM2835_PUD_UP
> +					     BCM2835_PUD_UP
> +					     BCM2835_PUD_UP
> +					     BCM2835_PUD_UP>;
> +			};
> +			emmc_gpio48: emmc_gpio48 {
> +				brcm,pins = <48 49 50 51 52 53>;
> +				brcm,function = <BCM2835_FSEL_ALT3>;
> +			};

Sorry, i didn't notice this before. The naming of these groups suggest 3 muxes
for the same eMMC interface. I thought there is a eMMC interface and a SD host
interface with different DMA channels.

> +
> ...
> +
> +			sdhost_gpio48: sdhost_gpio48 {
> +				brcm,pins = <48 49 50 51 52 53>;
> +				brcm,function = <BCM2835_FSEL_ALT0>;
> +			};

I think this incorrect. There is no function ALT0 for these pins, only ALT3.

Regards
Stefan
