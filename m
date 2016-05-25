From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 May 2016 12:48:01 -0700
Subject: [RFC][PATCH 0/3] Clean up Ion mapping/caching
Message-ID: <1464205684-5587-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series cleans up Ion a bit to be more in line with existing standards for
caching and dma mapping.

The most controversial part of this is probably going to be the first patch.
Ion takes quite a few liberties with how the DMA APIs are used for cache
syncing. dma_sync_sg is used without calling dma_map first. There isn't a
good way to get the cache synchronization with the DMA APIs. The behavior of
Ion is closer to the DRM framework which uses its own private cache APIs for
synchronization so I took that approach.

Assuming the approach of the first patch is appropriate, the next two patches
are fairly simple. dma_buf added support for a sync ioctl. Ion has a similar
ioctl already so this fixes the Ion APIs to be compatible with the dma_buf
ioctl. My plan would be to put a timeline on deprecation for the old Ion
sync ioctl. The map_dma_buf calls were also missing calls to the underlying
DMA APIs so the final patch in the series adds the appropriate calls.

Feedback is appreciated.

Thanks,
Laura

Laura Abbott (3):
  staging: ion: Move away from the DMA APIs for cache flushing
  staging: ion: Add support for syncing with DMA_BUF_IOCTL_SYNC
  staging: ion: Add dma_map/dma_unmap calls to dma_buf calls

 drivers/staging/android/ion/Kconfig             | 14 ++++-
 drivers/staging/android/ion/Makefile            |  3 +
 drivers/staging/android/ion/ion-arm.c           | 83 ++++++++++++++++++++++++
 drivers/staging/android/ion/ion-arm64.c         | 46 ++++++++++++++
 drivers/staging/android/ion/ion-x86.c           | 34 ++++++++++
 drivers/staging/android/ion/ion.c               | 84 +++++++++++++------------
 drivers/staging/android/ion/ion_carveout_heap.c |  5 +-
 drivers/staging/android/ion/ion_chunk_heap.c    |  7 +--
 drivers/staging/android/ion/ion_page_pool.c     |  3 +-
 drivers/staging/android/ion/ion_priv.h          | 14 ++---
 drivers/staging/android/ion/ion_system_heap.c   |  5 +-
 11 files changed, 235 insertions(+), 63 deletions(-)
 create mode 100644 drivers/staging/android/ion/ion-arm.c
 create mode 100644 drivers/staging/android/ion/ion-arm64.c
 create mode 100644 drivers/staging/android/ion/ion-x86.c

-- 
2.5.5
