From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Sep 2012 14:57:51 +0800
Subject: [PATCH v2 0/9] add EDO feature for gpmi-nand driver
Message-ID: <1347519480-31106-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ONFI nand supports the EDO (extended data out) feature in 
asynchronous mode when the host controller(such as gpmi-nand)
uses a tRC of less then 30ns.

The gpmi can supports this EDO feature.
This patch set adds the EDO support the gpmi-nand driver.

patch 1 ~ patch 2: 
	 These two patches provide the infrastructure for the EDO feature.
         They add necessary MTD helpers for the ONFI nand set/get features,
	 and the help to get the supportted timing mode.
	 These two patches are new version. The init version has been
	 reviewed by Vikram & Florian.

patch 3 ~ patch 7:
         These patches are clean-ups for the gpmi-nand's timing code.
	 Also they make the some preparations for the EDO patch.

patch 8: add the EDO feature to the gpmi-nand.


patch 9: a small optimization for the timing. 
         only set the timing registers one time.

I tested this patch set on the IMX6Q-arm2 board with several Micron's
ONFI nand chips. Some chips only can supports to mode 4, some chips
can supports to mode 5.

The performance is much improved. Take Micron MT29F32G08MAA for example
(in mode 5, 100MHz):

1) The test result BEFORE we add the EDO feature:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 209715200, eraseblock size 524288,
			page size 4096, count of eraseblocks 400,
			pages per eraseblock 128, OOB size 218
.......................................
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 3632 KiB/s
.......................................
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 3554 KiB/s
.......................................
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 3592 KiB/s
.......................................
=================================================

2) The test result AFTER we add the EDO feature:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 209715200, eraseblock size 524288,
			page size 4096, count of eraseblocks 400,
			pages per eraseblock 128, OOB size 218
.......................................
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 19555 KiB/s
.......................................
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 17319 KiB/s
.......................................
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 18339 KiB/s
.......................................
=================================================

The read data performance is much improved by more then 5 times.

---
ChangLog:
v1 --> v2:
	[1] fix the wrong macro for busy timeout
	[2] use the NSEC_PER_SEC to replace the `1000000000`.
	[3] fix the wrong macro type for WRN_DLY_SEL.
	[4] fix some comments.
	[5] misc

Huang Shijie (9):
  mtd: add helpers to set/get features for ONFI nand
  mtd: add helpers to get the supportted ONFI timing mode
  mtd: gpmi: add a new field for HW_GPMI_TIMING1
  mtd: gpmi: do not get the clock frequency in gpmi_begin()
  mtd: gpmi: add a new field for HW_GPMI_CTRL1
  mtd: gpmi: simplify the setting DLL code
  mtd: gpmi: do not set the default values for the extra clocks
  mtd: gpmi: add EDO feature for imx6q
  mtd: gpmi: initialize the timing registers only one time

 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  275 ++++++++++++++++++++++++++++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   23 ++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   19 +++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |   12 ++
 drivers/mtd/nand/nand_base.c           |   50 ++++++
 include/linux/mtd/nand.h               |   39 +++++
 6 files changed, 381 insertions(+), 37 deletions(-)
