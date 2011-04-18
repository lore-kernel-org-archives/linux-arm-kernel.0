From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 18 Apr 2011 12:34:00 -0500
Subject: vic: Use generic interrupt chip
In-Reply-To: <20110416211307.310117421@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.310117421@linutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D221CCCE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 16, 2011 2:14 PM, Thomas Gleixner wrote:
>
> The VIC chips can be handled by the generic implementation. The
> implementation uses always uses handle_level_irq. We can replace the
> ack and mask functions by a combined mask_ack function which also gets
> rid of the double write to VIC_INT_ENABLE_CLEAR.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/common/vic.c |  152 ++++++++++++--------------------------------------
>  1 file changed, 39 insertions(+), 113 deletions(-)
> 
> Index: linux-2.6/arch/arm/common/vic.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/common/vic.c
> +++ linux-2.6/arch/arm/common/vic.c

[snip]

> @@ -178,15 +172,13 @@ late_initcall(vic_pm_init);
>  
>  /**
>   * vic_pm_register - Register a VIC for later power management control
> - * @base: The base address of the VIC.
> - * @irq: The base IRQ for the VIC.
> - * @resume_sources: bitmask of interrupts allowed for resume sources.
> + * @gc: The generic interrupt chip for the VIC
>   *
>   * Register the VIC with the system device tree so that it can be notified
>   * of suspend and resume requests and ensure that the correct actions are
>   * taken to re-instate the settings on resume.
>   */
> -static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
> +static void __init vic_pm_register(struct irq_chip_generic *gc)
>  {
>  	struct vic_device *v;
>  
> @@ -194,85 +186,13 @@ static void __init vic_pm_register(void 
>  		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
>  	else {
>  		v = &vic_devices[vic_id];
> -		v->base = base;
> -		v->resume_sources = resume_sources;
> -		v->irq = irq;
> -		vic_id++;
> +		v->gc = gc;
>  	}
>  }

I think the vic_id++ is still needed here in order to handle multiple VIC devices.

Regards,
Hartley
