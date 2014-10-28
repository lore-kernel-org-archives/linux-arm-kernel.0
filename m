From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Oct 2014 12:08:46 -0700
Subject: DMA allocations from CMA and fatal_signal_pending check
Message-ID: <544FE9BE.6040503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While debugging why some dma_alloc_coherent() allocations where
returning NULL on our brcmstb platform, specifically with
drivers/net/ethernet/broadcom/bcmcsysport.c, I came across the
fatal_signal_pending() check in mm/page_alloc.c which is there.

This driver calls dma_alloc_coherent(, GFP_KERNEL) which ends up making
a coherent allocation from a CMA region on our platform. Since that
allocation is allowed to sleep, and because we are in bcm_syport_open(),
executed from process context, a pending signal makes
dma_alloc_coherent() return NULL.

There are two ways I could fix this:

- use a GFP_ATOMIC allocation, which would avoid this sensitivity to a
pending signal being fatal (we suffer from the same issue in
bcm_sysport_resume)

- move the DMA coherent allocation before bcm_sysport_open(), in the
driver's probe function, but if the network interface is never used, we
would be waisting precious DMA coherent memory for nothing (it is only 4
bytes times 32 but still

Now the general problem that I see with this fatal_signal_pending()
check is that any driver that calls dma_alloc_coherent() and which does
this in a process context (network drivers are frequently doing this in
their ndo_open callback) and also happens to get its allocation serviced
from CMA can now fail, instead of failing on really hard OOM conditions.
--
Florian
