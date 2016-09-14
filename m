From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 23:50:20 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160914163136.GA26842@red-moon>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <874m5skmv9.fsf@linux.intel.com> <20160914163136.GA26842@red-moon>
Message-ID: <5948102.1fQRRodOXz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 5:31:36 PM CEST Lorenzo Pieralisi wrote:
> On Wed, Sep 07, 2016 at 01:47:22PM +0300, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Robin Murphy <robin.murphy@arm.com> writes:
> > > On 07/09/16 10:55, Peter Chen wrote:
> > > [...]
> > >>> Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
> > >>> I think we should replace 
> > >>>
> > >>>         pdev->dev.dma_mask = dev->dma_mask;
> > >>>         pdev->dev.dma_parms = dev->dma_parms;
> > >>>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
> > >>>
> > >>> with of_dma_configure(), which has the chance to configure more than
> > >>> just those three, as the dma API might look into different aspects:
> > >>>
> > >>> - iommu specific configuration
> > >>> - cache coherency information
> > >>> - bus type
> > >>> - dma offset
> > >>> - dma_map_ops pointer
> > >>>
> > >>> We try to handle everything in of_dma_configure() at configuration
> > >>> time, and that would be the place to add anything else that we might
> > >>> need in the future.
> > >>>
> > >> 
> > >> Yes, I agree with you, but just like Felipe mentioned, we also need to
> > >> consider PCI device, can we do something like gpiod_get_index does? Are
> > >> there any similar APIs like of_dma_configure for ACPI?
> > >
> > > Not yet, but Lorenzo has one in progress[1], primarily for the sake of
> > > abstracting away the IOMMU configuration.
> > >
> > > Robin.
> > >
> > > [1]:http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1209911.html
> > 
> > not exported for drivers to use. If Lorenzo is trying to making a
> > matching API for ACPI systems, then it needs to follow what
> > of_dma_configure() is doing, and add an EXPORT_SYMBOL_GPL()
> 
> That's easy enough, not sure I understand though why
> of_dma_deconfigure() is not exported then. The second question mark
> is about the dma-ranges equivalent in ACPI world; the _DMA method
> seems to be the exact equivalent but to the best of my knowledge
> it is ignored by the kernel, to really have an of_dma_configure()
> equivalent that's really necessary, unless we want to resort to
> arch specific methods (is that what x86 is currently doing ?) to
> retrieve/build the dma masks.

Please see the follow-up emails after my proposed patch: if we add
a pointer to the device that firmware knows about in the USB core layer,
there is no longer a problem to be solved and the DMA operations will
do the right thing.

	Arnd
