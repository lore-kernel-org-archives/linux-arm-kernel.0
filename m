From: b32955@freescale.com (Huang Shijie)
Date: Mon, 19 Aug 2013 12:09:58 +0800
Subject: [PATCH V1 0/5] Add the Quadspi driver for vf610-twr
Message-ID: <1376885403-12156-1-git-send-email-b32955@freescale.com>
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

 (5) TODO:
     1.) add DDR QUAD read. 
     2.) support two nor chips

changelog:

init --> v1:
 	[1] since the ic bug in the IPS read,
            abandon the IPS read, use the AHB read.
	[2] change the mtd code, add the quad read support.
	[3] add the quad read support the QuadSpi driver.
	[4] misc.


Huang Shijie (5):
  mtd: m25p80: move the spi-nor commands to a header
  mtd: m25p80: add support for Spansion s25fl128s chip
  mtd: m25p80: add the quad-read support
  spi: Add Freescale QuadSpi driver
  ARM: dts: vf610-twr: Add SPI NOR support

 Documentation/devicetree/bindings/mtd/m25p80.txt   |    5 +
 .../devicetree/bindings/spi/fsl-quadspi.txt        |   27 +
 arch/arm/boot/dts/vf610-twr.dts                    |   22 +
 drivers/mtd/devices/m25p80.c                       |   93 ++-
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-fsl-quadspi.c                      |  930 ++++++++++++++++++++
 include/linux/mtd/spi-nor.h                        |   58 ++
 8 files changed, 1103 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-quadspi.txt
 create mode 100644 drivers/spi/spi-fsl-quadspi.c
 create mode 100644 include/linux/mtd/spi-nor.h
