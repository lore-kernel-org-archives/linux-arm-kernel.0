From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 09:24:22 +0800
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <375509863.2886324.1340049432848.JavaMail.root@advansee.com>
References: <375509863.2886324.1340049432848.JavaMail.root@advansee.com>
Message-ID: <20120619012420.GJ19249@S2101-09.ap.freescale.net>
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

NAK.

We have just gone through the pain to clean up those cpu_is_xxx() from
the driver.  Please do not bring them back.

Regards,
Shawn

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
>  
>  	port->both_edges &= ~(1 << (gpio & 31));
>  	switch (type) {
> @@ -160,15 +163,19 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  		edge = GPIO_INT_FALL_EDGE;
>  		break;
>  	case IRQ_TYPE_EDGE_BOTH:
> -		val = gpio_get_value(gpio);
> -		if (val) {
> -			edge = GPIO_INT_LOW_LEV;
> -			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
> +		if (edge_sel) {
> +			edge = GPIO_INT_BOTH_EDGES;
>  		} else {
> -			edge = GPIO_INT_HIGH_LEV;
> -			pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
> +			val = gpio_get_value(gpio);
> +			if (val) {
> +				edge = GPIO_INT_LOW_LEV;
> +				pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
> +			} else {
> +				edge = GPIO_INT_HIGH_LEV;
> +				pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
> +			}
> +			port->both_edges |= 1 << (gpio & 31);
>  		}
> -		port->both_edges |= 1 << (gpio & 31);
>  		break;
>  	case IRQ_TYPE_LEVEL_LOW:
>  		edge = GPIO_INT_LOW_LEV;
> @@ -180,10 +187,23 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  		return -EINVAL;
>  	}
>  
> -	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
> -	bit = gpio & 0xf;
> -	val = readl(reg) & ~(0x3 << (bit << 1));
> -	writel(val | (edge << (bit << 1)), reg);
> +	if (edge_sel) {
> +		val = readl(port->base + GPIO_EDGE_SEL);
> +		if (edge == GPIO_INT_BOTH_EDGES)
> +			writel(val | (1 << (gpio & 0x1f)),
> +				port->base + GPIO_EDGE_SEL);
> +		else
> +			writel(val & ~(1 << (gpio & 0x1f)),
> +				port->base + GPIO_EDGE_SEL);
> +	}
> +
> +	if (edge != GPIO_INT_BOTH_EDGES) {
> +		reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
> +		bit = gpio & 0xf;
> +		val = readl(reg) & ~(0x3 << (bit << 1));
> +		writel(val | (edge << (bit << 1)), reg);
> +	}
> +
>  	writel(1 << (gpio & 0x1f), port->base + GPIO_ISR);
>  
>  	return 0;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
