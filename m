From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Sep 2017 11:12:33 -0300
Subject: [PATCH v2] ARM: dts: Add initial Pistachio i.mx6q board support.
In-Reply-To: <1504847672-32742-1-git-send-email-onlywig@gmail.com>
References: <1504847672-32742-1-git-send-email-onlywig@gmail.com>
Message-ID: <CAOMZO5CifpaywHoaHA+UKEv7fHvhsWyxEkJP3TT+NBnWcV5XVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 2:14 AM, Wig Cheng <onlywig@gmail.com> wrote:
> From: YuanCheng Cheng <onlywig@gmail.com>
>
> Working items:
>
> - 800/433 MHz (CPU/DDR3)
> - 2GB of RAM (DDR3)
> - 4GB of NAND FLASH
> - 1T1R WiFi 2.4 GHz
> - Power management support
> - 1x 10/100/1000 Mbps Ethernet WAN port
> - 2x USB 2.0 Host
> - PCIe
> - HDMI/VGA/LVDS display
> - 1x UART for RS232/422/485
> - 2x UART for RS232
> - 1x UART for serial console
> - 1x CAN bus

A link to the board web page would be nice.

> Currently no mainline u-boot.

This information is not so relevant.

> Signed-off-by: YuanCheng Cheng <onlywig@gmail.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/imx6q-pistachio.dts              |  57 ++
>  arch/arm/boot/dts/imx6qdl-pistachio.dtsi           | 707 +++++++++++++++++++++
>  4 files changed, 766 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-pistachio.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-pistachio.dtsi
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 401ed98..3a16be8 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -234,6 +234,7 @@ nintendo    Nintendo
>  nlt    NLT Technologies, Ltd.
>  nokia  Nokia
>  nordic Nordic Semiconductor
> +nutsboard      NutsBoard

Usually you should send this as a separate patch for the devicetree
folks (Rob Herring).

> +#include "imx6q.dtsi"
> +#include "imx6qdl-pistachio.dtsi"
> +
> +/ {
> +       model = "NutsBoard i.MX6 Quad Pistachio board";
> +       compatible = "nutsboard,imx6q-pistachio", "fsl,imx6q";
> +};
> +
> +&sata {
> +       status = "okay";
> +};

Do you really need the 'imx6qdl-pistachio.dtsi' file?

Looks like you only have the imx6q variant of the board, so you could
put everything into imx6q-pistachio.dts.

> +
> +       chosen {
> +               stdout-path = &uart4;
> +       };
> +
> +       memory: memory {
> +               reg = <0x10000000 0x80000000>;
> +       };
> +
> +       reg_3p3v: regulator-3p3v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3P3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
> +       reg_1p8v: regulator-1p8v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "1P8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +       };

These two regulators above are OK

> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

As I mentioned earlier you should remove this regulator container and
do like you did for the first two regulators.

> +
> +               wlan_en_reg: regulator at 2 {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "wlan-en-regulator";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       gpio = <&gpio2 24 0>;

Please use GPIO_ACTIVE_HIGH flag.

> +                       startup-delay-us = <70000>;
> +                       enable-active-high;
> +               };
> +
> +               reg_usb_otg_vbus: regulator at 3 {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio3 22 0>;

Please use GPIO_ACTIVE_HIGH flag.

> +                       enable-active-high;
> +                       vin-supply = <&swbst_reg>;
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +               power {
> +                       label = "Power Button";
> +                       gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +                       gpio-key,wakeup;
> +                       linux,code = <KEY_POWER>;
> +               };
> +

No need for this extra blank line.

> +                       vgen6_reg: vgen6 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +

No need for this extra blank line.

> +               };
> +       };
> +
> +       ar1021 at 4d {
> +               compatible = "microchip,ar1021-i2c";
> +               reg = <0x4d>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <8 0x2>;

 interrupts = <8 IRQ_TYPE_EDGE_FALLING>;

> +       };
> +};
> +
> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +

No need for this extra blank line.

> +};
> +
> +&iomuxc {

It is OK to put iomux as the last node.

> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       imx6qdl-pistachio {

No need for this ' imx6qdl-pistachio' container.

> +               pinctrl_hog: hoggrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x1b0b0  /*pcie power*/
> +                               MX6QDL_PAD_EIM_A25__GPIO5_IO02  0x1b0b0   /*LCD power*/
> +                               MX6QDL_PAD_EIM_D16__GPIO3_IO16  0x1b0b0   /*backlight power*/
> +                               MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b1 /*SD3 CD pin*/
> +                               MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x1b0b0 /*codec power*/
> +                               MX6QDL_PAD_EIM_A16__GPIO2_IO22  0x1b0b0 /*touch reset*/
> +                               MX6QDL_PAD_NANDF_ALE__GPIO6_IO08        0x1b0b01 /*touch irq*/
> +                               MX6QDL_PAD_GPIO_7__GPIO1_IO07    0x1b0b0/*backlight pwr*/
> +                               MX6QDL_PAD_GPIO_16__GPIO7_IO11  0x1b0b0 /*gpio 5V_1*/
> +                               MX6QDL_PAD_EIM_A19__GPIO2_IO19  0x1b0b0 /*gpio 5V_2*/
> +                               MX6QDL_PAD_EIM_A24__GPIO5_IO04  0x1b0b0 /*gpio 5V_3*/
> +                               MX6QDL_PAD_GPIO_17__GPIO7_IO12  0x1b0b0 /*gpio 5V_4*/
> +                               MX6QDL_PAD_NANDF_CLE__GPIO6_IO07        0x1b0b0 /*AUX_5V_EN*/
> +                               MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09       0x1b0b0 /*AUX_5VB_EN*/
> +                               MX6QDL_PAD_NANDF_RB0__GPIO6_IO10        0x1b0b0 /*AUX_3V3_EN*/
> +                               MX6QDL_PAD_EIM_D21__GPIO3_IO21  0x1b0b0 /*I2C expander pwr*/
> +                       >;
> +               };
> +
> +               pinctrl_i2c1_sgtl5000: i2c1-sgtl5000grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_GPIO_0__CCM_CLKO1                    0x000b0 /* sys_mclk */
> +                               MX6QDL_PAD_SD3_RST__GPIO7_IO08          0x130b0 /*headphone det*/
> +                               MX6QDL_PAD_GPIO_8__GPIO1_IO08                   0x130b0 /*microphone det*/
> +                       >;
> +               };
> +
> +               pinctrl_audmux: audmuxgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_CSI0_DAT7__AUD3_RXD          0x130b0
> +                               MX6QDL_PAD_CSI0_DAT4__AUD3_TXC          0x130b0
> +                               MX6QDL_PAD_CSI0_DAT5__AUD3_TXD          0x110b0
> +                               MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS         0x130b0

Alphabetical order, please.

> +                       >;
> +               };
> +
> +               pinctrl_ecspi1: ecspi1grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_KEY_COL1__ECSPI1_MISO        0x100b1
> +                               MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI        0x100b1
> +                               MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK        0x100b1
> +                               MX6QDL_PAD_KEY_ROW1__GPIO4_IO09         0x1b0b0
> +                       >;
> +               };
> +
> +               pinctrl_enet: enetgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b8b0
> +                               MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
> +                       /* AR8035 reset */
> +                               MX6QDL_PAD_EIM_A20__GPIO2_IO18          0x130b0
> +                               /* AR8035 interrupt */
> +                               MX6QDL_PAD_EIM_CS0__GPIO2_IO23          0x1b0b1
> +                               MX6QDL_PAD_RGMII_TXC__RGMII_TXC         0x1b030
> +                               MX6QDL_PAD_RGMII_TD0__RGMII_TD0         0x1b030
> +                               MX6QDL_PAD_RGMII_TD1__RGMII_TD1         0x1b030
> +                               MX6QDL_PAD_RGMII_TD2__RGMII_TD2         0x1b030
> +                               MX6QDL_PAD_RGMII_TD3__RGMII_TD3         0x1b030
> +                               MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL   0x1b030
> +                               /* AR8035 CLK_25M --> ENET_REF_CLK (V22) */
> +                               MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK    0x0a0b1
> +                               /* AR8035 pin strapping: IO voltage: pull up */
> +                               MX6QDL_PAD_RGMII_RXC__RGMII_RXC         0x1b030
> +                               /* AR8035 pin strapping: PHYADDR#0: pull down */
> +                               MX6QDL_PAD_RGMII_RD0__RGMII_RD0         0x13030
> +                               /* AR8035 pin strapping: PHYADDR#1: pull down */
> +                               MX6QDL_PAD_RGMII_RD1__RGMII_RD1         0x13030
> +                               /* AR8035 pin strapping: MODE#1: pull up */
> +                               MX6QDL_PAD_RGMII_RD2__RGMII_RD2         0x1b030
> +                               /* AR8035 pin strapping: MODE#3: pull up */
> +                               MX6QDL_PAD_RGMII_RD3__RGMII_RD3         0x1b030
> +                               /* AR8035 pin strapping: MODE#0: pull down */
> +                               MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL   0x13030
> +                       >;
> +               };
> +
> +               pinctrl_gpio_keys: gpio_keysgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
> +                       >;
> +               };
> +
> +               pinctrl_hdmi_cec: hdmicecgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x108b0
> +                       >;
> +               };

You are not using these pins.

> +
> +               pinctrl_hdmi_hdcp: hdmihdcpgrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_KEY_COL3__HDMI_TX_DDC_SCL 0x4001b8b1
> +                               MX6QDL_PAD_KEY_ROW3__HDMI_TX_DDC_SDA 0x4001b8b1
> +                       >;
> +               };

You are not using these pins.

> +
> +               pinctrl_wdog: wdoggrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_GPIO_1__WDOG2_B 0x80000000
> +                       >;

You missed to use this pin.

> +               };
> +       };
> +

No need for this extra blank line.

> +};
> +
> +&ldb {
> +       status = "okay";
> +

> +&usbh1 {
> +       status = "okay";
> +};
> +
> +&usbphy1 {
> +       tx-d-cal = <0x5>;

fsl,tx-d-cal = <0x5>;

> +};
> +
> +&usbphy2 {
> +       tx-d-cal = <0x5>;

fsl,tx-d-cal = <0x5>;

> +};
> +
> +&usdhc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc1>;
> +       bus-width = <8>;
> +       keep-power-in-suspend;
> +       vmmc-supply = <&reg_3p3v>;
> +       status = "okay";
> +};
> +
> +&usdhc2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc2>;
> +       bus-width = <4>;
> +       vmmc-supply = <&wlan_en_reg>;
> +       no-1-8-v;
> +       pm-ignore-notify;

This property does not exist in mainline bindings. Please remove it.

> +       keep-power-in-suspend;
> +  non-removable;
> +  cap-power-off-card;

Weird indentation.

> +       status = "okay";
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore at 0 {

Here you use @0

> +               compatible = "ti,wl1835";
> +               reg = <2>;

and here reg = <2>, which does not match.

> +               interrupt-parent = <&gpio5>;
> +               interrupts = <18 IRQ_TYPE_EDGE_RISING>;
> +               ref-clock-frequency = <38400000>;
> +               tcxo-clock-frequency = <26000000>;
> +       };
> +};
> +
> +&usdhc3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc3>;
> +       bus-width = <4>;
> +       cd-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +       no-1-8-v;
> +       keep-power-in-suspend;
> +       enable-sdio-wakeup;

This one is deprecated. Please use 'wakeup-source' instead.

> +       status = "okay";
> +};
> +
> +&wdog1 {
> +       status = "okay";

In the previous version you had indicated that you were using the
watchdog pin to trigger a POR reset.

The problem was that you used bindings from NXP kernel.

You can still do this by:

pinctrl-0 = <&pinctrl_wdog>;
fsl,ext-reset-output;

> +};
> +
> +&can2 {
> +       pinctrl-names = "default";

Alphabetical order, please.
