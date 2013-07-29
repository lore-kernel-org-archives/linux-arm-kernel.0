From: joelf@ti.com (Joel Fernandes)
Date: Mon, 29 Jul 2013 08:29:46 -0500
Subject: [PATCH 0/9] dma: edma: Support scatter-lists of any length
Message-ID: <1375104595-16018-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds support to EDMA driver to enable DMA of
scatter-gather lists of arbitrary length, but still make use of only
a certain MAX number of slots at a time for a given channel. Thus
free-ing up the rest of the slots to other slaves/channels.  With this
there is no need for slave drivers to query the EDMA driver about how
much is the MAX it can send at a time as done in [1]. Drivers can send
SG lists of any number of entries to DMA. Reference discussion at [2].

Tested omap-aes and omap_hsmmc drivers with different MAX number of slots,
even just 1. In the case where it is 1, only 1-slot is used to DMA an
entire scatter list of arbitrary length.
Since this series touches EDMA private API code also shared with davinci-pcm,
playback of a 16-bit 44.1KHz audio file with davinci-pcm has been tested.

Sample test run with 1 vs 16 (MAX number of slots/SG) in omap-aes driver:
MAX slots = 1:
 (128 bit key, 8192 byte blocks): 1266 operations in 1 seconds (10371072 bytes)
MAX slots = 16:
 (128 bit key, 8192 byte blocks): 1601 operations in 1 seconds (13115392 bytes)

Note: For the above test, 8K buffer is mapped into SG list of size 2 so
only 2 slots are required. So beyond size 2, there will not be any noticeable
performance improvement. But using 1 slot is even managed by just DMA'ing 1 SG
entry at a time.

[1] https://lkml.org/lkml/2013/7/18/432
[2] http://marc.info/?l=linux-omap&m=137416733628831&w=2

Joel Fernandes (9):
  dma: edma: Setup parameters to DMA MAX_NR_SG at a time
  dma: edma: Write out and handle MAX_NR_SG at a given time
  ARM: edma: Add function to manually trigger an EDMA channel
  dma: edma: Find missed events and issue them
  dma: edma: Leave linked to Null slot instead of DUMMY slot
  dma: edma: Detect null slot errors and handle them correctly
  ARM: edma: Don't clear EMR of channel in edma_stop
  dma: edma: Link to dummy slot only for last SG list split
  dma: edma: remove limits on number of slots

 arch/arm/common/edma.c             |   22 ++++-
 drivers/dma/edma.c                 |  157 +++++++++++++++++++++++++++---------
 include/linux/platform_data/edma.h |    2 +
 3 files changed, 142 insertions(+), 39 deletions(-)

-- 
1.7.9.5
