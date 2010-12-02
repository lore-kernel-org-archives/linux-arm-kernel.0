From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:28 +0100
Subject: SPI support for CE4100, v2
Message-ID: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI core inside CE4100 is very much the same as in PXA25x.
I Cc the ARM folks because patch 4 reorganizes some files so that they
can be access from x86. Yes, CE4100 is a x86 SoC :)
The SPI device is behind a PCI bus. The PCI probe code simply creates a
platform device so we don't have much changes to the platform driver.
There is no clock framework on x86 and the peripherals don't support
changing their clocks or to enable/disable them. So I provided dummy
function which keep the driver happy.

History:
v1: initial post
v2: - the patch touching subys_inticall() got removed.
    - platform_driver_probe() is replaced with platform_driver_register()
    - there are no files created in include/asm.

The patch series has been created with the -M option so file moves can
be easily noticed. The whole series is also available at
  git://git.linutronix.de/users/bigeasy/soda.git spi

Sebastian Andrzej Siewior (9):
      spi/pxa2xx: register driver properly
      spi/pxa2xx: add support for shared IRQ handler
      spi/pxa2xx: Use define for SSSR_TFL_MASK instead of plain numbers
      arm/pxa2xx: reorgazine SSP and SPI header files
      spi/pxa2xx: Add CE4100 support
      spi/pxa2xx: Consider CE4100's FIFO depth
      spi/pxa2xx: Add chipselect support for Sodaville
      spi/pxa2xx: Modify RX-Tresh instead of busy-loop for the remaining RX bytes.
      spi/pxa2xx: pass of_node to spi device and set a parent device

 Documentation/spi/pxa2xx                           |    4 +-
 arch/arm/mach-pxa/cm-x255.c                        |    2 +-
 arch/arm/mach-pxa/cm-x270.c                        |    2 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/icontrol.c                       |    2 +-
 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h        |   47 -----
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/lubbock.c                        |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                          |    3 +-
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    1 -
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-pxa/zeus.c                           |    2 +-
 arch/arm/plat-pxa/ssp.c                            |    2 +-
 drivers/spi/Kconfig                                |   13 +-
 drivers/spi/Makefile                               |    1 +
 drivers/spi/pxa2xx_spi.c                           |  190 +++++++++++++------
 drivers/spi/pxa2xx_spi_pci.c                       |  201 ++++++++++++++++++++
 .../plat/ssp.h => include/linux/pxa2xx_ssp.h       |   39 +++-
 include/linux/spi/pxa2xx_spi.h                     |  152 +++++++++++++++
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 27 files changed, 547 insertions(+), 138 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
 create mode 100644 drivers/spi/pxa2xx_spi_pci.c
 rename arch/arm/plat-pxa/include/plat/ssp.h => include/linux/pxa2xx_ssp.h (90%)
 create mode 100644 include/linux/spi/pxa2xx_spi.h

Sebastian
