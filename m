From: brian.starkey@arm.com (Brian Starkey)
Date: Mon,  8 Feb 2016 17:30:49 +0000
Subject: [RESEND2 PATCH 0/3] Fix kernel panic in dma-coherent
Message-ID: <cover.1454950917.git.brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm resending these again to try and garner some interest. Without
this series, dma-coherent cannot be used on arm64 platforms. The
decision to add MEMREMAP_WC came out of a previous discussion with
Dan Williams and Catalin Marinas about the same problem[1].

These patches implement a MEMREMAP_WC flag for memremap(), which can
be used to obtain writecombine mappings. This is then used for setting
up dma_coherent_mem regions which use the DMA_MEMORY_MAP flag.
They apply cleanly on 4.5-rc3.

Patch 3 makes sure that the appropriate memset function is used
when zeroing coherent allocations, which fixes an alignment fault on
arm64.

Best Regards,
Brian

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390857.html

Brian Starkey (3):
  memremap: add MEMREMAP_WC flag
  drivers: dma-coherent: use MEMREMAP_WC for DMA_MEMORY_MAP
  drivers: dma-coherent: use memset_io for DMA_MEMORY_IO

 drivers/base/dma-coherent.c |   25 ++++++++++++++++++++-----
 include/linux/io.h          |    1 +
 kernel/memremap.c           |   15 +++++++++++++--
 3 files changed, 34 insertions(+), 7 deletions(-)

-- 
1.7.9.5
