From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Jun 2012 11:19:59 +0200
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <375509863.2886324.1340049432848.JavaMail.root@advansee.com>
References: <375509863.2886324.1340049432848.JavaMail.root@advansee.com>
Message-ID: <20120620091959.GQ28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 09:57:12PM +0200, Beno?t Th?baudeau wrote:
> Some mxc processors have an edge_sel feature, which allows the IRQ to be
> triggered by any edge.
> 
> This patch makes use of this feature if available, which skips mxc_flip_edge().
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../drivers/gpio/gpio-mxc.c                        |   44 ++++++++++++++------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git linux-next-HEAD-6c86b58.orig/drivers/gpio/gpio-mxc.c linux-next-HEAD-6c86b58/drivers/gpio/gpio-mxc.c
> index c337143..4c74482 100644
> --- linux-next-HEAD-6c86b58.orig/drivers/gpio/gpio-mxc.c
> +++ linux-next-HEAD-6c86b58/drivers/gpio/gpio-mxc.c
> @@ -30,6 +30,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/module.h>
> +#include <mach/hardware.h>
>  #include <asm-generic/bug.h>
>  #include <asm/mach/irq.h>
>  
> @@ -104,12 +105,13 @@ static struct mxc_gpio_hwdata *mxc_gpio_hwdata;
>  #define GPIO_ICR2		(mxc_gpio_hwdata->icr2_reg)
>  #define GPIO_IMR		(mxc_gpio_hwdata->imr_reg)
>  #define GPIO_ISR		(mxc_gpio_hwdata->isr_reg)
> +#define GPIO_EDGE_SEL		0x1c
>  
>  #define GPIO_INT_LOW_LEV	(mxc_gpio_hwdata->low_level)
>  #define GPIO_INT_HIGH_LEV	(mxc_gpio_hwdata->high_level)
>  #define GPIO_INT_RISE_EDGE	(mxc_gpio_hwdata->rise_edge)
>  #define GPIO_INT_FALL_EDGE	(mxc_gpio_hwdata->fall_edge)
> -#define GPIO_INT_NONE		0x4
> +#define GPIO_INT_BOTH_EDGES	0x4
>  
>  static struct platform_device_id mxc_gpio_devtype[] = {
>  	{
> @@ -150,6 +152,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  	u32 bit, val;
>  	int edge;
>  	void __iomem *reg = port->base;
> +	bool edge_sel = cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53();

To make Shawns suggestion a bit more clear:

What you should do here is to add flags describing differences between
SoCs in mxc_gpio_hwdata.

This means that you have to:

- add IMX35_GPIO to enum mxc_gpio_hwtype
- add imx35-gpio to mxc_gpio_devtype[]
- add "fsl,imx35-gpio" to the compatible list.
- fix all devicetree bindings and platform device bindings for
  i.MX25,35,51,53 and probably i.MX6

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
