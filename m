From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:39 +0100
Subject: [RFC PATCH 04/23] arm: use kconfig fragments for ARCH_ASPEED
 defconfigs
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace [acs5k,acs5k_tiny,ks8695]_defconfig-s with a Makefile target
using merge_config.

The patch was verified with doing:

    $ make [acs5k,acs5k_tiny,ks8695]_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                                  | 12 ++++
 arch/arm/configs/acs5k.config                      | 32 ++++++++++
 arch/arm/configs/acs5k_defconfig                   | 74 ----------------------
 arch/arm/configs/acs5k_tiny.config                 | 24 +++++++
 arch/arm/configs/acs5k_tiny_defconfig              | 66 -------------------
 arch/arm/configs/ks8695.config                     | 21 ++++++
 .../{ks8695_defconfig => ks8695_basic_defconfig}   | 21 ------
 7 files changed, 89 insertions(+), 161 deletions(-)
 create mode 100644 arch/arm/configs/acs5k.config
 delete mode 100644 arch/arm/configs/acs5k_defconfig
 create mode 100644 arch/arm/configs/acs5k_tiny.config
 delete mode 100644 arch/arm/configs/acs5k_tiny_defconfig
 create mode 100644 arch/arm/configs/ks8695.config
 rename arch/arm/configs/{ks8695_defconfig => ks8695_basic_defconfig} (67%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index abe8a60..91eab72b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -362,6 +362,18 @@ PHONY += aspeed_g5_defconfig
 aspeed_g5_defconfig:
 	$(call merge_into_defconfig,aspeed_basic_defconfig,aspeed_g5)
 
+PHONY += acs5k_defconfig
+acs5k_defconfig:
+	$(call merge_into_defconfig,ks8695_basic_defconfig,acs5k)
+
+PHONY += acs5k_tiny_defconfig
+acs5k_tiny_defconfig:
+	$(call merge_into_defconfig,ks8695_basic_defconfig,acs5k_tiny)
+
+PHONY += ks8695_defconfig
+ks8695_defconfig:
+	$(call merge_into_defconfig,ks8695_basic_defconfig,ks8695)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/acs5k.config b/arch/arm/configs/acs5k.config
new file mode 100644
index 0000000..eb8c70e
--- /dev/null
+++ b/arch/arm/configs/acs5k.config
@@ -0,0 +1,32 @@
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_MACH_KS8695=y
+CONFIG_MACH_DSM320=y
+CONFIG_MACH_ACS5K=y
+CONFIG_PCI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCCARD=y
+CONFIG_YENTA=y
+CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev/ram0 rw"
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_ARM_KS8695_ETHER=y
+CONFIG_PRISM54=m
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
+CONFIG_WATCHDOG=y
+CONFIG_KS8695_WATCHDOG=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PCF8563=y
+CONFIG_EXT2_FS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/acs5k_defconfig b/arch/arm/configs/acs5k_defconfig
deleted file mode 100644
index 8840d2c..0000000
--- a/arch/arm/configs/acs5k_defconfig
+++ /dev/null
@@ -1,74 +0,0 @@
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_KS8695=y
-CONFIG_MACH_KS8695=y
-CONFIG_MACH_DSM320=y
-CONFIG_MACH_ACS5K=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_PCI=y
-CONFIG_PCI_DEBUG=y
-CONFIG_PCCARD=y
-CONFIG_YENTA=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev/ram0 rw"
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_NETDEVICES=y
-CONFIG_ARM_KS8695_ETHER=y
-CONFIG_PRISM54=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_KS8695=y
-CONFIG_SERIAL_KS8695_CONSOLE=y
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_GPIO=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PCA953X=y
-CONFIG_WATCHDOG=y
-CONFIG_KS8695_WATCHDOG=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_PCF8563=y
-CONFIG_EXT2_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/acs5k_tiny.config b/arch/arm/configs/acs5k_tiny.config
new file mode 100644
index 0000000..7d913e3
--- /dev/null
+++ b/arch/arm/configs/acs5k_tiny.config
@@ -0,0 +1,24 @@
+CONFIG_POSIX_MQUEUE=y
+CONFIG_MACH_ACS5K=y
+CONFIG_CMDLINE="console=ttyAM0,115200 init=/bin/sh"
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_BLK_DEV is not set
+CONFIG_ARM_KS8695_ETHER=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_KS8695_WATCHDOG=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PCF8563=y
+CONFIG_SQUASHFS=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
diff --git a/arch/arm/configs/acs5k_tiny_defconfig b/arch/arm/configs/acs5k_tiny_defconfig
deleted file mode 100644
index a8e115c..0000000
--- a/arch/arm/configs/acs5k_tiny_defconfig
+++ /dev/null
@@ -1,66 +0,0 @@
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_KS8695=y
-CONFIG_MACH_ACS5K=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyAM0,115200 init=/bin/sh"
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-# CONFIG_BLK_DEV is not set
-CONFIG_NETDEVICES=y
-CONFIG_ARM_KS8695_ETHER=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_KS8695=y
-CONFIG_SERIAL_KS8695_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_GPIO=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PCA953X=y
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_KS8695_WATCHDOG=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_PCF8563=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/ks8695.config b/arch/arm/configs/ks8695.config
new file mode 100644
index 0000000..58b6577
--- /dev/null
+++ b/arch/arm/configs/ks8695.config
@@ -0,0 +1,21 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_MACH_KS8695=y
+CONFIG_MACH_DSM320=y
+CONFIG_PCI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCCARD=y
+CONFIG_YENTA=y
+CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev/ram0 rw"
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_PRISM54=m
+# CONFIG_HWMON is not set
+CONFIG_EXT2_FS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/ks8695_defconfig b/arch/arm/configs/ks8695_basic_defconfig
similarity index 67%
rename from arch/arm/configs/ks8695_defconfig
rename to arch/arm/configs/ks8695_basic_defconfig
index b5ef2b4..c9ee223 100644
--- a/arch/arm/configs/ks8695_defconfig
+++ b/arch/arm/configs/ks8695_basic_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -9,55 +8,35 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_KS8695=y
-CONFIG_MACH_KS8695=y
-CONFIG_MACH_DSM320=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_PCI=y
-CONFIG_PCI_DEBUG=y
-CONFIG_PCCARD=y
-CONFIG_YENTA=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev/ram0 rw"
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_PRISM54=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_KS8695=y
 CONFIG_SERIAL_KS8695_CONSOLE=y
-# CONFIG_HWMON is not set
-CONFIG_EXT2_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-- 
1.9.1
