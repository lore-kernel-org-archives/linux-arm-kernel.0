From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 9 Feb 2016 10:31:01 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun7i: Enable USB DRC on Itead
 Ibox
In-Reply-To: <1455010156-27754-1-git-send-email-codekipper@gmail.com>
References: <1455010156-27754-1-git-send-email-codekipper@gmail.com>
Message-ID: <56B9B1D5.7070002@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jo.

On 09-02-16 10:29, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Enable the otg/drc usb controller on the Itead Ibox device.
>
> Note this board has the otg-vbus connected directly to the 5v-dcc of
> the board, so there is no vbus0 regulator, nor vbus0-det.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
> Changes since v1:
> - Added comment concerning vbus0 regulator and detection to commit message

Thanks patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>
> ---
>   arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     | 14 ++++++++++++++
>   arch/arm/boot/dts/sunxi-itead-core-common.dtsi |  9 +++++++++
>   2 files changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> index 661c21d..a512581 100644
> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> @@ -118,8 +118,22 @@
>   		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>   		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>   	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PH4";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
>   };
>
>   &reg_ahci_5v {
>   	status = "okay";
>   };
> +
> +&usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_detect_pin>;
> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> index 2565d51..d22eea3 100644
> --- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> +++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> @@ -88,6 +88,10 @@
>   	status = "okay";
>   };
>
> +&otg_sram {
> +	status = "okay";
> +};
> +
>   #include "axp209.dtsi"
>
>   &reg_dcdc2 {
> @@ -129,6 +133,11 @@
>   	status = "okay";
>   };
>
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
>   &usbphy {
>   	usb1_vbus-supply = <&reg_usb1_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>
