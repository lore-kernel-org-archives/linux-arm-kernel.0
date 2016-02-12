From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 12 Feb 2016 16:59:45 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun4i: Enable USB DRC on the
 MK802
In-Reply-To: <1455278359-22451-1-git-send-email-codekipper@gmail.com>
References: <1455278359-22451-1-git-send-email-codekipper@gmail.com>
Message-ID: <56BE0171.9040305@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-02-16 12:59, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Enable the otg/drc usb controller on the MK802.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
> Changes since v1:
> - Corrected name of the device in subject & description.

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   arch/arm/boot/dts/sun4i-a10-mk802.dts | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> index ddf0683..ee46ea8 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> @@ -44,6 +44,7 @@
>   #include "sun4i-a10.dtsi"
>   #include "sunxi-common-regulators.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>
>   / {
>   	model = "MK802";
> @@ -84,7 +85,25 @@
>   	status = "okay";
>   };
>
> +&otg_sram {
> +	status = "okay";
> +};
> +
>   &pio {
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PH4";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
> +		allwinner,pins = "PH5";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
>   	usb2_vbus_pin_mk802: usb2_vbus_pin at 0 {
>   		allwinner,pins = "PH12";
>   		allwinner,function = "gpio_out";
> @@ -93,6 +112,10 @@
>   	};
>   };
>
> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
>   &reg_usb1_vbus {
>   	status = "okay";
>   };
> @@ -109,7 +132,17 @@
>   	status = "okay";
>   };
>
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
>   &usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
> +	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>   	usb1_vbus-supply = <&reg_usb1_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>   	status = "okay";
>
