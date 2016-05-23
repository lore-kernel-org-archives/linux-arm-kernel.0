From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 May 2016 14:49:12 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5C5goJUdHKB9a=eOv9TKDkJWxnkWWb-G7E5Kvceg6sZVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 22, 2016 at 7:47 PM,  <christopher.spinrath@rwth-aachen.de> wrote:

> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
> new file mode 100644
> index 0000000..bcd8e0d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
> @@ -0,0 +1,128 @@
> +/*
> + * Copyright 2016 Christopher Spinrath
> + * Copyright 2013 CompuLab Ltd.
> + *
> + * Based on the GPLv2 licensed devicetree distributed with the vendor
> + * kernel for the Utilite Pro:
> + *     Copyright 2013 CompuLab Ltd.
> + *     Author: Valentin Raevsky <valentin@compulab.co.il>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:

Can you make this dual GPL/X11 license?

For reference take a look at:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6sl-warp.dts?id=refs/tags/v4.6


> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               power {
> +                       label = "Power Button";
> +                       gpios = <&gpio1 29 1>;

Better to use a label like:
gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       hog {
> +               pinctrl_hog: hoggrp {
> +                       fsl,pins = <
> +                               /* power button */
> +                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000

Better to avoid 0x80000000. Replace it with the real iomux value
instead so that you don't need to rely on the bootloader
configuration.

> +
> +       imx6q-utilite-pro {
> +               pinctrl_i2c1: i2c1grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
> +                               MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
> +                       >;
> +               };

You should better remove one level of indentation. Check this commit
for reference:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6q-tbs2910.dts?h=for-next&id=aa7871b53bc3c36b4adefe67f728143e2deeec93

> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       fsl,uart-has-rtscts;
> +       dma-names = "rx", "tx";
> +       dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;

No need to add the dma nodes as they are already present in imx6qdl.dtsi.
