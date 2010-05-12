From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 02:01:20 +0100
Subject: [PATCH] s3c24xx: Fix handling of level irqs for external
	interrupts.
In-Reply-To: <1273620530-20717-1-git-send-email-lars@metafoo.de>
References: <1273620530-20717-1-git-send-email-lars@metafoo.de>
Message-ID: <20100512010119.GK2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 01:28:50AM +0200, Lars-Peter Clausen wrote:
> Although the external interrupts support level and edge triggered irqs their
> handler is currently always set to handle_edge_irq().
> While being technically wrong for a level triggered irq to be handled by
> handle_edge_irq() it will cause serious problems in combination with a oneshot
> irq. handle_edge_irq() will unmask the irq immediately and as a result the irq
> will be triggered again before the threaded irq handler had a chance to run and
> clear the irq source.
> 
> Thus level triggered irqs should be handled by handle_level_irq.
> According to the specs the irq controller will remember if an irq has been
> triggered while it had been masked and will issue it when the irq gets
> unmasked. Thus it is sufficient to use handle_level_irq() for edge triggered
> irqs as well. Hence handle_level_irq() can always be used for external
> interrupts.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Ok, can someone else test this on some s3c24xx type machines?

 ---
>  arch/arm/plat-s3c24xx/irq.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
> index ad0d44e..0bd7fc2 100644
> --- a/arch/arm/plat-s3c24xx/irq.c
> +++ b/arch/arm/plat-s3c24xx/irq.c
> @@ -631,15 +631,13 @@ void __init s3c24xx_init_irq(void)
>  
>  	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
>  		irqdbf("registering irq %d (ext int)\n", irqno);
> -		set_irq_chip(irqno, &s3c_irq_eint0t4);
> -		set_irq_handler(irqno, handle_edge_irq);
> +		set_irq_chip_and_handler(irqno, &s3c_irq_eint0t4, handle_level_irq);
>  		set_irq_flags(irqno, IRQF_VALID);
>  	}

I'd have rather youd just change the set_irq_handler() call instead of
merging the two together and changing the handle_level_irq.
  
>  	for (irqno = IRQ_EINT4; irqno <= IRQ_EINT23; irqno++) {
>  		irqdbf("registering irq %d (extended s3c irq)\n", irqno);
> -		set_irq_chip(irqno, &s3c_irqext_chip);
> -		set_irq_handler(irqno, handle_edge_irq);
> +		set_irq_chip_and_handler(irqno, &s3c_irqext_chip, handle_level_irq);
>  		set_irq_flags(irqno, IRQF_VALID);
>  	}
>  
> -- 
> 1.5.6.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
