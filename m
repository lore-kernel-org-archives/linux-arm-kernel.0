From: hch@lst.de (Christoph Hellwig)
Date: Fri, 12 Jan 2018 09:41:58 +0100
Subject: consolidate direct dma mapping V4
Message-ID: <20180112084232.2857-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost every architecture supports a direct dma mapping implementation,
where no iommu is used and the device dma address is a 1:1 mapping to
the physical address or has a simple linear offset.  Currently the
code for this implementation is most duplicated over the architectures,
and the duplicated again in the swiotlb code, and then duplicated again
for special cases like the x86 memory encryption DMA ops.

This series takes the existing very simple dma-noop dma mapping
implementation, enhances it with all the x86 features and quirks, and
creates a common set of architecture hooks for it and the swiotlb code.

It then switches a number of architectures to this generic
direct map implemention.

Note that for now this only handles architectures that do cache coherent
DMA, but a similar consolidation for non-coherent architectures is in the
work for later merge windows.

A git tree is also available:

   git://git.infradead.org/users/hch/misc.git dma-direct.3

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct.3

Changes since V3
 - new patch to fix an off-by-one in mips dma_capable
Changes since V2:
 - fixed a few patch description typos
 - fixed a few printk formats
 - fixed an off by one in dma_coherent_ok
 - add a few Reviewed-by/Acked-by tags.
 - moved the swiotlb consolidation to a new series
 - dropped a few patches for now to not overwhelem the x86
   maintainers.  They will be resubmitted in the next merge window
