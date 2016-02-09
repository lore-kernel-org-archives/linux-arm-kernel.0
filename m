From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 9 Feb 2016 10:30:51 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Enable USB DRC on MK808C
In-Reply-To: <1455009932-27616-1-git-send-email-codekipper@gmail.com>
References: <1455009932-27616-1-git-send-email-codekipper@gmail.com>
Message-ID: <56B9B1CB.102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-02-16 10:25, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Enable the otg/drc usb controller on the MK808C.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Thanks patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   arch/arm/boot/dts/sun7i-a20-mk808c.dts | 35 ++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> index c9e648d..90ff4a2 100644
> --- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> @@ -53,6 +53,7 @@
>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>
>   / {
>   	model = "mk808c";
> @@ -125,6 +126,30 @@
>   	status = "okay";
>   };
>
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&pio {
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
> +};
> +
> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
>   &reg_usb1_vbus {
>   	status = "okay";
>   };
> @@ -145,7 +170,17 @@
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
