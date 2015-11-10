From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 22:54:22 +0100
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <56425BBF.6000308@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <6333643.g8NiezT8gD@wuerfel> <56425BBF.6000308@codeaurora.org>
Message-ID: <4912471.TLsW7CIyYF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 15:03:59 Timur Tabi wrote:
> On 11/10/2015 01:13 PM, Arnd Bergmann wrote:
> > If the mask is 64-bit by default on ARM64, that is a bug that we need
> > to fix urgently. Can you verify this?
> 
> I think the mask is 0 by default, because there's no code in ARM64 that 
> actually sets the mask.
> 
> Take a look at arch_setup_pdev_archdata() in 
> arch/powerpc/kernel/setup-common.c.
> 
> void arch_setup_pdev_archdata(struct platform_device *pdev)
> {
>          pdev->archdata.dma_mask = DMA_BIT_MASK(32);
>          pdev->dev.dma_mask = &pdev->archdata.dma_mask;
>          set_dma_ops(&pdev->dev, &dma_direct_ops);
> }
> 
> I don't see anything equivalent in arch/arm64

of_dma_configure() sets up an initial DMA mask for 32 bits. The
same thing happens for pci_setup_device() in architecture-independent
code?

> > A lot of PCI devices can only do 32-bit DMA, and we have plenty
> > of drivers that don't bother setting a mask at all because the 32-bit
> > mask is the default on all other architectures.
> 
> In our drivers for 32-bit devices, we have to explicitly set the DMA 
> mask to 32-bits in order to get any DMA working.

Do you mean PCI devices or platform devices?

Maybe the parent bus is lacking a dma-ranges property?

	Arnd
