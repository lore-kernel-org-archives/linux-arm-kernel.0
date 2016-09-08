From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 8 Sep 2016 09:15:36 +0800
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <3189648.KnWLgq0lTY@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <12021424.cItk3A7CfE@wuerfel> <87inu8kny0.fsf@linux.intel.com>
 <3189648.KnWLgq0lTY@wuerfel>
Message-ID: <20160908011535.GE13903@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 05:24:08PM +0200, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 1:24:07 PM CEST Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Arnd Bergmann <arnd@arndb.de> writes:
> > 
> > [...]
> > 
> > > Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
> > > I think we should replace 
> > >
> > >         pdev->dev.dma_mask = dev->dma_mask;
> > >         pdev->dev.dma_parms = dev->dma_parms;
> > >         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
> > >
> > > with of_dma_configure(), which has the chance to configure more than
> > > just those three, as the dma API might look into different aspects:
> > >
> > > - iommu specific configuration
> > > - cache coherency information
> > > - bus type
> > > - dma offset
> > > - dma_map_ops pointer
> > >
> > > We try to handle everything in of_dma_configure() at configuration
> > > time, and that would be the place to add anything else that we might
> > > need in the future.
> > 
> > There are a couple problems with this:
> > 
> > 1) won't work for PCI-based systems.
> > 
> > DWC3 is used in production PCI-based HW and also in Synopsys HAPS DX
> > platform (FPGA that appears like a PCI card to host PC)
> 
> Right, I was specifically talking about the code in chipidea here,
> which I think is never used on the PCI bus, and how the current
> code is broken. We can probably do better than of_dma_configure()
> (see below), but it would be an improvement.

Chipidea is also used at PCI bus too, see drivers/usb/chipidea/ci_hdrc_pci.c

-- 

Best Regards,
Peter Chen
