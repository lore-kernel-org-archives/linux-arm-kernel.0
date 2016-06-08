From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jun 2016 17:49:59 +0200
Subject: [PATCH] arm64: mm: only initialize swiotlb when necessary
In-Reply-To: <20160608120829.GB16322@e104818-lin.cambridge.arm.com>
References: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
 <20160608120829.GB16322@e104818-lin.cambridge.arm.com>
Message-ID: <3518191.m1tVRlZvU1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 8, 2016 1:08:29 PM CEST Catalin Marinas wrote:
> On Wed, Jun 08, 2016 at 03:53:46PM +0800, Jisheng Zhang wrote:
> >  static int __init arm64_dma_init(void)
> >  {
> > +     if (swiotlb_force || max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
> > +             swiotlb = 1;
> > +
> >       return atomic_pool_init();
> >  }
> 
> So any platform with RAM larger than 4GB would still initialise swiotlb.
> I wouldn't say it's an issue, 64MB is not a significant loss on such
> systems.
> 
> An alternative would be to defer the freeing until we are aware of all
> possible dma masks for the populated devices (e.g. from DT), though I'm
> not sure that's enough, drivers may try to change such masks when
> probed.

Right, this is a hard problem, because you can in theory have odd devices
that require a DMA mask lower than the limit of ZONE_DMA.

In the kernel sources, I find these:

# git grep DMA_BIT_MASK | grep -v 'DMA_BIT_MASK(\(3[2-9]\|[456][0-9]\))'
arch/arm/mach-ixp4xx/common.c:		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
drivers/base/isa.c:		isa_dev->dev.coherent_dma_mask = DMA_BIT_MASK(24);
drivers/media/pci/sta2x11/sta2x11_vip.c:	err = dma_set_coherent_mask(&vip->pdev->dev, DMA_BIT_MASK(29));
drivers/media/pci/sta2x11/sta2x11_vip.c:	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(26))) {
drivers/net/ethernet/broadcom/b44.c:		mapping + RX_PKT_BUF_SZ > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:		    mapping + RX_PKT_BUF_SZ > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:	if (dma_mapping_error(bp->sdev->dma_dev, mapping) || mapping + len > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:		if (dma_mapping_error(bp->sdev->dma_dev, mapping) || mapping + len > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:			rx_ring_dma + size > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:			tx_ring_dma + size > DMA_BIT_MASK(30)) {
drivers/net/ethernet/broadcom/b44.c:	if (dma_set_mask_and_coherent(sdev->dma_dev, DMA_BIT_MASK(30))) {
drivers/net/wan/wanxl.c:	if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(28)) ||
drivers/net/wan/wanxl.c:	    pci_set_dma_mask(pdev, DMA_BIT_MASK(28))) {
drivers/net/wireless/broadcom/b43/dma.c:	return DMA_BIT_MASK(30);
drivers/net/wireless/broadcom/b43/dma.c:	if (dmamask == DMA_BIT_MASK(30))
drivers/net/wireless/broadcom/b43/dma.c:			mask = DMA_BIT_MASK(30);
drivers/net/wireless/broadcom/b43legacy/dma.c:	return DMA_BIT_MASK(30);
drivers/net/wireless/broadcom/b43legacy/dma.c:	if (dmamask == DMA_BIT_MASK(30))
drivers/net/wireless/broadcom/b43legacy/dma.c:			mask = DMA_BIT_MASK(30);
drivers/parport/parport_pc.c:		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(24));
drivers/pnp/card.c:	card->dev.coherent_dma_mask = DMA_BIT_MASK(24);
drivers/pnp/core.c:	dev->dma_mask = DMA_BIT_MASK(24);
drivers/scsi/aacraid/commsup.c:		if (((retval = pci_set_dma_mask(aac->pdev, DMA_BIT_MASK(31)))) ||
drivers/scsi/aacraid/commsup.c:		  ((retval = pci_set_consistent_dma_mask(aac->pdev, DMA_BIT_MASK(31)))))
drivers/scsi/aacraid/linit.c:		dmamask = DMA_BIT_MASK(31);
drivers/usb/host/ehci-pci.c:						DMA_BIT_MASK(31)) < 0)
include/linux/blkdev.h:#define BLK_BOUNCE_ISA		(DMA_BIT_MASK(24))
sound/pci/ali5451/ali5451.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(31)) < 0 ||
sound/pci/als300.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
sound/pci/als4000.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
sound/pci/azt3328.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
sound/pci/emu10k1/emu10k1x.c:	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
sound/pci/es1938.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
sound/pci/es1968.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
sound/pci/ice1712/ice1712.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
sound/pci/maestro3.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
sound/pci/sis7019.c:	rc = dma_set_mask(&pci->dev, DMA_BIT_MASK(30));
sound/pci/sonicvibes.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
sound/pci/trident/trident_main.c:	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(30)) < 0 ||
sound/pci/trident/trident_main.c:	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(30)) < 0) {
sound/soc/intel/common/sst-firmware.c:	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(31));
sound/soc/intel/haswell/sst-haswell-dsp.c:	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(31));

	Arnd
