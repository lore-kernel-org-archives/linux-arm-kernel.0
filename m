From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 May 2012 18:53:03 +0200
Subject: [PATCH/RFC 0/3] ARM: DMA-mapping: new extensions for buffer sharing
Message-ID: <1337273586-11089-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series introduces a new features to DMA mapping subsystem
to let drivers share the allocated buffers (preferably using recently
introduced dma_buf framework) easy and efficient.

The first extension is DMA_ATTR_NO_KERNEL_MAPPING attribute. It is
intended for use with dma_{alloc, mmap, free}_attrs functions. It can be
used to notify dma-mapping core that the driver will not use kernel
mapping for the allocated buffer at all, so the core can skip creating
it. This saves precious kernel virtual address space. Such buffer can be
accessed from userspace, after calling dma_mmap_attrs() for it (a
typical use case for multimedia buffers). The value returned by
dma_alloc_attrs() with this attribute should be considered as a DMA
cookie, which needs to be passed to dma_mmap_attrs() and
dma_free_attrs() funtions.

The second extension is required to let drivers to share the buffers
allocated by DMA-mapping subsystem. Right now the driver gets a dma
address of the allocated buffer and the kernel virtual mapping for it.
If it wants to share it with other device (= map into its dma address
space) it usually hacks around kernel virtual addresses to get pointers
to pages or assumes that both devices share the DMA address space. Both
solutions are just hacks for the special cases, which should be avoided
in the final version of buffer sharing. To solve this issue in a generic
way, a new call to DMA mapping has been introduced - dma_get_sgtable().
It allocates a scatter-list which describes the allocated buffer and
lets the driver(s) to use it with other device(s) by calling
dma_map_sg() on it.

The proposed patches have been generated on top of the ARM DMA-mapping
redesign patch series on Linux v3.4-rc7. They are also available on the
following GIT branch:

git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc7-arm-dma-v10-ext

with all require patches on top of vanilla v3.4-rc7 kernel.

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (3):
  common: DMA-mapping: add DMA_ATTR_NO_KERNEL_MAPPING attribute
  ARM: dma-mapping: add support for DMA_ATTR_NO_KERNEL_MAPPING
    attribute
  ARM: dma-mapping: add support for dma_get_sgtable()

 Documentation/DMA-attributes.txt   |   18 +++++++++++++
 arch/arm/include/asm/dma-mapping.h |   12 +++++++++
 arch/arm/mm/dma-mapping.c          |   51 ++++++++++++++++++++++++++++++++----
 include/linux/dma-attrs.h          |    1 +
 include/linux/dma-mapping.h        |    3 +++
 5 files changed, 80 insertions(+), 5 deletions(-)

-- 
1.7.10.1
