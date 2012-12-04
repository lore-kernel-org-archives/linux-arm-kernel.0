From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue,  4 Dec 2012 15:53:46 +0800
Subject: [v2 PATCH 00/14] atmel SPI controller with dmaengine and device tree
 support
Message-ID: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All, 

This set of patches is to add dmaengine and device tree support for atmel spi.
The work is based on Jean-Christophe, Nicolas and Richard's work.
I tested it on at91sam9x5ek, at91sam9m10g45ek.

It is based on v3.7-rc8.

Changelog:
v2: 
   1./ Remove the patch :PATCH]mtd: m25p80: change the m25p80_read to reading page to page
	which purpose to fix the BUG: when run "flashcp /bin/busybox /dev/mtdX" in 
	the at91sam9g25ek with DMA mode, it arises a OOPS. 
	Now fix it in this patch:
	[PATHC] spi/atmel_spi: add dmaengine support changing to fix the [BUG].

   2./ Remove two patches:
   	which purpose to read dts property to select SPI IP version and DMA mode
	Now they will be gat from device tree different compatile.

   3./ Fix DMA: when enable both spi0 AND spi1, the spi0 doesn't work BUG.

   4./ Rebase v3.7-rc8.

Best Regards,
Wenyou Yang.


Jean-Christophe PLAGNIOL-VILLARD (3):
  of: add dma-mask binding
  of_spi: add generic binding support to specify cs gpio
  spi/atmel_spi: add DT support

Nicolas Ferre (5):
  spi/atmel_spi: add physical base address
  spi/atmel_spi: call unmapping on transfers buffers
  spi/atmel_spi: status information passed through controller data
  spi/atmel_spi: add flag to controller data for lock operations
  spi/atmel_spi: add dmaengine support

Richard Genoud (6):
  spi/atmel_spi: Fix spi-atmel driver to adapt to slave_config changes
  spi/atmel_spi: correct 16 bits transfers using PIO
  spi/atmel_spi: correct 16 bits transfer with DMA
  ARM: at91: add clocks for spi DT entries
  ARM: dts: add spi nodes for atmel SoC
  ARM: dts: add spi nodes for atmel boards

 Documentation/devicetree/bindings/spi/spi-bus.txt  |    6 +
 .../devicetree/bindings/spi/spi_atmel.txt          |   23 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   30 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   30 +
 arch/arm/boot/dts/at91sam9263ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    9 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   30 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    9 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   30 +
 arch/arm/boot/dts/at91sam9n12ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   30 +
 arch/arm/mach-at91/at91sam9260.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9n12.c                   |    2 +
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +
 drivers/of/platform.c                              |   23 +-
 drivers/spi/spi-atmel.c                            |  793 ++++++++++++++++++--
 drivers/spi/spi.c                                  |   55 +-
 include/linux/spi/spi.h                            |    3 +
 20 files changed, 1033 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

-- 
1.7.9.5
