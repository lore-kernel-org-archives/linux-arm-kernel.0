From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 30 Oct 2015 10:00:35 +0200
Subject: [PATCH v2 0/3] dmaengine: ti-dma-crossbar: channel reserving and
 edma3-tpcc support
Message-ID: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1:
- Fixed issue introduced by the bitops patch: wrong error check, also switch to
  use find_first_zero_bit() instead of find_next_zero_bit()

Cover letter:

This series depends on the eDMA work I have done, which has been now applied:
https://lkml.org/lkml/2015/10/16/64

DRA7 family of chips have both sDMA and eDMA. Currently only sDMA can be used
becasue the old driver stack for eDMA did not allowed integration w/o hacks.

Due to the nature of eDMA the crossbar needs to know which eDMA events it can
use to map incoming events towards the eDMA. In eDMA a channel is wired to be
used with one specific event. For example eDMA event 14 can only be handled by
eDMA channel 14.
The eDMA itself can be shared by different processors in the system (ARM, DSP,
etc) and since ARM/Linux is the master we need to know which channels are used
by other cores. Also we need to mask out channels used for memcpy from the
events we use for HW triggers.

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr
  dmaengine: ti-dma-crossbar: dra7: Support for reserving DMA event
    ranges
  dmaengine: ti-dma-crossbar: dra7: Support for eDMA with new bindings

 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  6 ++
 drivers/dma/ti-dma-crossbar.c                      | 81 +++++++++++++++++++---
 2 files changed, 76 insertions(+), 11 deletions(-)

-- 
2.6.1
