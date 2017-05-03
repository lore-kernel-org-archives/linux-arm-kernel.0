From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 3 May 2017 11:16:42 +0100
Subject: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
Message-ID: <20170503101642.GA10800@red-moon>
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

s/warn/want, correct ?

> individual drivers, to have them allocate the dw_pcie structure as
> part of the host bridge allocation, before calling
> hisi_add_pcie_port().

I see what you mean I will see how I can do it with this series or
another one, it won't certainly make this DW stuff any shinier, it
is really really hard to read.

Thanks,
Lorenzo
