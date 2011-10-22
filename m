From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Oct 2011 21:36:35 +0100
Subject: [PATCH] ARM: gic: fix irq_alloc_descs handling for sparse irq
In-Reply-To: <1319314808-27007-1-git-send-email-robherring2@gmail.com>
References: <1319314808-27007-1-git-send-email-robherring2@gmail.com>
Message-ID: <20111022203635.GA30950@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2011 at 03:20:08PM -0500, Rob Herring wrote:
> @@ -657,7 +664,7 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
>  
>  	domain->of_node = of_node_get(node);
>  
> -	gic_init(gic_cnt, 16, dist_base, cpu_base);
> +	gic_init(gic_cnt, -1, dist_base, cpu_base);
>  
>  	if (parent) {
>  		irq = irq_of_parse_and_map(node, 0);

You don't explain this change - '16' is used here to skip the SGI
interrupts which will never be passed to the generic IRQ subsystem
from the GIC.

Moreover, the second parameter is an unsigned integer, not a signed
integer.

And not only that, but:

        gic->irq_offset = (irq_start - 1) & ~31;

means that irq_offset ends up being -2 & ~31, or -32.  Do you really
want the PPIs to generate IRQ numbers from -16 to -1 ?  It doesn't stop
there:

        for (i = irq_start; i < irq_limit; i++) {
                irq_set_chip_and_handler(i, &gic_chip, handle_fasteoi_irq);
                irq_set_chip_data(i, gic);
                set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
        }

This will start from -1 to irq_limit (-1 + number of GIC IRQs).

Basically, -1 is not legal here - 1 is the minimum valid value that
this function takes for proper operation - but that's just wasteful, so
16 is the realistic minimum value.
