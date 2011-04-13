From: b32955@freescale.com (Huang Shijie)
Date: Wed, 13 Apr 2011 14:24:37 +0800
Subject: [PATCH v5 0/4] add the GPMI controller driver for IMX23/IMX28
Message-ID: <1302675881-18862-1-git-send-email-b32955@freescale.com>
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

Test environment:
	Using imx23 and imx28 boards with the rootfs in the nand flash.
	The command line is:
	# console=ttyAMA0,115200 mtdparts=gpmi-nfc-main:20m(boot),-(use)  ubi.mtd=1 root=ubi0:rootfs0 rootfstype=ubifs gpmi_debug_init


Thanks to Lothar. I really appreciate your advices.

v4 --> v5:
	[0] rename the files.
	[1] fix PM bug
	[2] remove the rom_helper code, and move the necessary initialization code
		to the main file.
	[3] change the macros from CPU_IS_* to GPMI_IS_*
	[4] remove the default partition layout init code. revert back the 
		partition parsing command line code.
	[5] others

v3 --> v4:
	[0] use the nand_ids{} as the nand database, drop my own database.
	[1] remove the patch for DMA enginer, Shawn will submit his own version.
	[2] use the platform_id to distinguish different Archs.
	[3] fix the strange coding style.
	[4] others.

v2 --> v3:
	[0] merge the imx23 and imx28 into one file(including the header file).
	[1] remove the unuse registers in the headers.
	[2] fix DMA bugs
	[3] add bus width field to nand_attr{}
	[4] others

v1 --> v2:
	[0] merge the common files into the gpmi-nfc-main.c
	[1] change the code to get the clock.
	[2] remove the timing in the nand_device_info{}
	[3] fix DMA errors
	[4] add the nand_device_info.[ch] to generic code
	[5] use the chip->onfi_version for the ONFI nand
	[6] useless init
	[7] others

Huang Shijie (4):
  ARM: add GPMI support for imx23/imx28
  MTD : add the common code for GPMI controller driver
  MTD : add support for imx23 and imx28
  MTD : add GPMI driver in the config and Makefile

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +
 arch/arm/mach-mxs/clock-mx28.c                  |    3 +
 arch/arm/mach-mxs/devices-mx23.h                |    3 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi.c       |  134 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   65 +
 arch/arm/mach-mxs/mach-mx23evk.c                |   37 +
 arch/arm/mach-mxs/mach-mx28evk.c                |   37 +
 drivers/mtd/nand/Kconfig                        |   11 +
 drivers/mtd/nand/Makefile                       |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile              |    3 +
 drivers/mtd/nand/gpmi-nfc/bch-regs.h            |   88 +
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c       | 2502 +++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h            |  488 +++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs.h           |  163 ++
 drivers/mtd/nand/gpmi-nfc/hal-mxs.c             |  556 +++++
 20 files changed, 4107 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-mxs.c
