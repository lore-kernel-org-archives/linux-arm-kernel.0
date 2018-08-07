From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 08:08:58 -0600
Subject: [PATCH v2 3/3] ARM: dts: stm32: Fix DT dtc warnings for stm32f4
In-Reply-To: <1533646500-4028-4-git-send-email-patrice.chotard@st.com>
References: <1533646500-4028-1-git-send-email-patrice.chotard@st.com>
 <1533646500-4028-4-git-send-email-patrice.chotard@st.com>
Message-ID: <CABGGisxNQgduwhpX_jt1d=gKasDFTGovvQeRLh0-dsjSU277bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 6:55 AM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Fix the following DT dtc warnings for stm32f429 and
> stm32f469 boards:
>
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs at 0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs at 1: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_hs at 0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins at 0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od at 0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /gpio_keys: Character '_' not recommended in node name
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller/usart1 at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usart3 at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs at 1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_hs at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/mii at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/adc at 200: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/pwm at 1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/pwm at 3: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/i2c1 at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/ltdc at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/dcmi at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od at 0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /gpio_keys/button at 0: node has a unit name, but no reg property
> Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> Change since v1:
>         - update nodes name as following: <node_name>@0 to <node_name>-0
>
>
>  arch/arm/boot/dts/stm32429i-eval.dts     | 11 +++--
>  arch/arm/boot/dts/stm32f4-pinctrl.dtsi   | 30 ++++++-------
>  arch/arm/boot/dts/stm32f429-disco.dts    |  7 ++-
>  arch/arm/boot/dts/stm32f429-pinctrl.dtsi | 74 +++++++++++++++----------------
>  arch/arm/boot/dts/stm32f429.dtsi         |  8 ++--
>  arch/arm/boot/dts/stm32f469-disco.dts    | 11 +++--
>  arch/arm/boot/dts/stm32f469-pinctrl.dtsi | 76 +++++++++++++++-----------------
>  7 files changed, 102 insertions(+), 115 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 7eb786a2d624..116232b589e4 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -60,7 +60,7 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> -       memory {
> +       memory at 0 {
>                 reg = <0x00000000 0x2000000>;
>         };
>
> @@ -111,17 +111,16 @@
>                 };
>         };
>
> -       gpio_keys {
> +       gpio-keys {
>                 compatible = "gpio-keys";
> -               #address-cells = <1>;
>                 #size-cells = <0>;

Think you forgot this line.

>                 autorepeat;
> -               button at 0 {
> +               button-0 {
>                         label = "Wake up";
>                         linux,code = <KEY_WAKEUP>;
>                         gpios = <&gpioa 0 0>;
>                 };
> -               button at 1 {
> +               button-1 {
>                         label = "Tamper";
>                         linux,code = <KEY_RESTART>;
>                         gpios = <&gpioc 13 0>;
> @@ -145,7 +144,7 @@
>                 };
>         };
>
> -       mmc_vcard: mmc_vcard {
> +       mmc_vcard: mmc-vcard {
>                 compatible = "regulator-fixed";
>                 regulator-name = "mmc_vcard";
>                 regulator-min-microvolt = <3300000>;
> diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> index 35202896c093..244c7ab8c76d 100644
> --- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> @@ -45,7 +45,7 @@
>
>  / {
>         soc {
> -               pinctrl: pin-controller {
> +               pinctrl: pin-controller at 40020000 {

pinctrl is the documented node name, not pin-controller.

>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges = <0 0x40020000 0x3000>;
> @@ -163,7 +163,7 @@
>                                 st,bank-name = "GPIOK";
>                         };
>
> -                       usart1_pins_a: usart1 at 0 {
> +                       usart1_pins_a: usart1-0 {

What's wrong with just "usart1"?

I think I would like to see "-pins" appended to the node names.

>                                 pins1 {
>                                         pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>                                         bias-disable;
> @@ -176,7 +176,7 @@
>                                 };
>                         };
>
> -                       usart3_pins_a: usart3 at 0 {
> +                       usart3_pins_a: usart3-0 {
>                                 pins1 {
>                                         pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
>                                         bias-disable;
> @@ -189,7 +189,7 @@
>                                 };
>                         };
>
> -                       usbotg_fs_pins_a: usbotg_fs at 0 {
> +                       usbotg_fs_pins_a: usbotg-fs-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
>                                                  <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
> @@ -200,7 +200,7 @@
>                                 };
>                         };
>
> -                       usbotg_fs_pins_b: usbotg_fs at 1 {
> +                       usbotg_fs_pins_b: usbotg-fs-1 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('B', 12, AF12)>, /* OTG_HS_ID */
>                                                  <STM32_PINMUX('B', 14, AF12)>, /* OTG_HS_DM */
> @@ -211,7 +211,7 @@
>                                 };
>                         };
>
> -                       usbotg_hs_pins_a: usbotg_hs at 0 {
> +                       usbotg_hs_pins_a: usbotg-hs-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT*/
>                                                  <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -231,7 +231,7 @@
>                                 };
>                         };
>
> -                       ethernet_mii: mii at 0 {
> +                       ethernet_mii: mii-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_MII_TXD0_ETH_RMII_TXD0 */
>                                                  <STM32_PINMUX('G', 14, AF11)>, /* ETH_MII_TXD1_ETH_RMII_TXD1 */
> @@ -251,13 +251,13 @@
>                                 };
>                         };
>
> -                       adc3_in8_pin: adc at 200 {
> +                       adc3_in8_pin: adc-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('F', 10, ANALOG)>;
>                                 };
>                         };
>
> -                       pwm1_pins: pwm at 1 {
> +                       pwm1_pins: pwm-1 {

You have a mixture of the number suffix being a pin mode # and block
instance #. pwm1 or pwm1-pins?

Similar comments on the rest.

Rob
