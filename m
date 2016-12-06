From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:45 +0100
Subject: [RFC PATCH 10/23] arm: use kconfig fragments for ARCH_W90X900
 defconfigs
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-11-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace nuc9[5,6]0_defconfig-s with a Makefile target using
merge_config.

The patch was verified with doing:

    $ make nuc9[5,6]0_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                 |  8 +++++
 arch/arm/configs/nuc950.config    | 14 +++++++++
 arch/arm/configs/nuc950_defconfig | 63 ---------------------------------------
 arch/arm/configs/nuc960.config    |  5 ++++
 arch/arm/configs/nuc960_defconfig | 54 ---------------------------------
 5 files changed, 27 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm/configs/nuc950.config
 delete mode 100644 arch/arm/configs/nuc950_defconfig
 create mode 100644 arch/arm/configs/nuc960.config
 delete mode 100644 arch/arm/configs/nuc960_defconfig

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5d965f8..d4def05 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -398,6 +398,14 @@ PHONY += spear6xx_defconfig
 spear6xx_defconfig:
 	$(call merge_into_defconfig,spear_basic_defconfig,spear6xx)
 
+PHONY += nuc950_defconfig
+nuc950_defconfig:
+	$(call merge_into_defconfig,nuc910_defconfig,nuc950)
+
+PHONY += nuc960_defconfig
+nuc960_defconfig:
+	$(call merge_into_defconfig,nuc910_defconfig,nuc960)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/nuc950.config b/arch/arm/configs/nuc950.config
new file mode 100644
index 0000000..83824ca
--- /dev/null
+++ b/arch/arm/configs/nuc950.config
@@ -0,0 +1,14 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+# CONFIG_MACH_W90P910EVB is not set
+CONFIG_MACH_W90P950EVB=y
+CONFIG_BINFMT_MISC=y
+CONFIG_FB=y
+CONFIG_FB_NUC900=y
+CONFIG_GPM1040A0_320X240=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_FONTS=y
diff --git a/arch/arm/configs/nuc950_defconfig b/arch/arm/configs/nuc950_defconfig
deleted file mode 100644
index f30a14a..0000000
--- a/arch/arm/configs/nuc950_defconfig
+++ /dev/null
@@ -1,63 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_USER_NS=y
-CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ARCH_W90X900=y
-# CONFIG_MACH_W90P910EVB is not set
-CONFIG_MACH_W90P950EVB=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_CMDLINE="root=/dev/ram0 console=ttyS0,115200n8 rdinit=/sbin/init mem=64M"
-CONFIG_KEXEC=y
-CONFIG_BINFMT_MISC=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-# CONFIG_SCSI_LOWLEVEL is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=1
-CONFIG_SERIAL_8250_RUNTIME_UARTS=1
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_NUC900=y
-CONFIG_GPM1040A0_320X240=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_STORAGE=y
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_ROMFS_FS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_FS=y
-CONFIG_FONTS=y
diff --git a/arch/arm/configs/nuc960.config b/arch/arm/configs/nuc960.config
new file mode 100644
index 0000000..960f587
--- /dev/null
+++ b/arch/arm/configs/nuc960.config
@@ -0,0 +1,5 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+# CONFIG_MACH_W90P910EVB is not set
+CONFIG_MACH_W90N960EVB=y
+CONFIG_BINFMT_MISC=y
diff --git a/arch/arm/configs/nuc960_defconfig b/arch/arm/configs/nuc960_defconfig
deleted file mode 100644
index c38c79f..0000000
--- a/arch/arm/configs/nuc960_defconfig
+++ /dev/null
@@ -1,54 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_USER_NS=y
-CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ARCH_W90X900=y
-# CONFIG_MACH_W90P910EVB is not set
-CONFIG_MACH_W90N960EVB=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_CMDLINE="root=/dev/ram0 console=ttyS0,115200n8 rdinit=/sbin/init mem=64M"
-CONFIG_KEXEC=y
-CONFIG_BINFMT_MISC=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-# CONFIG_SCSI_LOWLEVEL is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=1
-CONFIG_SERIAL_8250_RUNTIME_UARTS=1
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_STORAGE=y
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_ROMFS_FS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_FS=y
-- 
1.9.1
