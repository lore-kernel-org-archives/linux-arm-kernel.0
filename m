From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Jul 2017 13:09:06 -0700
Subject: [PATCH 3/3] ARM: dts: bcm2835: Add Raspberry Pi Zero W
In-Reply-To: <1500579429-9101-4-git-send-email-stefan.wahren@i2se.com>
References: <1500579429-9101-1-git-send-email-stefan.wahren@i2se.com>
 <1500579429-9101-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87vamfx8nx.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The Raspberry Pi Zero W has the same components like the Zero plus
> a Cypress CYW43438 wireless chip (wifi + bl).

I sent out v2 of the arm64 patch so that hopefully we can get started
merging this.  Couple of comments on a re-read.

> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/boot/dts/Makefile               |  3 +-
>  arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 73 ++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ec60f4f..f3bf9397 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -74,7 +74,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2835-rpi-a-plus.dtb \
>  	bcm2836-rpi-2-b.dtb \
>  	bcm2837-rpi-3-b.dtb \
> -	bcm2835-rpi-zero.dtb
> +	bcm2835-rpi-zero.dtb \
> +	bcm2835-rpi-zero-w.dtb
>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>  	bcm4708-asus-rt-ac56u.dtb \
>  	bcm4708-asus-rt-ac68u.dtb \
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> new file mode 100644
> index 0000000..9c6d714
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (C) 2017 Stefan Wahren <stefan.wahren@i2se.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "bcm2835.dtsi"
> +#include "bcm2835-rpi.dtsi"
> +#include "bcm283x-rpi-usb-host.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,model-zero-w", "brcm,bcm2835";
> +	model = "Raspberry Pi Zero W";
> +
> +	aliases {
> +		uart0 = "/soc/serial at 7e201000";
> +		uart1 = "/soc/serial at 7e215040";
> +		serial0 = "/soc/serial at 7e201000";
> +		serial1 = "/soc/serial at 7e215040";
> +	};

Should we have this in the other board DTs?  What does it do?

> +
> +	leds {
> +		act {
> +			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wl_on>;
> +		reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&gpio {
> +	pinctrl-0 = <&gpioout &alt0>;
> +
> +	wl_on: wl-on {
> +		brcm,pins = <41>;
> +		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
> +	};
> +};

Would you be up for adding gpio-line-names based on the dt-blob.dts?

> +
> +&hdmi {
> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
> +};
> +
> +&sdhci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	status = "okay";
> +
> +	brcmf: wifi at 1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_gpio14>;
> +	status = "okay";
> +};
> -- 
> 2.7.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/dc6e8710/attachment.sig>
