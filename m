From: rogerq@ti.com (Roger Quadros)
Date: Thu, 11 Jun 2015 15:18:35 +0300
Subject: [PATCH 08/15] memory: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-9-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-9-git-send-email-robh@kernel.org>
Message-ID: <20150611151835.6d9b66a1@rockdesk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, 9 Jun 2015 13:26:34 -0500
Rob Herring <robh@kernel.org> wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> ---
>  drivers/memory/omap-gpmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index c94ea0d..0c833e2 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -1176,8 +1176,8 @@ static int gpmc_setup_irq(void)
>  		gpmc_client_irq[i].irq = gpmc_irq_start + i;
>  		irq_set_chip_and_handler(gpmc_client_irq[i].irq,
>  					&gpmc_irq_chip, handle_simple_irq);
> -		set_irq_flags(gpmc_client_irq[i].irq,
> -				IRQF_VALID | IRQF_NOAUTOEN);
> +		irq_modify_status(gpmc_client_irq[i].irq, IRQ_NOREQUEST,
> +				  IRQ_NOAUTOEN);

Shouldn't this be
		irq_modify_status(gpmc_client_irq[i].irq, IRQ_NOREQUEST,
				  IRQ_NOAUTOEN | IRQ_NOPROBE);
?

>  	}
>  
>  	/* Disable interrupts */
> @@ -1200,7 +1200,6 @@ static int gpmc_free_irq(void)
>  	for (i = 0; i < GPMC_NR_IRQ; i++) {
>  		irq_set_handler(gpmc_client_irq[i].irq, NULL);
>  		irq_set_chip(gpmc_client_irq[i].irq, &no_irq_chip);
> -		irq_modify_status(gpmc_client_irq[i].irq, 0, 0);
>  	}
>  
>  	irq_free_descs(gpmc_irq_start, GPMC_NR_IRQ);

cheers,
-roger
