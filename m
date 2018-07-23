From: yibin.gong@nxp.com (Robin Gong)
Date: Tue, 24 Jul 2018 01:46:09 +0800
Subject: [PATCH v3 0/3] add memcpy support for sdma
Message-ID: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config by default, so that could test dma
easily without any other device support such as uart/audio/spi...

Change from v2:
  1. remove 'copy_align' since sdma script for memory_2_memory will handle
     such align issue. No such align limitation. Also remove bus width
     description in bd.
  2. for multi bds case such as in dmatest, should make sure all bds of 
     single transfer should be consistent, so enlarge allocated size for
     dma pool to max bds, 20 bds/1.28MB should be enough for all case.Report
     error if the bd number exceed 20.

Change from v1:
  1. remove bus_width check for memcpy since only max bus width needed for
     memcpy case to speedup copy.
  2. remove DMATEST support patch, since DMATEST is a common memcpy case.
  3. split to single patch for SDMA_BD_MAX_CNT instead of '0xffff'
  4. move sdma_config_ownership() from alloc_chan into sdma_prep_memcpy.
  5. address some minor review comments.

Robin Gong (3):
  dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
  dmaengine: imx-sdma: add memcpy interface
  dmaengine: imx-sdma: allocate max 20 bds for one transfer

 drivers/dma/imx-sdma.c | 121 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 9 deletions(-)

-- 
2.7.4
