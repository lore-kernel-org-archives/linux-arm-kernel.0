From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Jul 2017 17:29:43 -0300
Subject: [PATCH v2] ARM: dts: imx6qdl-wandboard: enable USB OTG
In-Reply-To: <1500828552-16237-1-git-send-email-akurz@blala.de>
References: <1500828552-16237-1-git-send-email-akurz@blala.de>
Message-ID: <CAOMZO5DKVJN1JFBthotvnufodnN1JDd=hO12PGjLV1KFMQfs7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Shawn]

On Sun, Jul 23, 2017 at 1:49 PM, Alexander Kurz <akurz@blala.de> wrote:
> Enable USB OTG (dual-role) on the Wandboard.
> Note, that the USB_OTG_VBUS current is quite limited due to a 22R resistor
> in the power line. Hence, the overcurrent signal of 1A will never be
> triggered on this board.
>
> Signed-off-by: Alexander Kurz <akurz@blala.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

> ---
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> index b4fa7f1..f1abde8 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> @@ -34,6 +34,16 @@
>                         regulator-max-microvolt = <3300000>;
>                         regulator-always-on;
>                 };
> +
> +               reg_usb_otg_vbus: usb_otg_vbus {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_usbotgvbus>;
> +                       gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +               };
>         };
>
>         sound {
> @@ -170,6 +180,12 @@
>                         >;
>                 };
>
> +               pinctrl_usbotgvbus: usbotgvbusgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_EIM_D22__GPIO3_IO22          0x130b0
> +                       >;
> +               };
> +
>                 pinctrl_usdhc1: usdhc1grp {
>                         fsl,pins = <
>                                 MX6QDL_PAD_SD1_CMD__SD1_CMD             0x17059
> @@ -244,10 +260,11 @@
>  };
>
>  &usbotg {
> +       vbus-supply = <&reg_usb_otg_vbus>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_usbotg>;
>         disable-over-current;
> -       dr_mode = "peripheral";
> +       dr_mode = "otg";
>         status = "okay";
>  };
>
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
