From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Dec 2017 16:26:16 -0200
Subject: [PATCH v3 1/6] ARM: dts: imx6: Add initial support for
 phyCORE-i.MX 6 SOM
In-Reply-To: <1513940353-6145-2-git-send-email-s.riedmueller@phytec.de>
References: <1513940353-6145-1-git-send-email-s.riedmueller@phytec.de>
 <1513940353-6145-2-git-send-email-s.riedmueller@phytec.de>
Message-ID: <CAOMZO5D3gaTzhHFese_6gmKEL+M2+GLj4W3AcqWDgmA1JagF1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

I am sorry I missed some points during my last review.

On Fri, Dec 22, 2017 at 8:59 AM, Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:
> This patch adds basic support for PHYTEC phyCORE-i.MX 6 SOM with i.MX
> 6Quad/Dual or i.MX 6DualLight/Solo.
>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 282 ++++++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
>
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> new file mode 100644
> index 0000000..8501ac6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2017 PHYTEC Messtechnik GmbH
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "PHYTEC phyCORE-i.MX 6";
> +       compatible = "phytec,imx6qdl-pcm058", "fsl,imx6qdl";

fsl,imx6qdl is not a documented compatible. Please remove the model
and compatible from the dtsi and put it only in the dts files.

> +
> +       aliases {
> +               rtc1 = &da9062_rtc;
> +               rtc2 = &snvs_rtc;
> +       };
> +
> +       /*
> +        * Set the minimum memory size here and
> +        * let the bootloader set the real size.
> +        */
> +       memory at 10000000 {
> +               device_type = "memory";
> +               reg = <0x10000000 0x8000000>;
> +       };
> +
> +       gpio_leds_som: somleds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpioleds_som>;
> +
> +               som_green {
> +                       label = "phycore:green";
> +                       gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +};
> +
> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +
> +       flash: flash at 0 {
> +               compatible = "m25p80";

Please check Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
for the proper usage of the SPI NOR compatible.

Or you can also check arch/arm/boot/dts/imx6qdl-sabresd.dtsi as reference.

With these two changes you can add:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
