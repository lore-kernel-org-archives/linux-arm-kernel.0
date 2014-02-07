From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 07 Feb 2014 23:32:57 +0100
Subject: [PATCH 02/21] IRQ: Orion: Fix getting generic chip pointer.
In-Reply-To: <1391730137-14814-3-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-3-git-send-email-andrew@lunn.ch>
Message-ID: <52F55F19.3060800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 12:41 AM, Andrew Lunn wrote:
> Enabling SPARSE_IRQ shows up a bug in the irq-orion bridge interrupt
> handler. The bridge interrupt is implemented using a single generic
> chip. Thus the parameter passed to irq_get_domain_generic_chip()
> should always be zero.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Indeed, I remember we talked about it: irq_get_domain_generic_chip takes
hwirqs, so passing 0 is sane here.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/irqchip/irq-orion.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
> index e51d40031884..7d4e189ab4ec 100644
> --- a/drivers/irqchip/irq-orion.c
> +++ b/drivers/irqchip/irq-orion.c
> @@ -111,7 +111,8 @@ IRQCHIP_DECLARE(orion_intc, "marvell,orion-intc", orion_irq_init);
>   static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
>   {
>   	struct irq_domain *d = irq_get_handler_data(irq);
> -	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, irq);
> +
> +	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
>   	u32 stat = readl_relaxed(gc->reg_base + ORION_BRIDGE_IRQ_CAUSE) &
>   		   gc->mask_cache;
>
>
