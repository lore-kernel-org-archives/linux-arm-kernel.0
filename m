From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Sep 2011 16:33:47 +0200 (CEST)
Subject: [PATCH 11/24] C6X: interrupt handling
In-Reply-To: <1314826019-22330-12-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-12-git-send-email-msalter@redhat.com>
Message-ID: <alpine.LFD.2.02.1109091619350.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Aug 2011, Mark Salter wrote:

> + *
> + *  Large parts taken directly from powerpc.

Is it really necessary to copy that stuff instead of generalizing it ?
I guess that's mostly about the reverse map & Co.

> +
> +static spinlock_t core_irq_lock;

  raw_spinlock_t please

> +static void mask_core_irq(struct irq_data *data)
> +{
> +	unsigned int prio = data->irq;
> +	unsigned long flags;
> +
> +	BUG_ON(prio < 4 || prio >= NR_PRIORITY_IRQS);
> +
> +	spin_lock_irqsave(&core_irq_lock, flags);

The chip functions are called with interrupts disabled, so
raw_spin_lock() is sufficient

> +/*
> + * IRQ controller and virtual interrupts
> + */

How different is this from PPC ? Looks fairly familiar to me :)

> +struct megamod_pic {
> +	struct irq_host	*irqhost;
> +	struct megamod_regs __iomem *regs;
> +	spinlock_t lock;

  raw_spinlock_t please

> +
> +	/* hw mux mapping */
> +	unsigned int output_to_irq[NR_MUX_OUTPUTS];
> +};
> +
> +static struct megamod_pic *mm_pic;
> +
> +struct megamod_cascade_data {
> +	struct megamod_pic *pic;
> +	int index;
> +};
> +
> +static struct megamod_cascade_data cascade_data[NR_COMBINERS];
> +
> +static void mask_megamod(struct irq_data *data)
> +{
> +	struct megamod_pic *pic = irq_data_get_irq_chip_data(data);
> +	irq_hw_number_t src = irqd_to_hwirq(data);
> +	unsigned long flags;
> +	u32 __iomem *evtmask = &pic->regs->evtmask[src / 32];
> +
> +	spin_lock_irqsave(&pic->lock, flags);

  raw_spin_lock() is sufficient

> +	soc_writel(soc_readl(evtmask) | (1 << (src & 31)), evtmask);
> +	spin_unlock_irqrestore(&pic->lock, flags);
> +}
> +

> +static void megamod_irq_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct irq_data *idata = irq_desc_get_irq_data(desc);
> +	struct megamod_cascade_data *cascade;
> +	struct megamod_pic *pic;
> +	u32 events;
> +	int n, idx;
> +
> +	cascade = irq_desc_get_handler_data(desc);
> +
> +	pic = cascade->pic;
> +
> +	raw_spin_lock(&desc->lock);
> +
> +	chip->irq_mask(idata);

This runs with interrupts disabled, so why the lock, mask and the
inprogress fiddling? That interrupt cannot be reentered and it is not
controlled by disable_irq/enable_irq and better not subject to
free_irq, so why do you need this?

Thanks,

	tglx
