From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 14:29:40 +0200
Subject: [PATCH 0/4] scatterlist: sg_table from virtual pointer
Message-ID: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series has been extracted from another series [1] adding support
for DMA operations in a NAND driver.

The reason I decided to post those patches separately is because they
are touching core stuff, and I'd like to have feedback on these specific
aspects.

The idea is to provide a generic function creating an sg_table from
a virtual pointer and a length. This operation is complicated by
the different memory regions exposed in kernel space. For example,
you have the lowmem region, which guarantees that buffers are
physically contiguous, while the vmalloc region does not.

sg_alloc_table_from_buf() detects in which memory region your buffer
reside, and takes the appropriate precautions when creating the
sg_table. This function also takes an extract parameter, allowing
one to specify extra constraints, like the maximum DMA segment size,
the required and the preferred alignment.

Patch 1 and 2 are implementing sg_alloc_table_from_buf() (patch 1
is needed to properly detect buffers residing in the highmem/kmap
area).

Patch 3 is making use of sg_alloc_table_from_buf() in the spi_map_buf()
function (hopefully, other subsystems/drivers will be able to easily
switch to this function too).

Patch 4 is implementing what I really need: generic functions
to map/unmap a virtual buffer passed through mtd->_read/_write().

I'm not exactly a DMA or MM experts, so that would be great to have
feedbacks on this approach. That's why I added so many people in Cc
even if they're not directly impacted by those patches. Let me know if
you want me to drop/add people from/to the recipient list.

Thanks.

Best Regards,

Boris

[1]http://www.spinics.net/lists/arm-kernel/msg493552.html

Boris Brezillon (4):
  mm: add is_highmem_addr() helper
  scatterlist: add sg_alloc_table_from_buf() helper
  spi: use sg_alloc_table_from_buf()
  mtd: provide helper to prepare buffers for DMA operations

 drivers/mtd/mtdcore.c       |  66 ++++++++++++++++
 drivers/spi/spi.c           |  45 ++---------
 include/linux/highmem.h     |  13 ++++
 include/linux/mtd/mtd.h     |  25 ++++++
 include/linux/scatterlist.h |  24 ++++++
 lib/scatterlist.c           | 183 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 316 insertions(+), 40 deletions(-)

-- 
2.5.0
