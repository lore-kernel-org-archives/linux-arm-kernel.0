From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Oct 2015 17:59:20 +0800
Subject: [linux-sunxi] [PATCH v2 1/1] dts: sun6i: yones toptech bs1078 v2:
 Add AXP221 support to dts
In-Reply-To: <1445191673-8869-1-git-send-email-lyu@micile.com>
References: <1445191673-8869-1-git-send-email-lyu@micile.com>
Message-ID: <CAGb2v65S9R=sLVRBdUKFUDXCbEFJWF9Sp8Yw__+Q6ncpgPp7kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 2:07 AM, Lawrence Yu <lyu@micile.com> wrote:
> Enable the axp221 PMIC chip in the dts file.
>
> Allows board to power off correctly from the poweroff command
>
> This board requires dc1sw to be enabled in order to provide a power source
> for the 5V DCDC converter that powers USB2 and the LCD backlight
>
> This board uses dldo1 for 3.3V wifi power
>
> This board requires dldo3 to be enabled at 2.8V in order to provide voltage
> to the pullup resistors for the i2c0 bus.
>
> ---
>
> Changes since v1
>
> - Use axp22x.dtsi to standardize the register names
> - Change wifi power regulator to dldo1 instead of incorrect aldo1
> - Remove unnecessary gpio pin PH27 for wifi power, since this board uses
>   the axp221 chip to control power to the wifi chip.
>
> Signed-off-by: Lawrence Yu <lyu@micile.com>
> ---
>  .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     | 98 +++++++++++++++++++---
>  1 file changed, 88 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> index b199020..98d0a83 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> @@ -113,22 +113,100 @@
>         allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  };
>
> -&reg_usb1_vbus {
> -       gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins_a>;
>         status = "okay";
>  };
>
> -&usb1_vbus_pin_a {
> -       allwinner,pins = "PH27";
> +&p2wi {
> +       status = "okay";
> +
> +       axp22x: pmic at 68 {
> +               compatible = "x-powers,axp221";
> +               reg = <0x68>;
> +               interrupt-parent = <&nmi_intc>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       };
>  };
>
> -&usbphy {
> -       usb1_vbus-supply = <&reg_usb1_vbus>;
> -       status = "okay";
> +#include "axp22x.dtsi"
> +
> +&axp22x {
> +       regulators {
> +               /* Used by LCD backlight and USB2 */
> +               reg_dc1sw: dc1sw {
> +                       regulator-name = "dc1sw";
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3000000>;
> +                       regulator-name = "vcc-dc1sw";

I would use "vcc-lcd-usb2". Or just "vcc-lcd" if it proves it has nothing
to do with USB. Plus there's 2 "regulator-name" entries here.

> +               };
> +       };
>  };
>
> -&uart0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +&reg_aldo3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <2700000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "avcc";
> +};
> +
> +&reg_dc5ldo {
> +       regulator-min-microvolt = <700000>;
> +       regulator-max-microvolt = <1320000>;
> +       regulator-name = "vdd-cpus";
> +};
> +
> +&reg_dcdc1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3000000>;
> +       regulator-max-microvolt = <3000000>;
> +       regulator-name = "vcc-3v0";
> +};
> +
> +&reg_dcdc2 {
> +       regulator-min-microvolt = <700000>;
> +       regulator-max-microvolt = <1320000>;
> +       regulator-name = "vdd-gpu";
> +};
> +
> +&reg_dcdc3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <700000>;
> +       regulator-max-microvolt = <1320000>;
> +       regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc4 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <700000>;
> +       regulator-max-microvolt = <1320000>;
> +       regulator-name = "vdd-sys-dll";
> +};
> +
> +&reg_dcdc5 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1500000>;
> +       regulator-max-microvolt = <1500000>;
> +       regulator-name = "vcc-dram";
> +};
> +
> +&reg_dldo1 {
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "vcc-wifi";
> +};
> +
> +/* Voltage source for I2C pullup resistors for I2C Bus 0 */
> +&reg_dldo3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <2800000>;
> +       regulator-max-microvolt = <2800000>;
> +       regulator-name = "vcc-csi";

This should probably be named "vddio-csi".

I think Maxime and Hans were still debating whether the camera VDDIO
regulator should be defined independently as "always-on", instead of
having the I2C subsystem do some kind of power sequencing.

I wonder if the power domain stuff would work for this.

> +};
> +
> +&usbphy {
> +       usb1_vbus-supply = <&reg_dldo1>;
> +       usb2_vbus-supply = <&reg_dc1sw>;

This looks weird, though I cannot say it is impossible. There is likely
a boost regulator after this so the output is proper 5V for USB.

Also, we only have the FEX file for v1 of this board in sunxi-boards.
Would it be possible for you to extract and submit it?

Having the FEX file makes reviewing the dts without schematics slightly
easier.

Thanks
ChenYu

>         status = "okay";
>  };
> --
> 2.5.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
