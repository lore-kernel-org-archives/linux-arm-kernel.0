From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 08:12:21 -0500
Subject: [PATCH v5 05/19] PCI/MSI: of: Add support for OF-provided
 msi_domain
In-Reply-To: <1437643598-19795-6-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150723131221.GS21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 10:26:24AM +0100, Marc Zyngier wrote:
> In order to populate the PCI host bridge msi_domain, use the
> "msi-parent" attribute to lookup a corresponding irq domain.
> If found, this is our MSI domain.
> 
> This gets plugged into the core PCI code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
> +{
> +#ifdef CONFIG_IRQ_DOMAIN
> +	struct device_node *np;
> +	struct irq_domain *d;
> +
> +	if (!bus->dev.of_node)
> +		return NULL;
> +	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
> +	if (!np)
> +		return NULL;
> +	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	if (!d)
> +		d = irq_find_host(np);
> +	return d;

    d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
    if (d)
	    return d;

    return irq_find_host(np);

> +#else
> +	return NULL;
> +#endif

>  static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  {
> +	struct irq_domain *d;
> +
>  	/*
>  	 * Any firmware interface that can resolve the msi_domain
>  	 * should be called from here.
>  	 */
> +	d = pci_host_bridge_of_msi_domain(bus);
>  
> -	return NULL;
> +	return d;

No temporary needed (until there's another firmware interface):

    return pci_host_bridge_of_msi_domain(bus);
