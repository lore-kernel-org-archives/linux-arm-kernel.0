From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 3 Apr 2013 13:56:21 +0800
Subject: [PATCH v8 0/8] spi/spi-atmel: add dmaengine support for atmel spi
 controller and to test the device tree support
Message-ID: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, 

The work is based on Nicolas and Richard's work.

It is based on v3.9-rc5 
	+ Joachim Eastwood's spi/atmel: fix speed_hz check in atmel_spi_transfer()
	+ the following four patches of the version 7 series, which you've applied.
		- detect the capabilities of SPI core by reading the VERSION register
		- add support transfer on CS1,2,3, not only on CS0
		- call unmapping on transfers buffers
		- status information passed through controller data

As per your suggestion, do some change for the patches.

Thanks a lot for your work.

Best Regards
Wenyou Yang


Changelog:
v8:
     1 ./ squash the following two patches into dmaengine patch.
     	   - fix spi-atmel driver to adapt to slave_config changes
	   - correct 16 bits transfers with DMA.
     2./ Add some commit log for patches.

v7:
     1./ remove patch: fix probing failure after xfer->speed_hz set.
     2./ remove patch: add pinctrl support for atmel spi.

v6:
     1./ remove: fix master->num_chipselect wrongly set patch which isn't a issue in v3.9-rc1.
     2./ fix probing failure after xfer->speed_hz set.

v5:
     1./ add pinctrl patches.
     2./ detect capabilities by reading spi version register to replace multiple compatiles.
     3./ change the "cs-gpios" property of spi node.
     4./ rebase on v3.8.

v4:
     1./ Take Joe Perches's adivce, rewrite atmel_spi_is_v2(struct atmel_spi *as) 
         and atmel_spi_use_dma(struct atmel_spi *as),
	 and remove atmel_spi_use_pdc(struct atmel_spi *as).
     2./ Rebase on v3.8-rc3.

V3:
     1./ Rebase on v3.8-rc2.
     2./ Remove some Jean-Christophe's patches which has been applied on v3.8-rc2.
     3./ Remove spi property "cs-gpios" from the SoC dtsi files to the board dts files
         to avoid some useless pin conflicts.

v2: 
     1./ Remove the patch :PATCH]mtd: m25p80: change the m25p80_read to reading page to page
	 which purpose to fix the BUG: when run "flashcp /bin/busybox /dev/mtdX" in the at91sam9g25ek
	 with DMA mode, it arises a OOPS. Now fix it in this patch:
	    [PATHC] spi/atmel_spi: add dmaengine support changing to fix the [BUG].
     2./ Remove two patches:
   	    which purpose to read dts property to select SPI IP version and DMA mode
	    Now they will be gat from device tree different compatile.
     3./ Fix DMA: when enable both spi0 AND spi1, the spi0 doesn't work BUG.
     4./ Rebase v3.7-rc8.


Nicolas Ferre (3):
  spi/spi-atmel: add physical base address
  spi/spi-atmel: add flag to controller data for lock operations
  spi/spi-atmel: add dmaengine support

Richard Genoud (4):
  spi/spi-atmel: BUG: fix doesn' support 16 bits transfers using PIO
  ARM: at91: add clocks for spi dt entries
  ARM: dts: add spi nodes for atmel SoC
  ARM: dts: add spi nodes for the atmel boards

Wenyou Yang (1):
  ARM: dts: add pinctrl property for spi node for atmel SoC

 arch/arm/boot/dts/at91sam9260.dtsi          |   40 ++
 arch/arm/boot/dts/at91sam9263.dtsi          |   40 ++
 arch/arm/boot/dts/at91sam9263ek.dts         |   10 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   10 +
 arch/arm/boot/dts/at91sam9g45.dtsi          |   40 ++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   10 +
 arch/arm/boot/dts/at91sam9n12.dtsi          |   40 ++
 arch/arm/boot/dts/at91sam9n12ek.dts         |   10 +
 arch/arm/boot/dts/at91sam9x5.dtsi           |   40 ++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   10 +
 arch/arm/mach-at91/at91sam9260.c            |    2 +
 arch/arm/mach-at91/at91sam9g45.c            |    2 +
 arch/arm/mach-at91/at91sam9n12.c            |    2 +
 arch/arm/mach-at91/at91sam9x5.c             |    2 +
 drivers/spi/spi-atmel.c                     |  653 +++++++++++++++++++++++++--
 15 files changed, 876 insertions(+), 35 deletions(-)

-- 
1.7.9.5
