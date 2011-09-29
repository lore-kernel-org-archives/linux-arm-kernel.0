From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 11:55:07 -0500
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20110929093009.GM17204@pulham.picochip.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
Message-ID: <20110929165507.GB6800@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:30:09AM +0100, Jamie Iles wrote:
> On Thu, Sep 29, 2011 at 08:55:08AM +0200, Linus Walleij wrote:
> > On Wed, Sep 28, 2011 at 10:39 PM, Grant Likely
> > <grant.likely@secretlab.ca> wrote:
> > 
> > > Why isn't it simply written this way:
> > >
> > > ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> > > ? ? ? ?while (stat) {
> > > ? ? ? ? ? ? ? ?irq = fls(stat) - 1;
> > > ? ? ? ? ? ? ? ?handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> > > ? ? ? ? ? ? ? ?stat &= ~(1 << irq);
> > > ? ? ? ?}
> > 
> > That is indeed closer to the assembly loop most platforms have
> > implemented.
> > 
> > Jamie can you test this approach? And also use ffs() insteadof
> > fls()...
> 
> OK, here it is (and it works)!  That does make it a lot simpler, thanks 
> guys!  I've updated the vic-dt branch in my repo too.
> 
> Jamie
> 
> 8<------
> From: Jamie Iles <jamie@jamieiles.com>
> Subject: [PATCHv3] ARM: vic: MULTI_IRQ_HANDLER handler
> 
> Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
> platforms.  This can replace the ASM entry macros for platforms that use
> the VIC.
> 
> v3:	- simplify irq handling loop as suggested by Grant
> 	- service interrupts from msb->lsb order
> v2:	- allow the handler be used for !CONFIG_OF
> 	- use irq_domain_to_irq()
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/common/vic.c               |   22 ++++++++++++++++++++++
>  arch/arm/include/asm/hardware/vic.h |    4 ++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 3f9c8f2..b22b83d 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -427,3 +427,25 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
>  	return -EIO;
>  }
>  #endif /* CONFIG OF */
> +
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
> +{
> +	u32 stat, irq;
> +
> +	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> +	while (stat) {
> +		irq = ffs(stat) - 1;
> +		handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> +		stat &= ~(1 << irq);
> +	}
> +}
> +
> +asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> +{
> +	int i;
> +
> +	for (i = 0; i < vic_id; ++i)
> +		vic_single_handle_irq(&vic_devices[i], regs);
> +}
> +#endif /* CONFIG_MULTI_IRQ_HANDLER */
> diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
> index 0135215..c02fd6f 100644
> --- a/arch/arm/include/asm/hardware/vic.h
> +++ b/arch/arm/include/asm/hardware/vic.h
> @@ -45,11 +45,15 @@
>  #include <linux/types.h>
>  
>  struct device_node;
> +struct pt_regs;
> +
>  void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
>  
>  #ifdef CONFIG_OF
>  int vic_of_init(struct device_node *node, struct device_node *parent);
>  #endif /* CONFIG_OF */
>  
> +void vic_handle_irq(struct pt_regs *regs);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif
> -- 
> 1.7.4.1
> 
