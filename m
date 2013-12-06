From: b32955@freescale.com (Huang Shijie)
Date: Fri, 6 Dec 2013 16:32:40 +0800
Subject: [PATCH V2 0/4] mtd: spi-nor: add a new framework for SPI NOR
Message-ID: <1386318764-15882-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.) Why add a new framework for SPI NOR?
  The SPI-NOR controller such as Freescale's Quadspi controller is working
  in a different way from the SPI bus. It should knows the NOR commands to
  find the right LUT sequence. Unfortunately, the current code can not meet
  this requirement.

2.) How does this patch set do?
   This patch set adds a new spi-nor layer.
   Before this patch, the layer is like:

                   MTD
         ------------------------
                  m25p80
         ------------------------
	       spi bus driver
         ------------------------
	        SPI NOR chip

   After this patch, the layer is like:
                   MTD
         ------------------------
                  spi-nor
         ------------------------
                  m25p80
         ------------------------
	       spi bus driver
         ------------------------
	       SPI NOR chip

  With the spi-nor controller driver(Freescale Quadspi), it looks like:
                   MTD
         ------------------------
                  spi-nor
         ------------------------
                fsl-quadspi
         ------------------------
	       SPI NOR chip

3.) more details
    This patch set adds a new data structrue spi_nor{}, clones most the common
  code to spi-nor.c. Add spi_nor_xfer_cfg {} for the fundamental primitives:
  read_xfer/write_xfer.

    Make the m25p80.c use the new APIs.

    Let's discuss the SPI nor framework in the new thread. :)
    

4.) TODO list:
   3.1) add the new spi_nor_device{} for the spi-nor controller's device.
   3.2) add the Freescale Quadspi driver.

v1 --> v2:
	[1] follow Angus's advice, add more hooks and data structrures.
	[2] others.

Huang Shijie (4):
  mtd: spi-nor: copy the SPI NOR commands to a new header file
  mtd: spi-nor: add the basic data structures
  mtd: spi-nor: add the framework for SPI NOR
  mtd: m25p80: use the SPI nor framework

 drivers/mtd/Kconfig           |    2 +
 drivers/mtd/Makefile          |    1 +
 drivers/mtd/devices/Kconfig   |    2 +-
 drivers/mtd/devices/m25p80.c  | 1261 +++--------------------------------------
 drivers/mtd/spi-nor/Kconfig   |    6 +
 drivers/mtd/spi-nor/Makefile  |    1 +
 drivers/mtd/spi-nor/spi-nor.c | 1042 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  132 +++++
 8 files changed, 1277 insertions(+), 1170 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/Kconfig
 create mode 100644 drivers/mtd/spi-nor/Makefile
 create mode 100644 drivers/mtd/spi-nor/spi-nor.c
 create mode 100644 include/linux/mtd/spi-nor.h

-- 
1.7.2.rc3
