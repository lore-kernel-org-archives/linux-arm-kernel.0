From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 31 Aug 2015 15:11:19 +0200
Subject: Trying to get a Pogoplug v4 board description added
In-Reply-To: <CAAKvOSg7h=YOVWQ1gKLv-WGw6BGF_rBfp+Zb=za7FkKE2Zwbhg@mail.gmail.com>
References: <CAAKvOShfrRn-E9o2Gjek5xb8xfGucUmO_FRu7c3T7S2V=co-2g@mail.gmail.com>
 <20150829153646.GB31545@lunn.ch>
 <CAAKvOSg7h=YOVWQ1gKLv-WGw6BGF_rBfp+Zb=za7FkKE2Zwbhg@mail.gmail.com>
Message-ID: <20150831131119.GF14459@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

Once you have the copyright and licence sort out, we should have a
header here with this information.

> >> kirkwood-pogoplug_v4.dts
> >> /dts-v1/;
> >>
> >> #include "kirkwood.dtsi"
> >> #include "kirkwood-6192.dtsi"
> >>
> >> / {
> >>         model = "Pogoplug v4";
> >>         compatible = "cloudengines,pogoplug-v4",
> >> "cloudengines,pogoplug-mobile", "marvell,kirkwood-88f6192",
> >> "marvell,kirkwood";
> >>
> >>         memory {
> >>                 device_type = "memory";
> >>                 reg = <0x00000000 0x8000000>;
> >>         };
> >>
> >>         chosen {
> >>                 bootargs = "console=ttyS0,115200";
> >>                 stdout-path = &uart0;

You can combine this into one line:

    		     stdout-path = "uart0:115200n8"

I don't think any Kirkwood boards do this yet, but it should work.

> >>         };
> >>
> >>         mbus {
> >>                 pcie-controller {
> >>                         status = "okay";
> >>
> >>                         pcie at 1,0 {
> >>                                 status = "okay";
> >>                         };

Optional, but it is nice to comment on what is connected to the PCIe
bus. I think it is the USB 3 controller? Adding the make model makes
it easier for people to get the driver build into the kernel or as a
module.

> >>                 };
> >>         };
> >>
> >>         ocp at f1000000 {
> >>                 pinctrl: pin-controller at 10000 {
> >>                         pmx_led_green: pmx-led-green {
> >>                                 marvell,pins = "mpp22";
> >>                                 marvell,function = "gpio";
> >>                         };
> >>                         pmx_led_red: pmx-led-red {
> >>                                 marvell,pins = "mpp24";
> >>                                 marvell,function = "gpio";
> >>                         };
> >>                         pmx_button_eject: pmx-button-eject {
> >>                                 marvell,pins = "mpp29";
> >>                                 marvell,function = "gpio";
> >>                         };
> >>                 };
> >>
> >>                 serial at 12000 {
> >>                         status = "okay";
> >>                 };
> >>
> >>                 sata at 80000 {
> >>                         status = "okay";
> >>                         nr-ports = <1>;
> >>                         phys = <&sata_phy0>;
> >>                         phy-names = "port0";

You should not need these last two lines. They are provided by the
.dtsi file.

> >>                 };
> >>
> >>                 mvsdio at 90000 {
> >>                         pinctrl-0 = <&pmx_sdio>;
> >>                         pinctrl-names = "default";
> >>                         status = "okay";
> >>                         cd-gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;

You should have a pinmux definition for this. See for example
kirkwood-sheevaplug-esata.dts and kirkwood-sheevaplug-common.dtsi

> >>                         /* No WP GPIO */
> >>                 };
> >>         };
> >>
> >>         gpio-leds {
> >>                 compatible = "gpio-leds";
> >>                 pinctrl-0 = <&pmx_led_red &pmx_led_green>;
> >>                 pinctrl-names = "default";
> >>
> >>                 health {
> >>                         label = "status:green:health";
> >>                         gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> >>                         default-state = "keep";
> >>                 };
> >>                 fault {
> >>                         label = "status:red:fault";
> >>                         gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> >>                 };

A common problem here, the labels don't fit what is documented.
Documentation/leds/leds.txt says:

"devicename:colour:function"

so you should change status to pogoplugv4

> >>         };
> >>

Please also add this file to the Makefile, keeping things in order.

       Andrew
