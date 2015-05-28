From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 14:30:57 +0200
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <5566FD5C.4050708@hisilicon.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <2095085.CuXXeGT0Wg@wuerfel>
 <5566FD5C.4050708@hisilicon.com>
Message-ID: <4282256.8pP4M6Uy35@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 May 2015 19:34:52 Zhou Wang wrote:
> > @@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> >               if (!sys)
> >                       panic("PCI: unable to allocate sys data!");
> >  
> > -#ifdef CONFIG_PCI_MSI
> > -             sys->msi_ctrl = hw->msi_ctrl;
> > -#endif
> >               sys->busnr   = busnr;
> >               sys->swizzle = hw->swizzle;
> >               sys->map_irq = hw->map_irq;
> > @@ -493,6 +481,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> >                               panic("PCI: unable to scan bus!");
> >  
> >                       busnr = sys->bus->busn_res.end + 1;
> > +#ifdef CONFIG_PCI_MSI
> > +                     bus->msi = hw->msi_ctrl;
> > +#endif
> >  
> >                       list_add(&sys->node, head);
> >               } else {
> > 
> 
> Hi Arnd,
> 
> I think it does not work in above way(with adaptation as Fabrice mentioned).
> As the msi controller is passed to secondary bus one by one during the process of enumeration.
> Here we just set msi controller for root bus.

Ah, too bad. I guess you are right, the bus->msi pointer here would
really need to be set between pci_create_root_bus() and pci_scan_child_bus(),
but we currently don't run any ARM specific code between the two.

	Arnd
