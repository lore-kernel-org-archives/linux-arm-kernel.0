From: b32955@freescale.com (Huang Shijie)
Date: Thu, 21 Jul 2011 14:47:23 +0800
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
Message-ID: <1311230846-26437-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is based on branch "imx-for-3.1" of tree :
      git://git.pengutronix.de/git/imx/linux-2.6.git

The general-purpose media interface(GPMI) controller is a flexible interface
to up to several NAND flashs.

The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.

With the help of BCH, the GPMI controller can choose to do the hardware ECC or
not.

This driver is a _pure_ MTD NAND controller driver now.

To Walfram & Artem:
    About how to disable the JFFS2 to use the OOB:
    I read the code, and I still have no idea about how to use the ecclayout
    to do the job. Could you give me some hint? thanks.

The driver depends on another GPMI-NAND device patch set, you can find them at :
	[1] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037033.html
	[2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037031.html
	[3] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037032.html
	[4] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037034.html

The driver also depends on another DMA patch by Shawn:
	[0] http://lists.infradead.org/pipermail/linux-mtd/2011-June/036820.html

Test environment:
	Using imx23 and imx28 boards for test. 

	imx23 (burn the rootfs to NAND):
	console=ttyAMA0,115200 mtdparts=gpmi-nfc:20m(boot),-(user)  ubi.mtd=1 root=ubi0:rootfs0 rootfstype=ubifs gpmi_debug_init

        imx28 :
	#console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw rootwait gpmi_debug_init
	#console=ttyAMA0,115200 root=/dev/nfs ip=:::::eth0:dhcp nfsroot=10.192.242.11:/root/nfs_root/imx28 gpmi_debug_init

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

 drivers/mtd/nand/Kconfig               |   11 +
 drivers/mtd/nand/Makefile              |    1 +
 drivers/mtd/nand/gpmi-nand/Makefile    |    3 +
 drivers/mtd/nand/gpmi-nand/bch-regs.h  |   88 ++
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  978 ++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 1987 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  390 +++++++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |  174 +++
 8 files changed, 3632 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nand/Makefile
 create mode 100644 drivers/mtd/nand/gpmi-nand/bch-regs.h
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-lib.c
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-nand.c
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-nand.h
 create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-regs.h
