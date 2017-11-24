From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Nov 2017 12:33:34 -0200
Subject: [PATCH v2 5/6] ARM: dts: imx6q: Add Variscite DART-MX6
 Carrier-board support
In-Reply-To: <1511348560-28505-6-git-send-email-narmstrong@baylibre.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
 <1511348560-28505-6-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOMZO5Bg5gyF-E5sGqkp0rosC1KbVrzkB9Y6xhpJKbuF_oi-6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 9:02 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> This patch adds support for the i.MX6 Quad variant of the Variscite DART-MX6
> SoM Carrier-Board.
>
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - On-board DMIC
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - 4xButtons, 2xLeds
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Header + USB-Serial debug port
>
> Product Page : http://www.variscite.com/products/evaluation-kits/dart-mx6-kits
>
> The board support is done with all on-board and header interfaces enabled.
> 7" LVDS Touchscreen is enabled by default along HDMI output.
> Audio interface is supported with the "simple-card" bindings.
>
> PCIe slot, On-Board DMIC and Camera Interfaces are not handled yet.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/Makefile                     |   1 +
>  arch/arm/boot/dts/imx6q-var-dt6customboard.dts | 238 +++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9..148ff15 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -470,6 +470,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-tx6q-11x0-mb7.dtb \
>         imx6q-udoo.dtb \
>         imx6q-utilite-pro.dtb \
> +       imx6q-var-dt6customboard.dtb \
>         imx6q-wandboard.dtb \
>         imx6q-wandboard-revb1.dtb \
>         imx6q-wandboard-revd1.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
> new file mode 100644
> index 0000000..de01755
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
> @@ -0,0 +1,238 @@
> +/*
> + * Support for Variscite DART-MX6 Carrier-board
> + *
> + * Copyright 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6qdl-var-dart.dtsi"
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +/ {
> +       model = "Variscite DART-MX6 Carrier-board";
> +       compatible = "variscite,dt6customboard", "fsl,imx6q";
> +
> +       backlight_lvds: backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pwm2 0 50000>;
> +               brightness-levels = <0 4 8 16 32 64 128 248>;
> +               default-brightness-level = <7>;
> +               status = "okay";
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +
> +               back {
> +                       gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_BACK>;
> +                       label = "Key Back";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +
> +               home {
> +                       gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_HOME>;
> +                       label = "Key Home";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +
> +               menu {
> +                       gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_MENU>;
> +                       label = "Key Menu";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +       };
> +
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +
> +               led1 {
> +                       gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led2 {
> +                       gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "default-on";
> +               };
> +       };
> +
> +       panel1: lvds-panel {
> +               compatible = "sgd,gktw70sdae4se", "panel-lvds";
> +               backlight = <&backlight_lvds>;
> +
> +               width-mm = <153>;
> +               height-mm = <86>;
> +
> +               label = "gktw70sdae4se";
> +
> +               data-mapping = "jeida-18";
> +
> +               panel-timing {
> +                       clock-frequency = <32000000>;
> +                       hactive = <800>;
> +                       vactive = <480>;
> +                       hback-porch = <39>;
> +                       hfront-porch = <39>;
> +                       vback-porch = <29>;
> +                       vfront-porch = <13>;
> +                       hsync-len = <47>;
> +                       vsync-len = <2>;
> +               };
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&lvds1_out>;
> +                       };
> +               };
> +       };
> +
> +       reg_usb_h1_vbus: regulator-usbh1vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_h1_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;

Is this really GPIO_ACTIVE_HIGH?

If so, then a 'enable-active-high' property would be needed.

> +       };
> +
> +       reg_usb_otg_vbus: regulator-usbotgvbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;

Ditto.
