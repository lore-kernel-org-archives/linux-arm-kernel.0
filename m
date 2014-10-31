From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 31 Oct 2014 10:40:27 +0100 (CET)
Subject: [V9 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m
 MSI(-X)
In-Reply-To: <1414743990-28421-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1414743990-28421-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1414743990-28421-3-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <alpine.DEB.2.11.1410311014050.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Oct 2014, suravee.suthikulpanit at amd.com wrote:
> +/*
> + * alloc_msi_irq - Allocate MSIs from available MSI bitmap.
> + * @data: Pointer to v2m_data
> + * @nvec: Number of interrupts to allocate
> + * @irq: Pointer to the allocated irq
> + *
> + * Allocates interrupts only if the contiguous range of MSIs
> + * with specified nvec are available. Otherwise return the number
> + * of available interrupts. If none are available, then returns -ENOENT.

And the exact purpose of returning the number of available interrupts
is?

> + */
> +static int alloc_msi_irq(struct v2m_data *data, int nvec, int *irq)
> +{
> +	int size = data->nr_spis;
> +	int next = size, i = nvec, ret;
> +
> +	/* We should never allocate more than available nr_spis */
> +	if (i >= size)
> +		i = size;
> +
> +	spin_lock(&data->msi_cnt_lock);
> +
> +	for (; i > 0; i--) {
> +		next = bitmap_find_next_zero_area(data->bm,
> +					size, 0, i, 0);
> +		if (next < size)
> +			break;
> +	}

That we need a pointless loop here.

> +static int gicv2m_setup_msi_irq(struct msi_chip *chip, struct pci_dev *pdev,
> +				struct msi_desc *desc)
> +{
> +	int hwirq = 0, virq, avail;
> +	struct v2m_data *v2m = container_of(chip, struct v2m_data, msi_chip);
> +
> +	if (!desc) {
> +		dev_err(&pdev->dev,
> +			"MSI setup failed. Invalid msi descriptor\n");
> +		return -EINVAL;
> +	}
> +
> +	avail = alloc_msi_irq(v2m, 1, &hwirq);
> +	if (avail != 0) {

So that the caller can turn any non zero return value into -ENOSPC.

> +		dev_err(&pdev->dev,
> +			"MSI setup failed. Cannnot allocate IRQ\n");
> +		return -ENOSPC;
> +	}

Brilliant design.

> +	virq = __irq_domain_alloc_irqs(v2m->domain, hwirq,
> +				       1, NUMA_NO_NODE, v2m, true);

And surely the ability of alloc_msi_irq() to allocate a contiguous
vector space is required to satisfy an hardcoded allocation of ONE
interrupt.

What is guaranteeing that the caller only requests a single interrupt?

> +err_out:

Single error exit which undoes the stuff in the same order it got
initialized is just plain wrong. Ever looked at proper error exits in
other kernel files?

> +	of_pci_msi_chip_remove(&v2m->msi_chip);
> +	if (v2m->base)
> +		iounmap(v2m->base);
> +	if (v2m->bm)
> +		kzfree(v2m->bm);

Of course you need to zero out the kzalloced bitmap before freeing it
in order not to leak the secrets of a zeroed buffer to the sneaky
black hats, right?

Oh well...

      tglx
