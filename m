From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Aug 2014 15:01:56 +0800
Subject: [linux-sunxi] [PATCH v4 1/1] ARM: dts: sun7i: Add Merrii A20
 Hummingbird support
In-Reply-To: <1408341634-9952-2-git-send-email-wills.wang.open@gmail.com>
References: <1408341634-9952-1-git-send-email-wills.wang.open@gmail.com>
 <1408341634-9952-2-git-send-email-wills.wang.open@gmail.com>
Message-ID: <CAGb2v64GvqRHoV2q+gLCSFtgc_5QtpDh5DKF4pyZmO4XK-wBBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 2:00 PM, Wills Wang <wills.wang.open@gmail.com> wrote:
> This adds support for the A20 Hummingbird:
> http://www.merrii.com/en/pla_d.asp?id=171
>
> This patch enable most on-board peripherals supported on current kernel,
> such as uart, i2c, spi, pwm, ohci/ehci, gmac and mmc.
>
> Signed-off-by: Wills Wang <wills.wang.open@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/sun7i-a20-hummingbird.dts | 264 ++++++++++++++++++++++++++++
>  2 files changed, 265 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-hummingbird.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7ceae69..c95d2b1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -380,6 +380,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>  dtb-$(CONFIG_MACH_SUN7I) += \
>         sun7i-a20-cubieboard2.dtb \
>         sun7i-a20-cubietruck.dtb \
> +       sun7i-a20-hummingbird.dtb \
>         sun7i-a20-i12-tvbox.dtb \
>         sun7i-a20-olinuxino-micro.dtb \
>         sun7i-a20-pcduino3.dtb
> diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> new file mode 100644
> index 0000000..260b41a
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> @@ -0,0 +1,264 @@
> +/*
> + * Copyright 2013 Wills Wang
> + *
> + * Wills Wang <wills.wang.open@gmail.com>
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
> +/include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
> +
> +/ {
> +       model = "Merrii A20 Hummingbird";
> +       compatible = "merrii,a20-hummingbird", "allwinner,sun7i-a20";
> +
> +       soc at 01c00000 {
> +               mmc0: mmc at 01c0f000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +                       vmmc-supply = <&reg_vcc3v0>;
> +                       bus-width = <4>;
> +                       cd-gpios = <&pio 7 1 0>; /* PH1 */
> +                       cd-inverted;
> +                       status = "okay";
> +               };
> +
> +               mmc3: mmc at 01c12000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&mmc3_pins_a>;
> +                       vmmc-supply = <&reg_mmc3_vdd>;
> +                       bus-width = <4>;
> +                       non-removable;
> +                       status = "okay";
> +               };
> +
> +               usbphy: phy at 01c13400 {
> +                       usb1_vbus-supply = <&reg_usb1_vbus>;
> +                       usb2_vbus-supply = <&reg_usb2_vbus>;
> +                       status = "okay";
> +               };
> +
> +               ehci0: usb at 01c14000 {
> +                       status = "okay";
> +               };
> +
> +               ohci0: usb at 01c14400 {
> +                       status = "okay";
> +               };
> +
> +               ahci: sata at 01c18000 {
> +                       target-supply = <&reg_ahci_5v>;
> +                       status = "okay";
> +               };
> +
> +               ehci1: usb at 01c1c000 {
> +                       status = "okay";
> +               };
> +
> +               ohci1: usb at 01c1c400 {
> +                       status = "okay";
> +               };
> +
> +               pio: pinctrl at 01c20800 {
> +                       uart3_pins_a: uart3 at 0 {
> +                               allwinner,pins = "PG6", "PG7", "PG8", "PG9";
> +                               allwinner,function = "uart3";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       uart4_pins_a: uart4 at 0 {
> +                               allwinner,pins = "PG10", "PG11";
> +                               allwinner,function = "uart4";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       uart5_pins_a: uart5 at 0 {
> +                               allwinner,pins = "PI10", "PI11";
> +                               allwinner,function = "uart5";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       i2c3_pins_a: i2c3 at 0 {
> +                               allwinner,pins = "PI0", "PI1";
> +                               allwinner,function = "i2c3";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       spi2_pins_a: spi2 at 0 {
> +                               allwinner,pins = "PB14", "PB15", "PB16", "PB17";
> +                               allwinner,function = "spi2";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };

Maybe we should move these common pins to the dtsi (in a separate patch).
Maxime? Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +
> +                       ahci_pwr_pin_a: ahci_pwr_pin at 0 {
> +                               allwinner,pins = "PH15";
> +                       };
> +
> +                       usb1_vbus_pin_a: usb1_vbus_pin at 0 {
> +                               allwinner,pins = "PH2";
> +                       };
> +
> +                       mmc3_vdd_pin_a: mmc3_vdd_pin at 0 {
> +                               allwinner,pins = "PH9";
> +                               allwinner,function = "gpio_out";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       gmac_vdd_pin_a: gmac_vdd_pin at 0 {
> +                               allwinner,pins = "PH16";
> +                               allwinner,function = "gpio_out";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +               };
> +
> +               pwm: pwm at 01c20e00 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pwm0_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               ir0: ir at 01c21800 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&ir0_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               uart0: serial at 01c28000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart0_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               uart2: serial at 01c28800 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart2_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               uart3: serial at 01c28c00 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart3_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               uart4: serial at 01c29000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart4_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               uart5: serial at 01c29400 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart5_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               i2c0: i2c at 01c2ac00 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c0_pins_a>;
> +                       status = "okay";
> +
> +                       axp209: pmic at 34 {
> +                               compatible = "x-powers,axp209";
> +                               reg = <0x34>;
> +                               interrupt-parent = <&nmi_intc>;
> +                               interrupts = <0 8>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
> +               i2c1: i2c at 01c2b000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c1_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               i2c2: i2c at 01c2b400 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c2_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               i2c3: i2c at 01c2b800 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c3_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               spi2: spi at 01c17000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&spi2_pins_a>;
> +                       status = "okay";
> +               };
> +
> +               gmac: ethernet at 01c50000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&gmac_pins_rgmii_a>;
> +                       phy = <&phy1>;
> +                       phy-mode = "rgmii";
> +                       phy-supply = <&reg_gmac_vdd>;
> +                       /* phy reset config */
> +                       snps,reset-gpio = <&pio 0 17 0>; /* PA17 */
> +                       snps,reset-active-low;
> +                       /* wait 1s after reset, otherwise fail to read phy id */
> +                       snps,reset-delays-us = <0 10000 1000000>;
> +                       status = "okay";
> +
> +                       phy1: ethernet-phy at 1 {
> +                               reg = <1>;
> +                       };
> +               };
> +       };
> +
> +       reg_ahci_5v: ahci-5v {
> +               gpio = <&pio 7 15 0>; /* PH15 */
> +               status = "okay";
> +       };
> +
> +       reg_usb1_vbus: usb1-vbus {
> +               gpio = <&pio 7 2 0>; /* PH2 */
> +               status = "okay";
> +       };
> +
> +       reg_usb2_vbus: usb2-vbus {
> +               status = "okay";
> +       };
> +
> +       reg_mmc3_vdd: mmc3_vdd {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&mmc3_vdd_pin_a>;
> +               regulator-name = "mmc3_vdd";
> +               regulator-min-microvolt = <3000000>;
> +               regulator-max-microvolt = <3000000>;
> +               enable-active-high;
> +               gpio = <&pio 7 9 0>; /* PH9 */
> +       };
> +
> +       reg_gmac_vdd: gmac_vdd {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&gmac_vdd_pin_a>;
> +               regulator-name = "gmac_vdd";
> +               regulator-min-microvolt = <3000000>;
> +               regulator-max-microvolt = <3000000>;
> +               enable-active-high;
> +               gpio = <&pio 7 16 0>; /* PH16 */
> +       };
> +};
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
