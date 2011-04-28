From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 12:43:41 +0100
Subject: [PATCH 03/14] at91: factorize at91 interrupts init to soc
In-Reply-To: <1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110428114341.GH17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 08:31:13PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> they are the same except the default priority

No one uses anything but the default priority.  So let's have a version
of this patch which simplifies this further:

> diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
> index 5b2a7bb..1fac2fe 100644
> --- a/arch/arm/mach-at91/board-usb-a9263.c
> +++ b/arch/arm/mach-at91/board-usb-a9263.c
> @@ -61,7 +61,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9263_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }

by replacing every instance of the above with a call in their machine
record to at91_init_irq_default(), and:

> +void __init at91_init_interrupts(unsigned int *priority)
> +{
> +	if (!priority)
> +		priority = current_soc.default_irq_priority;
> +
> +	/* Initialize the AIC interrupt controller */
> +	at91_aic_init(priority);
> +
> +	/* Enable GPIO interrupts */
> +	at91_gpio_irq_setup();
> +}

void __init at91_init_interrupts(unsigned int *priority)
{
	/* Initialize the AIC interrupt controller */
	at91_aic_init(priority);

	/* Enable GPIO interrupts */
	at91_gpio_irq_setup();
}

void __init at91_init_irq_default(void)
{
	at91_init_interrupts(current_soc.default_irq_priority);
}

If people wish to change from the default priority, they can provide
their own init_irq function, and call at91_init_interrupts with their
desired priority array.

> diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> index 6c30d74..9aac491 100644
> --- a/arch/arm/mach-at91/soc.h
> +++ b/arch/arm/mach-at91/soc.h
> @@ -8,6 +8,7 @@
>  
>  struct at91_soc {
>  	char *name;

btw, this should be const (which should of course be a separate patch).
