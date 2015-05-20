From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 11:27:54 +0200
Subject: [V4 PATCH 3/6] pci: Generic function for setting up PCI device
 DMA coherency
In-Reply-To: <20150520092415.GA25313@e104818-lin.cambridge.arm.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <3954735.qeaTp8qOcM@vostro.rjw.lan>
 <20150520092415.GA25313@e104818-lin.cambridge.arm.com>
Message-ID: <2072233.lIH4idDurI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 10:24:15 Catalin Marinas wrote:
> On Sat, May 16, 2015 at 01:59:00AM +0200, Rafael J. Wysocki wrote:
> > On Friday, May 15, 2015 04:23:11 PM Suravee Suthikulpanit wrote:
> > > +/**
> > > + * pci_dma_configure - Setup DMA configuration
> > > + * @pci_dev: ptr to pci_dev struct of the PCI device
> > > + *
> > > + * Function to update PCI devices's DMA configuration using the same
> > > + * info from the OF node or ACPI node of host bridge's parent (if any).
> > > + */
> > > +static void pci_dma_configure(struct pci_dev *pci_dev)
> > > +{
> > > +   struct device *dev = &pci_dev->dev;
> > > +   struct device *bridge = pci_get_host_bridge_device(pci_dev);
> > > +   struct device *host = bridge->parent;
> > > +   struct acpi_device *adev;
> > > +
> > > +   if (!host)
> > > +           return;
> > > +
> > > +   if (acpi_disabled) {
> > > +           of_dma_configure(dev, host->of_node);
> > 
> > I'd rather do
> > 
> >       if (IS_ENABLED(CONFIG_OF) && host->of_node) {
> >               of_dma_configure(dev, host->of_node);
> 
> Nitpick: do we need the CONFIG_OF check? If disabled, I don't think
> anyone would set host->of_node.
> 

If of_dma_configure() is defined in a file that is built conditionally
based on CONFIG_OF, you need it.

	Arnd
