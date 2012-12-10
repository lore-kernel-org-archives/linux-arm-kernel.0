From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Dec 2012 09:28:47 +0100
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121210082847.GH26922@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
> +{
> +	/*
> +	 * Don't go out when trying to access --
> +	 * 1. nonexisting device on local bus
> +	 * 2. where there's no device connected (no link)
> +	 */
> +	if (bus == pp->root_bus_nr && dev == 0)
> +		return 1;
> +
> +	if (!orion_pcie_link_up(pp->base))
> +		return 0;
> +
> +	if (bus == pp->root_bus_nr && dev != 1)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/*
> + * PCIe config cycles are done by programming the PCIE_CONF_ADDR register
> + * and then reading the PCIE_CONF_DATA register. Need to make sure these
> + * transactions are atomic.
> + */
> +static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> +			int size, u32 *val)
> +{
> +	struct pci_sys_data *sys = bus->sysdata;
> +	struct pcie_port *pp = sys->private_data;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	spin_lock_irqsave(&pp->conf_lock, flags);
> +	ret = orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val);
> +	spin_unlock_irqrestore(&pp->conf_lock, flags);
> +
> +	return ret;
> +}
> +
> +static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> +			int where, int size, u32 val)
> +{
> +	struct pci_sys_data *sys = bus->sysdata;
> +	struct pcie_port *pp = sys->private_data;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	spin_lock_irqsave(&pp->conf_lock, flags);
> +	ret = orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val);
> +	spin_unlock_irqrestore(&pp->conf_lock, flags);
> +
> +	return ret;
> +}
> +
> +static struct pci_ops pcie_ops = {
> +	.read = pcie_rd_conf,
> +	.write = pcie_wr_conf,
> +};

Hi Thomas

pcie_rd_conf, pcie_wr_conf and pci_ops_pcie_ops are common on orion5x,
dove and kirkwood. Could you maybe factor these functions out and
place them in plat-orion/pcie.c?

> +
> +static void __devinit rc_pci_fixup(struct pci_dev *dev)
> +{
> +	/*
> +	 * Prevent enumeration of root complex.
> +	 */
> +	if (dev->bus->parent == NULL && dev->devfn == 0) {
> +		int i;
> +
> +		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +			dev->resource[i].start = 0;
> +			dev->resource[i].end   = 0;
> +			dev->resource[i].flags = 0;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);

rc_pci_fixup is also identical for all orion platforms, so is another
candidate for plat-orion/pcie.c

These are all exact copies, so are easy to cleanup. With more effort
there is more code which can be refactored and centralized, but that
is maybe too much work for the moment?

Thanks

   Andrew
