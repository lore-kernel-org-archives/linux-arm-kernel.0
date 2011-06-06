From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 6 Jun 2011 02:12:45 -0600
Subject: [PATCH] gpio/mxc: convert gpio-mxc to use basic_mmio_gpio library
In-Reply-To: <1307337761-10606-1-git-send-email-shawn.guo@linaro.org>
References: <1307337761-10606-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110606081245.GF10410@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 01:22:41PM +0800, Shawn Guo wrote:
> The gpio-mxc controller complies with basic_mmio_gpio library.  The
> patch convert the driver to use the library.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.

g.

> ---
> The patch is based on the series below.
> 
>   [PATCH v4 0/2] Move plat-mxc gpio driver into drivers/gpio
> 
> Thanks Jamie Iles for reminding this work.
> 
>  drivers/gpio/Kconfig    |    1 +
>  drivers/gpio/gpio-mxc.c |   83 ++++++++---------------------------------------
>  2 files changed, 15 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5f00b41..d973abd 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -96,6 +96,7 @@ config GPIO_EXYNOS4
>  config GPIO_MXC
>  	def_bool y
>  	depends on ARCH_MXC
> +	select GPIO_BASIC_MMIO_CORE
>  
>  config GPIO_PLAT_SAMSUNG
>  	bool "Samsung SoCs GPIO library support"
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 844079a..b351952893 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -26,6 +26,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/basic_mmio_gpio.h>
>  #include <mach/hardware.h>
>  #include <asm-generic/bug.h>
>  
> @@ -35,9 +36,8 @@ struct mxc_gpio_port {
>  	int irq;
>  	int irq_high;
>  	int virtual_irq_start;
> -	struct gpio_chip chip;
> +	struct bgpio_chip bgc;
>  	u32 both_edges;
> -	spinlock_t lock;
>  };
>  
>  /*
> @@ -101,8 +101,6 @@ static void gpio_unmask_irq(struct irq_data *d)
>  	_set_gpio_irqenable(port, gpio & 0x1f, 1);
>  }
>  
> -static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset);
> -
>  static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  {
>  	u32 gpio = irq_to_gpio(d->irq);
> @@ -120,7 +118,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  		edge = GPIO_INT_FALL_EDGE;
>  		break;
>  	case IRQ_TYPE_EDGE_BOTH:
> -		val = mxc_gpio_get(&port->chip, gpio & 31);
> +		val = gpio_get_value(gpio & 31);
>  		if (val) {
>  			edge = GPIO_INT_LOW_LEV;
>  			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
> @@ -259,60 +257,6 @@ static struct irq_chip gpio_irq_chip = {
>  	.irq_set_wake = gpio_set_wake_irq,
>  };
>  
> -static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
> -				int dir)
> -{
> -	struct mxc_gpio_port *port =
> -		container_of(chip, struct mxc_gpio_port, chip);
> -	u32 l;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&port->lock, flags);
> -	l = readl(port->base + GPIO_GDIR);
> -	if (dir)
> -		l |= 1 << offset;
> -	else
> -		l &= ~(1 << offset);
> -	writel(l, port->base + GPIO_GDIR);
> -	spin_unlock_irqrestore(&port->lock, flags);
> -}
> -
> -static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> -{
> -	struct mxc_gpio_port *port =
> -		container_of(chip, struct mxc_gpio_port, chip);
> -	void __iomem *reg = port->base + GPIO_DR;
> -	u32 l;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&port->lock, flags);
> -	l = (readl(reg) & (~(1 << offset))) | (!!value << offset);
> -	writel(l, reg);
> -	spin_unlock_irqrestore(&port->lock, flags);
> -}
> -
> -static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
> -{
> -	struct mxc_gpio_port *port =
> -		container_of(chip, struct mxc_gpio_port, chip);
> -
> -	return (readl(port->base + GPIO_PSR) >> offset) & 1;
> -}
> -
> -static int mxc_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> -{
> -	_set_gpio_direction(chip, offset, 0);
> -	return 0;
> -}
> -
> -static int mxc_gpio_direction_output(struct gpio_chip *chip,
> -				     unsigned offset, int value)
> -{
> -	mxc_gpio_set(chip, offset, value);
> -	_set_gpio_direction(chip, offset, 1);
> -	return 0;
> -}
> -
>  /*
>   * This lock class tells lockdep that GPIO irqs are in a different
>   * category than their parents, so it won't report false recursion.
> @@ -385,24 +329,25 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	/* register gpio chip */
> -	port->chip.direction_input = mxc_gpio_direction_input;
> -	port->chip.direction_output = mxc_gpio_direction_output;
> -	port->chip.get = mxc_gpio_get;
> -	port->chip.set = mxc_gpio_set;
> -	port->chip.base = pdev->id * 32;
> -	port->chip.ngpio = 32;
> +	err = bgpio_init(&port->bgc, &pdev->dev, 4,
> +			 port->base + GPIO_PSR,
> +			 port->base + GPIO_DR, NULL,
> +			 port->base + GPIO_GDIR, NULL, false);
> +	if (err)
> +		goto out_iounmap;
>  
> -	spin_lock_init(&port->lock);
> +	port->bgc.gc.base = pdev->id * 32;
>  
> -	err = gpiochip_add(&port->chip);
> +	err = gpiochip_add(&port->bgc.gc);
>  	if (err)
> -		goto out_iounmap;
> +		goto out_bgpio_remove;
>  
>  	list_add_tail(&port->node, &mxc_gpio_ports);
>  
>  	return 0;
>  
> +out_bgpio_remove:
> +	bgpio_remove(&port->bgc);
>  out_iounmap:
>  	iounmap(port->base);
>  out_release_mem:
> -- 
> 1.7.4.1
> 
