From: elen.song@atmel.com (Elen Song)
Date: Fri, 10 May 2013 10:59:58 +0800
Subject: [PATCH 0/2 V4] DMA: AT91: Fix get residue function in at_hdmac.c 
Message-ID: <1368154798-9279-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The residue actually means the bytes remain in transfer identified by current cookie.
The get residue api did not return the correct values in at_hdmac.c.
This patch serial focus on fix the issue.

This patch serials is based on DMA: AT91: Get residual bytes in dma buffer v2.
It is split into 3 aimed patch, the first one is to get transmit buswidth,
the second one is to get resiude in cookie, it use the buswidth to get residual bytes,
the third part is to handle the status that there are still some bytes remain in dma fifo.

Compare to v2, this patch serials improve:
1) consider buswidth to get correct residue.
2) handle dma fifo empty status.

Compare to v3, this patch serials improve:
1) To state clearly, replace buswidth with transfer width.
2) Do not pause dma when get residue.
3) Let issue pending handler remain work if data remain in dma fifo, polling empty flag is too time consuming.

Elen Song (2):
  DMA: AT91: Get transfer width
  DMA: AT91: Get residual bytes in dma buffer

 drivers/dma/at_hdmac.c      |  151 ++++++++++++++++++++++++++++++++++++++-----
 drivers/dma/at_hdmac_regs.h |    5 ++
 2 files changed, 139 insertions(+), 17 deletions(-)

-- 
1.7.9.5
