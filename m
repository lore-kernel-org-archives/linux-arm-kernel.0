From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Aug 2016 09:43:13 +0100
Subject: [PATCH] irqchip/gicv3-its: Disable the ITS before initializing it.
In-Reply-To: <1471560118-909-1-git-send-email-ddaney.cavm@gmail.com>
References: <1471560118-909-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <57B6C6A1.1080109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/08/16 23:41, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> When starting a kexec/kdump kernel, the GIC ITS will already have been
> enabled.  According to the ARM Generic Interrupt Controller
> Architecture Specification (GIC architecture Version 3.0 and version
> 4.0), writing to GITS_BASER<n> or GITS_CBASER is "UNPREDICTABLE" when
> the ITS is enabled.  On Cavium Thunder systems, this prevents the ITS
> from being initializing in the kexec/kdump kernel, resulting in
> failure to register/enable interrupts for all devices.
> 
> The fix is to disable the ITS if it is not already in the disabled
> state.  This allows the ITS to be properly initialized and then
> re-enabled in the kexec/kdump kernel.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7ceaba8..36b9c28 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1545,7 +1545,12 @@ static int its_force_quiescent(void __iomem *base)
>  	u32 val;
>  
>  	val = readl_relaxed(base + GITS_CTLR);
> -	if (val & GITS_CTLR_QUIESCENT)
> +	/*
> +	 * GIC architecture specification requires the ITS to be both
> +	 * disabled and quiescent for writes to GITS_BASER<n> or
> +	 * GITS_CBASER to not have UNPREDICTABLE results.
> +	 */
> +	if ((val & GITS_CTLR_QUIESCENT) && !(val & GITS_CTLR_ENABLE))
>  		return 0;
>  
>  	/* Disable the generation of all interrupts to this ITS */
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll queue it for the next batch of fixes that I plan to send to tglx on
Monday.

Still, there is the question of how safe it is to do a kexec on a system
that has an ITS that can modify memory behind our back, since we have no
way to tell an irqchip to disable itself altogether (not a device and
all that mess).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
