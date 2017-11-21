From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Nov 2017 14:45:56 -0200
Subject: [PATCH 3/4] ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board
 support
In-Reply-To: <1511281705-30849-4-git-send-email-narmstrong@baylibre.com>
References: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
 <1511281705-30849-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOMZO5DirsoVpX74oG+5e1LMDA+KpzMyztqy_GXO6P3fUbPypQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 2:28 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +
> +               button at 0 {

If you build this with W=1 it will give you warnings about using a
unit address without its corresponding reg field.

You could just drop the @x.

> +                       gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_BACK>;
> +                       label = "Key Back";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +
> +               button at 1 {
> +                       gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_HOME>;
> +                       label = "Key Home";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +
> +               button at 2 {
> +                       gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_MENU>;
> +                       label = "Key Menu";
> +                       linux,input-type = <1>;
> +                       debounce-interval = <100>;
> +                       gpio-key,wakeup;
> +               };
> +       };

> +       panel1: lvds-panel {
> +               compatible = "sgd,gktw70sdae4se", "panel-lvds";

sgd,gktw70sdae4se is not defined anywhere.

Documentation/devicetree/bindings/display/panel/panel-lvds.txt says"

"- compatible: Shall contain "panel-lvds" in addition to a mandatory
  panel-specific compatible string defined in individual panel bindings. The
  "panel-lvds" value shall never be used on its own."

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
> +               gpio = <&gpio1 28 0>;

It would be better to use:
gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;


> +               enable-active-high;
> +       };
> +
> +       reg_usb_otg_vbus: regulator-usbotgvbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio4 15 0>;

Same here.

> +               enable-active-high;
> +       };
> +

> +
> +&fec {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-reset-gpios = <&gpio1 25 0>;

GPIO_ACTIVE_LOW please.


> +};
> +
> +&hdmi {
> +       ddc-i2c-bus = <&i2c1>;
> +       status = "okay";
> +};
> +
> +&pcie {
> +       reset-gpio    = <&gpio4 11 0>;

GPIO_ACTIVE_LOW

> +       wake-up-gpio  = <&gpio4 31 1>;

This is not a valid property.

> +       disable-gpio  = <&gpio5 5 0>;

This is not a valid property.
