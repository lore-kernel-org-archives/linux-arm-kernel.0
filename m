From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Feb 2014 18:47:16 +0100
Subject: [PATCH v4 2/8] at91: pinctrl: don't request GPIOs used for
 interrupts but lock them as IRQ
In-Reply-To: <1392199607-27452-3-git-send-email-jjhiblot@traphandler.com>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <1392199607-27452-3-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52FBB3A4.8020706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2014 11:06, Jean-Jacques Hiblot :
> During the xlate stage of the DT interrupt parsing, the at91 pinctrl driver
> requests the GPIOs that are described as interrupt sources. This prevents a
> driver to request the gpio later to get its electrical value.
> This patch replaces the gpio_request with a gpio_lock_as_irq to prevent the
> gpio to be set as an ouput while allowing a subsequent gpio_request to succeed
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

But I suspect it may go through another patch: the pinctrl one: add
Linux W. to the recipient list please.

Thanks,

> ---
>  drivers/pinctrl/pinctrl-at91.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index d990e33..db55b96 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1478,18 +1478,17 @@ static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
>  {
>  	struct at91_gpio_chip *at91_gpio = d->host_data;
>  	int ret;
> -	int pin = at91_gpio->chip.base + intspec[0];
>  
>  	if (WARN_ON(intsize < 2))
>  		return -EINVAL;
>  	*out_hwirq = intspec[0];
>  	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
>  
> -	ret = gpio_request(pin, ctrlr->full_name);
> +	ret = gpio_lock_as_irq(&at91_gpio->chip, intspec[0]);
>  	if (ret)
>  		return ret;
>  
> -	ret = gpio_direction_input(pin);
> +	ret = at91_gpio_direction_input(&at91_gpio->chip, intspec[0]);
>  	if (ret)
>  		return ret;
>  
> 


-- 
Nicolas Ferre
