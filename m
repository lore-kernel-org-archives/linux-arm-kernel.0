From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 21:22:35 +0100
Subject: PCIe host controller behind IOMMU on ARM
In-Reply-To: <20151111182456.GV963@e106497-lin.cambridge.arm.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <PS1PR06MB11806B65D3408BDFBEAD9D3AF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151111182456.GV963@e106497-lin.cambridge.arm.com>
Message-ID: <4372968.dQOnUSIksK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 18:24:56 Liviu.Dudau at arm.com wrote:
> 
> > Somewhat related to this, since our PCIe controller HW is limited to
> > 32-bit AXI address range, before trying to hook up the IOMMU I have
> > tried to limit the dma_mask for PCI cards to DMA_BIT_MASK(32). The
> > reason being that Linux uses a 1 to 1 mapping between PCI addresses
> > and cpu (phys) addresses when there isn't an IOMMU involved, so I
> > think that we need to limit the PCI address space used.
> 
> I think you're mixing things a bit or not explaining them very well. Having the
> PCIe controller limited to 32-bit AXI does not mean that the PCIe bus cannot
> carry 64-bit addresses. It depends on how they get translated by the host bridge
> or its associated ATS block. I can't see why you can't have a setup where
> the CPU addresses are 32-bit but the PCIe bus addresses are all 64-bit.
> You just have to be careful on how you setup your mem64 ranges so that they don't
> overlap with the 32-bit ranges when translated.
> 
> And no, you should not limit at the card driver the DMA_BIT_MASK() unless the
> card is not capable of supporting more than 32-bit addresses.

I think we are missing one crucial bit of infrastructure on ARM64 at
the moment: the dma_set_mask() function should fail if a driver asks
for a mask that is larger than the dma-ranges property of the parent
device (or any device higher up in the hierarchy) allows.

Drivers that want a larger mask should try that first, and then fall
back to a 32-bit mask, which is guaranteed to work.

	Arnd
