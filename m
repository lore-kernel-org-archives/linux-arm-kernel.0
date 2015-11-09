From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 9 Nov 2015 12:32:13 +0000
Subject: PCIe host controller behind IOMMU on ARM
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151104142412.GS963@e106497-lin.cambridge.arm.com>
 <PS1PR06MB11804263DD55C54C5987654EF52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151104150147.GT963@e106497-lin.cambridge.arm.com>
Message-ID: <PS1PR06MB11806B65D3408BDFBEAD9D3AF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu, Will,

On 04 November 2015 15:19, Phil wrote:
> On 04 November 2015 15:02, Liviu wrote:
> > On Wed, Nov 04, 2015 at 02:48:38PM +0000, Phil Edworthy wrote:
> > > Hi Liviu,
> > >
> > > On 04 November 2015 14:24, Liviu wrote:
> > > > On Wed, Nov 04, 2015 at 01:57:48PM +0000, Phil Edworthy wrote:
> > > > > Hi,
> > > > >
> > > > > I am trying to hook up a PCIe host controller that sits behind an IOMMU,
> > > > > but having some problems.
> > > > >
> > > > > I'm using the pcie-rcar PCIe host controller and it works fine without
> > > > > the IOMMU, and I can attach the IOMMU to the controller such that any
> > calls
> > > > > to dma_alloc_coherent made by the controller driver uses the
> iommu_ops
> > > > > version of dma_ops.
> > > > >
> > > > > However, I can't see how to make the endpoints to utilise the dma_ops
> that
> > > > > the controller uses. Shouldn't the endpoints inherit the dma_ops from the
> > > > > controller?
> > > >
> > > > No, not directly.
> > > >
> > > > > Any pointers for this?
> > > >
> > > > You need to understand the process through which a driver for endpoint
> get
> > > > an address to be passed down to the device. Have a look at
> > > > Documentation/DMA-API-HOWTO.txt, there is a nice explanation there.
> > > > (Hint: EP driver needs to call dma_map_single).
> > > >
> > > > Also, you need to make sure that the bus address that ends up being set
> into
> > > > the endpoint gets translated correctly by the host controller into an address
> > > > that the IOMMU can then translate into physical address.
> > > Sure, though since this is bog standard Intel PCIe ethernet card which works
> > > fine when the IOMMU is effectively unused, I don?t think there is a problem
> > > with that.
> > >
> > > The driver for the PCIe controller sets up the IOMMU mapping ok when I
> > > do a test call to dma_alloc_coherent() in the controller's driver. i.e. when I
> > > do this, it ends up in arm_iommu_alloc_attrs(), which calls
> > > __iommu_alloc_buffer() and __alloc_iova().
> > >
> > > When an endpoint driver allocates and maps a dma coherent buffer it
> > > also needs to end up in arm_iommu_alloc_attrs(), but it doesn't.
> >
> > Why do you think that? Remember that the only thing attached to the IOMMU
> is
> > the
> > host controller. The endpoint is on the PCIe bus, which gets a different
> > translation
> > that the IOMMU knows nothing about. If it helps you to visualise it better, think
> > of the host controller as another IOMMU device. It's the ops of the host
> > controller
> > that should be invoked, not the IOMMU's.
> Ok, that makes sense. I'll have a think and poke it a bit more...
Somewhat related to this, since our PCIe controller HW is limited to
32-bit AXI address range, before trying to hook up the IOMMU I have
tried to limit the dma_mask for PCI cards to DMA_BIT_MASK(32). The
reason being that Linux uses a 1 to 1 mapping between PCI addresses
and cpu (phys) addresses when there isn't an IOMMU involved, so I
think that we need to limit the PCI address space used.

Since pci_setup_device() sets up dma_mask, I added a bus notifier in the
PCIe controller driver so I can change the mask, if needed, on the
BUS_NOTIFY_BOUND_DRIVER action.
However, I think there is the potential for card drivers to allocate and
map buffers before the bus notifier get called. Additionally, I've seen
drivers change their behaviour based on the success or failure of
dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)), so the
driver could, theoretically at least, operate in a way that is not
compatible with a more restricted dma_mask (though I can't think
of any way this would not work with hardware I've seen).

So, I think that using a bus notifier is the wrong way to go, but I don?t
know what other options I have. Any suggestions?

Thanks for your help
Phil
