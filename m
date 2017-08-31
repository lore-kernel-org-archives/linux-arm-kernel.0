From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 11:40:52 +0200
Subject: [PATCH v3 3/3] PCI: Avoid slot reset for Cavium cn8xxx root ports
In-Reply-To: <20170830084012.19d91759@w520.home>
References: <20170830142454.10971-1-jglauber@cavium.com>
 <20170830142454.10971-4-jglauber@cavium.com>
 <20170830084012.19d91759@w520.home>
Message-ID: <20170831094052.GA15906@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 08:40:12AM -0600, Alex Williamson wrote:
> On Wed, 30 Aug 2017 16:24:54 +0200
> Jan Glauber <jglauber@cavium.com> wrote:
> 
> > Root ports of cn8xxx do not function after a slot reset when used with
> > some e1000e and LSI HBA devices. Add a quirk to prevent slot reset on
> > these root ports.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/pci/quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 85191b8..6679971 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -845,6 +845,22 @@ static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_link);
> >  #endif
> >  
> > +/*
> > + * Root port on some Cavium CN8xxx chips do not successfully complete
> > + * a bus reset when used with certain types of child devices. Config
> > + * space access to the child may quit responding. Flag all devices under
> > + * the secondary bus as non-resettable.
> > + */
> > +static void quirk_CN8xxx_secondary_bus(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	dev_warn(&dev->dev, "Cavium CN8xxx quirk detected; reset for devices on secondary bus disabled\n");
> > +	list_for_each_entry(pdev, &dev->subordinate->devices, bus_list)
> > +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_CN8xxx_secondary_bus);
> > +
> >  /*
> >   * Some settings of MMRBC can lead to data corruption so block changes.
> >   * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
> 
> 
> This doesn't seem reliable, doesn't the user just need to remove and
> reprobe the slot and the device would re-appear without this flag set?

No, I tried before to disable the slot with "echo 0 > /sys/bus/pci/slots/3/power"
but that does not work as it is not supported.

I'm not familiar with the quirk types, would another one be better
suited here (even if we don't have the problem you descibed)?

thanks,
Jan


> Thanks,
> 
> Alex
