From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 8 Jul 2015 12:48:34 +0200 (CEST)
Subject: [PATCH v3 09/15] irqchip: gicv3-its: Split PCI/MSI code from
 the core ITS driver
In-Reply-To: <1436289485-28230-10-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
 <1436289485-28230-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1507081245120.5134@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jul 2015, Marc Zyngier wrote:
> +static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> +			       int nvec, msi_alloc_info_t *info)
> +{
> +	struct pci_dev *pdev;
> +	struct its_pci_alias dev_alias;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	dev_alias.pdev = pdev;
> +	dev_alias.count = nvec;
> +
> +	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
> +
> +	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);

I don't think you need its_msi_prepare() exposed to child
drivers. Something like

  domain->parent->ops->msi_prepare()

should do the trick.

Thanks,

	tglx
