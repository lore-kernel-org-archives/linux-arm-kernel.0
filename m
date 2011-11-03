From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Nov 2011 07:55:02 +0100
Subject: [PATCH 2/2] ARM: mcx: fix local timer interrupt handling
In-Reply-To: <1320255049-12447-3-git-send-email-marc.zyngier@arm.com>
References: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
	<1320255049-12447-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111103065502.GO23421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 05:30:49PM +0000, Marc Zyngier wrote:
> As local timer interrupts are now handled as normal interrupts,
> remove the special case in the GIC handler.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Ok, I'll pick this one up.

Sascha

> ---
>  arch/arm/plat-mxc/gic.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
> index b3b8eed..12f8f81 100644
> --- a/arch/arm/plat-mxc/gic.c
> +++ b/arch/arm/plat-mxc/gic.c
> @@ -28,21 +28,14 @@ asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  		if (irqnr == 1023)
>  			break;
>  
> -		if (irqnr > 29 && irqnr < 1021)
> +		if (irqnr > 15 && irqnr < 1021)
>  			handle_IRQ(irqnr, regs);
>  #ifdef CONFIG_SMP
> -		else if (irqnr < 16) {
> +		else {
>  			writel_relaxed(irqstat, gic_cpu_base_addr +
>  						GIC_CPU_EOI);
>  			handle_IPI(irqnr, regs);
>  		}
>  #endif
> -#ifdef CONFIG_LOCAL_TIMERS
> -		else if (irqnr == 29) {
> -			writel_relaxed(irqstat, gic_cpu_base_addr +
> -						GIC_CPU_EOI);
> -			handle_local_timer(regs);
> -		}
> -#endif
>  	} while (1);
>  }
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
