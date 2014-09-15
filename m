From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 15 Sep 2014 16:50:20 +0200
Subject: [PATCH v4 0/2] new Atmel DMA controller
Message-ID: <1410792622-22621-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches introduces support for the new Atmel DMA controller know as
XDMAC and available on SAMA5D4.

Driver updated according to Vinod's comments.

Still wondering if a new binding is needed or not. It's very close to hdma
binding, the only change is the content of the second cell.

Changes from:
- v3
  - use dma_get_any_slave_channel instead of dma_request_channel
  - fix tx_status behavior for non active transfers
  - rename at_xdmac_terminate_xfer
  - replace suspend/resume no irq variants by late/early variants
  - no more use dev res to request the irq, use the legacy way
  - add slave capabilities
- v2
  - documentation updated
  - fix locking issues
- v1
  - add power management stuff
  - check maxburst value
  - revert subsys_initcall remove, EPROBE_DEFER not yet available on the kernel
  version I use to do the tests, moreover other devices are not ready to use it
- RFC:
  - DMA_SUCCESS replaced by DMA_COMPLETE
  - fix memcpy issue caused by a mistake in interfaces used
  - add filter function
  - remove some parameters from device tree since we can get them through the
  dma slave configuration
  - use readl/writel relaxed
  - remove subsys_initcall
  - synchronize irq before killing tasklets
  - use BIT macro
  - misc cleanup

Ludovic Desroches (2):
  dma: at_xdmac: creation of the atmel eXtended DMA Controller driver
  ARM: dts: at_xdmac: add bindings documentation

 .../devicetree/bindings/dma/atmel-xdma.txt         |   48 +
 drivers/dma/Kconfig                                |    7 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/at_xdmac.c                             | 1210 ++++++++++++++++++++
 drivers/dma/at_xdmac.h                             |  308 +++++
 include/dt-bindings/dma/at91.h                     |   25 +
 6 files changed, 1599 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt
 create mode 100644 drivers/dma/at_xdmac.c
 create mode 100644 drivers/dma/at_xdmac.h

-- 
2.0.3
