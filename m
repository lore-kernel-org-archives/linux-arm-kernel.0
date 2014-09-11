From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 11 Sep 2014 13:22:38 +0200
Subject: [PATCH v2 0/3] CMA & device tree, another approach
Message-ID: <1410434561-9294-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is another approach to finish support for reserved memory regions
defined in device tree. Previous attempts 
(http://lists.linaro.org/pipermail/linaro-mm-sig/2014-February/003738.html
and https://lkml.org/lkml/2014/7/14/108) ended in merging parts of the
code and documentation. Merged patches allow to reserve memory, but
there is still no reserved memory drivers nor any code that actually
uses reserved memory regions.

The final conclusion from the above mentioned threads is that there is
no automated reserved memory initialization. All drivers that want to
use reserved memory, should initialize it on their own.

This patch series provides two driver for reserved memory regions (one
based on CMA and one based on dma_coherent allocator). The main
improvement comparing to the previous version is removal of automated
reserved memory for every device and support for named memory regions.

Those patches are for merging, rebased on top of recent linux-next tree.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changes since v1 (https://lkml.org/lkml/2014/8/26/339):
- removed patches for named reserved regions - they will be discussed
  separately
- added a check for 'no-map' property to dma coherent allocator
  (suggested by Laura Abbott)
- removed example code for s5p-mfc driver

Changes since '[PATCH v2 RESEND 0/4] CMA & device tree, once again' version:
(https://lkml.org/lkml/2014/7/14/108)
- added return error value to of_reserved_mem_device_init()
- added support for named memory regions (so more than one region can be
  defined per device)
- added usage example - converted custom reserved memory code used by
  s5p-mfc driver to the generic reserved memory handling code

Patch summary:

Marek Szyprowski (3):
  drivers: of: add return value to of_reserved_mem_device_init
  drivers: dma-coherent: add initialization from device tree
  drivers: dma-contiguous: add initialization from device tree

 drivers/base/dma-coherent.c     | 145 ++++++++++++++++++++++++++++++++++------
 drivers/base/dma-contiguous.c   |  71 ++++++++++++++++++++
 drivers/of/of_reserved_mem.c    |   3 +-
 include/linux/cma.h             |   3 +
 include/linux/of_reserved_mem.h |   9 ++-
 mm/cma.c                        |  62 ++++++++++++++---
 6 files changed, 259 insertions(+), 34 deletions(-)

-- 
1.9.2
