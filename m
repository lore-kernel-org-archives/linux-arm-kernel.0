From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Oct 2015 16:08:25 +0800
Subject: [PATCH v4 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <1445964626-6484-4-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-4-git-send-email-jenskuske@gmail.com>
Message-ID: <CAGb2v66wsCgoxedFY1mvVmQkLoRCRz_yeLaa0F8wG10JYHvXRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 28, 2015 at 12:50 AM, Jens Kuske <jenskuske@gmail.com> wrote:
> The H3 uses the same pin controller as previous SoC's from Allwinner.
> Add support for the pins controlled by the main PIO controller.
>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c           | 516 +++++++++++++++++++++
>  4 files changed, 522 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index b321b26..e6ba602 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -18,6 +18,7 @@ Required properties:
>    "allwinner,sun8i-a23-r-pinctrl"
>    "allwinner,sun8i-a33-pinctrl"
>    "allwinner,sun8i-a83t-pinctrl"
> +  "allwinner,sun8i-h3-pinctrl"
>
>  - reg: Should contain the register physical address and length for the
>    pin controller.
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index e68fd95..89ab7f5 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -51,6 +51,10 @@ config PINCTRL_SUN8I_A23_R
>         depends on RESET_CONTROLLER
>         select PINCTRL_SUNXI_COMMON
>
> +config PINCTRL_SUN8I_H3
> +       def_bool MACH_SUN8I
> +       select PINCTRL_SUNXI_COMMON
> +
>  config PINCTRL_SUN9I_A80
>         def_bool MACH_SUN9I
>         select PINCTRL_SUNXI_COMMON
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index e080290..6bd818e 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -13,4 +13,5 @@ obj-$(CONFIG_PINCTRL_SUN8I_A23)               += pinctrl-sun8i-a23.o
>  obj-$(CONFIG_PINCTRL_SUN8I_A23_R)      += pinctrl-sun8i-a23-r.o
>  obj-$(CONFIG_PINCTRL_SUN8I_A33)                += pinctrl-sun8i-a33.o
>  obj-$(CONFIG_PINCTRL_SUN8I_A83T)       += pinctrl-sun8i-a83t.o
> +obj-$(CONFIG_PINCTRL_SUN8I_H3)         += pinctrl-sun8i-h3.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80)                += pinctrl-sun9i-a80.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
> new file mode 100644
> index 0000000..98d465d
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
> @@ -0,0 +1,516 @@
> +/*
> + * Allwinner H3 SoCs pinctrl driver.
> + *
> + * Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> + *
> + * Based on pinctrl-sun8i-a23.c, which is:
> + * Copyright (C) 2014 Chen-Yu Tsai <wens@csie.org>
> + * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
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
> +static const struct sunxi_desc_pin sun8i_h3_pins[] = {

<snip>

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXD3 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXD2 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXD1 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXD0 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXCK */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXCTL/RCDV */

RXDV?

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* RXERR */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* TXD3 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* TXD2L */

Trailing "L" there.

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "emac")),         /* TXD1 */

<snip>

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* CLK */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 0)),  /* PG_EINT0 */

Datasheet say EINT is function 0x6. Same for all the other pins in group G.

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* CMD */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 1)),  /* PG_EINT1 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* D0 */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 2)),  /* PG_EINT2 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* D1 */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 3)),  /* PG_EINT3 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* D2 */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 4)),  /* PG_EINT4 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mmc1"),          /* D3 */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 5)),  /* PG_EINT5 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "uart1"),         /* TX */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 6)),  /* PG_EINT6 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "uart1"),         /* RX */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 7)),  /* PG_EINT7 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "uart1"),         /* RTS */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 8)),  /* PG_EINT8 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "uart1"),         /* CTS */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 9)),  /* PG_EINT9 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "i2s1"),          /* SYNC */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 10)), /* PG_EINT10 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "i2s1"),          /* CLK */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 11)), /* PG_EINT11 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "i2s1"),          /* DOUT */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 12)), /* PG_EINT12 */
> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "i2s1"),          /* DIN */
> +                 SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 13)), /* PG_EINT13 */
> +};
> +
> +static const struct sunxi_pinctrl_desc sun8i_h3_pinctrl_data = {
> +       .pins = sun8i_h3_pins,
> +       .npins = ARRAY_SIZE(sun8i_h3_pins),
> +       .irq_banks = 2,
> +};
> +
> +static int sun8i_h3_pinctrl_probe(struct platform_device *pdev)
> +{
> +       return sunxi_pinctrl_init(pdev,
> +                                 &sun8i_h3_pinctrl_data);
> +}
> +
> +static const struct of_device_id sun8i_h3_pinctrl_match[] = {
> +       { .compatible = "allwinner,sun8i-h3-pinctrl", },
> +       {}
> +};
> +
> +static struct platform_driver sun8i_h3_pinctrl_driver = {
> +       .probe  = sun8i_h3_pinctrl_probe,
> +       .driver = {
> +               .name           = "sun8i-h3-pinctrl",
> +               .of_match_table = sun8i_h3_pinctrl_match,
> +       },
> +};
> +builtin_platform_driver(sun8i_h3_pinctrl_driver);
> --
> 2.6.2
>

The rest looks good. Thanks!


Regards
ChenYu
