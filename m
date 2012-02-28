From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Feb 2012 16:02:31 -0800
Subject: [PATCH 4/6] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <1329999031-6914-5-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Thu, 23 Feb 2012 17:40:29 +0530")
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <87linnu8o8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This local variable is just assigned zero and then OR'ed
> with isr. It does not appear to serve any purpose and so
> removing it.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks like the use of this was removed when I moved things over to using
the generic IRQ framework, but I didn't fully clean up.

Can you update the changelog to something along the lines of:

"commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
framework) removed retrigger support in favor of using generic IRQ
framework.  This patch cleans up some unused remnants of that removal.

Thanks,

Kevin

> ---
>  drivers/gpio/gpio-omap.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b62e861..3dd4b3a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -623,7 +623,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	u32 isr;
>  	unsigned int gpio_irq, gpio_index;
>  	struct gpio_bank *bank;
> -	u32 retrigger = 0;
>  	int unmasked = 0;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> @@ -660,8 +659,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			chained_irq_exit(chip, desc);
>  		}
>  
> -		isr |= retrigger;
> -		retrigger = 0;
>  		if (!isr)
>  			break;
