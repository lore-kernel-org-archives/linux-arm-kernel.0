From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 19:29:13 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <532B2628.5080305@codethink.co.uk>
References: <201402241200.21944.arnd@arndb.de>
 <20140320173106.GA19395@obsidianresearch.com>
 <532B2628.5080305@codethink.co.uk>
Message-ID: <201403201929.13633.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Ben Dooks wrote:
> On 20/03/14 18:31, Jason Gunthorpe wrote:
> > On Thu, Mar 20, 2014 at 06:25:25PM +0100, Ben Dooks wrote:
> >> So doing:
> >>
> >> static void pci_rcar_fixup(struct pci_dev *dev)
> >> {
> >>      if (dev->bus->ops == &rcar_pci_ops) {
> >>              dev_info(&dev->dev, "applying new dma mask\n");
> >>              dev->dma_mask = DMA_BIT_MASK(31);
> >>      }
> >> }
> >>
> >> DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);
> >>
> >> Did not work for me :(
> >
> > Seems like it should work, do you have CONFIG_PCI_QUIRKS turned on?
> 
> Yes, see the print happening, just still PCI OHCI dies horribly.

Shouldn't that mask be 30 instead of 31 when you only support DMA
to the first GB?

Another possibility is that 'EARLY' means it gets applied before
the normal mask is set.

Finally, setting the mask itself is not enough. As I mentioned you
also need to use the swiotlb_dma_ops. Did you already implement
those?

	Arnd
