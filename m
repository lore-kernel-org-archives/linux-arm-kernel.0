From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 8 Feb 2016 11:31:47 +0100 (CET)
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1602081125560.25254@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine,

On Mon, 8 Feb 2016, Antoine Tenart wrote:
> +static int alpine_msix_set_affinity(struct irq_data *irq_data,
> +				    const struct cpumask *mask, bool force)
> +{
> +	int ret;
> +
> +	ret = irq_chip_set_affinity_parent(irq_data, mask, force);
> +	return ret == IRQ_SET_MASK_OK ? IRQ_SET_MASK_OK_DONE : ret;

What's the point of this exercise? Why can't you just set the affinity
callback to irq_chip_set_affinity_parent() ?

> +static struct irq_chip alpine_msix_irq_chip = {
> +	.name			= "MSIx",
> +	.irq_mask		= alpine_msix_mask_msi_irq,
> +	.irq_unmask		= alpine_msix_unmask_msi_irq,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_affinity	= alpine_msix_set_affinity,
> +};
> +
> +static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
> +{
> +	int first, i;
> +
> +	spin_lock(&priv->msi_map_lock);
> +
> +	first = bitmap_find_next_zero_area(priv->msi_map, priv->num_spis, 0,
> +					   num_req, 0);
> +	if (first >= priv->num_spis) {
> +		spin_unlock(&priv->msi_map_lock);
> +		return -ENOSPC;
> +	}
> +
> +	for (i = 0; i < num_req; i++)
> +		set_bit(first + i, priv->msi_map);

  bitmap_set() ??

> +
> +	spin_unlock(&priv->msi_map_lock);
> +
> +	return priv->spi_first + first;
> +}
> +
> +static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
> +				 int num_req)
> +{
> +	int i, first;
> +
> +	first = sgi - priv->spi_first;
> +
> +	spin_lock(&priv->msi_map_lock);
> +
> +	for (i = 0; i < num_req; i++)
> +		clear_bit(first + i, priv->msi_map);

  bitmap_clear() ??

> +	spin_unlock(&priv->msi_map_lock);
> +}

Thanks,

	tglx
