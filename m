From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:15 +0200
Subject: clean up and modularize arch dma_mapping interface V2
Message-ID: <20170616181059.19206-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

I've got a good number of reviews last time, but a few are still missing.
I'd love to not have to re-spam everyone with this patchbomb, so early
ACKs (or complaints) are welcome.

I plan to create a new dma-mapping tree to collect all this work.
Any volunteers for co-maintainers, especially from the iommu gang?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map

Changes since V1:
 - remove two lines of code from arm dmabounce
 - a few commit message tweaks
 - lots of ACKs
