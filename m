From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Jun 2016 17:49:10 +0800
Subject: [PATCH v2] ARM: sun8i: Add Parrot Board DTS
In-Reply-To: <1466602902-4022-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1466602902-4022-1-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v676iNBUCvZCYFAtNoW1BUqQz7r8y1_uFUGXNLxdLgoSLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 9:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The Parrot Board is an evaluation board with an Allwinner R16 (assumed
> to be close to an Allwinner A33), 4GB of eMMC, 512MB of RAM, USB host
> and OTG, a WiFi/Bluetooth combo chip, a micro SD Card reader, 2
> controllable buttons, an LVDS port with separated backlight and
> capacitive touch panel ports, an audio/microphone jack, a camera CSI
> port, 2 sets of 22 GPIOs and an accelerometer.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> Patch dependencies:
>  - regulator: axp20x: Add support for the (external) drivebus regulator
>  - ARM: dts: axp22x.dtsi: Add reg_drivebus node
>  - ARM: dts: axp22x.dtsi: Add usb_power_supply node
>  - power: axp20x_usb: Add support for usb power-supply on axp22x pmics
>  - mfd: axp20x: Extend axp22x_volatile_ranges
>  - mfd: axp20x: Add axp20x-usb-power-supply for axp22x pmics
>  - phy-sun4i-usb: Add workaround for missing Vbus det interrupts on A31
> or the micro USB port would not be powered.
>
> v2:
>  - correct typos,
>  - chose less generic name suffix for nodes (now_parrot_r16),
>  - add comment for i2c childless node,
>  - add comment for two regulators-powered WiFi chip,
>  - add comment to explicit the use of some regulators,
>  - add usb_vbus_power-supply property in usbphy node (this adds a
>    dependance to an other patch),
>
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/sun8i-r16-parrot.dts | 356 +++++++++++++++++++++++++++++++++
>  2 files changed, 357 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 1ff5434..6c7581f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -762,6 +762,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>         sun8i-a33-ippo-q8h-v1.2.dtb \
>         sun8i-a33-q8-tablet.dtb \
>         sun8i-a33-sinlinx-sina33.dtb \
> +       sun8i-r16-parrot.dtb \
>         sun8i-a83t-allwinner-h8homlet-v2.dtb \
>         sun8i-a83t-cubietruck-plus.dtb \
>         sun8i-h3-orangepi-2.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
> new file mode 100644
> index 0000000..cd68bfa
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
> @@ -0,0 +1,356 @@

[...]

> +&reg_usb1_vbus {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&usb1_vbus_pin_parrot_r16>;
> +       gpio = <&pio 3 12 GPIO_ACTIVE_HIGH>; /* PD12 */
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins_b>;
> +       status = "okay";
> +};
> +
> +&usb_otg {
> +       dr_mode = "otg";
> +       status = "okay";
> +};
> +
> +&usb_power_supply {
> +       status = "okay";
> +};
> +
> +&usbphy {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&usb0_id_det>;
> +       usb0_vbus-supply = <&reg_drivevbus>;
> +       usb0_id_det-gpios = <&pio 3 10 GPIO_ACTIVE_HIGH>; /* PD10 */
> +       usb0_vbus_power-supply = <&usb_power_supply>;
> +       usb1_vbus-supply = <&reg_usb1_vbus>; /* USB1 VBUS is always on */

The comment is misleading, as you have a controllable regulator above.
Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +};
> --
> 2.5.0
>
