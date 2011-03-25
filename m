From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Mar 2011 18:22:54 +0800
Subject: [ PATCH V2  0/7] add the GPMI controller driver for IMX23/IMX28
Message-ID: <1301048581-21321-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

This driver is based the Shawn Guo's DMA patches for IMX23/IMX28,
please refer to :
	http://git.infradead.org/users/vkoul/slave-dma.git/commit/a580b8c5429a624d120cd603e1498bf676e2b4da

v1 --> v2:
	[0] merge the common files into the gpmi-nfc-main.c
	[1] change the code to get the clock.
	[2] remove the timing in the nand_device_info{}
	[3] fix DMA errors
	[4] add the nand_device_info.[ch] to generic code
	[5] use the chip->onfi_version for the ONFI nand
	[6] useless init
	[7] others

Huang Shijie (7):
  ARM: add GPMI support for imx23/imx28
  dmaengine: change the flags of request_irq()
  MTD : add the database for the NANDs
  MTD : add the common code for GPMI controller driver
  MTD : add GPMI support for imx23
  MTD : add GPMI support for imx28
  MTD : add GPMI driver in the config and Makefile

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +
 arch/arm/mach-mxs/clock-mx28.c                  |    3 +
 arch/arm/mach-mxs/devices-mx23.h                |    3 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi.c       |  140 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   62 +
 arch/arm/mach-mxs/mach-mx23evk.c                |   37 +
 arch/arm/mach-mxs/mach-mx28evk.c                |   37 +
 drivers/dma/mxs-dma.c                           |    2 +-
 drivers/mtd/nand/Kconfig                        |   10 +
 drivers/mtd/nand/Makefile                       |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile              |    7 +
 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h      |  342 ++++
 drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h      |  342 ++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c       | 2452 +++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h            |  550 +++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h     |  381 ++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h     |  370 ++++
 drivers/mtd/nand/gpmi-nfc/hal-imx23.c           |  555 +++++
 drivers/mtd/nand/gpmi-nfc/hal-imx28.c           |  503 +++++
 drivers/mtd/nand/gpmi-nfc/rom-imx23.c           |  300 +++
 drivers/mtd/nand/gpmi-nfc/rom-imx28.c           |   66 +
 drivers/mtd/nand/nand_device_info.c             |  154 ++
 drivers/mtd/nand/nand_device_info.h             |   83 +
 28 files changed, 6415 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx23.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx28.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx23.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx28.c
 create mode 100644 drivers/mtd/nand/nand_device_info.c
 create mode 100644 drivers/mtd/nand/nand_device_info.h
