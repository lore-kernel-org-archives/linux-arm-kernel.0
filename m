From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Aug 2014 16:54:49 +0200
Subject: [PATCH 1/2] ARM: Kirkwood: add DT support for Seagate Goflex
 Home and CloudEngines Pogoplug E02
In-Reply-To: <CAA8MNViqMpuV8K0X5f4WWsEihwtPVZaE8g6RRmDB=Te2Wuzojg@mail.gmail.com>
References: <CAA8MNViqMpuV8K0X5f4WWsEihwtPVZaE8g6RRmDB=Te2Wuzojg@mail.gmail.com>
Message-ID: <20140810145449.GE26751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 10, 2014 at 04:37:35AM -0600, Oleg Rakhmanov wrote:
Hi Oleg

Thanks for the patches. Overall they look good. I just have a few
minor comments.

> This patch adds support for Sevice Tree support for Seagate GoFlex Home. It

Typo: Device not Sevice.

> is very similar to GoFlex Net, but with only 1 sata available and different
> leds. DTS is based on ArchLinux ARM boardfile for this devices. Kernel with
> this patch is availabe in Arch ARM repos and is tested by myself and users
> using the package.
> 
> The second patch in the series add Pogoplug E02 support. Again, it is
> available in repositories and is tested by myself and users using the
> package.

The text you provide here ends up in the commit changelog, for this
one commit. However, you are talking about both patches. So it would
be better to have this text in the cover note. Then in each patch,
just talk about that one patch.

Also, the subject line should be specific to the patch. So the subject
line for this patch should be just about Go Flex Home.

You are missing a signed-of-by line. Take a look at section 12 of

https://www.kernel.org/doc/Documentation/SubmittingPatches


> diff -uprN a/arch/arm/boot/dts/kirkwood-goflexhome.dts
> b/arch/arm/boot/dts/kirkwood-goflexhome.dts
> --- a/arch/arm/boot/dts/kirkwood-goflexhome.dts 1969-12-31
> 17:00:00.000000000 -0700
> +++ b/arch/arm/boot/dts/kirkwood-goflexhome.dts 2014-08-10
> 02:34:52.310545726 -0600
> @@ -0,0 +1,127 @@
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +       model = "Seagate GoFlex Home";
> +       compatible = "seagate,goflexhome", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x00000000 0x8000000>;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200n8 earlyprintk
> root=/dev/sda1 rootdelay=10";

Specifying the root device is pretty unusual. However i see that both
Go Flex Net and Dockstar does this. No other devices have this. This
needs some discussion.

> +               stdout-path = &uart0;
> +       };
> +
> +       ocp at f1000000 {
> +               pinctrl: pin-controller at 10000 {
> +                       pmx_usb_power_enable: pmx-usb-power-enable {
> +                               marvell,pins = "mpp29";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_white: pmx-led_white {

pmx-led_white should be pmx-led-white

> +                               marvell,pins = "mpp40";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_green: pmx-led_green {
> +                               marvell,pins = "mpp46";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_orange: pmx-led_orange {

Same again.

> +                               marvell,pins = "mpp47";
> +                               marvell,function = "gpio";
> +                       };
> +               };
> +               serial at 12000 {
> +                       status = "ok";
> +               };
> +
> +               sata at 80000 {
> +                       status = "okay";
> +                       nr-ports = <1>;
> +               };
> +
> +       };
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +               pinctrl-0 = < &pmx_led_orange
> +                             &pmx_led_green
> +                             &pmx_led_white
> +                           >;
> +               pinctrl-names = "default";
> +
> +               health {
> +                       label = "status:green:health";
> +                       gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +                       default-state = "keep";
> +               };
> +               fault {
> +                       label = "status:orange:fault";
> +                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> +               };
> +               misc {
> +                       label = "status:white:misc";
> +                       gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "ide-disk";
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
> +       chip-delay = <40>;
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
> +               reg = <0x0100000 0x0600000>;
> +       };
> +
> +       partition at 0600000 {
> +               label = "root";
> +               reg = <0x0600000 0xd800000>;
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
> --- a/arch/arm/boot/dts/Makefile        2014-08-03 16:25:02.000000000 -0600
> +++ b/arch/arm/boot/dts/Makefile        2014-08-10 03:14:10.157372577 -0600
> @@ -111,6 +111,7 @@ kirkwood := \
>         kirkwood-ds411.dtb \
>         kirkwood-ds411j.dtb \
>         kirkwood-ds411slim.dtb \
> +      kirkwood-goflexhome.dtb \

Is there a space/tab mixup here? Indentation looks wrong?

>         kirkwood-goflexnet.dtb \
>         kirkwood-guruplug-server-plus.dtb \
>         kirkwood-ib62x0.dtb \

Thanks
	Andrew
