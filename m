From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 20:31:05 +0100
Subject: [PATCH V3 1/2] clocksource: add common of_clksrc_init() function
In-Reply-To: <1353439206-1654-1-git-send-email-swarren@wwwdotorg.org>
References: <1353439206-1654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121120203105.3c54e49f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Tue, 20 Nov 2012 12:20:05 -0700, Stephen Warren wrote:

> It is desirable to move all clocksource drivers to drivers/clocksource,
> yet each requires its own initialization function. We'd rather not
> pollute <linux/> with a header for each function. Instead, create a
> single of_clksrc_init() function which will determine which clocksource
> driver to initialize based on device tree.

Sounds great!

I'm still planning to send irqchip soon, but I've been busy preparing
things for the merge window in the mvebu architecture, which has been
quite active during this cycle.

> +#include <linux/init.h>
> +#include <linux/of.h>
> +
> +extern struct of_device_id *__start_clksrc_of_match_tables[];
> +extern struct of_device_id *__stop_clksrc_of_match_tables[];
> +
> +void __init clocksource_of_init(void)
> +{
> +	struct of_device_id **table;
> +	struct of_device_id **stop;
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +	void (*init_func)(void);
> +
> +	table = __start_clksrc_of_match_tables;
> +	stop = __stop_clksrc_of_match_tables;
> +
> +	for ( ; table < stop; table++) {
> +		for_each_matching_node(np, *table) {
> +			match = of_match_node(*table, np);
> +			init_func = match->data;
> +			init_func();
> +		}
> +	}
> +}

The way I did things for irqchip is a bit different: I used the
standard of_irq_init(), which requires a table that is terminated by a
sentinel. In order to guarantee that I have a sentinel, I did:

#define IRQCHIP_DECLARE(compstr,fn)                             \
        static const struct of_device_id irqchip_of_match       \
        __used __section(.init.irqchip)                         \
        = { .compatible = compstr, .data = fn }

which is used to declare all irq drivers. But then in the main
irqchip.c file, I did:

static const struct of_device_id
irqchip_of_match_end __used __section(.init.irqchip.end);

and my linker script looks like:

        .init.irqchip : {
                __irqchip_begin = .;
                *(.init.irqchip)
                *(.init.irqchip.end)
        }

So I gather all the of_device_id definitions and then the special
sentinel of_device_id. I don't know if it is better than your solution,
or even if my solution is good at all.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
