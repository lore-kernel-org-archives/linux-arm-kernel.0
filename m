From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Aug 2014 12:09:41 +0100
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <53F724F5.3040004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On 13/08/14 03:11, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> GIC supports the combination with external extensions. But this
> is not reflected in the checks of the interrupt type flag.
> This patch allows interrupt types other than the one supported by GIC,
> if an architecture extension is present and supports them.
> 
> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/irq-gic.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 57d165e..66485ab 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -194,23 +194,32 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>  	u32 confoff = (gicirq / 16) * 4;
>  	bool enabled = false;
>  	u32 val;
> +	int ret = 0;
>  
>  	/* Interrupt configuration for SGIs can't be changed */
>  	if (gicirq < 16)
>  		return -EINVAL;
>  
> -	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> -		return -EINVAL;
> -
>  	raw_spin_lock(&irq_controller_lock);
>  
> -	if (gic_arch_extn.irq_set_type)
> -		gic_arch_extn.irq_set_type(d, type);
> +	if (gic_arch_extn.irq_set_type) {
> +		ret = gic_arch_extn.irq_set_type(d, type);
> +		if (ret)
> +			goto out;
> +	} else if (type != IRQ_TYPE_LEVEL_HIGH &&
> +		type != IRQ_TYPE_EDGE_RISING) {
> +			ret = -EINVAL;
> +			goto out;
> +	}
>  
>  	val = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
> -	if (type == IRQ_TYPE_LEVEL_HIGH)
> +	/* Check for both edge and level here, so we can support GIC irq
> +	   polarity extension in gic_arch_extn.irq_set_type. If arch
> +	   doesn't support polarity extension, the check above will reject
> +	   improper type. */
> +	if (type & IRQ_TYPE_LEVEL_MASK)
>  		val &= ~confmask;
> -	else if (type == IRQ_TYPE_EDGE_RISING)
> +	else if (type & IRQ_TYPE_EDGE_BOTH)
>  		val |= confmask;
>  
>  	/*
> @@ -226,10 +235,10 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>  
>  	if (enabled)
>  		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);
> -
> +out:
>  	raw_spin_unlock(&irq_controller_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int gic_retrigger(struct irq_data *d)
> 

You're really abusing the gic_arch_extn feature. I know this is
tempting, but this is pushing it a bit too far.

This feature exist for one particular reason: if your GIC is in the same
power-domain as the CPUs, it will go down as well when you suspend the
system, hence being enable to wake the CPU up. You then need a shadow
interrupt controller to take over. This is exactly why we call the hook
on every GIC-related operation.

Here, you're using it to program something that sits between the device
and the GIC. This is a separate block, with its own hardware
configuration, that modifies the interrupt signal. This should be
reflected in the device-tree and the code paths.

You can probably model this as a separate irqchip for the few interrupts
that require this, or have it configured at boot time (assuming the
configuration never changes).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
