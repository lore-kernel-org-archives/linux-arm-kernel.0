From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Jun 2013 14:30:00 +0200
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <516C46BC.2040707@wwwdotorg.org>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <516C46BC.2040707@wwwdotorg.org>
Message-ID: <20130612122959.GA32444@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 12:28:12PM -0600, Stephen Warren wrote:
> On 04/03/2013 08:45 AM, Thierry Reding wrote:
> > Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> > directory. The motivation is to collect various host controller drivers
> > in the same location in order to facilitate refactoring.
> > 
> > The Tegra PCIe driver has been largely rewritten, both in order to turn
> > it into a proper platform driver and to add MSI (based on code by
> > Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> 
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> 
> > +struct tegra_msi {
> > +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> > +	struct irq_domain *domain;
> > +	struct msi_chip chip;
> 
> Nit: You could move that to be the first field in the struct, then
> to_tegra_msi() would end up being a no-op, which might save a byte or two.

Done.

> > +static int tegra_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
> > +				 int where, int size, u32 value)
> ...
> > +	if (bus->number == 0) {
> > +		unsigned int slot = PCI_SLOT(devfn);
> > +		struct tegra_pcie_port *port;
> > +
> > +		list_for_each_entry(port, &pcie->ports, list) {
> > +			if (port->index + 1 == slot) {
> > +				addr = port->base + (where & ~3);
> > +				break;
> > +			}
> > +		}
> > +	} else {
> > +		addr = tegra_pcie_bus_map(pcie, bus->number);
> > +		if (!addr) {
> > +			dev_err(pcie->dev,
> > +				"failed to map cfg. space for bus %u\n",
> > +				bus->number);
> > +			return PCIBIOS_DEVICE_NOT_FOUND;
> > +		}
> > +
> > +		addr += tegra_pcie_conf_offset(devfn, where);
> > +	}
> 
> It seems like that chunk of code could be shared between
> tegra_pcie_read_conf() and tegra_pcie_write_conf().
> 
> Also, tegra_pcie_read_conf() checks again for addr == NULL and returns
> if so. read and write should be consistent.

Done.

> > +static void tegra_pcie_port_free(struct tegra_pcie_port *port)
> > +{
> > +	struct tegra_pcie *pcie = port->pcie;
> > +
> > +	devm_iounmap(pcie->dev, port->base);
> > +	devm_release_mem_region(pcie->dev, port->regs.start,
> > +				resource_size(&port->regs));
> > +	list_del(&port->list);
> > +	devm_kfree(pcie->dev, port);
> > +}
> 
> Do ports get allocated and freed separately from the host controller,
> such that it's actually worth manually calling the
> devm_iounmap/release/free functions?

Yes, they can be freed separately. When a link is down and hence no
device is connected to the port, tegra_pcie_enable() will disable and
free that port.

That's in fact the only place where this is called because we don't
actually support removing the controller. I don't know of any ARM
architecture support to do that (i.e. there is no counterpart to
pci_common_init()).

> > +static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
> ...
> > +	/* disable all exceptions */
> > +	afi_writel(pcie, 0, AFI_FPCI_ERROR_MASKS);
> 
> Is that a good idea?

I have no idea what that register means. It's one of the undocumented
registers. Note that I also didn't change this, it's been there since
the beginning.

It's probably worth finding out about the register's meaning and about
how to catch these exceptions at runtime, though. I'm adding Jay on Cc
maybe he can research internally.

> > +static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
> 
> > +	err = devm_request_irq(&pdev->dev, pcie->irq, tegra_pcie_isr,
> > +			       IRQF_SHARED, "PCIE", pcie);
> 
> devm_request_irq and IRQF_SHARED sounds like a bad combination; what if
> the IRQ goes off after this driver's remove() is called, but before the
> driver core devm cleanup runs?

You're right. Changed to request_irq() in tegra_pcie_get_resources() and
added free_irq() to tegra_pcie_put_resources().

> > +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
> ...
> > +	return IRQ_HANDLED;
> 
> Shouldn't this function return IRQ_NONE if no MSI status bits were found
> set?

The IRQ isn't marked IRQF_SHARED, so I don't think this is needed.

> > +static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
> 
> > +	/* setup AFI/FPCI range */
> > +	msi->pages = __get_free_pages(GFP_KERNEL, 3);
> 
> If tegra_msi_setup_irq() hard-codes the MSI address as msi->pages, then
> I expect you can get away with a single page here. Of course, perhaps
> tegra_msi_setup_irq() is supposed to give a different address to every
> MSI client? Even so, 256 clients * 4 bytes is still less than 1 page.

Yes, I'll try setting the order to 0 and see if that still works. I
don't have a setup with more than one MSI client so test results may not
be very reliable, though.

> > +static u32 tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes)
> > +{
> > +	struct device_node *np = pcie->dev->of_node;
> > +
> > +	switch (lanes) {
> > +	case 0x00000004:
> > +		dev_info(pcie->dev, "single-mode configuration\n");
> > +		return AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE;
> > +
> > +	case 0x00000202:
> > +		dev_info(pcie->dev, "dual-mode configuration\n");
> > +		return AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
> > +	}
> > +
> > +	return 0;
> 
> Shouldn't that return an error, and dev_err() about it? If not, then I
> think using one of the #defines for the default would make the result a
> lot more obvious.

I've changed tegra_pcie_get_xbar_config() to return -EINVAL if an
invalid combination of lanes is encountered and 0 otherwise, passing
back the corresponding define in an output parameter. I think it's
reasonable to fail if an invalid combination is provided instead of
assuming that some default will work.

> > +static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> 
> > +	pcie->xbar_config = tegra_pcie_get_xbar_config(pcie, lanes);
> > +	if (!pcie->xbar_config) {
> > +		dev_err(pcie->dev, "invalid lane configuration\n");
> > +		return -EINVAL;
> > +	}
> 
> Oh, but AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE==0, which is valid...

Fixed by the above change.

> > +static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
> ...
> > +			if (value & 0x20000000)
> > +				return true;
> 
> Can we use a #define for 0x20000000?

Yes, we could use something like RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE
from the TRM, though it's rather long...

> > +static int tegra_pcie_enable(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port, *tmp;
> > +	struct hw_pci hw;
> > +
> > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > +		dev_info(pcie->dev, "probing port %u, using %u lanes\n",
> > +			 port->index, port->lanes);
> > +
> > +		tegra_pcie_port_enable(port);
> > +
> > +		if (tegra_pcie_port_check_link(port))
> > +			continue;
> > +
> > +		dev_info(pcie->dev, "link %u down, ignoring\n", port->index);
> > +
> > +		tegra_pcie_port_disable(port);
> > +		tegra_pcie_port_free(port);
> > +	}
> 
> Why is that needed; when would a port get enabled if it was already
> enabled, and if it was already enabled, wouldn't you want this function
> to be a no-op rather than destroying everything and starting again?

I'm not sure I understand what you're saying. The intent of this
function is to enable a port, check that there's a link and disable the
port otherwise. That way we don't keep ports around where nothing is
connected.

> > +static int tegra_pcie_probe(struct platform_device *pdev)
> ...
> > +	pcibios_min_mem = 0;
> 
> What does that mean/do? I wonder if that should be set to 0x80000000 by
> the Tegra30 patches?

ARM defines PCIBIOS_MIN_MEM to that variable. That macro in turn is only
used by pci_bus_alloc_resource() AFAICT, which uses it to override the
start of a resource when allocating if res->start == 0. As such it
designates a lower-bound of valid PCI memory addresses, so 0 on Tegra20
and 0x80000000 on Tegra30 don't seem like good values. Maybe we need to
set them to the lowest of the prefetchable and non-prefetchable memory
areas as defined in the DT?

It doesn't currently seem to matter at all, though, since we never pass
in a range that's 0, so the start address of resources can never be 0
and therefore PCIBIOS_MIN_MEM is never used.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/a71aec96/attachment.sig>
