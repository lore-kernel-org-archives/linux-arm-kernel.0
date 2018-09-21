From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 21 Sep 2018 17:07:45 +0100
Subject: [PATCH v4 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
In-Reply-To: <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
 <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20180921160745.GB21644@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 05:50:20PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Mediatek's host controller has two slots, each with it's own control
> registers. The host driver need to identify which slot was connected
> in order to access the device's configuration space. There's problem
> for current host driver to find out which slot was connected to for
> a given EP device.
> 
> Assuming each slot have connect with one EP device as below:
> 
>                 host bridge
>   bus 0 --> __________|_______
>            |                  |
>            |                  |
>          slot 0             slot 1
>   bus 1 -->|        bus 2 --> |
>            |                  |
>          EP 0               EP 1
> 
> During PCI enumeration, system software will scan all the PCI device
> starting from devfn 0. So it will get the proper port for slot0 and
> slot1 device when using PCI_SLOT(devfn) for match. But it will get
> the wrong slot for EP1: The devfn will be start from 0 when scanning
> EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> for port0's slot value. So the host driver should not using EP's devfn
> but the slot's devfn(the slot which EP was connected to) for match.
> 
> This patch fix the mtk_pcie_find_port's logical by using the slot's
> devfn for match.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 861dda6..20b9088 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -337,11 +337,26 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
>  {
>  	struct mtk_pcie *pcie = bus->sysdata;
>  	struct mtk_pcie_port *port;
> +	struct pci_dev *dev;
> +	struct pci_bus *pbus;
>  
> -	list_for_each_entry(port, &pcie->ports, list)
> -		if (port->slot == PCI_SLOT(devfn))
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		if (!bus->number && port->slot == PCI_SLOT(devfn))
>  			return port;
>  
> +		if (bus->number) {
> +			pbus = bus;
> +
> +			while (pbus->number) {
> +				dev = pbus->self;
> +				pbus = dev->bus;
> +			}
> +
> +			if (port->slot == PCI_SLOT(dev->devfn))
> +				return port;
> +		}
> +	}

	/*
	 * Walk the bus hierarchy to get the devfn value
	 * of the port in the root bus.
	 */
	while (bus && bus->number) {
		devfn = bus->self->devfn;
		bus = bus->parent;
	}

	list_for_each_entry(port, &pcie->ports, list) {
		if (port->slot == PCI_SLOT(devfn))
			return port;

	return NULL;

Would it work ? Maybe it is a little easier to parse.

I think this can even be made easier by using struct device_node* as
comparison (and store it in port->slot instead of the port number), I
think that the pci_dev representing the port should have the right
of_node associated with it by core code, so it is just a matter of
finding the first pci_dev parent with an of_node set and compare it
against port->slot (that should be converted to a struct device_node*).

This ought to be tested and written but I think that's doable.

Lorenzo
