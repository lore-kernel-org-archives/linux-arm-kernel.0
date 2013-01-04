From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  4 Jan 2013 14:17:20 +0000
Subject: [PATCH v3 6/7] arm64: Enable ARMv8 RTSM model (SoC) support
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1357309041-6192-7-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary Kconfig entries to enable support for the
ARMv8 software model (Versatile Express platform) together with
vexpress_defconfig.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                    | 12 ++++-
 arch/arm64/configs/vexpress_defconfig | 90 +++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/smsc/Kconfig     |  4 +-
 3 files changed, 103 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/configs/vexpress_defconfig

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 87912dd..ae8cd1f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,7 +98,17 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "System Type"
+menu "Platform selection"
+
+config ARCH_VEXPRESS
+	bool "ARMv8 software model (Versatile Express)"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_GIC
+	select COMMON_CLK_VERSATILE
+	select VEXPRESS_CONFIG
+	help
+	  This enables support for the ARMv8 software model (Versatile
+	  Express).
 
 endmenu
 
diff --git a/arch/arm64/configs/vexpress_defconfig b/arch/arm64/configs/vexpress_defconfig
new file mode 100644
index 0000000..c1ee86d
--- /dev/null
+++ b/arch/arm64/configs/vexpress_defconfig
@@ -0,0 +1,90 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PROFILING=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_VEXPRESS=y
+CONFIG_SMP=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_CMDLINE="console=ttyAMA0"
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_COMPAT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+# CONFIG_BLK_DEV is not set
+CONFIG_SCSI=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CADENCE is not set
+CONFIG_SMC91X=y
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_SERIO_AMBAKMI=y
+CONFIG_LEGACY_PTY_COUNT=16
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_FUSE_FS=y
+CONFIG_CUSE=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+# CONFIG_FTRACE is not set
+CONFIG_ATOMIC64_SELFTEST=y
+CONFIG_DEBUG_ERRORS=y
diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 5a689af..bb4c167 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_SMSC
 	bool "SMC (SMSC)/Western Digital devices"
 	default y
-	depends on ARM || ISA || MAC || ARM || MIPS || M32R || SUPERH || \
+	depends on ARM || ISA || MAC || ARM64 || MIPS || M32R || SUPERH || \
 		BLACKFIN || MN10300 || COLDFIRE || PCI || PCMCIA
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y
@@ -40,7 +40,7 @@ config SMC91X
 	select NET_CORE
 	select MII
 	depends on (ARM || M32R || SUPERH || MIPS || BLACKFIN || \
-		    MN10300 || COLDFIRE)
+		    MN10300 || COLDFIRE || ARM64)
 	---help---
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
