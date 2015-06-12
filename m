From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 12 Jun 2015 12:48:49 +0200 (CEST)
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <1434077399-32200-3-git-send-email-majun258@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1506121230320.3786@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Jun 2015, Ma Jun wrote:

> This patch is applied to support the mbigen interrupt.
> 
> As a kind of MSI interrupt controller, the mbigen is used as a child 
> domain of ITS domain just like PCI devices.
> So the arm-gic-v3-its and related files are changed.
> 
> The chip.c is also changed to check irq_ach before it called.

This patch wants to be split into several:

1) Changes to the core code

2) New functionality in the core code

2) Changes to gic-v3-its

And all patches require proper changelogs which explain WHY these
changes are necessary.

We can see which files are changed from the diffstat and the patch
ourself. So no point to mention this in the changelog.

But we cannot figure out from looking at the code WHY you think that
your approach to solve the problem is the right one.

>  void irq_chip_ack_parent(struct irq_data *data)
>  {
>  	data = data->parent_data;
> -	data->chip->irq_ack(data);
> +	if (data->chip->irq_ack)
> +		data->chip->irq_ack(data);

Why is this required? Just because? Again, you fail to provide a
rationale for the changes to the irq_chip*parent() functions.

Why would you call irq_chip_ack_parent() if that parent does not
provide the required functionality in the first place?

>  /*
> @@ -363,6 +364,9 @@ struct irq_chip {
>  	int		(*irq_request_resources)(struct irq_data *data);
>  	void		(*irq_release_resources)(struct irq_data *data);
>  
> +	void		(*irq_compose_mbigen_msg)(struct irq_data *data, struct mbigen_msg *msg);
> +	void		(*irq_write_mbigen_msg)(struct irq_data *data, struct mbigen_msg *msg);
> +

What's so special about mbigen to justify extra callbacks which just
bloat the data structure for everyone. Why are the msi callbacks not
sufficient?

MBI is just another variant of MSI, right?

struct mbigen_msg {
       u32     address_lo;
       u32     address_hi;
       u32     data;
};

struct mbigen_msg is just a mindless copy of struct msi_msg:

struct msi_msg {
        u32     address_lo;     /* low 32 bits of msi message address */
        u32     address_hi;     /* high 32 bits of msi message address */
        u32     data;           /* 16 bits of msi message data */
};

So what's the point of this?

>  	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
>  	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
>  

> +
> +/**
> + * irq_chip_compose_mbigen_msg - Componse mbigen message for a mbigen irq chip
> + * @data:	Pointer to interrupt specific data
> + * @msg:	Pointer to the mbigen message
> + *
> + * For hierarchical domains we find the first chip in the hierarchy
> + * which implements the irq_compose_mbigen_msg callback. For non
> + * hierarchical we use the top level chip.
> + */
> +
> +int irq_chip_compose_mbigen_msg(struct irq_data *data, struct mbigen_msg *msg)
> +{
> +	struct irq_data *pos = NULL;
> +
> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> +	for (; data; data = data->parent_data)
> +#endif
> +		if (data->chip && data->chip->irq_compose_mbigen_msg)
> +			pos = data;
> +	if (!pos)
> +		return -ENOSYS;
> +
> +	pos->chip->irq_compose_mbigen_msg(pos, msg);
> +
> +	return 0;
> +}

Again, this is a completely useless copy of irq_chip_compose_msi_msg().
Why can't you just use the existing callbacks and use struct msi_msg
for your special chip?

And w/o looking at the mbigen code in detail, I bet it's nothing else
than MSI for non PCI devices and contains tons of redundant and copied
code, right?

Can you please provide a proper description of this mbigen chip and
explain WHY you think that it needs all this special hackery?

Thanks,

	tglx
