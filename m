From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 13 Jan 2014 11:35:18 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a
 gpio used as an interrupt source.
In-Reply-To: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
Message-ID: <52D3C166.5050908@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2014 11:29, Jean-Jacques Hiblot wrote:
> Hello Nicolas, Jean-Christophe,
>
> As I was trying to enable the touchscreen on the at91sam9261ek with
> device-tree support, I ran into an issue. The touchscreen driver needs
> to know the state of the pendown gpio and also needs it as an
> interrupt source.
>
> The problem is that when a gpio is used as an interrupt, it's
> requested by the pinctrl driver during the xlate stage, marking it
> unavaliable for the other driver.
> It looks like the at91 pinctrl driver is the only one to use
> gpio_request() in the xlate stage. Maybe we should remove this:

You should only request it as a GPIO and then use gpio_to_irq to get the
related IRQ.
Because what is done here, is to solve the case where only the irq
is request, and in this specific case we need to request the pin as a
GPIO.


Best Regards,

Boris
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index a7549c4..cf91a35 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1463,14 +1463,6 @@ static int at91_gpio_irq_domain_xlate(struct
> irq_domain *d,
>          *out_hwirq = intspec[0];
>          *out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
>
> -       ret = gpio_request(pin, ctrlr->full_name);
> -       if (ret)
> -               return ret;
> -
> -       ret = gpio_direction_input(pin);
> -       if (ret)
> -               return ret;
> -
>          return 0;
>   }
>
> Jean-Jacques
