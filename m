From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:14 +0200
Subject: [PATCH 00/23] work in progress: SPI controller w/DMA SAM9X5
Message-ID: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,
I said that I had some work done on sam9g35-ek, here is the spi part, based
on your and Jean-Christophe work.
You have to enable CONFIG_ARCH_AT91SAM9X5 to get it work.

The goal of this patchset is to share the work I've done, it's not ready
for upstream, but it may save some time.

It's based on 3.6-rc1 + Jean-Christophe's pinctrl patchset.

Best Regards,
Richard.

Jean-Christophe PLAGNIOL-VILLARD (3):
  of: add dma-mask binding
  of_spi: add generic binding support to specify cs gpio
  spi/atmel: add DT support

Nicolas Ferre (6):
  spi/atmel_spi: trivial: change some comments
  spi/atmel_spi: add physical base address
  spi/atmel_spi: call unmapping on transfers buffers
  spi/atmel_spi: status information passed through controller data
  spi/atmel_spi: add flag to controller data for lock operations
  spi/atmel_spi: add dmaengine support

Richard Genoud (14):
  spi-atmel: update with dmaengine interface
  spi-atmel: fix __init/__devinit sections mismatch
  spi-atmel: Fix spi-atmel driver to adapt to slave_config changes
  AT91 DMA OF support
  add at91sam9x5 Kconfig ARCH/SOC link
  spi-atmel: add DMA OF support
  [BUG] SPI: array out of bound => no CS
  [BUG] atmel-spi && DMA: OOPS if buffer > 4400 bytes
  sam9x5: declare SPI clocks
  spi-atmel: add sam9x5 SPI in device tree
  spi-atmel: add dma support in sam9x5 device tree
  spi-atmel OF: complete documentation
  spi-atmel: complete DMA slave OF documentation
  sam9x5ek DTS: enable SPI dataflash

 Documentation/devicetree/bindings/spi/spi-bus.txt  |    6 +
 .../devicetree/bindings/spi/spi_atmel.txt          |   46 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   42 ++
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |   10 +
 arch/arm/mach-at91/Kconfig                         |    4 +
 arch/arm/mach-at91/at91sam9x5.c                    |    3 +
 arch/arm/mach-at91/include/mach/at_hdmac.h         |    1 +
 drivers/of/Kconfig                                 |    4 +
 drivers/of/Makefile                                |    1 +
 drivers/of/of_atmel.c                              |  111 ++++
 drivers/of/platform.c                              |   23 +-
 drivers/spi/Kconfig                                |    9 +
 drivers/spi/spi-atmel.c                            |  611 ++++++++++++++++++--
 drivers/spi/spi.c                                  |   55 ++-
 include/linux/of_atmel.h                           |   29 +
 include/linux/spi/spi.h                            |    3 +
 16 files changed, 914 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
 create mode 100644 drivers/of/of_atmel.c
 create mode 100644 include/linux/of_atmel.h

-- 
1.7.2.5
