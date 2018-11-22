From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Nov 2018 15:02:56 +0100
Subject: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181122140320.24080-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Error reporting for the dma_map_single and dma_map_page operations is
currently a mess.  Both APIs directly return the dma_addr_t to be used for
the DMA, with a magic error escape that is specific to the instance and
checked by another method provided.  This has a few downsides:

 - the error check is easily forgotten and a __must_check marker doesn't
   help as the value always is consumed anyway
 - the error checking requires another indirect call, which have gotten
   incredibly expensive
 - a lot of code is wasted on implementing these methods

The historical reason for this is that people thought DMA mappings would
not fail when the API was created, which sounds like a really bad
assumption in retrospective, and then we tried to cram error handling
onto it later on.

There basically are two variants:  the error code is 0 because the
implementation will never return 0 as a valid DMA address, or the error
code is all-F as the implementation won't ever return an address that
high.  The old AMD GART is the only one not falling into these two camps
as it picks sort of a relative zero relative to where it is mapped.

The 0 return doesn't work for direct mappings that have ram at address
zero and a lot of IOMMUs that start allocating bus space from address
zero, so we can't consolidate on that, but I think we can move everyone
to all-Fs, which the patch here does.  The reason for that is that
there is only one way to ever get this address: by doing a 1-byte long,
1-byte aligned mapping, but all our mappings are not only longer but
generally aligned, and the mappings have to keep at least the basic
alignment.

Note that the first two patches are queued up for 4.20 and included
for reference.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git dma-mapping-error.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mapping-error.2

Changes since v1:
 - dropped the signature change
 - split into multiple patches
 - fixed the iova allocator return check in amd-iommu
 - remove EMERGENCY_PAGES in amd_gart and calgary
