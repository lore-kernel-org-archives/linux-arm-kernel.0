From: eric@anholt.net (Eric Anholt)
Date: Mon, 21 May 2018 11:26:02 -0700
Subject: [PATCH RFC] ARM: dts: add Raspberry Pi Compute Module and IO board
In-Reply-To: <1526589872-13459-1-git-send-email-stefan.wahren@i2se.com>
References: <1526589872-13459-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87d0xouapx.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The Raspberry Pi Compute Module (CM1) is a SoM which contains a
> BCM2835 processor, 512 MB RAM and a 4 GB eMMC. There is also a carrier
> board which is called Compute Module IO Board.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts | 92 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi    | 34 ++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ec2024e..a9883e8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2835-rpi-b-rev2.dtb \
>  	bcm2835-rpi-b-plus.dtb \
>  	bcm2835-rpi-a-plus.dtb \
> +	bcm2835-rpi-cm1-io1.dtb \
>  	bcm2836-rpi-2-b.dtb \
>  	bcm2837-rpi-3-b.dtb \
>  	bcm2837-rpi-3-b-plus.dtb \
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
> new file mode 100644
> index 0000000..4d9aa22
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2835-rpi-cm1.dtsi"
> +#include "bcm283x-rpi-usb-host.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,compute-module", "brcm,bcm2835";
> +	model = "Raspberry Pi Compute Module IO board rev1";
> +};
> +
> +&dsi1 {
> +	status = "okay";
> +};
> +
> +&gpio {
> +	/*
> +	 * This is based on the official GPU firmware DT blob.
> +	 *
> +	 * Legend:
> +	 * "NC" = not connected (no rail from the SoC)
> +	 * "FOO" = GPIO line named "FOO" on the schematic
> +	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +	 */
> +	gpio-line-names = "GPIO0",
> +			  "GPIO1",
> +			  "GPIO2",
> +			  "GPIO3",
> +			  "GPIO4",
> +			  "GPIO5",
> +			  "GPIO6",
> +			  "GPIO7",
> +			  "GPIO8",
> +			  "GPIO9",
> +			  "GPIO10",
> +			  "GPIO11",
> +			  "GPIO12",
> +			  "GPIO13",
> +			  "GPIO14",
> +			  "GPIO15",
> +			  "GPIO16",
> +			  "GPIO17",
> +			  "GPIO18",
> +			  "GPIO19",
> +			  "GPIO20",
> +			  "GPIO21",
> +			  "GPIO22",
> +			  "GPIO23",
> +			  "GPIO24",
> +			  "GPIO25",
> +			  "GPIO26",
> +			  "GPIO27",
> +			  "GPIO28",
> +			  "GPIO29",
> +			  "GPIO30",
> +			  "GPIO31",
> +			  "GPIO32",
> +			  "GPIO33",
> +			  "GPIO34",
> +			  "GPIO35",
> +			  "GPIO36",
> +			  "GPIO37",
> +			  "GPIO38",
> +			  "GPIO39",
> +			  "GPIO40",
> +			  "GPIO41",
> +			  "GPIO42",
> +			  "GPIO43",
> +			  "GPIO44",
> +			  "GPIO45",
> +			  "HDMI_HPD_N",
> +			  /* Also used as ACT LED */
> +			  "EMMC_EN_N",
> +			  /* Used by eMMC */
> +			  "SD_CLK_R",
> +			  "SD_CMD_R",
> +			  "SD_DATA0_R",
> +			  "SD_DATA1_R",
> +			  "SD_DATA2_R",
> +			  "SD_DATA3_R";
> +
> +	pinctrl-0 = <&gpioout &alt0>;
> +};
> +
> +&hdmi {
> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
> +};

I think this should be ACTIVE_LOW, since it's "HDMI_HPD_N_1V8", right?

> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_gpio14>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
> new file mode 100644
> index 0000000..ef22c2d
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2835.dtsi"
> +#include "bcm2835-rpi.dtsi"
> +
> +/ {
> +	leds {
> +		act {
> +			gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	reg_3v3: fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_1v8: fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&sdhost {
> +	non-removable;
> +	vmmc-supply = <&reg_3v3>;
> +	vqmmc-supply = <&reg_1v8>;
> +};

Also, looking at some datasheets I have laying around, it says "eMMC I/O
Voltage fixed at 1V8" -- is this regulator setup right, in that case?

With answers for these two issues, it will be:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/aced93f8/attachment.sig>
