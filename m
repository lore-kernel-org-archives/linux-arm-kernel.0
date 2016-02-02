From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Feb 2016 14:25:18 +0800
Subject: [PATCH] pinctrl: sunxi: Add H3 R_PIO controller support
In-Reply-To: <20160201101225.GA19687@box2.japko.eu>
References: <20160201101225.GA19687@box2.japko.eu>
Message-ID: <CAGb2v65-X2_MoRm1=wAub9Y8Vpt-f-roYUT73jDk5Fnj17zKTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 6:12 PM, Krzysztof Adamski <k@japko.eu> wrote:
> H3 has additional PIO controller similar to what we can find on A23.
> It's a 12 pin port, described in H3 Datasheet rev 1.1, pages 345-350.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
> .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
> arch/arm/boot/dts/sun8i-h3.dtsi                    |  12 +++
> drivers/pinctrl/sunxi/Kconfig                      |   4 +
> drivers/pinctrl/sunxi/Makefile                     |   1 +
> drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c         | 105
> +++++++++++++++++++++
> 5 files changed, 123 insertions(+)
> create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
>
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 9213b27..730a917 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -20,6 +20,7 @@ Required properties:
>   "allwinner,sun9i-a80-pinctrl"
>   "allwinner,sun9i-a80-r-pinctrl"
>   "allwinner,sun8i-a83t-pinctrl"
> +  "allwinner,sun8i-h3-r-pinctrl"
>   "allwinner,sun8i-h3-pinctrl"

h3-r-pinctrl comes after h3-pinctrl


>
> - reg: Should contain the register physical address and length for the
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 1524130e..745f64c 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -493,5 +493,17 @@
>                         interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>                 };
> +
> +               r_pio: pinctrl at 01f02c00 {
> +                       compatible = "allwinner,sun8i-h3-r-pinctrl";
> +                       reg = <0x01f02c00 0x400>;
> +                       interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&bus_gates 69>;

This is probably wrong. According to other SoCs all R_ block peripherals
have clock gates and reset controls in the PRCM.

> +                       gpio-controller;
> +                       #gpio-cells = <3>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +

Extra new line here.

Also please split this into a separate patch.

>         };
> };
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index f8dbc8b..75a26c9 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -55,6 +55,10 @@ config PINCTRL_SUN8I_H3
>         def_bool MACH_SUN8I
>         select PINCTRL_SUNXI_COMMON
>
> +config PINCTRL_SUN8I_H3_R
> +       def_bool MACH_SUN8I
> +       select PINCTRL_SUNXI_COMMON
> +
> config PINCTRL_SUN9I_A80
>         def_bool MACH_SUN9I
>         select PINCTRL_SUNXI_COMMON
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index ef82f22..a5d56f1 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -14,5 +14,6 @@ obj-$(CONFIG_PINCTRL_SUN8I_A23_R)     +=
> pinctrl-sun8i-a23-r.o
> obj-$(CONFIG_PINCTRL_SUN8I_A33)         += pinctrl-sun8i-a33.o
> obj-$(CONFIG_PINCTRL_SUN8I_A83T)        += pinctrl-sun8i-a83t.o
> obj-$(CONFIG_PINCTRL_SUN8I_H3)          += pinctrl-sun8i-h3.o
> +obj-$(CONFIG_PINCTRL_SUN8I_H3_R)       += pinctrl-sun8i-h3-r.o
> obj-$(CONFIG_PINCTRL_SUN9I_A80)         += pinctrl-sun9i-a80.o
> obj-$(CONFIG_PINCTRL_SUN9I_A80_R)       += pinctrl-sun9i-a80-r.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
> b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
> new file mode 100644
> index 0000000..6271ceb
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
> @@ -0,0 +1,105 @@
> +/*
> + * Allwinner H3 SoCs pinctrl driver.
> + *
> + * Copyright (C) 2016 Krzysztof Adamski <k@japko.eu>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const struct sunxi_desc_pin sun8i_h3_r_pins[] = {
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_twi"),         /* SCK */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),  /* PL_EINT0 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_twi"),         /* SDA */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),  /* PL_EINT1 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_uart"),        /* TX */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),  /* PL_EINT2 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_uart"),        /* RX */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),  /* PL_EINT3 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_jtag"),        /* MS */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),  /* PL_EINT4 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_jtag"),        /* CK */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),  /* PL_EINT5 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_jtag"),        /* DO */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),  /* PL_EINT6 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_jtag"),        /* DI */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),  /* PL_EINT7 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),  /* PL_EINT8 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),  /* PL_EINT9 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_pwn"),

Typo: s_pwm

Regards
ChenYu

> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)), /* PL_EINT10 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 11),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "s_cir_rx"),
> +                 SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)), /* PL_EINT11 */
> +};
> +
> +static const struct sunxi_pinctrl_desc sun8i_h3_r_pinctrl_data = {
> +       .pins = sun8i_h3_r_pins,
> +       .npins = ARRAY_SIZE(sun8i_h3_r_pins),
> +       .irq_banks = 1,
> +       .pin_base = PL_BASE,
> +};
> +
> +static int sun8i_h3_r_pinctrl_probe(struct platform_device *pdev)
> +{
> +       return sunxi_pinctrl_init(pdev,
> +                                 &sun8i_h3_r_pinctrl_data);
> +}
> +
> +static const struct of_device_id sun8i_h3_r_pinctrl_match[] = {
> +       { .compatible = "allwinner,sun8i-h3-r-pinctrl", },
> +       {}
> +};
> +
> +static struct platform_driver sun8i_h3_r_pinctrl_driver = {
> +       .probe  = sun8i_h3_r_pinctrl_probe,
> +       .driver = {
> +               .name           = "sun8i-h3-r-pinctrl",
> +               .of_match_table = sun8i_h3_r_pinctrl_match,
> +       },
> +};
> +builtin_platform_driver(sun8i_h3_r_pinctrl_driver);
> --
> 2.4.2
>
