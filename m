From: robherring2@gmail.com (Rob Herring)
Date: Thu, 04 Aug 2011 20:54:59 -0500
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <1312498820-2275-2-git-send-email-swarren@nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
Message-ID: <4E3B4D73.9030505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2011 06:00 PM, Stephen Warren wrote:
> Many IRQs are associated with GPIO pins. When the pin is used as an IRQ,
> it can't be used as anything else; it should be requested. Enhance the
> core interrupt code to call gpio_request() and gpio_direction_input() for
> any IRQ that is also a GPIO. This prevents duplication of these calls in
> each driver that uses an IRQ.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  kernel/irq/manage.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 0a7840a..6e2db72 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -7,6 +7,7 @@
>   * This file contains driver APIs to the irq subsystem.
>   */
>  
> +#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> @@ -875,7 +876,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	struct irqaction *old, **old_ptr;
>  	const char *old_name = NULL;
>  	unsigned long flags, thread_mask = 0;
> -	int ret, nested, shared = 0;
> +	int ret, nested, shared = 0, gpio = -1;
>  	cpumask_var_t mask;
>  
>  	if (!desc)
> @@ -978,6 +979,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  			old = *old_ptr;
>  		} while (old);
>  		shared = 1;
> +	} else {
> +		gpio = irq_to_gpio(irq);

If you read the documentation for gpio, it is not recommended to use
irq_to_gpio. There's only a handful of users. Part of the problem is it
is platform specific and the gpio core cannot convert irq to gpio
number. Here is the relevant section:

Non-error values returned from irq_to_gpio() would most commonly be used
with gpio_get_value(), for example to initialize or update driver state
when the IRQ is edge-triggered.  Note that some platforms don't support
this reverse mapping, so you should avoid using it.

Rob

> +		if (gpio_is_valid(gpio)) {
> +			ret = gpio_request(gpio, new->name);
> +			if (ret < 0)
> +				goto out_mask;
> +			ret = gpio_direction_input(gpio);
> +			if (ret < 0)
> +				goto out_mask;
> +		}
>  	}
>  
>  	/*
> @@ -1083,6 +1094,8 @@ mismatch:
>  	ret = -EBUSY;
>  
>  out_mask:
> +	if (gpio_is_valid(gpio))
> +		gpio_free(gpio);
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>  	free_cpumask_var(mask);
>  
> @@ -1127,6 +1140,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>  	struct irq_desc *desc = irq_to_desc(irq);
>  	struct irqaction *action, **action_ptr;
>  	unsigned long flags;
> +	int gpio;
>  
>  	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
>  
> @@ -1165,8 +1179,13 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>  #endif
>  
>  	/* If this was the last handler, shut down the IRQ line: */
> -	if (!desc->action)
> +	if (!desc->action) {
>  		irq_shutdown(desc);
> +		/* If the IRQ line is a GPIO, it's no longer in use */
> +		gpio = irq_to_gpio(irq);
> +		if (gpio_is_valid(gpio))
> +			gpio_free(gpio);
> +	}
>  
>  #ifdef CONFIG_SMP
>  	/* make sure affinity_hint is cleaned up */
