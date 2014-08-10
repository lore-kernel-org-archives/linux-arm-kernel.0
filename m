From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Aug 2014 18:17:20 +0200
Subject: [PATCH 2/2] ARM: Kirkwood: add DT support for Seagate Goflex
 Home and CloudEngines Pogoplug E02
In-Reply-To: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
Message-ID: <20140810161720.GF26751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 10, 2014 at 04:37:37AM -0600, Oleg Rakhmanov wrote:
> This patch adds Pogoplug E02 support and to apply clean it depends on the
> first patch in the series.

Hi Oleg

I don't see any dependencies between the two patches.  Even if there
is, we treat a two patch series as one entity, and apply them together
in order. So you can remove that part of the comment.

> 
> diff -uprN a/arch/arm/boot/dts/kirkwood-pogo_e02.dts
> b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
> --- a/arch/arm/boot/dts/kirkwood-pogo_e02.dts   1969-12-31
> 17:00:00.000000000 -0700
> +++ b/arch/arm/boot/dts/kirkwood-pogo_e02.dts   2014-08-10
> 03:59:10.616338535 -0600
> @@ -0,0 +1,117 @@
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +       model = "CloudEngines Pogoplug E02";
> +       compatible = "cloudengines,pogo_e02", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";

All vendors should be listed in
Documentation/devicetree/bindings/vendor-prefixes.txt.  Please could
you make a separate patch in this series adding it.

> +       memory {
> +               device_type = "memory";
> +               reg = <0x00000000 0x10000000>;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200n8 earlyprintk
> root=/dev/sda1 rootdelay=10";
> +               stdout-path = &uart0;
> +       };
> +
> +       ocp at f1000000 {
> +               pinctrl: pin-controller at 10000 {
> +                       pmx_usb_power_enable: pmx-usb-power-enable {
> +                               marvell,pins = "mpp29";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_green: pmx-led_green {

Last _ should be -

> +                               marvell,pins = "mpp48";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_orange: pmx-led_orange {

Same here.

> +                               marvell,pins = "mpp49";
> +                               marvell,function = "gpio";
> +                       };
> +               };
> +               serial at 12000 {
> +                       status = "ok";
> +               };
> +
> +       };
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +               pinctrl-0 = < &pmx_led_orange
> +                             &pmx_led_green
> +                           >;
> +               pinctrl-names = "default";
> +
> +               health {
> +                       label = "status:green:health";
> +                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +                       default-state = "keep";
> +               };
> +               fault {
> +                       label = "status:orange:fault";
> +                       gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               pinctrl-0 = <&pmx_usb_power_enable>;
> +               pinctrl-names = "default";
> +
> +               usb_power: regulator at 1 {
> +                       compatible = "regulator-fixed";
> +                       reg = <1>;
> +                       regulator-name = "USB Power";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       enable-active-high;
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +};
> +
> +&nand {
> +       chip-delay = <25>;
> +       status = "okay";
> +
> +       partition at 0 {
> +               label = "u-boot";
> +               reg = <0x0000000 0x100000>;
> +               read-only;
> +       };
> +
> +       partition at 100000 {
> +               label = "uImage";
> +               reg = <0x0100000 0x0500000>;
> +       };
> +
> +        partition at 0500000 {
> +                label = "pogoplug";
> +                reg = <0x0500000 0x2500000>;
> +        };
> +
> +       partition at 2500000 {
> +               label = "root";
> +               reg = <0x2500000 0x6c00000>;
> +       };
> +};
> +
> +&mdio {
> +       status = "okay";
> +
> +       ethphy0: ethernet-phy at 0 {
> +               reg = <0>;
> +       };
> +};
> +
> +&eth0 {
> +       status = "okay";
> +       ethernet0-port at 0 {
> +               phy-handle = <&ethphy0>;
> +       };
> +};
> diff -uprN a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> --- a/arch/arm/boot/dts/Makefile        2014-08-10 03:54:22.764885366 -0600
> +++ b/arch/arm/boot/dts/Makefile        2014-08-10 04:00:43.570037020 -0600
> @@ -137,6 +137,7 @@ kirkwood := \
>         kirkwood-openrd-base.dtb \
>         kirkwood-openrd-client.dtb \
>         kirkwood-openrd-ultimate.dtb \
> +      kirkwood-pogo_e02.dtb \

Again, there looks to be something odd here.

>         kirkwood-rd88f6192.dtb \
>         kirkwood-rd88f6281-a0.dtb \
>         kirkwood-rd88f6281-a1.dtb \

Thanks
	Andrew
