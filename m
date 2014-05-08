From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 May 2014 23:27:21 -0300
Subject: [RFC PATCH] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <53695C34.5000604@gmail.com>
References: <53695C34.5000604@gmail.com>
Message-ID: <CAOMZO5C=Yph-Rtor1v_PpPw68J=GwozWW6=mPux2d3f97mi3+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 7:03 PM, Iain Paton <ipaton0@gmail.com> wrote:

> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       regulators {
> +               compatible = "simple-bus";
> +
> +               reg_2p5v: 2p5v {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "2P5V";
> +                       regulator-min-microvolt = <2500000>;
> +                       regulator-max-microvolt = <2500000>;
> +                       regulator-always-on;

No need for this 'regulator-always-on' property, as this is not
controlled by a GPIO.

> +               };
> +
> +               reg_3p3v: 3p3v {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "3P3V";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;

Same here.

> +               };
> +
> +               reg_usb_otg_vbus: usb_otg_vbus {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio3 22 0>;
> +                       enable-active-high;
> +               };
> +
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               led0: user1 {
> +                       label = "user1";
> +                       gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led1: user2 {
> +                       label = "user2";
> +                       gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
> +                       default-state = "off";
> +               };
> +       };
> +
> +       sound {
> +               compatible = "fsl,imx-audio-sgtl5000";
> +               model = "imx6-riotboard-sgtl5000";
> +               ssi-controller = <&ssi1>;
> +               audio-codec = <&codec>;
> +               audio-routing =
> +                       "MIC_IN", "Mic Jack",
> +                       "Mic Jack", "Mic Bias",
> +                       "Headphone Jack", "HP_OUT";
> +                       mux-int-port = <1>;
> +                       mux-ext-port = <3>;
> +       };
> +
> +};
> +
> +

Only one line is enough here.

> +&audmux {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_audmux>;
> +       status = "okay";
> +};
> +
> +
> +

Only one line is enough here.

> +&ecspi1 {
> +       fsl,spi-num-chipselects = <1>;
> +       cs-gpios = <&gpio5 17 0>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       status = "okay";
> +
> +       spidev at 1 {
> +               spi-max-frequency = <24000000>;
> +               reg = <0>;
> +               compatible = "spidev";
> +       };

The reg should match the number after the @, but since spidev is not a
real hardware I am not sure if this should be part of the dts file.

> +
> +&hdmi {
> +       compatible = "fsl,imx6dl-hdmi";

You can drop this compatible line.

> +       ddc-i2c-bus = <&i2c2>;
> +       status = "okay";
> +};

> +
> +               pinctrl_usdhc4: usdhc4grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD4_CMD__SD4_CMD             0x17059
> +                               MX6QDL_PAD_SD4_CLK__SD4_CLK             0x10059
> +                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0          0x17059
> +                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1          0x17059
> +                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2          0x17059
> +                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3          0x17059
> +                               MX6QDL_PAD_NANDF_ALE__GPIO6_IO08        0x80000000      /* SD4 RST (eMMC) */

Just curious: do you get eMMC working? I tried it on mx6qsabresd and
it is not working for me.

> +                       >;
> +               };
> +
> +       };
> +};
> +
> +
> +

Only one line is enough.
