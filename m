From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:45:03 +0100 (CET)
Subject: [RFC PATCH 21/33] irqchip/gic-v3-its: Add VPE irq domain
 allocation/teardown
In-Reply-To: <1484648454-21216-22-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-22-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131142430.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				    unsigned int nr_irqs, void *args)
> +{
> +	msi_alloc_info_t *info = args;
> +	struct its_vpe **vpes = info->scratchpad[0].ptr;
> +	struct its_vm *vm = vpes[0]->its_vm;
> +	unsigned long *bitmap;
> +	struct page *vprop_page;
> +	int base, nr_ids, i, err = 0;
> +
> +	bitmap = its_lpi_alloc_chunks(nr_irqs, &base, &nr_ids);
> +	if (!bitmap)
> +		return -ENOMEM;
> +
> +	if (nr_ids < nr_irqs) {
> +		its_lpi_free_chunks(bitmap, base, nr_ids);
> +		return -ENOMEM;
> +	}
> +
> +	vprop_page = its_allocate_prop_table(GFP_KERNEL);
> +	if (!vprop_page) {
> +		its_lpi_free_chunks(bitmap, base, nr_ids);
> +		return ENOMEM;
> +	}
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		vpes[i]->vpe_db_lpi = base + i;
> +		err = its_vpe_init(vpes[i]);
> +		if (err)
> +			break;
> +		irq_domain_set_hwirq_and_chip(domain,
> +					      virq + i, vpes[i]->vpe_db_lpi,
> +					      &its_vpe_irq_chip, vpes[i]);
> +		set_bit(i, bitmap);
> +	}
> +
> +	if (err) {
> +		while (--i >= 0) {
> +			its_vpe_teardown(vpes[i]);
> +			clear_bit(i, bitmap);
> +		}
> +
> +		its_lpi_free_chunks(bitmap, base, nr_ids);
> +		its_free_prop_table(vprop_page);

Couldn't you just do:

	if (err) {
		if (i > 0)
			its_vpe_irq_domain_free(domain, virq, i - 1)

Hmm?

Thanks,

	tglx
