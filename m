From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Thu, 8 Oct 2015 22:05:09 +0200
Subject: [PATCH v8 4/6] pci: altera: Add Altera PCIe MSI driver
In-Reply-To: <E1ZkHFw-0007bx-3v@feisty.vs19.net>
References: <E1ZkHFw-0007bx-3v@feisty.vs19.net>
Message-ID: <5616CC75.5030700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
> number of vectors, which is a dts parameter.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> +
> +static inline void msi_writel(struct altera_msi *msi, u32 value, u32 reg)
> +{
> +	writel_relaxed(value, msi->csr_base + reg);
> +}
> +
> +static inline u32 msi_readl(struct altera_msi *msi, u32 reg)
> +{
> +	return readl_relaxed(msi->csr_base + reg);
> +}
> +

You could set value and reg parameter as const

> +
> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	struct altera_msi *msi = domain->host_data;
> +	unsigned long bit;
> +	u32 mask;
> +
> +	WARN_ON(nr_irqs != 1);
> +	mutex_lock(&msi->lock);
> +
> +	bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
> +	if (bit >= msi->num_of_vectors)
> +		return -ENOSPC;
> +
> +	set_bit(bit, msi->used);
> +
> +	mutex_unlock(&msi->lock);
> +
> +	irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
> +
> +	mask = msi_readl(msi, MSI_INTMASK);
> +	mask |= 1 << bit;
> +	msi_writel(msi, mask, MSI_INTMASK);
> +
> +	return 0;
> +}

You do not unlock the mutex when returning -ENOSPC
And again some parameter could be set as const
