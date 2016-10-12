From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 05:38:43 -0700
Subject: [RFC PATCH 01/11] pci: endpoint: add EP core layer to enable EP
 controller and EP functions
In-Reply-To: <1473829927-20466-2-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-2-git-send-email-kishon@ti.com>
Message-ID: <20161012123843.GA942@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/**
> + * pci_epc_stop() - stop the PCI link
> + * @epc: the link of the EPC device that has to be stopped
> + *
> + * Invoke to stop the PCI link
> + */
> +void pci_epc_stop(struct pci_epc *epc)
> +{
> +	if (IS_ERR(epc) || !epc->ops->stop)
> +		return;
> +
> +	spin_lock_irq(&epc->irq_lock);
> +	epc->ops->stop(epc);
> +	spin_unlock_irq(&epc->irq_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_stop);

Can you elaborate on the synchronization strategy here?  It seems
like irq_lock is generally taken irq save and just around method
calls.  Wou;dn't it be better to leave locking to the methods
themselves?

> +/**
> + * struct pci_epc - represents the PCI EPC device
> + * @dev: PCI EPC device
> + * @ops: function pointers for performing endpoint operations
> + * @mutex: mutex to protect pci_epc ops
> + */
> +struct pci_epc {
> +	struct device			dev;
> +	/* support only single function PCI device for now */
> +	struct pci_epf			*epf;
> +	const struct pci_epc_ops	*ops;
> +	spinlock_t			irq_lock;
> +};

And this still documentes a mutex instead of the irq save spinlock,
while we're at it..

> +/**
> + * struct pci_epf_bar - represents the BAR of EPF device
> + * @phys_addr: physical address that should be mapped to the BAR
> + * @size: the size of the address space present in BAR
> + */
> +struct pci_epf_bar {
> +	dma_addr_t	phys_addr;
> +	size_t		size;
> +};

Just curious: shouldn't this be a phys_addr_t instead of a dma_addr_t?


Otherwise this looks like a nice little framework to get started!
