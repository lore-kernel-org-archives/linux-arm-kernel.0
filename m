From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:48:13 +0800
Subject: [PATCH][RESEND 0/8] Add and implement gen_pool_dma_alloc()
Message-ID: <cover.1383306365.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, we don't have a specific gen_pool_alloc() for DMA usage;
Instead, we need to use gen_pool_virt_to_phys() to convert the addr
returned from gen_pool_alloc(). So each implementation of this has
duplicated code. Thus add new helper function -- gen_pool_dma_alloc().

After gen_pool_dma_alloc() is introduced, we can replace the original
combination of gen_pool_alloc()+gen_pool_virt_to_phys() with this new
helper function. Thus this patch implement the helper function to all
the current drivers which use gen_pool_virt_to_phys().

!!-------------------important------------------!!

The later 7 patches need all related driver owner to test. We can
here define a simple rule:
1, If one driver owner or maintainer doesn't like the mofication
   to his/her driver, just let me know. I would drop that patch.
2, If there's a bug and issue found after patch-testing, please
   reply the mail so that I can fix and refine the patch.
3, If one driver owner or maintainer is too busy and doesn't have
   bandwidth to test the patch, I would drop that patch from this
   series. We can reimplement it till there's someone test it.

!!-------------------current progress-----------!!

  lib/genalloc: [Okay]
  ARM: davinci: [Untested]
  dma: mmp_tdma: [Untested]
  [media] coda: [Untested]
  uio: uio_pruss: [Untested]
  ALSA: memalloc: [Tested] by Nicolin Chen with i.MX6Q SabreSD
  ASoC: davinci: [Untested]
  ASoC: pxa: use [Untested]


Nicolin Chen (8):
  lib/genalloc: add a helper function for DMA buffer allocation
  ARM: davinci: use gen_pool_dma_alloc() to sram.c
  dma: mmp_tdma: use gen_pool_dma_alloc() to allocate descriptor
  [media] coda: use gen_pool_dma_alloc() to allocate iram buffer
  uio: uio_pruss: use gen_pool_dma_alloc() to allocate sram memory
  ALSA: memalloc: use gen_pool_dma_alloc() to allocate iram buffer
  ASoC: davinci: use gen_pool_dma_alloc() in davinci-pcm.c
  ASoC: pxa: use gen_pool_dma_alloc() to allocate dma buffer

 arch/arm/mach-davinci/sram.c    |  9 +--------
 drivers/dma/mmp_tdma.c          |  7 +------
 drivers/media/platform/coda.c   |  5 ++---
 drivers/uio/uio_pruss.c         |  6 ++----
 include/linux/genalloc.h        |  2 ++
 lib/genalloc.c                  | 28 ++++++++++++++++++++++++++++
 sound/core/memalloc.c           |  6 +-----
 sound/soc/davinci/davinci-pcm.c |  3 +--
 sound/soc/pxa/mmp-pcm.c         |  3 +--
 9 files changed, 39 insertions(+), 30 deletions(-)

-- 
1.8.4
