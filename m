From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Jan 2014 13:49:56 +0100
Subject: [PATCH 2/2] at91: pinctrl: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <1390394341-12548-2-git-send-email-jjhiblot@traphandler.com>
References: <1390394341-12548-1-git-send-email-jjhiblot@traphandler.com>
 <1390394341-12548-2-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52DFBE74.7000300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Jacques,

On 22/01/2014 13:39, Jean-Jacques Hiblot wrote:
> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index e8c8301..fbedde2 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1299,6 +1299,28 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
>  	return 0;
>  }
>  
> +static unsigned int gpio_irq_startup(struct irq_data *d)
> +{
> +	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
> +	unsigned	pin = d->hwirq;
> +	int ret;
> +
> +	ret = gpio_lock_as_irq(&at91_gpio->chip, pin);
> +	if (ret) {
> +		dev_err(at91_gpio->chip.dev, "unable to lock pind %lu IRQ\n",
> +			d->hwirq);
> +		return ret;
> +	}
> +	return 0;
> +}

As for the 1st patch, a blank line between the 2 functions should be nice

Thanks,

Gregory

> +static void gpio_irq_shutdown(struct irq_data *d)
> +{
> +	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
> +	unsigned	pin = d->hwirq;
> +
> +	gpio_unlock_as_irq(&at91_gpio->chip, pin);
> +}
> +
>  #ifdef CONFIG_PM
>  
>  static u32 wakeups[MAX_GPIO_BANKS];
> @@ -1377,6 +1399,8 @@ void at91_pinctrl_gpio_resume(void)
>  
>  static struct irq_chip gpio_irqchip = {
>  	.name		= "GPIO",
> +	.irq_startup	= gpio_irq_startup,
> +	.irq_shutdown	= gpio_irq_shutdown,
>  	.irq_disable	= gpio_irq_mask,
>  	.irq_mask	= gpio_irq_mask,
>  	.irq_unmask	= gpio_irq_unmask,
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
