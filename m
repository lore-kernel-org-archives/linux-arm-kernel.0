From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 14 Mar 2013 13:27:40 +0200
Subject: [PATCH 1/4] mtd: merge mtdchar module with mtdcore
Message-ID: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The MTD subsystem has historically tried to be as configurable as possible. The
side-effect of this is that its configuration menu is rather large, and we are
gradually shrinking it. For example, we recently merged partitions support with
the mtdcore.

This patch does the next step - it merges the mtdchar module to mtdcore. And in
this case this is not only about eliminating too fine-grained separation and
simplifying the configuration menu. This is also about eliminating seemingly
useless kernel module.

Indeed, mtdchar is a module that allows user-space making use of MTD devices
via /dev/mtd* character devices. If users do not enable it, they simply cannot
use MTD devices at all. The cannot read or write the flash contents. Is it a
sane and useful setup? I believe not. And everyone just enables mtdchar.

Having mtdchar separate is also a little bit harmful. People sometimes miss the
fact that they need to enable an additional configuration option to have
user-space MTD interfaces, and then they wonder why on earth the kernel does
not allow using the flash? They spend time asking around.

Thus, let's just get rid of this module and make it part of mtd core.

Note, mtdchar had additional configuration option to enable OTP interfaces,
which are present on some flashes. I removed that option as well - it saves a
really tiny amount space.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/mtd/Kconfig         |   13 -------------
 drivers/mtd/Makefile        |    3 +--
 drivers/mtd/chips/Kconfig   |    1 -
 drivers/mtd/devices/Kconfig |    1 -
 drivers/mtd/mtdchar.c       |    6 ------
 drivers/mtd/mtdcore.c       |    4 ----
 drivers/mtd/onenand/Kconfig |    1 -
 7 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 557bec5..5fab4e6e 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -157,19 +157,6 @@ config MTD_BCM47XX_PARTS
 
 comment "User Modules And Translation Layers"
 
-config MTD_CHAR
-	tristate "Direct char device access to MTD devices"
-	help
-	  This provides a character device for each MTD device present in
-	  the system, allowing the user to read and write directly to the
-	  memory chips, and also use ioctl() to obtain information about
-	  the device, or to erase parts of it.
-
-config HAVE_MTD_OTP
-	bool
-	help
-	  Enable access to OTP regions using MTD_CHAR.
-
 config MTD_BLKDEVS
 	tristate "Common interface to block layer for MTD 'translation layers'"
 	depends on BLOCK
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 18a38e5..4cfb31e 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -4,7 +4,7 @@
 
 # Core functionality.
 obj-$(CONFIG_MTD)		+= mtd.o
-mtd-y				:= mtdcore.o mtdsuper.o mtdconcat.o mtdpart.o
+mtd-y				:= mtdcore.o mtdsuper.o mtdconcat.o mtdpart.o mtdchar.o
 
 obj-$(CONFIG_MTD_OF_PARTS)	+= ofpart.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
@@ -15,7 +15,6 @@ obj-$(CONFIG_MTD_BCM63XX_PARTS)	+= bcm63xxpart.o
 obj-$(CONFIG_MTD_BCM47XX_PARTS)	+= bcm47xxpart.o
 
 # 'Users' - code which presents functionality to userspace.
-obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
 obj-$(CONFIG_MTD_BLKDEVS)	+= mtd_blkdevs.o
 obj-$(CONFIG_MTD_BLOCK)		+= mtdblock.o
 obj-$(CONFIG_MTD_BLOCK_RO)	+= mtdblock_ro.o
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index c219e3d..e4696b3 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -146,7 +146,6 @@ config MTD_CFI_I8
 config MTD_OTP
 	bool "Protection Registers aka one-time programmable (OTP) bits"
 	depends on MTD_CFI_ADV_OPTIONS
-	select HAVE_MTD_OTP
 	default n
 	help
 	  This enables support for reading, writing and locking so called
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index ec4a2cc..2a4d55e 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -71,7 +71,6 @@ config MTD_DATAFLASH_WRITE_VERIFY
 config MTD_DATAFLASH_OTP
 	bool "DataFlash OTP support (Security Register)"
 	depends on MTD_DATAFLASH
-	select HAVE_MTD_OTP
 	help
 	  Newer DataFlash chips (revisions C and D) support 128 bytes of
 	  one-time-programmable (OTP) data.  The first half may be written
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index c2b6729..e50b321 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -365,7 +365,6 @@ static void mtdchar_erase_callback (struct erase_info *instr)
 	wake_up((wait_queue_head_t *)instr->priv);
 }
 
-#ifdef CONFIG_HAVE_MTD_OTP
 static int otp_select_filemode(struct mtd_file_info *mfi, int mode)
 {
 	struct mtd_info *mtd = mfi->mtd;
@@ -395,9 +394,6 @@ static int otp_select_filemode(struct mtd_file_info *mfi, int mode)
 
 	return 0;
 }
-#else
-# define otp_select_filemode(f,m)	-EOPNOTSUPP
-#endif
 
 static int mtdchar_writeoob(struct file *file, struct mtd_info *mtd,
 	uint64_t start, uint32_t length, void __user *ptr,
@@ -890,7 +886,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		break;
 	}
 
-#ifdef CONFIG_HAVE_MTD_OTP
 	case OTPSELECT:
 	{
 		int mode;
@@ -946,7 +941,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
 		break;
 	}
-#endif
 
 	/* This ioctl is being deprecated - it truncates the ECC layout */
 	case ECCGETLAYOUT:
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 681bb6d..a8ff916 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -96,11 +96,7 @@ EXPORT_SYMBOL_GPL(__mtd_next_device);
 static LIST_HEAD(mtd_notifiers);
 
 
-#if defined(CONFIG_MTD_CHAR) || defined(CONFIG_MTD_CHAR_MODULE)
 #define MTD_DEVT(index) MKDEV(MTD_CHAR_MAJOR, (index)*2)
-#else
-#define MTD_DEVT(index) 0
-#endif
 
 /* REVISIT once MTD uses the driver model better, whoever allocates
  * the mtd_info will probably want to use the release() hook...
diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index 91467bb..eac7bb2 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -40,7 +40,6 @@ config MTD_ONENAND_SAMSUNG
 
 config MTD_ONENAND_OTP
 	bool "OneNAND OTP Support"
-	select HAVE_MTD_OTP
 	help
 	  One Block of the NAND Flash Array memory is reserved as
 	  a One-Time Programmable Block memory area.
-- 
1.7.10.4
