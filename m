From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 9 Feb 2016 10:51:03 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun7i: Enable USB DRC on Olimex
 A20 EVB
In-Reply-To: <1455010408-27896-1-git-send-email-codekipper@gmail.com>
References: <1455010408-27896-1-git-send-email-codekipper@gmail.com>
Message-ID: <56B9B687.4070800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-02-16 10:33, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Enable the otg/drc usb controller on the Olimex A20 EVB.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
> Changes since v1:
> - Added vbus0 regulator and vbus0 detection to dts

Thanks patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


 >



>
> ---
>   arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 32 ++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> index c3c626b..23aacce 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> @@ -198,6 +198,10 @@
>   	status = "okay";
>   };
>
> +&otg_sram {
> +	status = "okay";
> +};
> +
>   &pio {
>   	ahci_pwr_pin_olimex_som_evb: ahci_pwr_pin at 1 {
>   		allwinner,pins = "PC3";
> @@ -219,6 +223,20 @@
>   		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>   		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>   	};
> +
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
>   };
>
>   &reg_ahci_5v {
> @@ -254,6 +272,10 @@
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
> @@ -268,7 +290,17 @@
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
> +	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH04 */
> +	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH05 */
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>   	usb1_vbus-supply = <&reg_usb1_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>   	status = "okay";
>
