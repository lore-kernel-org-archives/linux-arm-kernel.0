From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Aug 2011 15:33:21 +0800
Subject: [PATCH v10 0/3] add the GPMI controller driver for IMX23/IMX28
Message-ID: <1314171204-25458-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is based on Artem's tree:
	http://git.infradead.org/users/dedekind/l2-mtd-2.6.git

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

This driver is a _pure_ MTD NAND controller driver now.


The driver depends on another GPMI-NAND device patch set, you can find them at :
	[1] http://marc.info/?l=linux-arm-kernel&m=131416901319573&w=2
	[2] http://marc.info/?l=linux-arm-kernel&m=131416912319668&w=2
	[3] http://marc.info/?l=linux-arm-kernel&m=131416891119504&w=2
	[4] http://marc.info/?l=linux-arm-kernel&m=131416896219539&w=2

Test environment:
	Using imx23 and imx28 boards for test. 

	imx23 :
	console=ttyAMA0,115200 mtdparts=gpmi-nfc:20m(boot),-(user)
	Tested by USB boot and NAND boot.

        imx28 :
	#console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw rootwait 
	Tested by SD card boot mode.

v9 --> v10:
	[0] fix DMA timeout bug by adding custom routine for reset blocks.
	[1] remove mil{} 
	[2] add gpmi_hw_ecclayout.
	[3] add ecc_write_oob() again to prohibit the mtd ioctl : MEMWRITEOOB
	[4] change pr_info to dev_dbg() or pr_err().
	[5] merge the all the dump functions into gpmi_dump_info().
	[6] remove parse_mtd_partitions(), and use mtd_device_parse_register().
	[7] move the the debug control code from gpmi-nand.h to gpmi-nand.c
	[8] renames
	[9] others

v8 --> v9:
	[0] remove the ONFI nand code, it will cause the DMA timeout in the ONFI nand.
	[1] remove sysfs entry.
	[2] remove kernel command parameter.
	[3] report to ecclayout that we will use all the page + OOB.
		remove the ->ecc_write_oob().
	[4] add our own block_markbad() hook.
	[5] rename some functions from mil_* to gpmi_*.
	[6] replace the __raw_readl/__raw_writel to readl/writel.
	[7] others

v7 --> v8:
	[0] rename the name from `GPMI-NFC` to `GPMI-NAND`
	[1] remove the `hal` layer, and change it to function library.
	[2] Do not use ~0 to initialize the DMA address.
	[3] fix the issue : several DMA channels share the same IRQ.
	[4] DMA timeout issue. I use the .config created by `make mxs_defconfig`
	    and the bug never occur. It seems some other module has impact to the
	    DMA.
	    Of course, you should enable the UBIFS,MTD_CHAR and GPMI for
	    the .config. You can also disable the SPIN-LOCK/MUTEX debug features.
	[5] add function to print out the GPMI registers.	    
	[6] others.	    

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
  MTD : add the common code for GPMI-NAND controller driver
  MTD : add helper functions library and header files for GPMI NAND
    driver
  MTD : add GPMI-NAND driver in the config and Makefile

 drivers/mtd/nand/Kconfig               |   13 +
 drivers/mtd/nand/Makefile              |    1 +
 drivers/mtd/nand/gpmi-nand/Makefile    |    3 +
 drivers/mtd/nand/gpmi-nand/bch-regs.h  |   84 ++
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  | 1056 ++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 1674 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  274 ++++++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |  168 ++++
 8 files changed, 3273 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nand/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nand/bch-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-lib.c
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-nand.c
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-nand.h
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-regs.h
