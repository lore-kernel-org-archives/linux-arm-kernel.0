From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Feb 2016 15:53:44 +0100
Subject: [linux-sunxi] [PATCH] ARM: dts: sun4i: Enable USB DRC on
 Hyundai-a7hd
In-Reply-To: <1455656404-31191-1-git-send-email-peter@korsgaard.com>
References: <1455656404-31191-1-git-send-email-peter@korsgaard.com>
Message-ID: <56CC7278.6060901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/16/2016 10:00 PM, Peter Korsgaard wrote:
> Enable the OTG USB controller on the A7HD.
>
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts | 34 ++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> index 43f58fb..9103864 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> @@ -87,6 +87,30 @@
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
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
> +
> +	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
> +		allwinner,pins = "PH5";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
> +	};
> +};
> +
> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
>   &reg_usb2_vbus {
>   	gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
>   	status = "okay";
> @@ -102,7 +126,17 @@
>   	allwinner,pins = "PH6";
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
> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>   	status = "okay";
>   };
>
