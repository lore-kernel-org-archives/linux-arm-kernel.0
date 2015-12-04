From: robh@kernel.org (Rob Herring)
Date: Fri, 4 Dec 2015 08:39:04 -0600
Subject: [PATCH 1/7] pinctrl: sunxi: Add A80 special pin controller
In-Reply-To: <1448948845-28347-2-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
 <1448948845-28347-2-git-send-email-wens@csie.org>
Message-ID: <20151204143904.GA10784@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 01:47:19PM +0800, Chen-Yu Tsai wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Like the previous designs, the A80 has a special pin controller for the
> critical pins, like the PMIC bus.
> 
> Add a driver for this controller.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [wens: Add A80 compatible strings to bindings doc; fix pin function
>        names based on v1.3 datasheet; constify of_device_id table]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   2 +

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sunxi/Kconfig                      |   5 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c        | 181 +++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index b321b26780dc..b3b6c2f210d7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -18,6 +18,8 @@ Required properties:
>    "allwinner,sun8i-a23-r-pinctrl"
>    "allwinner,sun8i-a33-pinctrl"
>    "allwinner,sun8i-a83t-pinctrl"
> +  "allwinner,sun9i-a80-pinctrl"
> +  "allwinner,sun9i-a80-r-pinctrl"
>  
>  - reg: Should contain the register physical address and length for the
>    pin controller.
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index e68fd951129a..0252b3fa41ce 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -55,4 +55,9 @@ config PINCTRL_SUN9I_A80
>  	def_bool MACH_SUN9I
>  	select PINCTRL_SUNXI_COMMON
>  
> +config PINCTRL_SUN9I_A80_R
> +	def_bool MACH_SUN9I
> +	depends on RESET_CONTROLLER
> +	select PINCTRL_SUNXI_COMMON
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index e08029034510..0b4b827f314b 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
>  obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
>  obj-$(CONFIG_PINCTRL_SUN8I_A83T)	+= pinctrl-sun8i-a83t.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
> +obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
> new file mode 100644
> index 000000000000..42547ffa20a8
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
> @@ -0,0 +1,181 @@
> +/*
> + * Allwinner A80 SoCs special pins pinctrl driver.
> + *
> + * Copyright (C) 2014 Maxime Ripard
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
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
> +#include <linux/reset.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const struct sunxi_desc_pin sun9i_a80_r_pins[] = {
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_uart"),	/* TX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_uart"),	/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PL_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* TMS */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PL_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* TCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PL_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* TDO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PL_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* TDI */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PL_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_cir_rx"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PL_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "1wire"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PL_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_ps2"),		/* SCK1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_ps2"),		/* SDA1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PL_EINT9 */
> +
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PM_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PM_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PM_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PM_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_i2s1"),	/* LRCKR */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PM_EINT4 */
> +
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_i2c1"),	/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),	/* PM_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "s_i2c1"),	/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 9)),	/* PM_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s0"),	/* MCLK */
> +		  SUNXI_FUNCTION(0x3, "s_i2s1")),	/* MCLK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s0"),	/* BCLK */
> +		  SUNXI_FUNCTION(0x3, "s_i2s1")),	/* BCLK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s0"),	/* LRCK */
> +		  SUNXI_FUNCTION(0x3, "s_i2s1")),	/* LRCK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s0"),	/* DIN */
> +		  SUNXI_FUNCTION(0x3, "s_i2s1")),	/* DIN */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s0"),	/* DOUT */
> +		  SUNXI_FUNCTION(0x3, "s_i2s1")),	/* DOUT */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 15)),	/* PM_EINT15 */
> +
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2c0"),	/* SCK */
> +		  SUNXI_FUNCTION(0x3, "s_rsb")),	/* SCK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2c0"),	/* SDA */
> +		  SUNXI_FUNCTION(0x3, "s_rsb")),	/* SDA */
> +};
> +
> +static const struct sunxi_pinctrl_desc sun9i_a80_r_pinctrl_data = {
> +	.pins = sun9i_a80_r_pins,
> +	.npins = ARRAY_SIZE(sun9i_a80_r_pins),
> +	.pin_base = PL_BASE,
> +	.irq_banks = 2,
> +};
> +
> +static int sun9i_a80_r_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return sunxi_pinctrl_init(pdev,
> +				  &sun9i_a80_r_pinctrl_data);
> +}
> +
> +static const struct of_device_id sun9i_a80_r_pinctrl_match[] = {
> +	{ .compatible = "allwinner,sun9i-a80-r-pinctrl", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun9i_a80_r_pinctrl_match);
> +
> +static struct platform_driver sun9i_a80_r_pinctrl_driver = {
> +	.probe	= sun9i_a80_r_pinctrl_probe,
> +	.driver	= {
> +		.name		= "sun9i-a80-r-pinctrl",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= sun9i_a80_r_pinctrl_match,
> +	},
> +};
> +module_platform_driver(sun9i_a80_r_pinctrl_driver);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
> +MODULE_DESCRIPTION("Allwinner A80 R_PIO pinctrl driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.6.2
> 
