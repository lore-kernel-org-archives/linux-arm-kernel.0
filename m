From: b32955@freescale.com (Huang Shijie)
Date: Mon, 24 Feb 2014 18:37:34 +0800
Subject: [PATCH v5 0/8] mtd: spi-nor: add a new framework for SPI NOR
Message-ID: <1393238262-8622-1-git-send-email-b32955@freescale.com>
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

    Make the m25p80.c/fsl_quaspi.c use the new APIs. 

4.) Change log:
v4 --> v5:
	[1] rebase the patch set on the l2-mtd tree.
	[2] fixed bugs in the fsl-quadspi driver.
	[3] tested the fsl-quadspi with imx6sx board.

v3 --> v4:
	[1] move the wait_till_ready to the @read hook.
	[2] convert to linux-doc style comment.
	[3] remove the some DT property for QuadSPI driver, such as
	    "fsl,nor-size".
	[4] others    

v2 --> v3:
	[1] add prepare/unprepare hooks for spi_nor{}.
	[2] add a new "priv" field for spi_nor{}.
	[3] add the Freescale Quadspi driver which supports the Quad read by
             default. 

v1 --> v2:
	[1] follow Angus's advice, add more hooks and data structrures.
	[2] others.

*** BLURB HERE ***

Huang Shijie (8):
  mtd: spi-nor: copy the SPI NOR commands to a new header file
  mtd: spi-nor: add the basic data structures
  mtd: spi-nor: add the framework for SPI NOR
  Documentation: add the document for the SPI NOR framework
  mtd: m25p80: use the SPI nor framework
  mtd: spi-nor: add a helper to find the spi_device_id
  Documentation: add the binding file for Freescale QuadSPI driver
  mtd: spi-nor: Add Freescale QuadSPI driver

 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   35 +
 Documentation/mtd/spi-nor.txt                      |   59 +
 drivers/mtd/Kconfig                                |    2 +
 drivers/mtd/Makefile                               |    1 +
 drivers/mtd/devices/m25p80.c                       | 1302 ++------------------
 drivers/mtd/spi-nor/Kconfig                        |   12 +
 drivers/mtd/spi-nor/Makefile                       |    2 +
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 1009 +++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 1099 +++++++++++++++++
 include/linux/mtd/spi-nor.h                        |  197 +++
 10 files changed, 2521 insertions(+), 1197 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
 create mode 100644 Documentation/mtd/spi-nor.txt
 create mode 100644 drivers/mtd/spi-nor/Kconfig
 create mode 100644 drivers/mtd/spi-nor/Makefile
 create mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/mtd/spi-nor/spi-nor.c
 create mode 100644 include/linux/mtd/spi-nor.h

-- 
1.7.2.rc3
