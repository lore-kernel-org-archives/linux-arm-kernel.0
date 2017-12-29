From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:04 +0100
Subject: consolidate direct dma mapping and swiotlb support
Message-ID: <20171229081911.2802-1-hch@lst.de>
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

It then switches a large number of architectures to this generic
direct map implement and the new generic swiotlb dma_map ops.

Note that for now this only handles architectures that do cache coherent
DMA, but a similar consolidation for non-coherent architectures is in the
work for later merge windows.
