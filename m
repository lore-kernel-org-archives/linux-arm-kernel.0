From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 28 Oct 2012 12:17:52 +0000 (GMT)
Subject: [PATCH] GPIO: mvebu-gpio: Don't initialize the mask_cache
In-Reply-To: <1351344538-5238-1-git-send-email-andrew@lunn.ch>
References: <1351344538-5238-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.DEB.2.00.1210281213420.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Oct 2012, Andrew Lunn wrote:

> Due to the SMP nature of some of the chips, which have per CPU
> registers, the driver does not use the generic irq_gc_mask_set_bit() &
> irq_gc_mask_clr_bit() functions, which only support a single register.
> The driver has its own implementation of these functions, which can
> pick the correct register depending on the CPU being used. The
> functions do however use the gc->mask_cache value.
>
> The call to irq_setup_generic_chip() was passing
> IRQ_GC_INIT_MASK_CACHE, which caused the gc->mask_cache to be
> initialized to the contents of some random register. This resulted in
> unexpected interrupts been delivered from random GPIO lines.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Tested-by: Jamie Lentin <jm@lentin.co.uk>

This is what was causing my NAS to lock up when I turned the LEDs off. 
Thanks! The only one not working now is the power LED, patch coming soon 
to fix that.

> ---
> drivers/gpio/gpio-mvebu.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index eb42ab1..cf7afb9 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -646,7 +646,7 @@ static int __devinit mvebu_gpio_probe(struct platform_device *pdev)
> 	ct->handler = handle_edge_irq;
> 	ct->chip.name = mvchip->chip.label;
>
> -	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), IRQ_GC_INIT_MASK_CACHE,
> +	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), 0,
> 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
>
> 	/* Setup irq domain on top of the generic chip. */
>

-- 
Jamie Lentin
