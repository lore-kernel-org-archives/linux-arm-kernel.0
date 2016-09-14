From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 14 Sep 2016 17:31:36 +0100
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <874m5skmv9.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <5844875.KucAoPMrXi@wuerfel>
 <20160907063313.GA13903@b29397-desktop>
 <12021424.cItk3A7CfE@wuerfel>
 <20160907095549.GD13903@b29397-desktop>
 <75ca65eb-e8c4-bc3f-e00b-b0cba46d28c6@arm.com>
 <874m5skmv9.fsf@linux.intel.com>
Message-ID: <20160914163136.GA26842@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 01:47:22PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Robin Murphy <robin.murphy@arm.com> writes:
> > On 07/09/16 10:55, Peter Chen wrote:
> > [...]
> >>> Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
> >>> I think we should replace 
> >>>
> >>>         pdev->dev.dma_mask = dev->dma_mask;
> >>>         pdev->dev.dma_parms = dev->dma_parms;
> >>>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
> >>>
> >>> with of_dma_configure(), which has the chance to configure more than
> >>> just those three, as the dma API might look into different aspects:
> >>>
> >>> - iommu specific configuration
> >>> - cache coherency information
> >>> - bus type
> >>> - dma offset
> >>> - dma_map_ops pointer
> >>>
> >>> We try to handle everything in of_dma_configure() at configuration
> >>> time, and that would be the place to add anything else that we might
> >>> need in the future.
> >>>
> >> 
> >> Yes, I agree with you, but just like Felipe mentioned, we also need to
> >> consider PCI device, can we do something like gpiod_get_index does? Are
> >> there any similar APIs like of_dma_configure for ACPI?
> >
> > Not yet, but Lorenzo has one in progress[1], primarily for the sake of
> > abstracting away the IOMMU configuration.
> >
> > Robin.
> >
> > [1]:http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1209911.html
> 
> not exported for drivers to use. If Lorenzo is trying to making a
> matching API for ACPI systems, then it needs to follow what
> of_dma_configure() is doing, and add an EXPORT_SYMBOL_GPL()

That's easy enough, not sure I understand though why
of_dma_deconfigure() is not exported then. The second question mark
is about the dma-ranges equivalent in ACPI world; the _DMA method
seems to be the exact equivalent but to the best of my knowledge
it is ignored by the kernel, to really have an of_dma_configure()
equivalent that's really necessary, unless we want to resort to
arch specific methods (is that what x86 is currently doing ?) to
retrieve/build the dma masks.

Lorenzo
