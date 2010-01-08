From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 8 Jan 2010 09:21:31 -0500
Subject: [PATCH] [ARM] pxa168: avengers lite board bring up
Message-ID: <mailman.130.1262940907.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jack Ren <jack.ren@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/pxa168_defconfig           |  125 ++++++++++++++++-----------
 arch/arm/mach-mmp/Kconfig                   |    7 ++
 arch/arm/mach-mmp/Makefile                  |    1 +
 arch/arm/mach-mmp/avengers_lite.c           |   51 +++++++++++
 arch/arm/mach-mmp/include/mach/uncompress.h |   12 ++-
 5 files changed, 145 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/mach-mmp/avengers_lite.c

diff --git a/arch/arm/configs/pxa168_defconfig
b/arch/arm/configs/pxa168_defconfig
index 791b8c3..e9fdfd6 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -9,7 +9,6 @@ CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
-# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -18,13 +17,12 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y

 #
 # General setup
@@ -64,10 +62,14 @@ CONFIG_NAMESPACES=y
 # CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_INITRAMFS_COMPRESSION_NONE is not set
+# CONFIG_INITRAMFS_COMPRESSION_GZIP is not set
+# CONFIG_INITRAMFS_COMPRESSION_BZIP2 is not set
+# CONFIG_INITRAMFS_COMPRESSION_LZMA is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 # CONFIG_EMBEDDED is not set
 CONFIG_UID16=y
 CONFIG_SYSCTL_SYSCALL=y
@@ -78,26 +80,36 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+
+#
+# Performance Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_CLK=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_SLOW_WORK is not set
 CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -109,8 +121,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set

@@ -137,12 +148,14 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_VERSATILE is not set
 # CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_IMX is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -151,25 +164,25 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KIRKWOOD is not set
-# CONFIG_ARCH_KS8695 is not set
-# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
-# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_ORION5X is not set
+CONFIG_ARCH_MMP=y
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
-CONFIG_ARCH_MMP=y
+# CONFIG_ARCH_MSM is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
 # CONFIG_ARCH_DAVINCI is not set
 # CONFIG_ARCH_OMAP is not set
-# CONFIG_ARCH_MSM is not set
-# CONFIG_ARCH_W90X900 is not set
 # CONFIG_MACH_TAVOREVB is not set

 #
@@ -177,6 +190,7 @@ CONFIG_ARCH_MMP=y
 #
 CONFIG_MACH_ASPENITE=y
 CONFIG_MACH_ZYLONITE2=y
+CONFIG_MACH_AVENGERS_LITE=y
 # CONFIG_MACH_TTC_DKB is not set
 CONFIG_CPU_PXA168=y
 CONFIG_PLAT_PXA=y
@@ -201,7 +215,6 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
-# CONFIG_OUTER_CACHE is not set
 CONFIG_IWMMXT=y
 CONFIG_COMMON_CLKDEV=y

@@ -227,9 +240,9 @@ CONFIG_PREEMPT=y
 CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
-CONFIG_ARCH_FLATMEM_HAS_HOLES=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+# CONFIG_HIGHMEM is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -241,8 +254,11 @@ CONFIG_SPLIT_PTLOCK_CPUS=4096
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set

 #
 # Boot options
@@ -288,7 +304,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -343,6 +358,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set

@@ -355,13 +372,16 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 CONFIG_WIRELESS=y
 # CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_OLD_REGULATORY=y
 # CONFIG_WIRELESS_EXT is not set
 # CONFIG_LIB80211 is not set
-# CONFIG_MAC80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+CONFIG_MAC80211_DEFAULT_PS_VALUE=0
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -412,8 +432,10 @@ CONFIG_MII=y
 # CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
+# CONFIG_ETHOC is not set
 # CONFIG_SMC911X is not set
 # CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
@@ -422,6 +444,7 @@ CONFIG_SMC91X=y
 # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set

@@ -430,7 +453,6 @@ CONFIG_SMC91X=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set

 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -555,22 +577,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-# CONFIG_DAB is not set
+# CONFIG_MEDIA_SUPPORT is not set

 #
 # Graphics support
@@ -600,6 +607,7 @@ CONFIG_DUMMY_CONSOLE=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
@@ -613,10 +621,12 @@ CONFIG_RTC_LIB=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -627,6 +637,11 @@ CONFIG_INOTIFY_USER=y
 CONFIG_GENERIC_ACL=y

 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -668,11 +683,13 @@ CONFIG_CRAMFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
@@ -681,7 +698,6 @@ CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
-# CONFIG_SUNRPC_REGISTER_V4 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -714,11 +730,15 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -746,20 +766,23 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 # CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
-
-#
-# Tracers
-#
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
 # CONFIG_FUNCTION_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
 # CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_STACK_TRACER is not set
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -791,10 +814,12 @@ CONFIG_CRYPTO_BLKCIPHER2=y
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_HASH2=y
 CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_TEST is not set
@@ -863,6 +888,7 @@ CONFIG_CRYPTO_DES=y
 # Compression
 #
 # CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
 # CONFIG_CRYPTO_LZO is not set

 #
@@ -870,6 +896,7 @@ CONFIG_CRYPTO_DES=y
 #
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set

 #
 # Library routines
@@ -884,7 +911,7 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
-CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 5f0bcf6..6ab843e 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -16,6 +16,13 @@ config MACH_ZYLONITE2
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Zylonite2 Development Board.

+config MACH_AVENGERS_LITE
+	bool "Marvell's PXA168 Avengers Lite Development Board"
+	select CPU_PXA168
+	help
+	  Say 'Y' here if you want to support the Marvell PXA168-based
+	  Avengers Lite Development Board.
+
 config MACH_TAVOREVB
 	bool "Marvell's PXA910 TavorEVB Development Board"
 	select CPU_PXA910
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index fb013d6..8b66d06 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o
 # board support
 obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
 obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
+obj-$(CONFIG_MACH_AVENGERS_LITE)+= avengers_lite.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
diff --git a/arch/arm/mach-mmp/avengers_lite.c
b/arch/arm/mach-mmp/avengers_lite.c
new file mode 100644
index 0000000..494e560
--- /dev/null
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -0,0 +1,51 @@
+/*
+ *  linux/arch/arm/mach-mmp/avengers_lite.c
+ *
+ *  Support for the Marvell PXA168-based Avengers lite Development Platform.
+ *
+ *  Copyright (C) 2009-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/addr-map.h>
+#include <mach/mfp-pxa168.h>
+#include <mach/pxa168.h>
+#include <mach/irqs.h>
+
+
+#include "common.h"
+#include <linux/delay.h>
+
+/* Avengers lite MFP configurations */
+static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
+	/* DEBUG_UART */
+	MFP_CFG(GPIO88, AF2),
+	MFP_CFG(GPIO89, AF2),
+};
+
+static void __init avengers_lite_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(avengers_lite_pin_config_V16F));
+
+	/* on-chip devices */
+	pxa168_add_uart(2);
+}
+
+MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
+	.phys_io        = APB_PHYS_BASE,
+	.boot_params    = 0x00000100,
+	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
+	.map_io		= pxa_map_io,
+	.init_irq       = pxa168_init_irq,
+	.timer          = &pxa168_timer,
+	.init_machine   = avengers_lite_init,
+MACHINE_END
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h
b/arch/arm/mach-mmp/include/mach/uncompress.h
index c93d5fa..1902f6d 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -8,14 +8,16 @@

 #include <linux/serial_reg.h>
 #include <mach/addr-map.h>
+#include <asm/mach-types.h>

 #define UART1_BASE	(APB_PHYS_BASE + 0x36000)
 #define UART2_BASE	(APB_PHYS_BASE + 0x17000)
 #define UART3_BASE	(APB_PHYS_BASE + 0x18000)

+static volatile unsigned long *UART = (volatile unsigned long *)UART2_BASE;
+
 static inline void putc(char c)
 {
-	volatile unsigned long *UART = (unsigned long *)UART2_BASE;

 	/* UART enabled? */
 	if (!(UART[UART_IER] & UART_IER_UUE))
@@ -34,8 +36,14 @@ static inline void flush(void)
 {
 }

+static inline void arch_decomp_setup(void)
+{
+	if (machine_is_avengers_lite())
+		UART = (volatile unsigned long *)UART3_BASE;
+}
+
 /*
  * nothing to do
  */
-#define arch_decomp_setup()
+
 #define arch_decomp_wdog()
-- 
1.5.6.5
