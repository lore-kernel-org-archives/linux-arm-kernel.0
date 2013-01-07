From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon,  7 Jan 2013 09:50:01 +0800
Subject: [v3 PATCH 00/12] atmel spi controller with dmaengine and device tree
 support
Message-ID: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All, 

This set of patches is to add dmaengine and device tree support for atmel spi.
The work is based on Nicolas and Richard's work.
It is tested on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and at91sam9g20ek.

It is based on v3.8-rc2.

Changelog:
V3:
	1./ Rebase on v3.8-rc2.

	2./ Remove some Jean-Christophe's patches which has been
	    applied on v3.8-rc2.

	3./ Remove spi property "cs-gpios" from the SoC dtsi files
	    to the board dts files to avoid some useless pin conflicts.

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

Nicolas Ferre (5):
  spi/atmel_spi: add physical base address
  spi/atmel_spi: call unmapping on transfers buffers
  spi/atmel_spi: status information passed through controller data
  spi/atmel_spi: add flag to controller data for lock operations
  spi/atmel_spi: add dmaengine support

Richard Genoud (6):
  spi/atmel_spi: fix spi-atmel driver to adapt to slave_config changes
  spi/atmel_spi: correct 16 bits transfers using PIO
  spi/atmel_spi: correct 16 bits transfer with DMA
  ARM: at91: add clocks for spi dt entries
  ARM: dts: add spi nodes for atmel SoC
  ARM: dts: add spi nodes for the atmel boards

Wenyou Yang (1):
  spi/atmel_spi: update the dt support

 arch/arm/boot/dts/at91sam9260.dtsi          |   18 +
 arch/arm/boot/dts/at91sam9263.dtsi          |   18 +
 arch/arm/boot/dts/at91sam9263ek.dts         |   14 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   14 +
 arch/arm/boot/dts/at91sam9g45.dtsi          |   18 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   14 +
 arch/arm/boot/dts/at91sam9n12.dtsi          |   18 +
 arch/arm/boot/dts/at91sam9n12ek.dts         |   14 +
 arch/arm/boot/dts/at91sam9x5.dtsi           |   18 +
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   14 +
 arch/arm/mach-at91/at91sam9260.c            |    2 +
 arch/arm/mach-at91/at91sam9g45.c            |    2 +
 arch/arm/mach-at91/at91sam9n12.c            |    2 +
 arch/arm/mach-at91/at91sam9x5.c             |    2 +
 drivers/spi/spi-atmel.c                     |  823 ++++++++++++++++++++++++---
 15 files changed, 922 insertions(+), 69 deletions(-)

-- 
1.7.9.5
