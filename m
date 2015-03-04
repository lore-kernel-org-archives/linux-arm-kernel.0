From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 4 Mar 2015 22:30:03 +0100
Subject: [PATCH] pinctrl: at91: move lock/unlock_as_irq calls into
 request/release resources methods
In-Reply-To: <1423419822-6258-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1423419822-6258-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150304213003.GD14457@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:23 Sun 08 Feb     , Boris Brezillon wrote:
> The gpiochip_lock_as_irq call can fail and return an error, while the
> irq_startup is not expected to fail (returns an unsigned int which is not
> checked by irq core code).
> 
> irq_request/release_resources functions have been created to address this
> problem.
> 
> Move gpiochip_lock/unlock_as_irq calls into
> irq_request/release_resources functions to prevent using a gpio as an irq
> if the gpiochip_lock_as_irq call failed.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Linus

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
>  drivers/pinctrl/pinctrl-at91.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index f4cd0b9..a481406 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1477,28 +1477,25 @@ static void gpio_irq_ack(struct irq_data *d)
>  	/* the interrupt is already cleared before by reading ISR */
>  }
>  
> -static unsigned int gpio_irq_startup(struct irq_data *d)
> +static int gpio_irq_request_res(struct irq_data *d)
>  {
>  	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
>  	unsigned	pin = d->hwirq;
>  	int ret;
>  
>  	ret = gpiochip_lock_as_irq(&at91_gpio->chip, pin);
> -	if (ret) {
> +	if (ret)
>  		dev_err(at91_gpio->chip.dev, "unable to lock pind %lu IRQ\n",
>  			d->hwirq);
> -		return ret;
> -	}
> -	gpio_irq_unmask(d);
> -	return 0;
> +
> +	return ret;
>  }
>  
> -static void gpio_irq_shutdown(struct irq_data *d)
> +static void gpio_irq_release_res(struct irq_data *d)
>  {
>  	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
>  	unsigned	pin = d->hwirq;
>  
> -	gpio_irq_mask(d);
>  	gpiochip_unlock_as_irq(&at91_gpio->chip, pin);
>  }
>  
> @@ -1577,8 +1574,8 @@ void at91_pinctrl_gpio_resume(void)
>  static struct irq_chip gpio_irqchip = {
>  	.name		= "GPIO",
>  	.irq_ack	= gpio_irq_ack,
> -	.irq_startup	= gpio_irq_startup,
> -	.irq_shutdown	= gpio_irq_shutdown,
> +	.irq_request_resources = gpio_irq_request_res,
> +	.irq_release_resources = gpio_irq_release_res,
>  	.irq_disable	= gpio_irq_mask,
>  	.irq_mask	= gpio_irq_mask,
>  	.irq_unmask	= gpio_irq_unmask,
> -- 
> 1.9.1
> 
