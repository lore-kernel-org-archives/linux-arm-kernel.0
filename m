From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 02 Jul 2015 09:36:22 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
Message-ID: <5594E9F6.7040701@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 09:34 PM, Richard Cochran wrote:
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 58faf04..b7e7977 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -491,6 +491,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> +		if (of_property_read_u32(port_np, "snps,base",
> +					 &pp->gpio_base)) {
> +			dev_info(dev, "no base gpio specified for %s\n",
> +				 port_np->full_name);
> +			pp->gpio_base = -1;
> +		}
> +

If you are in a specific SoC you could do
	base = of_alias_get_id(np, "gpio") * num_of_gpio_per_chip
and get consistent numbers / sane.
I think this is the one reason why there is no generic binding for the
starting address. The other reason might be that this is simply a user
space problem. To get consistent numbers all you need to do to lookup
each gpio's memory address and decide if this is the one you look for.

Sebastian
