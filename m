From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:43 +0100
Subject: [RFC PATCH 08/23] arm: use kconfig fragments for PLAT_SPEAR defconfigs
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-9-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace spear[13,3,6]xx_defconfig-s with a Makefile target
using merge_config.

The patch was verified with doing:

    $ make spear[13,...]xx_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                                  |  12 +++
 arch/arm/configs/spear13xx.config                  |  35 +++++++
 arch/arm/configs/spear13xx_defconfig               | 104 ---------------------
 arch/arm/configs/spear3xx.config                   |  15 +++
 arch/arm/configs/spear3xx_defconfig                |  84 -----------------
 arch/arm/configs/spear6xx.config                   |   5 +
 .../{spear6xx_defconfig => spear_basic_defconfig}  |   5 -
 7 files changed, 67 insertions(+), 193 deletions(-)
 create mode 100644 arch/arm/configs/spear13xx.config
 delete mode 100644 arch/arm/configs/spear13xx_defconfig
 create mode 100644 arch/arm/configs/spear3xx.config
 delete mode 100644 arch/arm/configs/spear3xx_defconfig
 create mode 100644 arch/arm/configs/spear6xx.config
 rename arch/arm/configs/{spear6xx_defconfig => spear_basic_defconfig} (92%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 32d4eb9..5d965f8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -386,6 +386,18 @@ PHONY += mmp2_defconfig
 mmp2_defconfig:
 	$(call merge_into_defconfig,mmp_basic_defconfig,mmp2)
 
+PHONY += spear13xx_defconfig
+spear13xx_defconfig:
+	$(call merge_into_defconfig,spear_basic_defconfig,spear13xx)
+
+PHONY += spear3xx_defconfig
+spear3xx_defconfig:
+	$(call merge_into_defconfig,spear_basic_defconfig,spear3xx)
+
+PHONY += spear6xx_defconfig
+spear6xx_defconfig:
+	$(call merge_into_defconfig,spear_basic_defconfig,spear6xx)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/spear13xx.config b/arch/arm/configs/spear13xx.config
new file mode 100644
index 0000000..4e89e2b
--- /dev/null
+++ b/arch/arm/configs/spear13xx.config
@@ -0,0 +1,35 @@
+CONFIG_ARCH_SPEAR13XX=y
+CONFIG_MACH_SPEAR1310=y
+CONFIG_MACH_SPEAR1340=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_SPEAR13XX=y
+CONFIG_SMP=y
+# CONFIG_SMP_ON_UP is not set
+# CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_AEABI=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_VFP=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_PATA_ARASAN_CF=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_SPEAR=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SPEAR=y
+CONFIG_DW_DMAC=y
+CONFIG_FUSE_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
deleted file mode 100644
index 7630748..0000000
--- a/arch/arm/configs/spear13xx_defconfig
+++ /dev/null
@@ -1,104 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR13XX=y
-CONFIG_MACH_SPEAR1310=y
-CONFIG_MACH_SPEAR1340=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIE_SPEAR13XX=y
-CONFIG_SMP=y
-# CONFIG_SMP_ON_UP is not set
-# CONFIG_ARM_CPU_TOPOLOGY is not set
-CONFIG_AEABI=y
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_VFP=y
-CONFIG_BINFMT_MISC=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_NET_IPIP=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSMC=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-# CONFIG_SATA_PMP is not set
-CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_PATA_ARASAN_CF=y
-CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-CONFIG_STMMAC_ETH=y
-# CONFIG_WLAN is not set
-CONFIG_INPUT_FF_MEMLESS=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_KEYBOARD_ATKBD is not set
-CONFIG_KEYBOARD_SPEAR=y
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_AMBA_PL011=y
-CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
-CONFIG_I2C=y
-CONFIG_I2C_DESIGNWARE_PLATFORM=y
-CONFIG_SPI=y
-CONFIG_SPI_PL022=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PL061=y
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SPEAR=y
-CONFIG_RTC_CLASS=y
-CONFIG_DMADEVICES=y
-CONFIG_DW_DMAC=y
-CONFIG_DMATEST=m
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=y
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_DEFAULT="utf8"
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=m
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/arm/configs/spear3xx.config b/arch/arm/configs/spear3xx.config
new file mode 100644
index 0000000..f22b2c0
--- /dev/null
+++ b/arch/arm/configs/spear3xx.config
@@ -0,0 +1,15 @@
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_SPEAR3XX=y
+CONFIG_MACH_SPEAR300=y
+CONFIG_MACH_SPEAR310=y
+CONFIG_MACH_SPEAR320=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_SPEAR=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_FB=y
+CONFIG_FB_ARMCLCD=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SPEAR=y
+CONFIG_AMBA_PL08X=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
deleted file mode 100644
index 58e0046..0000000
--- a/arch/arm/configs/spear3xx_defconfig
+++ /dev/null
@@ -1,84 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR3XX=y
-CONFIG_MACH_SPEAR300=y
-CONFIG_MACH_SPEAR310=y
-CONFIG_MACH_SPEAR320=y
-CONFIG_BINFMT_MISC=y
-CONFIG_NET=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSMC=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-CONFIG_STMMAC_ETH=y
-# CONFIG_WLAN is not set
-CONFIG_INPUT_FF_MEMLESS=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_KEYBOARD_ATKBD is not set
-CONFIG_KEYBOARD_SPEAR=y
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_AMBA_PL011=y
-CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
-CONFIG_I2C=y
-CONFIG_I2C_DESIGNWARE_PLATFORM=y
-CONFIG_SPI=y
-CONFIG_SPI_PL022=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PL061=y
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SPEAR=y
-CONFIG_RTC_CLASS=y
-CONFIG_DMADEVICES=y
-CONFIG_AMBA_PL08X=y
-CONFIG_DMATEST=m
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
-CONFIG_AUTOFS4_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NLS_DEFAULT="utf8"
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=m
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/arm/configs/spear6xx.config b/arch/arm/configs/spear6xx.config
new file mode 100644
index 0000000..6f31e3c
--- /dev/null
+++ b/arch/arm/configs/spear6xx.config
@@ -0,0 +1,5 @@
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_SPEAR6XX=y
+# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_AMBA_PL08X=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear_basic_defconfig
similarity index 92%
rename from arch/arm/configs/spear6xx_defconfig
rename to arch/arm/configs/spear_basic_defconfig
index 2db31d0..c489270 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear_basic_defconfig
@@ -5,9 +5,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR6XX=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -30,7 +28,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_FF_MEMLESS=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_AMBA_PL011=y
@@ -45,13 +42,11 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_RTC_CLASS=y
 CONFIG_DMADEVICES=y
-CONFIG_AMBA_PL08X=y
 CONFIG_DMATEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
1.9.1
