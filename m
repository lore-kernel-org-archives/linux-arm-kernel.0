From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 28 Sep 2011 15:39:05 -0500
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <1317206507-18867-3-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
Message-ID: <20110928203905.GB2838@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 11:41:39AM +0100, Jamie Iles wrote:
> Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
> platforms.  This can replace the ASM entry macros for platforms that use
> the VIC.
> 
> v2:	- allow the handler be used for !CONFIG_OF
> 	- use irq_domain_to_irq()
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/common/vic.c               |   29 +++++++++++++++++++++++++++++
>  arch/arm/include/asm/hardware/vic.h |    4 ++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 3f9c8f2..71adced 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -427,3 +427,32 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
>  	return -EIO;
>  }
>  #endif /* CONFIG OF */
> +
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
> +{
> +	u32 stat, irq;
> +	bool handled = false;
> +
> +	while (!handled) {
> +		stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> +		if (!stat)
> +			break;
> +
> +		while (stat) {
> +			irq = fls(stat) - 1;
> +			handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> +			stat &= ~(1 << irq);
> +			handled = true;
> +		}
> +	}

I don't follow why this is written this way.  The way I see it, there
are two conditions:
1) first read will show no irqs pending (!stat), which will break out
   of the outer while() loop.

2) or there will be irqs pending, it will enter the second while()
   loop, which unconditionally sets the handled flag, and causes the
   outer loop to exit immediately after the inner loop exits.

Why isn't it simply written this way:

	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	while (stat) {
		irq = fls(stat) - 1;
		handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
		stat &= ~(1 << irq);
	}

g.
