From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 27 Mar 2018 10:38:52 +0800
Subject: [PATCH v2 2/2] arm: dts: nes: add Nintendo NES/SuperNES Classic
 Edition support
In-Reply-To: <20180326212820.20637-3-miquel.raynal@bootlin.com>
References: <20180326212820.20637-1-miquel.raynal@bootlin.com>
 <20180326212820.20637-3-miquel.raynal@bootlin.com>
Message-ID: <CAGb2v66yPjKxoMwktEb09drL0qqX807tHdB3g+iHXax=e91s3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 5:28 AM, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The Nintendo NES/SuperNES features an R16 already well supported in
> mainline.
>
> The console over UART0 may be wired on two ports of the R16, both
> available on the NES Classic PCB.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  2 +
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  2 +
>  .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    | 62 ++++++++++++++++++++++
>  .../dts/sun8i-r16-nintendo-supernes-classic.dts    | 17 ++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
>  create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-supernes-classic.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..cfdb48bd1a1d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -990,6 +990,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>         sun8i-h3-orangepi-plus.dtb \
>         sun8i-h3-orangepi-plus2e.dtb \
>         sun8i-r16-bananapi-m2m.dtb \
> +       sun8i-r16-nintendo-nes-classic.dtb \
> +       sun8i-r16-nintendo-supernes-classic.dtb \
>         sun8i-r16-parrot.dtb \
>         sun8i-r40-bananapi-m2-ultra.dtb \
>         sun8i-v3s-licheepi-zero.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 0308e8b21ea5..c83919ab8542 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -198,6 +198,8 @@
>                         clock-names = "ahb", "mod";
>                         resets = <&ccu RST_BUS_NAND>;
>                         reset-names = "ahb";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
> new file mode 100644
> index 000000000000..bc067befd2eb
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +/* Copyright (c) 2016 FUKAUMI Naoki <naobsd@gmail.com> */
> +
> +/dts-v1/;
> +#include "sun8i-a33.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +/ {
> +       model = "Nintendo NES Classic Edition";
> +       compatible = "nintendo,nes-classic", "allwinner,sun8i-a33";

The chip found on the board is the R16, which is compatible or identical
with the A33. Nevertheless, please have an R33 compatible in front of
the A33 one. That would describe it properly.

> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&uart0 {
> +       /*
> +        * UART0 is available on two ports: PB and PF, both are accessible.
> +        * PF can also be used for the SD card so PB is preferred.
> +        */
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins_a>;
> +       status = "okay";
> +};
> +
> +&nfc {
> +       status = "okay";
> +
> +       /* 2Gb Macronix MX30LF2G18AC (3V) */
> +       nand at 0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0>;
> +               allwinner,rb = <0>;
> +               nand-ecc-mode = "hw";
> +               nand-ecc-strength = <16>;
> +               nand-ecc-step-size = <1024>;
> +       };
> +};
> +
> +&usb_otg {
> +       status = "okay";

This is missing a "dr_mode" property.

> +};
> +
> +&usbphy {
> +       /* VBUS is always on because it is wired to the power supply */
> +       usb1_vbus-supply = <&reg_vcc5v0>;
> +       status = "okay";
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ohci0 {
> +       status = "okay";
> +};

What is connected to the USB hosts? OTG does not use these.

> diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-supernes-classic.dts b/arch/arm/boot/dts/sun8i-r16-nintendo-supernes-classic.dts
> new file mode 100644
> index 000000000000..928f82dbe440
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-r16-nintendo-supernes-classic.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +
> +/dts-v1/;
> +#include "sun8i-r16-nintendo-nes-classic.dts"
> +
> +/ {
> +       model = "Nintendo SuperNES Classic Edition";
> +       compatible = "nintendo,supernes-classic", "allwinner,sun8i-a33";

Same here.

ChenYu

> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> --
> 2.14.1
>
