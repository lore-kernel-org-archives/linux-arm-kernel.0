From: joelf@ti.com (Joel Fernandes)
Date: Sun, 21 Jul 2013 01:57:33 -0500
Subject: [RFC 0/5] EDMA: Support to DMA scatter-lists with any no. of entries
Message-ID: <1374389853-32458-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re: on-going discussion at [1], I've added support to EDMA driver to be
able to accept scatter gather lists of arbitrary length, but still make
use of only a certain MAX number of slots. Thus free-ing up the rest of
the slots to other slave users.  With this there is no need for slave
drivers to query the EDMA driver how much is the MAX. It can send SG lists
of any number of entries to DMA.

Tested with various number of MAX slots , even just "1". In the case where
it is 1, only 1-slot is used to transmit an entire set of scatter list.
If only 1 slot is used for a channel, there is a performance impact, but
it works. A DMA resources vs Performance tradeoff.

[1] http://marc.info/?l=linux-omap&m=137416733628831&w=2

Joel Fernandes (5):
  dma: edma: Setup parameters to DMA MAX_SG_NR at a time
  dma: edma: Write out and handle MAX_SG_NR at a given time
  ARM: edma: Add function to manually trigger an EDMA channel
  dma: edma: Find missed events and issue them
  DMA: EDMA: Leave linked to Null slot instead of DUMMY slot

 arch/arm/common/edma.c             |   21 +++++++
 drivers/dma/edma.c                 |  113 ++++++++++++++++++++++++++----------
 include/linux/platform_data/edma.h |    2 +
 3 files changed, 104 insertions(+), 32 deletions(-)

-- 
1.7.9.5
