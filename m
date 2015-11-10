From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 23:08:57 +0100
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <564268B6.9000204@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <4912471.TLsW7CIyYF@wuerfel> <564268B6.9000204@codeaurora.org>
Message-ID: <5480219.RxDdMdtxQU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 15:59:18 Timur Tabi wrote:
> On 11/10/2015 03:54 PM, Arnd Bergmann wrote:
> 
> >> In our drivers for 32-bit devices, we have to explicitly set the DMA
> >> mask to 32-bits in order to get any DMA working.
> >
> > Do you mean PCI devices or platform devices?
> 
> Platform.
> 
> > Maybe the parent bus is lacking a dma-ranges property?
> 
> All of this applies only on device-tree platforms.  Sinan and I are 
> working on an ACPI server platform.  So we never call 
> of_dma_configure(), and we don't have a dma-ranges property.

ACPI must have something else to mark DMA master devices and their
capabilities, right?

The platform should initialize the dma_mask pointer to a per-device
mask and set both the dma_mask and dma_coherent_mask to 32 bits
for any DMA master device, and the device driver should override
that to be an appropriate mask based on its needs later.

	Arnd
