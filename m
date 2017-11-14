From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:02 +0200
Subject: [PATCH 00/10] dmaengine: fix race with vchan_complete
Message-ID: <20171114143212.8311-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With the introduction of .device_synchronize callback it was thought that the
race caused crash observed in vchan_complete is fixed, but unfortunately it can
still happen.

The observed scenario (really hard to reproduce) is:
Cyclic mode
- DMA period interrupt
 - call to vchan_cyclic_callback() which sets vc->cyclic to vd and schedules the
   vchan_complete tasklet
- .terminate_all is called
 - we make sure that no further DMA irqs are going to be handled, but the
   tasklet had been already scheduled
 - we free up the descriptor to avoid leaking memory
- the vchan_complete tasklet starts to execute and it checks vc->cyclic, which
  is not NULL, saves the vd pointer (which points to an already freed up memory)
  and try to access it later to call the callback
- the tasklet_kill() in .device_synchronize will make sure that the tasklet is
  going to finish it's execution if it is already scheduled, it can only help if
  the tasklet is yet to be executed.

At this point it is just matter of luck if the vc->cyclic is still pointing to
an unchanged memory location or it is taken into use and thus it is corrupted.

My first approach was to just set vc->cyclic to NULL in the .terminate_all
callback, but that still have theoritical race: if the vchan_complete is
executing and it saves the vd from vc->cyclic (protected by the vc->lock). If at
that point the .terminate_all is called it will wait for the lock and start
executing. _if_ the .terminate_all free up the vd before the vchan_complete
reaches the point when it is going to call the callback, then we have the race.

The series will do this:
- the drivers should call vchan_terminate_vdesc() instead of directly freeing up
  the descriptor. vchan_terminate_vdesc() will save the vd as vc->vd_terminated
  and will set the vc->cyclic to NULL, all while holding the lock.
- the drivers must implement the .device_synchronize callback and within the
  vchan_synchronize() we free up the vc->vd_terminated after we killed the
  tasklet.

I have tested this on platforms using TI's eDMA and sDMA and have not seen any
side effect so far and a client tested similar set on a setup where it was easy
to reproduce the race.

By looking for similar patterns in other drivers I have implemented the fix for
the ones where it looked straight forward.

Regards,
Peter
---
Peter Ujfalusi (10):
  dmaengine: virt-dma: Add helper to free/reuse a descriptor
  dmaengine: virt-dma: Support for race free transfer termination
  dmaengine: omap-dma: Use vchan_terminate_vdesc() instead of desc_free
  dmaengine: edma: Use vchan_terminate_vdesc() instead of desc_free
  dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of
    desc_free
  dmaengine: dma-jz4780: Use vchan_terminate_vdesc() instead of
    desc_free
  dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of
    desc_free
  dmaengine: img-mdc-dma: Use vchan_terminate_vdesc() instead of
    desc_free
  dmaengine: k3dma: Use vchan_terminate_vdesc() instead of desc_free
  dmaengine: s3c24xx-dma: Use vchan_terminate_vdesc() instead of
    desc_free

 drivers/dma/amba-pl08x.c  | 11 ++++++++++-
 drivers/dma/bcm2835-dma.c | 10 +++++++++-
 drivers/dma/dma-jz4780.c  | 10 +++++++++-
 drivers/dma/edma.c        |  7 ++-----
 drivers/dma/img-mdc-dma.c | 17 ++++++++++++-----
 drivers/dma/k3dma.c       | 10 +++++++++-
 drivers/dma/omap-dma.c    |  2 +-
 drivers/dma/s3c24xx-dma.c | 11 ++++++++++-
 drivers/dma/virt-dma.c    |  5 +----
 drivers/dma/virt-dma.h    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 107 insertions(+), 20 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
