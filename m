From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 18 Mar 2018 10:21:36 -0300
Subject: [PATCH V2] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM
 and PDK2
In-Reply-To: <20180318084238.26759-1-marex@denx.de>
References: <20180318084238.26759-1-marex@denx.de>
Message-ID: <CAOMZO5AfXgZPLXSx5MnigMjSG0HCqPDg5t_mZTtj37eg9hwQkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sun, Mar 18, 2018 at 5:42 AM, Marek Vasut <marex@denx.de> wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3b4cc1b64a1e..c39f991e3c3e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -440,6 +440,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-cubox-i-som-v15.dtb \
>         imx6q-dfi-fs700-m60.dtb \
>         imx6q-display5-tianma-tm070-1280x768.dtb \
> +       imx6q-dhcom-pdk2.dtb \

imx6q-dhcom-pdk2.dtb should come prior to
imx6q-display5-tianma-tm070-1280x768.dtb to keep in alphabetical
order.

> +&ecspi1 {
> +       fsl,spi-num-chipselects = <2>;

This property is not necessary.

> +       cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       status = "okay";
> +
> +       flash at 0 {       /* S25FL116K */
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "jedec,spi-nor";
> +               spi-max-frequency = <50000000>;
> +               reg = <0>;
> +               m25p,fast-read;
> +       };
> +};
> +
> +&ecspi2 {
> +       fsl,spi-num-chipselects = <1>;

Same here.

> +       cs-gpios = <&gpio5 29 1>;

&gpio5 29 GPIO_ACTIVE_LOW

> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet_100M>;
> +       phy-mode = "rmii";
> +       phy-handle = <&ethphy0>;
> +       power-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;

'power-gpios' is not a valid property for fec.


> +       ltc3676: pmic at 3c {
> +               compatible = "lltc,ltc3676";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pmic_hw300>;
> +               reg = <0x3c>;
> +               interrupt-parent = <&gpio5>;
> +               interrupts = <2 2>;

interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
