From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Dec 2012 21:06:30 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces support for the ARMv8 software model (Versatile
Express platform). The aim is to reduce the SoC code to a single file
and pass the driver specific data in FDT. Single kernel Image file for
multiple SoCs is mandatory.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                    |  3 ++
 arch/arm64/configs/vexpress_defconfig | 90 +++++++++++++++++++++++++++++++++++
 arch/arm64/platforms/Kconfig          | 11 +++++
 arch/arm64/platforms/Makefile         |  1 +
 arch/arm64/platforms/vexpress.c       | 38 +++++++++++++++
 drivers/net/ethernet/smsc/Kconfig     |  4 +-
 6 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/configs/vexpress_defconfig
 create mode 100644 arch/arm64/platforms/vexpress.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e58a35a..d66a444 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -91,6 +91,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config GENERIC_GPIO
+	bool
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
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
diff --git a/arch/arm64/platforms/Kconfig b/arch/arm64/platforms/Kconfig
index e69de29..3533d71 100644
--- a/arch/arm64/platforms/Kconfig
+++ b/arch/arm64/platforms/Kconfig
@@ -0,0 +1,11 @@
+config ARCH_VEXPRESS
+	bool "ARMv8 software model (Versatile Express)"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select COMMON_CLK_VERSATILE
+	select GENERIC_GPIO
+	select VEXPRESS_CONFIG
+	help
+	  This enables support for the ARMv8 software model (Versatile
+	  Express).
diff --git a/arch/arm64/platforms/Makefile b/arch/arm64/platforms/Makefile
index e69de29..2e3fcba 100644
--- a/arch/arm64/platforms/Makefile
+++ b/arch/arm64/platforms/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_VEXPRESS)	:= vexpress.o
diff --git a/arch/arm64/platforms/vexpress.c b/arch/arm64/platforms/vexpress.c
new file mode 100644
index 0000000..a484aac
--- /dev/null
+++ b/arch/arm64/platforms/vexpress.c
@@ -0,0 +1,38 @@
+/*
+ * ARMv8 software model (Versatile Express) support
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/vexpress.h>
+
+static const char *vexpress_dt_match[] __initdata = {
+	"arm,vexpress",
+	NULL,
+};
+
+static int __init vexpress_init(void)
+{
+	if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
+		return 0;
+
+	vexpress_sysreg_of_early_init();
+	vexpress_clk_of_init();
+
+	return 0;
+}
+arch_initcall(vexpress_init);
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
