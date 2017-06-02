From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 2 Jun 2017 12:49:56 +0100
Subject: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
Message-ID: <20170602114956.GA20004@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 03:13:04PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
> > API to scan a PCI root bus backed by an already initialized
> > struct pci_host_bridge object, which simplifies the bus scan
> > interface and makes the PCI scan root bus interface easier to
> > generalize as members are added to the struct pci_host_bridge().
> >
> > Convert PCI designware host code to pci_scan_root_bus_bridge() to
> > improve the PCI root bus scanning interface.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 36 +++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 5ba3349..e43c21a 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -294,16 +294,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                 dev_err(dev, "missing *config* reg space\n");
> >         }
> >
> > -       ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> > +       bridge = pci_alloc_host_bridge(0);
> > +       if (!bridge)
> > +               return  -ENOMEM;
> > +
> 
> I think here we warn to have the pci_alloc_host_bridge() called in the
> individual
> drivers, to have them allocate the dw_pcie structure as part of the host
> bridge allocation, before calling hisi_add_pcie_port().

I am almost done refactoring this series and this is the last review to
address. What you suggest above makes sense but:

1) it means patching ALL dw_pcie_host_init() callers and allocate the
   host bridge there, not sure it simplifies, certainly it complicates
   the error handling path (given that the host bridge memory is
   probably the only memory that is allocated with kzalloc instead of
   devm interface so it needs unwinding)
2) I noticed that allocating the host bridge in the caller complicates
   error handling, in particular code in the mainline (ie tegra and
   ftpci100) using pci_alloc_host_bridge() needs already patching since it
   may leak memory if PCI host bridge drivers probing fails.

I can implement (1) and (2) but I wanted to ask first to understand if
that's the direction we want to take.

Lorenzo
