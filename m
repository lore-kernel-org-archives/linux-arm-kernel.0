From: pavel@denx.de (Pavel Machek)
Date: Wed, 11 Jul 2012 18:20:59 +0200
Subject: [PATCH v3] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <1342023144-13945-1-git-send-email-dinguyen@altera.com>
References: <1342023144-13945-1-git-send-email-dinguyen@altera.com>
Message-ID: <20120711162058.GA28067@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Make a common device tree glue for clocksource/dw_apb_timer.
> Move mach-picoxcell/time.c to be a generic device tree application
> of the dw_apb_timer.
> 
> Configure mach-picoxcell to use the dw_apb_timer_of device tree
> implementation in drivers/clocksource.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>

Ok, this is getting complex.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
> @@ -0,0 +1,24 @@
> +* Designware APB timer
> +
> +Required properties:
> +- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: IRQ line for the timer.
> +- clock-frequency: The frequency in HZ of the timer.

I know device-tree maintainers requested -freq -> -frequency,
> --- a/arch/arm/mach-picoxcell/time.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c

But then this will need updating to accept "-frequency",

> -static const struct of_device_id picoxcell_timer_ids[] __initconst = {
> +static const struct of_device_id osctimer_ids[] __initconst = {
>  	{ .compatible = "picochip,pc3x2-timer" },
> +	{ .compatible = "snps,dw-apb-timer-osc" },
>  	{},
>  };

and dts will need to be updated, anyway, so we could update
"picochip,pc3x2-timer" -> "snps,dw-apb-timer-osc" as well, right?

Alternatively, we could just keep using "-freq"....

Or am I overlooking something?

Otherwise looks ok to me.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
