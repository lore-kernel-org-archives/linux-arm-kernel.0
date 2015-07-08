From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 8 Jul 2015 12:44:20 +0200 (CEST)
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <559CA530.2090508@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1507061248090.3916@nanos> <559CA530.2090508@huawei.com>
Message-ID: <alpine.DEB.2.11.1507081154090.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jul 2015, majun (F) wrote:
> ? 2015/7/6 20:33, Thomas Gleixner ??:
> > Care to explain what this does? It seems for some nodes you cannot
> > write the msi message. So how is that supposed to work? How is that
> > interrupt controlled (mask/unmask ...) ?
> > 
> This function is used to write irq event id into vector register.Depends on
> hardware design, write operation is permitted in some mbigen node(nid=0,5,and >7),
> For other mbigen node, this register is read only.
> 
> But only vector register has this problem. Other registers are ok for read/write.

You still fail to explain how that works if the register is not
writeable. And the code wants a proper comment explaining it.
 
> >> +static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >> +			       unsigned int nr_irqs, void *arg)
> >> +{
> >> +	struct mbigen_chip *chip = domain->host_data;
> >> +	struct of_phandle_args *irq_data = arg;
> >> +	irq_hw_number_t hwirq;
> >> +	u32 nid, dev_id, mbi_lines;
> >> +	struct mbigen_node *mgn_node;
> >> +	struct mbigen_device *mgn_dev;
> >> +	msi_alloc_info_t out_arg;
> >> +	int ret = 0, i;
> >> +
> >> +	/* OF style allocation, one interrupt at a time */
> > 
> > -ENOPARSE
> > 
> what's this mean? I didn't find this definition in kernel code

That error code does not exist at all. It's just a jargon word and
means: "Error: Cannot parse".

In other words: That comment does not make any sense to me.

> According to Marc suggestion, I changed the ITS code so I can use its_msi_prepare
> function in my code.
> So,do you mean i should not call this function directly ?
> How about make this code likes below in mbigen driver:
> 
> static struct msi_domain_ops mbigen_domain_ops = {
> 
> 	.msi_prepare	= mbigen_domain_ops_prepare,
> };
> 
> static int mbigen_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
> 			       int nvec, msi_alloc_info_t *info)
> {
> 	return its_msi_prepare(domain, dev_id, count, info);
> }

How about using the parent domain pointer and invoking the function
via the parent->msi_domain_ops?

You seem to be focussed on hacking the ITS code into submission
instead of looking at the hierarchy information and use it proper.
 
> >> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	for (i = 0; i < nr_irqs; i++) {
> > 
> > This loop is required because?
> > 
> Although we know this value is 1, I think use loop seems better

Better for what? For obfuscating the code?

Either this function can handle nr_irqs > 1 or not. If it can handle
it, then the WARN_ON(nr_irqs != 1) is bogus. If it can not, then the
loop is pointless.

> >> +static int __init mbigen_of_init(struct device_node *node,
> >> +				 struct device_node *parent_node)
> >> +{
> >> +	struct mbigen_chip *chip;
> >> +	struct irq_domain *parent_domain;
> >> +	int err;
> >> +
> >> +	parent_node = of_parse_phandle(node, "msi-parent", 0);
> > 
> > Huch. parent node is an argument here. So WHY do you need to override
> > it with some magic parent entry in the mbigen node? Seems your
> > devicetree design sucks.
> Because parent_nod argument point to gic node, but the parent device node of
> mbigen is its node.
>
> I didn't find the way how to pass its node into this function as the parent_node,
> would you please give me some hint?

I gave you a hint already: 

> > .... Seems your devicetree design sucks.

In other words: If your device tree the MBI node parent is GIC, then
your device tree is not reflecting the actual hierarchy.

> > Crap in various aspects
> > 
> >      - these functions should only be visible from drivers/irqchip/
> > 
> >      - the header name is wrong as it does not provide any MBI
> >        specific functionality
> > 
> Maybe I can named this file as 'arm-gic-v3-its.h' and put it in
> include/linux/irqchip/

Care to read what I wrote?

> >      - these functions should only be visible from drivers/irqchip/

So what's the proper place for the header? Certainly not
include/linux/....

Aside of that, please look at the per-device MSI series Marc posted
(you were cc'ed). This is going to be where we are heading and your
driver should be based on that.

Thanks,

	tglx
