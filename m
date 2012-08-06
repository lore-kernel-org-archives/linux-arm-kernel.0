From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Mon,  6 Aug 2012 18:55:20 +0900
Subject: [PATCH v3 0/4] Use dma_mmap_coherent to support IOMMU mapper
Message-ID: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a dma_mmap_coherent() API in some architectures.  This API
provides a mmap function for memory allocated by dma_alloc_coherent().
Some drivers mmap a dma_addr_t returned by dma_alloc_coherent() as a
physical address.  But such drivers do not work correctly when IOMMU
mapper is used.

v3:
- Remove an unnecessary line which sets page protection bits.
v2:
- Rebase on fbdev-next branch of
  git://github.com/schandinat/linux-2.6.git.
- Initialize .fb_mmap in both sh_mobile_lcdc_overlay_ops and
  sh_mobile_lcdc_ops.
- Add Laurent's clean up patch.

Hideki EIRAKU (3):
  ARM: dma-mapping: define ARCH_HAS_DMA_MMAP_COHERENT
  media: videobuf2-dma-contig: use dma_mmap_coherent if available
  fbdev: sh_mobile_lcdc: use dma_mmap_coherent if available

Laurent Pinchart (1):
  ALSA: pcm - Don't define ARCH_HAS_DMA_MMAP_COHERENT privately for ARM

 arch/arm/include/asm/dma-mapping.h         |    1 +
 drivers/media/video/videobuf2-dma-contig.c |   17 +++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c           |   28 ++++++++++++++++++++++++++++
 sound/core/pcm_native.c                    |    7 -------
 4 files changed, 46 insertions(+), 7 deletions(-)
