From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 24 Jan 2014 18:41:37 -0300
Subject: [PATCH 1/3] irqchip: orion: clear bridge cause register on init
In-Reply-To: <1390516686-2224-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390516686-2224-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140124211528.GA14012@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 11:38:04PM +0100, Sebastian Hesselbarth wrote:
> It is good practice to mask and clear pending irqs on init. We already
> mask all irqs, so also clear the bridge irq cause register.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/irqchip/irq-orion.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
> index e51d40031884..4137c3d15284 100644
> --- a/drivers/irqchip/irq-orion.c
> +++ b/drivers/irqchip/irq-orion.c
> @@ -180,8 +180,9 @@ static int __init orion_bridge_irq_init(struct device_node *np,
>  	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
>  	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
>  
> -	/* mask all interrupts */
> +	/* mask and clear all interrupts */
>  	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_MASK);
> +	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_CAUSE);
>  

This looks a bit bogus to me, now that we are clearing the cause upon
irq_startup(). Don't have a strong opinion, it's just that I fail to see
why we'd want or need this change...
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
