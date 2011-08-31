From: msalter@redhat.com (Mark Salter)
Date: Wed, 31 Aug 2011 17:30:11 -0400
Subject: [PATCH 0/3] RFC: addition to DMA API
Message-ID: <1314826214-22428-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set arose out of a discussion on linux-arm concerning a
performance problem with USB on some ARMv7 based platforms. The
problem was tracked down by ming.lei at canonical.com and found to be
the result of CPU writes to DMA-coherent memory being delayed in a
write buffer between the CPU and memory. One proposed patch fixed
only the immediate problem with the USB EHCI driver, but several
folks thought a more general approach was needed, so I put this series
of patches together as a starting point for wider discussion outside
the ARM specific list.

The original problem seen was that USB storage performance was unusually
poor on some ARMv7 based platforms. With my particular setup, I was
seeing hdparm -t report ~5.6MB/s on an SMP Cortex-A9 based platform
where the same disk driver would get ~21MB/s on a Cortex-A8 based system.
My understanding from subsequent discussion is that the A9 cores have
a write buffer between the CPU and memory which could buffer data for a
prolonged period even in the case of DMA coherent mappings. The ARM
architecture code largely mitigates this by doing a write buffer flush
as part of the MMIO functions used to write to device registers. This
avoids problems in almost all drivers because most need to write to a
device register to tell the device when something is written in the
shared DMA coherent memory. In the case of USB, an EHCI host controller
will poll certain DMA coherent memory locations for information coming
from the CPU. In that case, the write buffering negatively affects
performance.

This series of patches adds a new function to the DMA API to deal with
ARMv7 and any future architectures which have write buffering even for
DMA coherent memory. The proposed dma_coherent_write_sync() function
will allow those few drivers which need it to force out write buffer
data in a timely way to avoid performace issues.

Mark Salter (3):
  add dma_coherent_write_sync to DMA API
  define ARM-specific dma_coherent_write_sync
  add dma_coherent_write_sync calls to USB EHCI driver

 Documentation/DMA-API-HOWTO.txt    |   15 +++++++++++++++
 Documentation/DMA-API.txt          |   12 ++++++++++++
 arch/arm/include/asm/dma-mapping.h |   10 ++++++++++
 drivers/usb/host/ehci-q.c          |    7 ++++++-
 include/linux/dma-mapping.h        |    6 ++++++
 5 files changed, 49 insertions(+), 1 deletions(-)

-- 
1.7.6
