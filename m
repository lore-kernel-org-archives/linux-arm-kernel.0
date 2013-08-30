From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Aug 2013 10:07:21 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
Message-ID: <1377828449-18912-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is based on Li Xiaochun's init version.
http://marc.info/?l=linux-arm-kernel&m=137181252311126&w=2

(0) What is the Quadspi controller?

    The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
    one single or two external serial flash devices, each with up to 4
    bidirectional data lines.

(1) The Quadspi controller is driven by the LUT(Look-up Table) registers.
    The LUT registers are a look-up-table for sequences of instructions.
    A valid sequence consists of four LUT registers.

(2) The definition of the LUT register shows below:

    ---------------------------------------------------
    | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
    ---------------------------------------------------

    There are several types of INSTRx, such as:
    	CMD	: the SPI NOR command.
	ADDR	: the address for the SPI NOR command.
	DUMMY	: the dummy cycles needed by the SPI NOR command.
	....

(3) We connect the NOR the QuadSPI now. I am not sure, but i think the
    QuadSPI will be only used for the NOR. We may connect other devices
    to it. But, for the reason of (2), we have to parse out the SPI NOR
    command for the QuadSPI.

(4) Test this driver with the JFFS2 and UBIFS with the Spansion s25fl128s :

    For jffs2:
         #flash_eraseall /dev/mtd0
         #mount -t jffs2 /dev/mtdblock0 tmp
         #bonnie++ -d tmp -u 0 -s 10 -r 5

    For ubifs:
         #flash_eraseall /dev/mtd0
    	 #ubiattach /dev/ubi_ctrl -m 0
    	 #ubimkvol /dev/ubi0 -N test -m
         #mount -t ubifs ubi0:test tmp
         #bonnie++ -d tmp -u 0 -s 10 -r 5

 (5) The test result of the DDR QUAD Read (66MHz) performance:
        #insmod mtd_speedtest.ko dev=0

	[  194.831313] =================================================
	[  194.825453] mtd_speedtest: MTD device: 0
	[  194.818670] mtd_speedtest: not NAND flash, assume page size is 512 bytes.
	[  194.811705] mtd_speedtest: MTD device size 16777216, eraseblock size 65536,
               page size 512, count of eraseblocks 256, pages per eraseblock 128, OOB size 0
	[  228.482355] mtd_speedtest: testing eraseblock write speed
	[  213.024166] mtd_speedtest: eraseblock write speed is 203 KiB/s
	[  213.018306] mtd_speedtest: testing eraseblock read speed
	[  212.660856] mtd_speedtest: eraseblock read speed is 46545 KiB/s
	[  181.728267] mtd_speedtest: testing page write speed
	[  231.434842] mtd_speedtest: page write speed is 203 KiB/s
	[  231.429515] mtd_speedtest: testing page read speed
	[  228.957422] mtd_speedtest: page read speed is 6641 KiB/s
	[  197.778872] mtd_speedtest: testing 2 page write speed
	[  247.338069] mtd_speedtest: 2 page write speed is 203 KiB/s
	[  247.332514] mtd_speedtest: testing 2 page read speed
	[  245.925048] mtd_speedtest: 2 page read speed is 11686 KiB/s
	[  245.919460] mtd_speedtest: Testing erase speed
	[  214.612341] mtd_speedtest: erase speed is 523 KiB/s
	[  214.607410] mtd_speedtest: Testing 2x multi-block erase speed
	[  245.545971] mtd_speedtest: 2x multi-block erase speed is 480 KiB/s
	[  245.539744] mtd_speedtest: Testing 4x multi-block erase speed
	[  211.141696] mtd_speedtest: 4x multi-block erase speed is 476 KiB/s
	[  211.135496] mtd_speedtest: Testing 8x multi-block erase speed
	[  241.761502] mtd_speedtest: 8x multi-block erase speed is 475 KiB/s
	[  241.755269] mtd_speedtest: Testing 16x multi-block erase speed
	[  272.307979] mtd_speedtest: 16x multi-block erase speed is 474 KiB/s
	[  272.301660] mtd_speedtest: Testing 32x multi-block erase speed
	[  237.637902] mtd_speedtest: 32x multi-block erase speed is 472 KiB/s
	[  237.631581] mtd_speedtest: Testing 64x multi-block erase speed
	[  267.954341] mtd_speedtest: 64x multi-block erase speed is 471 KiB/s
	[  267.948005] mtd_speedtest: finished
	[  267.944478] =================================================

     * Conclusion *:
     --------------------------------------------------------------------
       We can get the 46.5 MiB/s read speed when the DDR Quad Read is enabled.
	 (From S25FL128S's spec, the maximum read rate of DDR Quad Read is
	 66MiB/s)
     --------------------------------------------------------------------

Changelog:
 v2 --> v3:
 	[1] use the "num-cs" property, and remove the "fsl,spi-num-chipselects".
	[2] remove the redundant log.

 v1 --> v2:
	[1] add DDR QUAD read support. 
	[2] add the support for two NOR chips
	[3] misc.

init --> v1:
 	[1] since the ic bug in the IPS read,
            abandon the IPS read, use the AHB read.
	[2] change the mtd code, add the quad read support.
	[3] add the quad read support the QuadSpi driver.
	[4] misc.


Huang Shijie (8):
  mtd: m25p80: move the spi-nor commands to a header
  mtd: m25p80: add support for Spansion s25fl128s chip
  mtd: m25p80: add the quad-read support
  mtd: m25p80: add the DDR quad-read support
  spi: Add Freescale QuadSpi driver
  Documentation: add the binding file for Quadspi driver
  ARM: dts: vf610: change the PAD values for Quadspi
  ARM: dts: vf610-twr: Add SPI NOR support

 Documentation/devicetree/bindings/mtd/m25p80.txt   |   10 +
 .../devicetree/bindings/spi/fsl-quadspi.txt        |   32 +
 arch/arm/boot/dts/vf610-twr.dts                    |   36 +
 arch/arm/boot/dts/vf610.dtsi                       |   24 +-
 drivers/mtd/devices/m25p80.c                       |  116 ++-
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-fsl-quadspi.c                      | 1031 ++++++++++++++++++++
 include/linux/mtd/spi-nor.h                        |   61 ++
 9 files changed, 1265 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-quadspi.txt
 create mode 100644 drivers/spi/spi-fsl-quadspi.c
 create mode 100644 include/linux/mtd/spi-nor.h
