From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Thu, 7 Apr 2016 12:07:23 +0200
Subject: [PATCH v3 4/9] ARM: dts: imx: add Boundary Devices Nitrogen7 board
In-Reply-To: <20160406141555.GL18833@tiger>
References: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-5-git-send-email-gary.bisson@boundarydevices.com>
 <20160406141555.GL18833@tiger>
Message-ID: <CAAMH-yu+wKKV_K3qXQoS43T9uOzSWWNO-++055QZyLZpS8Pc2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Shawn,

On Wed, Apr 6, 2016 at 4:15 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Sat, Apr 02, 2016 at 06:25:46PM +0200, Gary Bisson wrote:
>> Based on i.MX7 Dual with 1GB of RAM.
>>
>> https://boundarydevices.com/product/nitrogen7/
>>
>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> ---
>>
>> Changes v1 -> v2:
>> - none
>> Changes v2 -> v3:
>> - Fix Nitrogen7 BT UART clock parent
>> - Fix Nitrogen7 lvdo2 node to be always-on
>>
>> ---
>>  arch/arm/boot/dts/Makefile            |   1 +
>>  arch/arm/boot/dts/imx7d-nitrogen7.dts | 819 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 820 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx7d-nitrogen7.dts
>
> <snip>
>
>> +/ {
>> +     model = "Boundary Devices i.MX7 Nitrogen7 Board";
>> +     compatible = "boundary,imx7d-nitrogen7", "fsl,imx7d";
>> +
>> +     aliases {
>> +             fb_lcd = &lcdif;
>> +             t_lcd = &t_lcd;
>> +     };
>> +
>> +     memory {
>> +             reg = <0x80000000 0x40000000>;
>> +     };
>> +
>> +     backlight_j9 {
>
> Use hyphen instead of underscore in node name.

Sorry I forgot about that.

>> +             compatible = "gpio-backlight";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_backlight_j9>;
>> +             gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>> +             default-on;
>> +     };
>> +
>> +     backlight_j20 {
>> +             compatible = "pwm-backlight";
>> +             pwms = <&pwm1 0 5000000>;
>> +             brightness-levels = <0 4 8 16 32 64 128 255>;
>> +             default-brightness-level = <6>;
>> +             status = "okay";
>> +     };
>> +
>> +     regulators {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>
> DT maintainers do not like this fake "simple-bus".  Please put all these
> fixed regulators directly under root node in the naming schema below.
>
>         reg_xxx: regulator-xxx {
>                 ...
>         };

Ok, good to know, will be fixed in v4.

>> +
>> +             reg_usb_otg1_vbus: regulator at 0 {
>> +                     compatible = "regulator-fixed";
>> +                     reg = <0>;
>> +                     regulator-name = "usb_otg1_vbus";
>> +                     regulator-min-microvolt = <5000000>;
>> +                     regulator-max-microvolt = <5000000>;
>> +                     gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
>> +                     enable-active-high;
>> +             };
>
> <snip>
>
>> +&uart3 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_uart3>;
>> +     assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
>> +     assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
>> +     control-gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
>> +     uart-has-rs485-half-duplex;
>> +     rs485-mode = <1>;
>
> The above 3 properties are undefined?

You're right, the mainline i.MX UART driver doesn't have those.

>> +     status = "okay";
>> +};
>> +
>> +&uart6 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_uart6>;
>> +     assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
>> +     assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
>> +     fsl,uart-has-rtscts;
>> +     status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +     vbus-supply = <&reg_usb_otg1_vbus>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usbotg1>;
>> +     status = "okay";
>> +};
>> +
>> +&usbotg2 {
>> +     vbus-supply = <&reg_usb_otg2_vbus>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usbotg2>;
>> +     dr_mode = "host";
>> +     status = "okay";
>> +};
>> +
>> +&usdhc1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usdhc1>;
>> +     cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>> +     vmmc-supply = <&vgen3_reg>;
>> +     bus-width = <4>;
>> +     fsl,tuning-step = <2>;
>> +     wakeup-source;
>> +     keep-power-in-suspend;
>> +     status = "okay";
>> +};
>> +
>> +&usdhc2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usdhc2>;
>> +     bus-width = <4>;
>> +     non-removable;
>> +     vmmc-supply = <&reg_wlan>;
>> +     vqmmc-1-8-v;
>
> Unsupported property?

Same here.

>> +     cap-power-off-card;
>> +     keep-power-in-suspend;
>> +     status = "okay";
>> +
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>
> Move these two up to the top of property list.

Ok.

>> +     wlcore: wlcore at 2 {
>> +             compatible = "ti,wl1271";
>> +             reg = <2>;
>> +             interrupt-parent = <&gpio4>;
>> +             interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>> +             ref-clock-frequency = <38400000>;
>> +     };
>> +};
>> +
>> +&usdhc3 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usdhc3>;
>> +     assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
>> +     assigned-clock-rates = <400000000>;
>> +     bus-width = <8>;
>> +     fsl,tuning-step = <2>;
>> +     non-removable;
>> +     status = "okay";
>> +};
>> +
>> +&wdog1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_wdog1>;
>> +     status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_hog_1 &pinctrl_j2>;
>> +
>> +     imx7d-nitrogen7 {
>
> Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without
> function nodes), we can drop this container code to save one level of
> indentation.

Great, that will remove all the over 80 lines with checkpatch.

>> +             pinctrl_hog_1: hoggrp-1 {
>> +                     fsl,pins = <
>> +                             MX7D_PAD_SD3_RESET_B__GPIO6_IO11        0x5d
>> +                             MX7D_PAD_GPIO1_IO13__GPIO1_IO13         0x7d
>> +                             MX7D_PAD_ECSPI2_MISO__GPIO4_IO22        0x7d
>> +                     >;
>> +             };
>> +
>> +             pinctrl_bt_rfkill: btrfkillgrp {
>> +                     fsl,pins = <
>> +                             MX7D_PAD_ECSPI2_SS0__GPIO4_IO23         0x7d
>> +                     >;
>> +             };
>
> Drop unused pinctrl entries, and let's add it when needed.

Ok, makes sense.

>> +
>> +             pinctrl_enet1: enet1grp {
>> +                     fsl,pins = <
>> +                             MX7D_PAD_GPIO1_IO10__ENET1_MDIO                 0x3
>> +                             MX7D_PAD_GPIO1_IO11__ENET1_MDC                  0x3
>> +                             MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1          0x3
>> +                             MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC       0x71
>> +                             MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0       0x71
>> +                             MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1       0x71
>> +                             MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2       0x71
>> +                             MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3       0x71
>> +                             MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL 0x71
>> +                             MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC       0x71
>> +                             MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0       0x11
>> +                             MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1       0x11
>> +                             MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2       0x11
>> +                             MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3       0x71
>> +                             MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL 0x11
>> +                             MX7D_PAD_SD3_STROBE__GPIO6_IO10                 0x75 /* Reset */
>> +                     >;
>> +             };
>> +
>> +             pinctrl_flash: flashgrp {
>
> Ditto
>
>> +                     fsl,pins = <
>> +                             MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0      0x71
>> +                             MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1      0x71
>> +                             MX7D_PAD_EPDC_DATA02__GPIO2_IO2         0x7d
>> +                             MX7D_PAD_EPDC_DATA03__GPIO2_IO3         0x7d
>> +                             MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK       0x71
>> +                             MX7D_PAD_EPDC_DATA06__GPIO2_IO6         0x71
>> +                     >;
>> +             };
>
> <snip>
>
>> +&iomuxc_lpsr {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_hog_2>;
>> +
>> +     imx7d-nitrogen7 {
>
> Drop this container node.

I'll submit a v4 shortly. I'll also make sure to do the same on the
6SX device tree.

Regards,
Gary
