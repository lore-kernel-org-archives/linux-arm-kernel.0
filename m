From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 11 Nov 2014 11:52:27 +0000
Subject: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
In-Reply-To: <20141111112424.GB16265@arm.com>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20141111112424.GB16265@arm.com>
Message-ID: <20141111115227.GF12037@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 11:24:24AM +0000, Will Deacon wrote:
> Hi Suravee,
> 
> On Mon, Nov 10, 2014 at 07:24:40PM +0000, suravee.suthikulpanit at amd.com wrote:
> > From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > 
> > This patch implement set_msi_parent callback for PCI generic host controller.
> > 
> > Cc: Bjorn Helgass <bhelgaas@google.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > ---
> >  drivers/pci/host/pci-host-generic.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> > index 036ab1b..f9bb97a 100644
> > --- a/drivers/pci/host/pci-host-generic.c
> > +++ b/drivers/pci/host/pci-host-generic.c
> > @@ -42,6 +42,7 @@ struct gen_pci {
> >  	struct pci_host_bridge			host;
> >  	struct gen_pci_cfg_windows		cfg;
> >  	struct list_head			resources;
> > +	struct msi_chip				*mchip;
> >  };
> >  
> >  #ifdef CONFIG_ARM
> > @@ -128,9 +129,19 @@ static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >  
> > +static int gen_pci_set_msi_parent(struct pci_bus *bus)
> > +{
> > +	struct gen_pci *pci = bus_to_gen_pci(bus);
> > +
> > +	bus->msi = pci->mchip;
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> 
> I don't think this makes much sense a host controller callback. Why can't
> bus->msi be set in generic code?

Because of the current way in which a bus gets created and them immediately used for
scanning devices if you use pci_scan_root_bus(). Alternative is to use pci_create_root_bus()
and increase your code size with the body of pci_scan_root_bus().

Solution is to have pci_host_bridge holding the msi_chip pointer and that gets created
before root bus, with pci_scan_root_bus() now having all the info needed to do successful
setup of scanned devices.

Best regards,
Liviu

> 
> >  static struct pci_ops gen_pci_ops = {
> >  	.read	= gen_pci_config_read,
> >  	.write	= gen_pci_config_write,
> > +	.set_msi_parent = gen_pci_set_msi_parent,
> >  };
> >  
> >  static const struct of_device_id gen_pci_of_match[] = {
> > @@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
> >  		return err;
> >  	}
> >  
> > +	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
> > +						  "msi-parent", 0));
> 
> This bit should be in the generic of_pci.c code and not duplicated for
> each host controller.
> 
> Will
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
