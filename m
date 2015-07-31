From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:52:21 +0200
Subject: [PATCH] ARM: dts: sun7i: Enable USB DRC on Wexler TAB7200
In-Reply-To: <1438277208-20721-1-git-send-email-mamlinav@gmail.com>
References: <1438277208-20721-1-git-send-email-mamlinav@gmail.com>
Message-ID: <55BB3745.9050200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30-07-15 19:26, Aleksei Mamlin wrote:
> Enable the otg/drc usb controller on the Wexler TAB7200 tablet.
>
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Thanks, since this depends on the axp20x-usb-power-supply bits
which are still pending I'll add this to my sunxi-wip tree, and
then send it to Maxime together with a bunch of other otg
enablement patches with the same dependency once those bits
are merged.



> ---
>   arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 32 ++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index 83c6d3f..7ec6071 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -135,6 +135,20 @@
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
> +};
> +
> +

The two newlines here should be only one, no need to resend
I'll fix this when I merge it.

Regards,

Hans



>   #include "axp209.dtsi"
>
>   &reg_dcdc2 {
> @@ -162,6 +176,10 @@
>   	regulator-name = "avcc";
>   };
>
> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
>   &reg_usb1_vbus {
>   	status = "okay";
>   };
> @@ -176,7 +194,21 @@
>   	status = "okay";
>   };
>
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usb_power_supply {
> +	status = "okay";
> +};
> +
>   &usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_detect_pin>;
> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_power-supply = <&usb_power_supply>;
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>   	usb1_vbus-supply = <&reg_usb1_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>   	status = "okay";
>
