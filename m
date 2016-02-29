From: brian.starkey@arm.com (Brian Starkey)
Date: Mon, 29 Feb 2016 16:09:20 +0000
Subject: [PATCH v2 0/4] Fix kernel panic in dma-coherent allocations
Message-ID: <cover.1456225103.git.brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches implement a MEMREMAP_WC flag for memremap(), which can
be used to obtain writecombine mappings. This is then used for setting
up dma_coherent_mem regions which use the DMA_MEMORY_MAP flag.

The motivation is to fix an alignment fault on arm64, and the
suggestion to implement MEMREMAP_WC for this case was made at [1].
That particular issue is handled in patch 4, which makes sure that the
appropriate memset function is used when zeroing allocations mapped as
IO memory.

Best Regards,
Brian

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390857.html

Changes since v1:
* Added preparatory patch removing flag modifications in memremap()
  (Suggested by Andrew Morton)
* Rebase onto linux-next

Brian Starkey (4):
  memremap: don't modify flags
  memremap: add MEMREMAP_WC flag.
  drivers: dma-coherent: use MEMREMAP_WC for DMA_MEMORY_MAP
  drivers: dma-coherent: use memset_io for DMA_MEMORY_IO mappings

 drivers/base/dma-coherent.c |   25 ++++++++++++++++++++-----
 include/linux/io.h          |    1 +
 kernel/memremap.c           |   24 +++++++++++++++---------
 3 files changed, 36 insertions(+), 14 deletions(-)

-- 
1.7.9.5
