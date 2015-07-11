From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 14:12:03 +0200
Subject: [PATCH 0/4] PL08x DT bindings and LPC18xx DMA support
Message-ID: <1436616727-4847-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

This is the non-RFC version of the patch set with only a few changes.
Hope this can go in for 4.3. Changes to the DT for LPC18xx/43xx will
go thru arm-soc once this get accepted.


This patch set aims to add support for DMA on the NXP LPC18xx/43xx
(Cortex-M3/M4) platform. The platform has a PL080 controller with a
mux in front of the DMA request lines. This setup is quite common
and can be found on most other, if not all, NXP LPC devices.

Patch set adds DT support for the PL08x dmaengine driver and a DMA
router driver for the LPC18xx/43xx DMA multiplexer.

DT support for the PL08x was originally written by Linus Walleij and
can be found on the link below.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286866.html

Changes since RFC:
 - remove some useless headers from dmamux driver.
 - turn a dev_info into dev_dbg in dmamux driver.

The following changes has since been made to the pl08x dt patch by
Linus:
 - move AHB master setting into dma specifier as
   suggested by Arnd [1].
 - remove channel sub-nodes from driver and dt doc.
 - dynamically allocate dma channels in xlate
   function as outlined by Arnd [2].
 - address some minor comments from Arnd in [1].
 - minor misc clean ups (white space + include order).

Patch set successfully tested on 8250 UART (TX) with DMA support on
Embedded Artists' LPC4357 Developer's Kit.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287834.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286150.html


Joachim Eastwood (2):
  dmaengine: add driver for lpc18xx dmamux
  doc: dt: dma: add bindings for lpc1850-dmamux

Linus Walleij (2):
  dmaengine: pl08x: support dt channel assignment
  doc: dt: dma: add binding doc for pl08x

 .../devicetree/bindings/dma/arm-pl08x.txt          |  54 ++++++
 .../devicetree/bindings/dma/lpc1850-dmamux.txt     |  54 ++++++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amba-pl08x.c                           | 192 ++++++++++++++++++++-
 drivers/dma/lpc18xx-dmamux.c                       | 183 ++++++++++++++++++++
 6 files changed, 490 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
 create mode 100644 Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
 create mode 100644 drivers/dma/lpc18xx-dmamux.c

-- 
1.8.0
