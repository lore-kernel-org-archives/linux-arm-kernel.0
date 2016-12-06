From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:41 +0100
Subject: [RFC PATCH 06/23] arm: use kconfig fragments for ARCH_ASPEED
 defconfigs
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-7-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace [mmp2,pxa168,pxa910]_defconfig-s with a Makefile target
using merge_config.

The patch was verified with doing:

    $ make [mmp2,...]_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                                  | 12 ++++
 arch/arm/configs/mmp2.config                       | 32 +++++++++
 arch/arm/configs/mmp2_defconfig                    | 81 ----------------------
 .../{pxa168_defconfig => mmp_basic_defconfig}      |  3 -
 arch/arm/configs/pxa168.config                     |  3 +
 arch/arm/configs/pxa910.config                     |  8 +++
 arch/arm/configs/pxa910_defconfig                  | 57 ---------------
 7 files changed, 55 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm/configs/mmp2.config
 delete mode 100644 arch/arm/configs/mmp2_defconfig
 rename arch/arm/configs/{pxa168_defconfig => mmp_basic_defconfig} (83%)
 create mode 100644 arch/arm/configs/pxa168.config
 create mode 100644 arch/arm/configs/pxa910.config
 delete mode 100644 arch/arm/configs/pxa910_defconfig

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 91eab72b..32d4eb9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -374,6 +374,18 @@ PHONY += ks8695_defconfig
 ks8695_defconfig:
 	$(call merge_into_defconfig,ks8695_basic_defconfig,ks8695)
 
+PHONY += pxa168_defconfig
+pxa168_defconfig:
+	$(call merge_into_defconfig,mmp_basic_defconfig,pxa168)
+
+PHONY += pxa910_defconfig
+pxa910_defconfig:
+	$(call merge_into_defconfig,mmp_basic_defconfig,pxa910)
+
+PHONY += mmp2_defconfig
+mmp2_defconfig:
+	$(call merge_into_defconfig,mmp_basic_defconfig,mmp2)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/mmp2.config b/arch/arm/configs/mmp2.config
new file mode 100644
index 0000000..1c2e9ca
--- /dev/null
+++ b/arch/arm/configs/mmp2.config
@@ -0,0 +1,32 @@
+CONFIG_MACH_BROWNSTONE=y
+CONFIG_MACH_FLINT=y
+CONFIG_MACH_MARVELL_JASPER=y
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
+CONFIG_VFP=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_ONENAND=y
+CONFIG_MTD_ONENAND_GENERIC=y
+CONFIG_I2C=y
+CONFIG_I2C_PXA=y
+CONFIG_MFD_MAX8925=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_MAX8649=y
+CONFIG_REGULATOR_MAX8925=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_MAX8925=y
+CONFIG_MMC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_MAX8925=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_DNOTIFY is not set
+CONFIG_MSDOS_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_MMP_UART3=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
deleted file mode 100644
index 19e6fec..0000000
--- a/arch/arm/configs/mmp2_defconfig
+++ /dev/null
@@ -1,81 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
-CONFIG_MACH_BROWNSTONE=y
-CONFIG_MACH_FLINT=y
-CONFIG_MACH_MARVELL_JASPER=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
-CONFIG_VFP=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-# CONFIG_IPV6 is not set
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_GENERIC=y
-# CONFIG_BLK_DEV is not set
-CONFIG_NETDEVICES=y
-CONFIG_SMC91X=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_PXA=y
-CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_PXA=y
-# CONFIG_HWMON is not set
-CONFIG_MFD_MAX8925=y
-CONFIG_REGULATOR=y
-CONFIG_REGULATOR_MAX8649=y
-CONFIG_REGULATOR_MAX8925=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_LCD_CLASS_DEVICE=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
-CONFIG_BACKLIGHT_MAX8925=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_MMC=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_MAX8925=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_DNOTIFY is not set
-CONFIG_MSDOS_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_MMP_UART3=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/mmp_basic_defconfig
similarity index 83%
rename from arch/arm/configs/pxa168_defconfig
rename to arch/arm/configs/mmp_basic_defconfig
index d681360..042a37e 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/mmp_basic_defconfig
@@ -1,5 +1,4 @@
 CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SLAB=y
@@ -12,14 +11,12 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 # CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
diff --git a/arch/arm/configs/pxa168.config b/arch/arm/configs/pxa168.config
new file mode 100644
index 0000000..9806001
--- /dev/null
+++ b/arch/arm/configs/pxa168.config
@@ -0,0 +1,3 @@
+CONFIG_NO_HZ=y
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/arch/arm/configs/pxa910.config b/arch/arm/configs/pxa910.config
new file mode 100644
index 0000000..ade7b8a
--- /dev/null
+++ b/arch/arm/configs/pxa910.config
@@ -0,0 +1,8 @@
+CONFIG_NO_HZ=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_SPI=y
+CONFIG_FB=y
+CONFIG_LOGO=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
deleted file mode 100644
index 1067216..0000000
--- a/arch/arm/configs/pxa910_defconfig
+++ /dev/null
@@ -1,57 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_BLK_DEV is not set
-CONFIG_NETDEVICES=y
-CONFIG_SMC91X=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_PXA=y
-CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_SPI=y
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_LOGO=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_CCITT=y
-- 
1.9.1
