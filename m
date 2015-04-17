From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 16:09:23 +0200
Subject: [RFC] PCI: BCM5301X: add PCIe2 driver for BCM5301X SoCs
In-Reply-To: <11068573.lefhT3BUSj@wuerfel>
References: <1415470392-28229-1-git-send-email-hauke@hauke-m.de>
 <545E8AA2.6050301@hauke-m.de> <11068573.lefhT3BUSj@wuerfel>
Message-ID: <4575399.moLzVD0xqT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(reviving an old thread)

On Sunday 09 November 2014 21:27:40 Arnd Bergmann wrote:
> 
> > >> +  /*
> > >> +   * Inbound address translation setup
> > >> +   * Northstar only maps up to 128 MiB inbound, DRAM could be up to 1 GiB.
> > >> +   *
> > >> +   * For now allow access to entire DRAM, assuming it is less than 128MiB,
> > >> +   * otherwise DMA bouncing mechanism may be required.
> > >> +   * Also consider DMA mask to limit DMA physical address
> > >> +   */
> > >> +  /* 64-bit LE regs, write low word, high is 0 at reset */
> > >> +  bcma_write32(bdev, BCMA_CORE_PCIE2_FUNC0_IMAP1, PHYS_OFFSET | 0x1);
> > >> +  bcma_write32(bdev, BCMA_CORE_PCIE2_IARR1_LOWER,
> > >> +                     PHYS_OFFSET | ((SZ_128M >> 20) & 0xff));
> > > 
> > > Maybe I should bully you into enabling swiotlb on arm32 
> > 
> > This sounds complicated, I hope I can avoid it. 
> 
> I'd really hope that it's not that hard. We basically just need a copy of
> coherent_swiotlb_dma_ops/noncoherent_swiotlb_dma_ops from arm64 and
> use those on bcma devices, with the right dma_mask set.

Peter Senna has tested this on bcm4708a0 (Buffalo WZR-1750DHP) and found
that all RAM is DMA capable, as tested with CONFIG_VMSPLIT_1G. Could
the code comment here be incorrect, or is it possible that it was fixed
in later chip versions?

If this works, using CONFIG_VMSPLIT_1G should result in noticeably
better I/O performance on this chip.

I have created a patch that lets him simulate the broken behavior on his
machine, so he can work on implementing swiotlb, but it would certainly
be best to understand which machines are really affected.

Note that the driver that was merged as drivers/pci/host/pcie-iproc.c
does not seem to touch the BCMA_CORE_PCIE2_IARR1_LOWER (offset 0xd08)
register, and presumably the power-on default for this register
maps all of RAM correctly.

	Arnd
