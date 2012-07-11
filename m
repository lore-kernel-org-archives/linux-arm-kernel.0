From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:23 +0100
Subject: [PATCH 1/9] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

The vexpress Kconfig setup tries to be clever^Whelpful and selects some
errata workarounds for certain revisions of the Cortex-A9 and PL310,
which may be required depending on the coretile.

Since the mach-vexpress can support A5, A7 and A15 coretiles, let's
defer errata workaround selection to the user and instead propose
recommended workarounds in the defconfig. Note that the use of the
savedefconfig target removed some unrelated, redundant entries from the
file.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/configs/vexpress_defconfig |   25 +++++++------------------
 arch/arm/mach-vexpress/Kconfig      |   13 -------------
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..8af0213 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -8,11 +8,9 @@ CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 # CONFIG_UTS_NS is not set
 # CONFIG_IPC_NS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
@@ -24,9 +22,14 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
 # CONFIG_SWP_EMULATE is not set
+CONFIG_ARM_ERRATA_720789=y
+CONFIG_ARM_ERRATA_751472=y
+CONFIG_PL310_ERRATA_753970=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_PL310_ERRATA_769419=y
 CONFIG_SMP=y
 CONFIG_VMSPLIT_2G=y
-CONFIG_HOTPLUG_CPU=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -46,33 +49,26 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_ARM_INTEGRATOR=y
-CONFIG_MISC_DEVICES=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 # CONFIG_SATA_PMP is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
@@ -103,7 +99,6 @@ CONFIG_HID_THRUSTMASTER=y
 CONFIG_HID_ZEROPLUS=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_MON=y
 CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_STORAGE=y
@@ -120,9 +115,7 @@ CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-# CONFIG_RPCSEC_GSS_KRB5 is not set
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
@@ -131,10 +124,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index cf8730d..6a165fa7 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,20 +1,8 @@
 menu "Versatile Express platform type"
 	depends on ARCH_VEXPRESS
 
-config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
-	bool
-	select ARM_ERRATA_720789
-	select ARM_ERRATA_751472
-	select PL310_ERRATA_753970 if CACHE_PL310
-	help
-	  Provides common dependencies for Versatile Express platforms
-	  based on Cortex-A5 and Cortex-A9 processors. In order to
-	  build a working kernel, you must also enable relevant core
-	  tile support or Flattened Device Tree based support options.
-
 config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
-	select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
@@ -22,7 +10,6 @@ config ARCH_VEXPRESS_CA9X4
 
 config ARCH_VEXPRESS_DT
 	bool "Device Tree support for Versatile Express platforms"
-	select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	select ARM_GIC
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
-- 
1.7.9.5
