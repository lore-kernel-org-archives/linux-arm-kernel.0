From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 19:34:20 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun7i: Enable USB DRC on Itead
 Ibox
In-Reply-To: <1455010156-27754-1-git-send-email-codekipper@gmail.com>
References: <1455010156-27754-1-git-send-email-codekipper@gmail.com>
Message-ID: <20160209183420.GW31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 09, 2016 at 10:29:16AM +0100, codekipper at gmail.com wrote:
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
> 
> ---
>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     | 14 ++++++++++++++
>  arch/arm/boot/dts/sunxi-itead-core-common.dtsi |  9 +++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> index 661c21d..a512581 100644
> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> @@ -118,8 +118,22 @@
>  		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>  		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PH4";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
>  };
>  
>  &reg_ahci_5v {
>  	status = "okay";
>  };
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
>  	status = "okay";
>  };
>  
> +&otg_sram {
> +	status = "okay";
> +};
> +
>  #include "axp209.dtsi"
>  
>  &reg_dcdc2 {
> @@ -129,6 +133,11 @@
>  	status = "okay";
>  };
>  
> +&usb_otg {
> +	dr_mode = "otg";

If VBUS is tied to 5V, without anyway to disable it, then it cannot do
OTG.

The mode it can do is host.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/0f3e8167/attachment.sig>
