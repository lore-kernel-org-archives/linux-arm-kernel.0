From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 2 Oct 2018 11:59:45 +0100
Subject: [PATCH v5 1/9] PCI: mediatek: Using slot's devfn for compare to
 fix mtk_pcie_find_port logic
In-Reply-To: <20181001143641.GB13049@red-moon>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
 <1538129080-8206-2-git-send-email-honghui.zhang@mediatek.com>
 <20181001143641.GB13049@red-moon>
Message-ID: <20181002105945.GA27736@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 03:36:41PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 28, 2018 at 06:04:32PM +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The Mediatek's host controller has two slots, each with it's own control
> > registers. The host driver need to identify which slot was connected
> > in order to access the device's configuration space. There's problem
> > for current host driver to find out which slot was connected to for
> > a given EP device.
> > 
> > Assuming each slot have connect with one EP device as below:
> > 
> >                 host bridge
> >   bus 0 --> __________|_______
> >            |                  |
> >            |                  |
> >          slot 0             slot 1
> >   bus 1 -->|        bus 2 --> |
> >            |                  |
> >          EP 0               EP 1
> > 
> > During PCI enumeration, system software will scan all the PCI device
> > starting from devfn 0. So it will get the proper port for slot0 and
> > slot1 device when using PCI_SLOT(devfn) for match. But it will get
> > the wrong slot for EP1: The devfn will be start from 0 when scanning
> > EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> > for port0's slot value. So the host driver should not using EP's devfn
> > but the slot's devfn(the slot which EP was connected to) for match.
> > 
> > This patch fix the mtk_pcie_find_port's logic by using the slot's
> > devfn for match if finding device connected to the subordinate bus.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 9999dae..264e03f 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -337,10 +337,25 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
> >  {
> >  	struct mtk_pcie *pcie = bus->sysdata;
> >  	struct mtk_pcie_port *port;
> > +	struct pci_dev *dev = NULL;
> > +
> > +	/*
> > +	 * Walk the bus hierarchy to get the devfn value
> > +	 * of the port in the root bus.
> > +	 */
> > +	while (bus && bus->number) {
> > +		dev = bus->self;
> > +		bus = dev->bus;
> 
> If you add:
> 
> devfn = dev->devfn;
> 
> here
> 
> > +	}
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		/* Using slot's devfn to compare for subordinary bus. */
> > +		if (dev)
> > +			devfn = dev->devfn;
> 
> You can remove this ugly hunk altogether (and dev initialization
> to NULL).

Hi Honghui,

if you can make this change I would merge this series, it has been
been in the mailing lists for a while, I can make that change too
just let me know please.

Thanks,
Lorenzo
