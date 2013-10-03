From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  3 Oct 2013 22:36:57 +0200
Subject: [PATCH v3] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
Message-ID: <1380832617-2199-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since v2, sent with
Message-id:1379447884-14025-1-git-send-email-u.kleine-koenig at pengutronix.de
    
    - merge common.c and dtmachine.c
    - drop init_{irq,time,machine}
      dropping init_time adds a runtime dependency on Sebastian Hesselbarth's patch
      "ARM: call of_clk_init from default time_init handler"
      (Message-Id: 1379922870-2325-1-git-send-email-sebastian.hesselbarth at gmail.com)
    - drop selection of HAVE_CLK as this is implied by COMMON_CLK
    - adapt for ARCH_MULTIPLATFORM, drop all headers from include/mach and
      Makefile.boot. This makes this patch depend on my patches
        ARM: drop !ARCH_MULTIPLATFORM dependency of XIP_KERNEL
        ARM: allow MULTIPLATFORM on no-MMU machines; and
        [RFC] ARM: prepare ARMv7-M for MULTIPLATFORM use

 arch/arm/Kconfig                 |   4 +-
 arch/arm/Makefile                |   1 +
 arch/arm/configs/efm32_defconfig | 104 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-efm32/Kconfig      |   8 +++
 arch/arm/mach-efm32/Makefile     |   1 +
 arch/arm/mach-efm32/cmu.h        |  15 ++++++
 arch/arm/mach-efm32/dtmachine.c  |  21 ++++++++
 7 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/configs/efm32_defconfig
 create mode 100644 arch/arm/mach-efm32/Kconfig
 create mode 100644 arch/arm/mach-efm32/Makefile
 create mode 100644 arch/arm/mach-efm32/cmu.h
 create mode 100644 arch/arm/mach-efm32/dtmachine.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4d749fa..c9c4f4d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -946,6 +946,8 @@ source "arch/arm/mach-dove/Kconfig"
 
 source "arch/arm/mach-ep93xx/Kconfig"
 
+source "arch/arm/mach-efm32/Kconfig"
+
 source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
@@ -1833,7 +1835,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE
 	range 11 64 if ARCH_SHMOBILE
 	default "12" if SOC_AM33XX
-	default "9" if SA1111
+	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a37a50f..bee8be4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -152,6 +152,7 @@ machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
+machine-$(CONFIG_ARCH_EFM32)		+= efm32
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
new file mode 100644
index 0000000..b31af07
--- /dev/null
+++ b/arch/arm/configs/efm32_defconfig
@@ -0,0 +1,104 @@
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=12
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_UID16 is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLUB_CPU_PARTIAL is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_MMU is not set
+CONFIG_ARCH_EFM32=y
+# CONFIG_KUSER_HELPERS is not set
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x88000000
+CONFIG_DRAM_SIZE=0x00400000
+CONFIG_FLASH_MEM_BASE=0x8c000000
+CONFIG_FLASH_SIZE=0x01000000
+CONFIG_PREEMPT=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_XIP_KERNEL=y
+CONFIG_XIP_PHYS_ADDR=0x8c000000
+CONFIG_BINFMT_FLAT=y
+CONFIG_BINFMT_SHARED_FLAT=y
+# CONFIG_COREDUMP is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_ROM=y
+CONFIG_MTD_UCLINUX=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+CONFIG_KS8851=y
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_EFM32_UART=y
+CONFIG_SERIAL_EFM32_UART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_EFM32=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_BACKED_BY_MTD=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/mach-efm32/Kconfig b/arch/arm/mach-efm32/Kconfig
new file mode 100644
index 0000000..941e4a6
--- /dev/null
+++ b/arch/arm/mach-efm32/Kconfig
@@ -0,0 +1,8 @@
+config ARCH_EFM32
+        bool "Energy Micro Cortex M3 Platform" if ARCH_MULTI_V7M
+        select ARM_NVIC
+        select CLKSRC_MMIO
+        select CLKSRC_OF
+        select GENERIC_CLOCKEVENTS
+        select NO_DMA
+        select NO_IOPORT
diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
new file mode 100644
index 0000000..081f45a
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile
@@ -0,0 +1 @@
+obj-y += common.o dtmachine.o
diff --git a/arch/arm/mach-efm32/cmu.h b/arch/arm/mach-efm32/cmu.h
new file mode 100644
index 0000000..a7e5741
--- /dev/null
+++ b/arch/arm/mach-efm32/cmu.h
@@ -0,0 +1,15 @@
+/*
+ * Register definition for efm32's CMU component
+ */
+
+#define CMU_OSCENCMD		0x20
+#define CMU_OSCENCMD_HFXOEN		0x00000004
+
+#define CMU_CMD			0x24
+#define CMU_CMD_HFCLKSEL_HFXO		0x00000002
+
+#define CMU_STATUS		0x2c
+#define CMU_STATUS_HFRCOSEL		0x00000400
+#define CMU_STATUS_HFXOSEL		0x00000800
+
+#define CMU_HFPERCLKEN0		0x44
diff --git a/arch/arm/mach-efm32/dtmachine.c b/arch/arm/mach-efm32/dtmachine.c
new file mode 100644
index 0000000..cf3461b
--- /dev/null
+++ b/arch/arm/mach-efm32/dtmachine.c
@@ -0,0 +1,21 @@
+#include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+
+#include <asm/v7m.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+static const char *const efm32gg_compat[] __initconst = {
+	"efm32,dk3750",
+	NULL
+};
+
+DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
+	.dt_compat = efm32gg_compat,
+	.restart = armv7m_restart,
+MACHINE_END
-- 
1.8.4.rc3
