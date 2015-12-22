From: alex.aring@gmail.com (Alexander Aring)
Date: Tue, 22 Dec 2015 11:11:33 +0100
Subject: [PATCH v2 6/8] ARM: bcm2835: Add devicetree for bcm2836 and
 Raspberry Pi 2 B
In-Reply-To: <1450310115-22163-7-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <1450310115-22163-7-git-send-email-eric@anholt.net>
Message-ID: <20151222101131.GA566@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 03:55:13PM -0800, Eric Anholt wrote:
> The Pi 2 B ends up like a Pi 1 B+, with the same peripherals and
> pinout, but the CPU and memory layout changed to use the 2836.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts | 35 ++++++++++++++++
>  arch/arm/boot/dts/bcm2836.dtsi        | 77 +++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2836-rpi-2-b.dts
>  create mode 100644 arch/arm/boot/dts/bcm2836.dtsi
> 
> diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> new file mode 100644
> index 0000000..ff94666
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> @@ -0,0 +1,35 @@
> +/dts-v1/;
> +#include "bcm2836.dtsi"
> +#include "bcm2835-rpi.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
> +	model = "Raspberry Pi 2 Model B";
> +
> +	memory {
> +		reg = <0 0x40000000>;
> +	};
> +
> +	leds {
> +		act {
> +			gpios = <&gpio 47 0>;
> +		};
> +
> +		pwr {
> +			label = "PWR";
> +			gpios = <&gpio 35 0>;
> +			default-state = "keep";
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +};
> +
> +&gpio {
> +	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
> +
> +	/* I2S interface */
> +	i2s_alt0: i2s_alt0 {
> +		brcm,pins = <18 19 20 21>;
> +		brcm,function = <BCM2835_FSEL_ALT0>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
> new file mode 100644
> index 0000000..6693118
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2836.dtsi
> @@ -0,0 +1,77 @@
> +#include "bcm283x.dtsi"
> +
> +/ {
> +	compatible = "brcm,bcm2836";
> +
> +	soc {
> +		ranges = <0x7e000000 0x3f000000 0x1000000>,

nitpik, I would change it here to 0x01000000 for the size parameter,
like below: 8-byte filled with zeroes.

> +			 <0x40000000 0x40000000 0x00001000>;

Is 0x00001000 correct here? I currently debug this part because the
devicetree issues which I mentioned. I looked into some bcm2836
datasheet. See [0], section "4 Registers", I assume this should be 0x00000100.
Or are there more than these registers which need to be accessable?

- Alex

[0] https://github.com/raspberrypi/documentation/blob/master/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
