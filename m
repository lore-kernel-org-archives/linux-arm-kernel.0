From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Nov 2011 16:28:08 +0000
Subject: [PATCHv4 02/13] ARM: vic: device tree binding
In-Reply-To: <4EBBEBD3.8090001@arm.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-3-git-send-email-jamie@jamieiles.com>
 <20111110144648.GC16018@totoro> <4EBBEBD3.8090001@arm.com>
Message-ID: <20111110162808.GE16018@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 03:20:51PM +0000, Marc Zyngier wrote:
> On 10/11/11 14:46, Jamie Iles wrote:
> > On Fri, Nov 04, 2011 at 01:09:59AM +0000, Jamie Iles wrote:
> >> This adds a device tree binding for the VIC based on the of_irq_init()
> >> support.  This adds an irqdomain to the vic and always registers all
> >> vics in the static vic array rather than for pm only to keep track of
> >> the irq domain.  struct irq_data::hwirq is used where appropriate rather
> >> than runtime masking.
> >>
> >> v2:	- use irq_domain_simple_ops
> >> 	- remove stub implementation of vic_of_init for !CONFIG_OF
> >> 	- Make VIC select IRQ_DOMAIN
> >>
> >> Reviewed-by: Rob Herring <robherring2@gmail.com>
> >> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> >> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/vic.txt |   29 +++++++
> >>  arch/arm/common/Kconfig                       |    1 +
> >>  arch/arm/common/vic.c                         |  106 ++++++++++++++++++-------
> >>  arch/arm/include/asm/hardware/vic.h           |    7 ++-
> >>  4 files changed, 114 insertions(+), 29 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
> >>
> >> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> >> index 01f18a4..e689975 100644
> >> --- a/arch/arm/common/vic.c
> >> +++ b/arch/arm/common/vic.c
> >> @@ -22,6 +22,10 @@
> > [...]
> >> +#ifdef CONFIG_OF
> >> +int __init vic_of_init(struct device_node *node, struct device_node *parent)
> >> +{
> >> +	void __iomem *regs;
> >> +	int irq_base;
> >> +
> >> +	if (WARN(parent, "non-root VICs are not supported"))
> >> +		return -EINVAL;
> >> +
> >> +	regs = of_iomap(node, 0);
> >> +	if (WARN_ON(!regs))
> >> +		return -EIO;
> >> +
> >> +	irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
> >> +	if (WARN_ON(irq_base < 0))
> >> +		goto out_unmap;
> > 
> > Hmm, this appears to need linux/export.h for THIS_MODULE now.  
> > linux/irq.h has a comment saying it uses a macro to avoid needing an 
> > include of export.h there so I guess it needs to go in here instead.
> 
> Yes, I had to hack it when I tested this series on PB1176 (and of course
> forgot to send the patch around...).
> 
> It seems a bit backward to impose including linux/export.h while this
> file doesn't use any of it directly.

Yeah, but seeing as include/linux/irq.h had a comment saying that they'd 
explicitly decided to avoid including export.h there I decided it would 
be simplest to punt it into vic.c and that someone knew better than me!

I'll include it in vic.c when I ask you to pull (probably tomorrow).

Thanks,

Jamie
