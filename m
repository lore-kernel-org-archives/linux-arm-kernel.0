From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Jan 2017 13:47:44 +0000
Subject: [RFC PATCH v3 0/5] ARM: Fix dma_alloc_coherent() and friends for NOMMU
Message-ID: <1483969669-4636-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seem that addition of cache support for M-class cpus uncovered
latent bug in DMA usage. NOMMU memory model has been treated as being
always consistent; however, for R/M classes of cpu memory can be
covered by MPU which in turn might configure RAM as Normal
i.e. bufferable and cacheable. It breaks dma_alloc_coherent() and
friends, since data can stuck in caches now or be buffered.

This patch set is trying to address the issue by providing region of
memory suitable for consistent DMA operations. It is supposed that
such region is marked by MPU as non-cacheable. Robin suggested to
advertise such memory as reserved shared-dma-pool, rather then using
homebrew command line option, and extend dma-coherent to provide
default DMA area in the similar way as it is done for CMA (PATCH
2/5). It allows us to offload all bookkeeping on generic coherent DMA
framework, and it is seems that it might be reused by other
architectures like c6x and blackfin.

Dedicated DMA region is required for cases other than:
 - MMU/MPU is off
 - cpu is v7m w/o cache support
 - device is coherent

In case one of the above conditions is true dma operations are forced
to be coherent and wired with dma_noop_ops.

To make life easier NOMMU dma operations are kept in separate
compilation unit.

Since the issue was reported in the same time as Benjamin sent his
patch [1] to allow mmap for NOMMU, his case is also addressed in this
series (PATCH 1/5 and PATCH 3/5).

@Benjamin I've tested that mmap is working with amba-clcd and following
hack on top:

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 76c1ad9..64465c9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1492,6 +1492,24 @@ __releases(&info->lock)
        return 0;
 }
 
+static unsigned fb_capabilities(struct file *file)
+{
+       return NOMMU_MAP_DIRECT | NOMMU_MAP_READ | NOMMU_MAP_WRITE;
+}
+
+static unsigned long get_fb_unmapped_area(struct file *filp,
+                                  unsigned long addr, unsigned long len,
+                                  unsigned long pgoff, unsigned long flags)
+{
+       struct fb_info * const info = filp->private_data;
+       unsigned long fb_size = PAGE_ALIGN(info->fix.smem_len);
+
+       if (pgoff > fb_size || len > fb_size - pgoff)
+               return -EINVAL;
+
+       return (unsigned long)info->screen_base + pgoff;
+}
+
 static const struct file_operations fb_fops = {
        .owner =        THIS_MODULE,
        .read =         fb_read,
@@ -1503,13 +1521,12 @@ static const struct file_operations fb_fops = {
        .mmap =         fb_mmap,
        .open =         fb_open,
        .release =      fb_release,
-#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
        .get_unmapped_area = get_fb_unmapped_area,
-#endif
 #ifdef CONFIG_FB_DEFERRED_IO
        .fsync =        fb_deferred_io_fsync,
 #endif
        .llseek =       default_llseek,
+       .mmap_capabilities = fb_capabilities,
 };
 
 struct class *fb_class;

I can see that fb-test-app updates display and addresses returnend with
dma_alloc_cohernet() and mmap() are the same.

Thanks!

[1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1

Vladimir Murzin (5):
  dma: Add simple dma_noop_mmap
  drivers: dma-coherent: Introduce default DMA pool
  ARM: NOMMU: Introduce dma operations for noMMU
  ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
  ARM: dma-mapping: Remove traces of NOMMU code

 .../bindings/reserved-memory/reserved-memory.txt   |   3 +
 arch/arm/include/asm/dma-mapping.h                 |   3 +-
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm/mm/Makefile                               |   5 +-
 arch/arm/mm/dma-mapping-nommu.c                    | 252 +++++++++++++++++++++
 arch/arm/mm/dma-mapping.c                          |  26 +--
 drivers/base/dma-coherent.c                        |  59 ++++-
 lib/dma-noop.c                                     |  21 ++
 8 files changed, 335 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mm/dma-mapping-nommu.c

-- 
2.0.0
