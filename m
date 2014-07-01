From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Jul 2014 10:22:11 +0800
Subject: [PATCH 6/9] ARM: dts: sun7i: Add board support for LinkSprite
 pcDuino V3
In-Reply-To: <1404165479-23785-7-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
 <1404165479-23785-7-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65mDnuwveUiTKU2J3b3jbNzRLvPjS+wXNEj2MRtDN4Q2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 5:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> From: Zoltan HERPAI <wigyori@uid0.hu>
>
> The LinkSprite pcDuino V3 is an A20 based development board featuring
> arduino compatible io headers, 1G RAM, 4G nand, sata, rtl8188cus usb wifi
> and 100 Mbit ethernet using an ip101a phy:
>
> http://www.pcduino.com/pcduino-v3/
>
> Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
> [hdegoede at redhat.com: Various cleanups, correct led pins]
> [hdegoede at redhat.com: Add axp209, ir and gpio-keys nodes]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> --
>
> Changes since v2:
>  - update MMC entry to comply with upstream
>  - unify the 4 patches into one
>
> Changes since v1:
>  - fix cosmetic issues
>  - fix i2c entry
>  - remove unnecessary input bindings include
>  - add MMC support
> ---
>  arch/arm/boot/dts/Makefile               |   3 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 173 +++++++++++++++++++++++++++++++
>  2 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ed0de8b..fdc590e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -380,7 +380,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>         sun7i-a20-cubieboard2.dtb \
>         sun7i-a20-cubietruck.dtb \
>         sun7i-a20-i12-tvbox.dtb \
> -       sun7i-a20-olinuxino-micro.dtb
> +       sun7i-a20-olinuxino-micro.dtb \
> +       sun7i-a20-pcduino3.dtb

You may need to rebase onto my sun8i ippo-q8h dts patch.

  https://patchwork.kernel.org/patch/4389951/

There's a likely conflict in the Makefile here.

>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>         tegra20-iris-512.dtb \
>         tegra20-medcom-wide.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> new file mode 100644
> index 0000000..168b0bc
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> @@ -0,0 +1,173 @@
> +/*
> + * Copyright 2014 Zoltan HERPAI
> + * Zoltan HERPAI <wigyori@uid0.hu>
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
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "LinkSprite pcDuino3";
> +       compatible = "linksprite,pcduino3", "allwinner,sun7i-a20";
> +
> +       soc at 01c00000 {
> +               mmc0: mmc at 01c0f000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +                       vmmc-supply = <&reg_vcc3v3>;
> +                       bus-width = <4>;
> +                       cd-gpios = <&pio 7 1 0>; /* PH1 */
> +                       cd-inverted;
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
> +               pinctrl at 01c20800 {
> +                       ahci_pwr_pin_a: ahci_pwr_pin at 0 {
> +                               allwinner,pins = "PH2";
> +                       };
> +
> +                       led_pins_pcduino3: led_pins at 0 {
> +                               allwinner,pins = "PH15", "PH16";
> +                               allwinner,function = "gpio_out";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       key_pins_pcduino3: key_pins at 0 {
> +                               allwinner,pins = "PH17", "PH18", "PH19";
> +                               allwinner,function = "gpio_in";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
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
> +               gmac: ethernet at 01c50000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&gmac_pins_mii_a>;
> +                       phy = <&phy1>;
> +                       phy-mode = "mii";
> +                       status = "okay";
> +
> +                       phy1: ethernet-phy at 1 {
> +                               reg = <1>;
> +                       };
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&led_pins_pcduino3>;
> +
> +               tx {
> +                       label = "pcduino3:green:tx";
> +                       gpios = <&pio 7 15 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               rx {
> +                       label = "pcduino3:green:rx";
> +                       gpios = <&pio 7 16 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       gpio_keys {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_pins_pcduino3>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               button at 0 {
> +                       label = "Key Back";
> +                       linux,code = <KEY_BACK>;
> +                       gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
> +               };
> +               button at 1 {
> +                       label = "Key Home";
> +                       linux,code = <KEY_HOME>;
> +                       gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
> +               };
> +               button at 2 {
> +                       label = "Key Menu";
> +                       linux,code = <KEY_MENU>;
> +                       gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       reg_usb1_vbus: usb1-vbus {
> +               status = "okay";
> +       };
> +
> +       reg_usb2_vbus: usb2-vbus {
> +               status = "okay";
> +       };
> +
> +       reg_ahci_5v: ahci-5v {
> +               gpio = <&pio 7 2 0>;
> +               status = "okay";
> +       };
> +};
> --
> 2.0.0
>
