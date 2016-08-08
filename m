From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:32 -0700
Subject: [RFCv2][PATCH 0/5] Cleanup Ion mapping/caching
Message-ID: <1470678577-14010-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is v2 on the attempt to remove misuse of the cache APIs from Ion. The
previous version[1] attempted to pull the cache APIs into Ion. This was
indicated as the wrong approach and real APIs should be created instead.

The APIs created are kernel_force_cache_clean and kernel_force_cache_invalidate.
They force a clean and invalidate of the cache, respectively. The aim was to
take the semantics of dma_sync and turn them into something that isn't
dma_sync. This series includes a nominal implementation for arm/arm64, mostly
for demonstration purposes.

I did review before writing this of whether Ion could just use the DMA mapping
APIs to acheive the necessary coherency. The conclusion I came to was that
trying to force the Ion code into the DMA model would create more problem than
it solved since there wasn't anything like DMA going on. Similarly, none of
the existing cache APIs did exactly what was needed either. The closest matches
were designed for file cache pages and not drivers.

The series includes conversion of Ion to the new APIs. There are a few other
drivers which are calling either arch specific APIs or flush_dcache_page
that could be converted as well. The i915 driver could potentially be converted
with the addition of an x86 implementation.

Feedback appreciated as always.

Thanks,
Laura

[1] https://lkml.kernel.org/g/<1464205684-5587-1-git-send-email-labbott@redhat.com>

Laura Abbott (5):
  Documentation: Introduce kernel_force_cache_* APIs
  arm: Implement ARCH_HAS_FORCE_CACHE
  arm64: Implement ARCH_HAS_FORCE_CACHE
  staging: android: ion: Convert to the kernel_force_cache APIs
  staging: ion: Add support for syncing with DMA_BUF_IOCTL_SYNC

 Documentation/cachetlb.txt                      |  18 +++-
 arch/arm/include/asm/cacheflush.h               |   4 +
 arch/arm/mm/dma-mapping.c                       | 119 ------------------------
 arch/arm/mm/flush.c                             | 115 +++++++++++++++++++++++
 arch/arm/mm/mm.h                                |   8 ++
 arch/arm64/include/asm/cacheflush.h             |   5 +
 arch/arm64/mm/flush.c                           |  11 +++
 drivers/staging/android/ion/ion.c               |  53 +++++++----
 drivers/staging/android/ion/ion_carveout_heap.c |   8 +-
 drivers/staging/android/ion/ion_chunk_heap.c    |  12 ++-
 drivers/staging/android/ion/ion_page_pool.c     |   6 +-
 drivers/staging/android/ion/ion_priv.h          |  11 ---
 drivers/staging/android/ion/ion_system_heap.c   |   6 +-
 include/linux/cacheflush.h                      |  11 +++
 14 files changed, 225 insertions(+), 162 deletions(-)
 create mode 100644 include/linux/cacheflush.h

-- 
2.7.4
