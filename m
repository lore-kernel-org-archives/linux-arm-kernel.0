From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Sun, 2 Mar 2014 20:02:39 +0530
Subject: [RFC PATCH] EDAC support for ARM PL310 cache controller
Message-ID: <85311a4f-219e-4f3d-ab48-81fce8ef3443@VA3EHSMHS019.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  The following patch adds EDAC support for reporting the data and tag ram
parity errors for ARM PL310 cache controller.
As part of this driver implementtaion, the following options are considered
and this patch is implemented as described in option 3 

1. Enable the parity interrupts in cache-l2x0.c(pl310 driver) and notify the
parity errors based on error interrupt.
   This implementation is straight forward and no dependency with other
modules. But it is not utilizing the edac framework which meant for error
reproting

2. Move the edac chnages to cache-l2x0.c
    With this implementation, the edac farme work may not be ready
during this driver initilaization time. so this could be potential issue.

3. Create seperate driver for parity checking
   This implementaion looks organized. The edac driver always monitor the
status and never modify the control register values except for enabling the 
parity interrupts. But still in this case the pl310 platform device bind to
both the cache-l2x0.c and edac driver and both drivers share the same region.

The current implementation in cache-l2x0.c is not using the interrupts.if this
driver is going to use interrupts then that time the edac driver need modifications
for implementing shared irq mechanism.

So, i request your commnets on this patch and please suggest if there is a
better implemenattion than above.

Punnaiah Choudary Kalluri (1):
  edac: add support for PL310 L2 cache parity

 .../devicetree/bindings/edac/pl310_edac_l2.txt     |   19 ++
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/Makefile                              |    1 +
 drivers/edac/pl310_edac_l2.c                       |  236 ++++++++++++++++++++
 4 files changed, 263 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/pl310_edac_l2.txt
 create mode 100644 drivers/edac/pl310_edac_l2.c

-- 
1.7.4
