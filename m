From: labbott@redhat.com (Laura Abbott)
Date: Mon, 12 Sep 2016 14:32:53 -0700
Subject: [RFCv3][PATCH 0/5] Cleanup Ion mapping/caching
Message-ID: <1473715978-11633-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 on the attempt to remove the misuse of the DMA cache APIS from Ion.

As from before:
The APIs created are kernel_force_cache_clean and kernel_force_cache_invalidate.
They force a clean and invalidate of the cache, respectively. The aim was to
take the semantics of dma_sync and turn them into something that isn't
dma_sync. This series includes a nominal implementation for arm/arm64, mostly
for demonstration purposes.

The major change from v2 is that the implementations no longer leverage the
DMA abstractions. Russell King noted that dma_map and dma_unmap just 'happen'
to do the right thing but they aren't guaranteed.

I'm hoping at v3 there are no objections to the general concept but if they
exist please express them.

Thanks,
Laura

[1]http://www.mail-archive.com/driverdev-devel at linuxdriverproject.org/msg49406.html

Laura Abbott (5):
  Documentation: Introduce kernel_force_cache_* APIs
  arm: Impelment ARCH_HAS_FORCE_CACHE
  arm64: Implement ARCH_HAS_FORCE_CACHE
  staging: android: ion: Convert to the kernel_force_cache APIs
  staging: ion: Add support for syncing with DMA_BUF_IOCTL_SYNC

 Documentation/cachetlb.txt                      | 18 ++++++-
 arch/arm/include/asm/cacheflush.h               | 11 ++++
 arch/arm/include/asm/glue-cache.h               |  2 +
 arch/arm/mm/Makefile                            |  2 +-
 arch/arm/mm/cache-fa.S                          |  8 +++
 arch/arm/mm/cache-nop.S                         |  6 +++
 arch/arm/mm/cache-v4.S                          | 10 ++++
 arch/arm/mm/cache-v4wb.S                        |  8 +++
 arch/arm/mm/cache-v4wt.S                        |  8 +++
 arch/arm/mm/cache-v6.S                          |  8 +++
 arch/arm/mm/cache-v7.S                          | 13 +++++
 arch/arm/mm/cacheflush.c                        | 71 +++++++++++++++++++++++++
 arch/arm/mm/proc-arm920.S                       |  8 +++
 arch/arm/mm/proc-arm922.S                       |  8 +++
 arch/arm/mm/proc-arm925.S                       |  8 +++
 arch/arm/mm/proc-arm926.S                       |  8 +++
 arch/arm/mm/proc-feroceon.S                     | 11 ++++
 arch/arm/mm/proc-macros.S                       |  2 +
 arch/arm/mm/proc-xsc3.S                         |  9 ++++
 arch/arm/mm/proc-xscale.S                       |  9 ++++
 arch/arm64/include/asm/cacheflush.h             |  8 +++
 arch/arm64/mm/cache.S                           | 24 +++++++--
 arch/arm64/mm/flush.c                           | 11 ++++
 drivers/staging/android/ion/ion.c               | 53 +++++++++++-------
 drivers/staging/android/ion/ion_carveout_heap.c |  8 +--
 drivers/staging/android/ion/ion_chunk_heap.c    | 12 +++--
 drivers/staging/android/ion/ion_page_pool.c     |  7 +--
 drivers/staging/android/ion/ion_priv.h          | 11 ----
 drivers/staging/android/ion/ion_system_heap.c   |  6 +--
 include/linux/cacheflush.h                      | 11 ++++
 30 files changed, 330 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mm/cacheflush.c
 create mode 100644 include/linux/cacheflush.h

-- 
2.7.4
