From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 28 Oct 2016 13:00:22 +0200 (CEST)
Subject: [PATCH v2] irqchip/bcm2836: Prevent spurious interrupts
In-Reply-To: <20161027182038.11312-1-eric@anholt.net>
References: <20161027182038.11312-1-eric@anholt.net>
Message-ID: <alpine.DEB.2.20.1610281257230.4896@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Oct 2016, Eric Anholt wrote:

> From: Phil Elwell <phil@raspberrypi.org>
> 
> The old arch-specific IRQ macros included a dsb to ensure the
> write to clear the mailbox interrupt completed before returning
> from the interrupt. The BCM2836 irqchip driver needs the same
> precaution to avoid spurious interrupts.

This is missing a fixes tag. I have no idea when that problem was
introduced, so I have no way to decide whether this needs to be tagged
stable or not.

Thanks,

	tglx

> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/irqchip/irq-bcm2836.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index d96b2c947e74..93e3f7660c42 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -175,6 +175,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
>  		u32 ipi = ffs(mbox_val) - 1;
>  
>  		writel(1 << ipi, mailbox0);
> +		dsb(sy);
>  		handle_IPI(ipi, regs);
>  #endif
>  	} else if (stat) {
> -- 
> 2.9.3
> 
> 
