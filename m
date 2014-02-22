From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 14:46:32 -0500
Subject: [PATCH v4 02/22] irqchip: Orion: Fix getting generic chip pointer.
In-Reply-To: <1393096504-11844-3-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
 <1393096504-11844-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140222194632.GC7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 08:14:44PM +0100, Andrew Lunn wrote:
> Enabling SPARSE_IRQ shows up a bug in the irq-orion bridge interrupt
> handler. The bridge interrupt is implemented using a single generic
> chip. Thus the parameter passed to irq_get_domain_generic_chip()
> should always be zero.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (on kirkwood)
> ---
>  drivers/irqchip/irq-orion.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

tglx has already taken pull request containing this fix.

thx,

Jason.

> diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
> index e51d40031884..7d4e189ab4ec 100644
> --- a/drivers/irqchip/irq-orion.c
> +++ b/drivers/irqchip/irq-orion.c
> @@ -111,7 +111,8 @@ IRQCHIP_DECLARE(orion_intc, "marvell,orion-intc", orion_irq_init);
>  static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct irq_domain *d = irq_get_handler_data(irq);
> -	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, irq);
> +
> +	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
>  	u32 stat = readl_relaxed(gc->reg_base + ORION_BRIDGE_IRQ_CAUSE) &
>  		   gc->mask_cache;
>  
> -- 
> 1.8.5.3
> 
