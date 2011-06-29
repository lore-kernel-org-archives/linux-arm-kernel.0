From: b32955@freescale.com (Huang Shijie)
Date: Wed, 29 Jun 2011 16:24:35 +0800
Subject: [PATCH v7 0/3]  add the GPMI controller driver for IMX23/IMX28
Message-ID: <1309335878-16678-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

This driver is a _pure_ MTD NAND controller driver now.

The driver depends on another patch set, you can find them at :
	[1] http://marc.info/?l=linux-arm-kernel&m=130933298731899&w=2
	[2] http://marc.info/?l=linux-arm-kernel&m=130933302531947&w=2
	[3] http://marc.info/?l=linux-arm-kernel&m=130933300431921&w=2

Test environment:
	Using imx23 and imx28 boards for test, and burned the ROOTFS
	in the nand flash.

	imx23 :
	console=ttyAMA0,115200 mtdparts=gpmi-nfc:20m(boot),-(user)  ubi.mtd=1 root=ubi0:rootfs0 rootfstype=ubifs gpmi_debug_init

        imx28 :
	# console=ttyAMA0,115200 mtdparts=gpmi-nfc-main:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0 rootfstype=ubifs gpmi_debug_init


v6 --> v7:
	[0] remove the function wrapping the clock.
	[1] use the module_param() for debugging.
	[2] use the new interface of MTD partitions.
		replace add_mtd_partitions() with mtd_device_register().
	[3] use pr_info() to print log.
	[4] add `__devinit` for some functions, etc.
	[5] add `gpmi_nfc` to control the GPMI-NFC driver's initialization.
	[6] others.

v5 --> v6:
	[0] split out the IMX23/IMX28 arch code to separate patches.
	[1] fix bug : missing empty item in the end of platform_id array.
	[2] inconsistent identation.
	[3] others

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


Huang Shijie (3):
  MTD : add the common code for GPMI-NFC controller driver
  MTD : add support for imx23 and imx28
  MTD : add GPMI-NFC driver in the config and Makefile

 drivers/mtd/nand/Kconfig              |   11 +
 drivers/mtd/nand/Makefile             |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile    |    3 +
 drivers/mtd/nand/gpmi-nfc/bch-regs.h  |   88 ++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c  | 2484 +++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h  |  495 +++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs.h |  163 +++
 drivers/mtd/nand/gpmi-nfc/hal-mxs.c   |  554 ++++++++
 8 files changed, 3799 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-mxs.c
