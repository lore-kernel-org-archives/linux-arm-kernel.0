From: saeed@marvell.com (Saeed Bishara)
Date: Tue, 24 Nov 2009 19:33:51 +0200
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <1259084033-7283-1-git-send-email-saeed@marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
Message-ID: <1259084033-7283-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Dove (88AP510) is a high-performance, highly integrated,
low power SoC with high-end ARM-compatible processor (known as PJ4),
graphics processing unit, high-definition video decoding acceleration
hardware, and a broad range of peripherals.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/Kconfig                              |   13 +
 arch/arm/Makefile                             |    1 +
 arch/arm/boot/compressed/head.S               |    6 +
 arch/arm/configs/dove_defconfig               | 1617 +++++++++++++++++++++++++
 arch/arm/mach-dove/Kconfig                    |   14 +
 arch/arm/mach-dove/Makefile                   |    3 +
 arch/arm/mach-dove/Makefile.boot              |    3 +
 arch/arm/mach-dove/addr-map.c                 |  149 +++
 arch/arm/mach-dove/common.c                   |  777 ++++++++++++
 arch/arm/mach-dove/common.h                   |   40 +
 arch/arm/mach-dove/dove-db-setup.c            |  102 ++
 arch/arm/mach-dove/include/mach/bridge-regs.h |   58 +
 arch/arm/mach-dove/include/mach/debug-macro.S |   20 +
 arch/arm/mach-dove/include/mach/dove.h        |  180 +++
 arch/arm/mach-dove/include/mach/entry-macro.S |   39 +
 arch/arm/mach-dove/include/mach/gpio.h        |   49 +
 arch/arm/mach-dove/include/mach/hardware.h    |   26 +
 arch/arm/mach-dove/include/mach/io.h          |   20 +
 arch/arm/mach-dove/include/mach/irqs.h        |  101 ++
 arch/arm/mach-dove/include/mach/memory.h      |   10 +
 arch/arm/mach-dove/include/mach/pm.h          |   54 +
 arch/arm/mach-dove/include/mach/system.h      |   36 +
 arch/arm/mach-dove/include/mach/timex.h       |    9 +
 arch/arm/mach-dove/include/mach/uncompress.h  |   37 +
 arch/arm/mach-dove/include/mach/vmalloc.h     |    6 +
 arch/arm/mach-dove/irq.c                      |  133 ++
 arch/arm/mach-dove/pcie.c                     |  238 ++++
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/mm/proc-v6.S                         |   33 +-
 29 files changed, 3774 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/dove_defconfig
 create mode 100644 arch/arm/mach-dove/Kconfig
 create mode 100644 arch/arm/mach-dove/Makefile
 create mode 100644 arch/arm/mach-dove/Makefile.boot
 create mode 100644 arch/arm/mach-dove/addr-map.c
 create mode 100644 arch/arm/mach-dove/common.c
 create mode 100644 arch/arm/mach-dove/common.h
 create mode 100644 arch/arm/mach-dove/dove-db-setup.c
 create mode 100644 arch/arm/mach-dove/include/mach/bridge-regs.h
 create mode 100644 arch/arm/mach-dove/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-dove/include/mach/dove.h
 create mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-dove/include/mach/gpio.h
 create mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 create mode 100644 arch/arm/mach-dove/include/mach/io.h
 create mode 100644 arch/arm/mach-dove/include/mach/irqs.h
 create mode 100644 arch/arm/mach-dove/include/mach/memory.h
 create mode 100644 arch/arm/mach-dove/include/mach/pm.h
 create mode 100644 arch/arm/mach-dove/include/mach/system.h
 create mode 100644 arch/arm/mach-dove/include/mach/timex.h
 create mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-dove/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-dove/irq.c
 create mode 100644 arch/arm/mach-dove/pcie.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..7fae1ef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -433,6 +433,17 @@ config ARCH_L7200
 	  If you have any questions or comments about the Linux kernel port
 	  to this board, send e-mail to <sjhill@cotw.com>.
 
+config ARCH_DOVE
+	bool "Marvell Dove"
+	select PCI
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select PLAT_ORION
+	help
+	  Support for the Marvell Dove SoC 88AP510
+
 config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
 	select CPU_FEROCEON
@@ -747,6 +758,8 @@ source "arch/arm/mach-orion5x/Kconfig"
 
 source "arch/arm/mach-kirkwood/Kconfig"
 
+source "arch/arm/mach-dove/Kconfig"
+
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s3c64xx/Kconfig"
 source "arch/arm/plat-s3c/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..2ddc323 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -122,6 +122,7 @@ machine-$(CONFIG_ARCH_AT91)		:= at91
 machine-$(CONFIG_ARCH_BCMRING)		:= bcmring
 machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
 machine-$(CONFIG_ARCH_DAVINCI)		:= davinci
+machine-$(CONFIG_ARCH_DOVE)		:= dove
 machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		:= gemini
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fa6fbf4..d356af7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -743,6 +743,12 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv6_mmu_cache_flush
 
+		.word	0x560f5810		@ Marvell PJ4 ARMv6
+		.word	0xff0ffff0
+		W(b)	__armv4_mmu_cache_on
+		W(b)	__armv4_mmu_cache_off
+		W(b)	__armv6_mmu_cache_flush
+
 		.word	0x000f0000		@ new CPU Id
 		.word	0x000f0000
 		W(b)	__armv7_mmu_cache_on
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
new file mode 100644
index 0000000..f2d1ea0
--- /dev/null
+++ b/arch/arm/configs/dove_defconfig
@@ -0,0 +1,1617 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.32-rc6
+# Tue Nov 24 13:48:39 2009
+#
+CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
+CONFIG_COMPAT_BRK=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+# CONFIG_FREEZER is not set
+
+#
+# System Type
+#
+CONFIG_MMU=y
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_GEMINI is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_NOMADIK is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_L7200 is not set
+CONFIG_ARCH_DOVE=y
+# CONFIG_ARCH_KIRKWOOD is not set
+# CONFIG_ARCH_LOKI is not set
+# CONFIG_ARCH_MV78XX0 is not set
+# CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_MSM is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_DAVINCI is not set
+# CONFIG_ARCH_OMAP is not set
+# CONFIG_ARCH_BCMRING is not set
+
+#
+# Marvell Dove Implementations
+#
+CONFIG_MACH_DOVE_DB=y
+CONFIG_PLAT_ORION=y
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=y
+CONFIG_CPU_V6=y
+CONFIG_CPU_32v6K=y
+CONFIG_CPU_32v6=y
+CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_V6=y
+CONFIG_CPU_CACHE_V6=y
+CONFIG_CPU_CACHE_VIPT=y
+CONFIG_CPU_COPY_V6=y
+CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=y
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+CONFIG_ARM_L1_CACHE_SHIFT=5
+# CONFIG_ARM_ERRATA_411920 is not set
+
+#
+# Bus support
+#
+CONFIG_PCI=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_VMSPLIT_3G=y
+# CONFIG_VMSPLIT_2G is not set
+# CONFIG_VMSPLIT_1G is not set
+CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_HZ=100
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
+# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE=""
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
+
+#
+# CPU Power Management
+#
+# CONFIG_CPU_IDLE is not set
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+# CONFIG_FPE_NWFPE is not set
+# CONFIG_FPE_FASTFPE is not set
+CONFIG_VFP=y
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_HAVE_AOUT=y
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Power management options
+#
+# CONFIG_PM is not set
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_LRO=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+# CONFIG_MTD_IMPA7 is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_DATAFLASH is not set
+CONFIG_MTD_M25P80=y
+CONFIG_M25PXX_USE_FAST_READ=y
+# CONFIG_MTD_SST25L is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
+# CONFIG_MTD_UBI_GLUEBI is not set
+
+#
+# UBI debugging options
+#
+# CONFIG_MTD_UBI_DEBUG is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_ATA_VERBOSE_ERROR=y
+CONFIG_SATA_PMP=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+CONFIG_SATA_MV=y
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATP867X is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RDC is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+CONFIG_MV643XX_ETH=y
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+CONFIG_WLAN=y
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+CONFIG_INPUT_POLLDEV=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+CONFIG_INPUT_MOUSE=y
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
+# CONFIG_MOUSE_BCM5974 is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_MOUSE_GPIO is not set
+# CONFIG_MOUSE_SYNAPTICS_I2C is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MAX3100 is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=16
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_GPIO is not set
+CONFIG_I2C_MV64XXX=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Graphics adapter I2C/DDC channel drivers
+#
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
+CONFIG_SPI_ORION=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO expanders:
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_LANGWELL is not set
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+
+#
+# AC97 GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+CONFIG_VGA_ARB=y
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+# CONFIG_USB_MUSB_HDRC is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_DMADEVICES=y
+
+#
+# DMA Devices
+#
+CONFIG_MV_XOR=y
+CONFIG_DMA_ENGINE=y
+
+#
+# DMA Clients
+#
+# CONFIG_NET_DMA is not set
+# CONFIG_ASYNC_TX_DMA is not set
+# CONFIG_DMATEST is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_UBIFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+CONFIG_TIMER_STATS=y
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
+# CONFIG_BOOT_TRACER is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_ARM_UNWIND=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_ERRORS=y
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_LL is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_GHASH is not set
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+CONFIG_CRYPTO_BLOWFISH=y
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+CONFIG_CRYPTO_TEA=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRYPTO_TWOFISH_COMMON=y
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=y
+# CONFIG_CRYPTO_ZLIB is not set
+CONFIG_CRYPTO_LZO=y
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_MV_CESA is not set
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
new file mode 100644
index 0000000..3b9a32a
--- /dev/null
+++ b/arch/arm/mach-dove/Kconfig
@@ -0,0 +1,14 @@
+if ARCH_DOVE
+
+menu "Marvell Dove Implementations"
+
+config MACH_DOVE_DB
+	bool "Marvell DB-MV88AP510 Development Board"
+	select I2C_BOARDINFO
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell DB-MV88AP510 Development Board.
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
new file mode 100644
index 0000000..7ab3be5
--- /dev/null
+++ b/arch/arm/mach-dove/Makefile
@@ -0,0 +1,3 @@
+obj-y				+= common.o addr-map.o irq.o pcie.o
+
+obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
new file mode 100644
index 0000000..67039c3
--- /dev/null
+++ b/arch/arm/mach-dove/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
new file mode 100644
index 0000000..34187bd
--- /dev/null
+++ b/arch/arm/mach-dove/addr-map.c
@@ -0,0 +1,149 @@
+/*
+ * arch/arm/mach-dove/addr-map.c
+ *
+ * Address map functions for Marvell Dove 88AP510 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mbus.h>
+#include <asm/mach/arch.h>
+#include <asm/io.h>
+#include <asm/setup.h>
+#include "common.h"
+
+/*
+ * Generic Address Decode Windows bit settings
+ */
+#define TARGET_DDR		0x0
+#define TARGET_BOOTROM		0x1
+#define TARGET_CESA		0x3
+#define TARGET_PCIE0		0x4
+#define TARGET_PCIE1		0x8
+#define TARGET_SCRATCHPAD	0xd
+
+#define ATTR_CESA		0x01
+#define ATTR_BOOTROM		0xfd
+#define ATTR_DEV_SPI0_ROM	0xfe
+#define ATTR_DEV_SPI1_ROM	0xfb
+#define ATTR_PCIE_IO		0xe0
+#define ATTR_PCIE_MEM		0xe8
+#define ATTR_SCRATCHPAD		0x0
+
+/*
+ * CPU Address Decode Windows registers
+ */
+#define WIN_CTRL(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x0)
+#define WIN_BASE(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x4)
+#define WIN_REMAP_LO(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x8)
+#define WIN_REMAP_HI(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0xc)
+
+struct mbus_dram_target_info dove_mbus_dram_info;
+
+static inline void __iomem *ddr_map_sc(int i)
+{
+	return (void __iomem *)(DOVE_MC_VIRT_BASE + 0x100 + ((i) << 4));
+}
+
+static int cpu_win_can_remap(int win)
+{
+	if (win < 4)
+		return 1;
+
+	return 0;
+}
+
+static void __init setup_cpu_win(int win, u32 base, u32 size,
+				 u8 target, u8 attr, int remap)
+{
+	u32 ctrl;
+
+	base &= 0xffff0000;
+	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
+
+	writel(base, WIN_BASE(win));
+	writel(ctrl, WIN_CTRL(win));
+	if (cpu_win_can_remap(win)) {
+		if (remap < 0)
+			remap = base;
+		writel(remap & 0xffff0000, WIN_REMAP_LO(win));
+		writel(0, WIN_REMAP_HI(win));
+	}
+}
+
+void __init dove_setup_cpu_mbus(void)
+{
+	int i;
+	int cs;
+
+	/*
+	 * First, disable and clear windows.
+	 */
+	for (i = 0; i < 8; i++) {
+		writel(0, WIN_BASE(i));
+		writel(0, WIN_CTRL(i));
+		if (cpu_win_can_remap(i)) {
+			writel(0, WIN_REMAP_LO(i));
+			writel(0, WIN_REMAP_HI(i));
+		}
+	}
+
+	/*
+	 * Setup windows for PCIe IO+MEM space.
+	 */
+	setup_cpu_win(0, DOVE_PCIE0_IO_PHYS_BASE, DOVE_PCIE0_IO_SIZE,
+		      TARGET_PCIE0, ATTR_PCIE_IO, DOVE_PCIE0_IO_BUS_BASE);
+	setup_cpu_win(1, DOVE_PCIE1_IO_PHYS_BASE, DOVE_PCIE1_IO_SIZE,
+		      TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE);
+	setup_cpu_win(2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
+		      TARGET_PCIE0, ATTR_PCIE_MEM, -1);
+	setup_cpu_win(3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
+		      TARGET_PCIE1, ATTR_PCIE_MEM, -1);
+
+	/*
+	 * Setup window for CESA engine.
+	 */
+	setup_cpu_win(4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
+		      TARGET_CESA, ATTR_CESA, -1);
+
+	/*
+	 * Setup the Window to the BootROM for Standby and Sleep Resume
+	 */
+	setup_cpu_win(5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
+		      TARGET_BOOTROM, ATTR_BOOTROM, -1);
+
+	/*
+	 * Setup the Window to the PMU Scratch Pad space
+	 */
+	setup_cpu_win(6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
+		      TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1);
+
+	/*
+	 * Setup MBUS dram target info.
+	 */
+	dove_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
+
+	for (i = 0, cs = 0; i < 2; i++) {
+		u32 map = readl(ddr_map_sc(i));
+
+		/*
+		 * Chip select enabled?
+		 */
+		if (map & 1) {
+			struct mbus_dram_window *w;
+
+			w = &dove_mbus_dram_info.cs[cs++];
+			w->cs_index = i;
+			w->mbus_attr = 0; /* CS address decoding done inside */
+					  /* the DDR controller, no need to  */
+					  /* provide attributes */
+			w->base = map & 0xff800000;
+			w->size = 0x100000 << (((map & 0x000f0000) >> 16) - 4);
+		}
+	}
+	dove_mbus_dram_info.num_cs = cs;
+}
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
new file mode 100644
index 0000000..a9248ce
--- /dev/null
+++ b/arch/arm/mach-dove/common.c
@@ -0,0 +1,777 @@
+/*
+ * arch/arm/mach-dove/common.c
+ *
+ * Core functions for Marvell Dove 88AP510 System On Chip
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/clk.h>
+#include <linux/mbus.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/mv643xx_i2c.h>
+#include <linux/ata_platform.h>
+#include <linux/spi/orion_spi.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+#include <asm/timex.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/mach/pci.h>
+#include <mach/dove.h>
+#include <mach/bridge-regs.h>
+#include <asm/mach/arch.h>
+#include <mach/gpio.h>
+#include <linux/irq.h>
+#include <plat/mv_xor.h>
+#include <plat/ehci-orion.h>
+#include <plat/time.h>
+#include "common.h"
+
+/*****************************************************************************
+ * I/O Address Mapping
+ ****************************************************************************/
+static struct map_desc dove_io_desc[] __initdata = {
+	{
+		.virtual	= DOVE_SB_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(DOVE_SB_REGS_PHYS_BASE),
+		.length		= DOVE_SB_REGS_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= DOVE_NB_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(DOVE_NB_REGS_PHYS_BASE),
+		.length		= DOVE_NB_REGS_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= DOVE_PCIE0_IO_VIRT_BASE,
+		.pfn		= __phys_to_pfn(DOVE_PCIE0_IO_PHYS_BASE),
+		.length		= DOVE_PCIE0_IO_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= DOVE_PCIE1_IO_VIRT_BASE,
+		.pfn		= __phys_to_pfn(DOVE_PCIE1_IO_PHYS_BASE),
+		.length		= DOVE_PCIE1_IO_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+void __init dove_map_io(void)
+{
+	iotable_init(dove_io_desc, ARRAY_SIZE(dove_io_desc));
+}
+
+/*****************************************************************************
+ * EHCI
+ ****************************************************************************/
+static struct orion_ehci_data dove_ehci_data = {
+	.dram		= &dove_mbus_dram_info,
+	.phy_version	= EHCI_PHY_NA,
+};
+
+static u64 ehci_dmamask = DMA_BIT_MASK(32);
+
+/*****************************************************************************
+ * EHCI0
+ ****************************************************************************/
+static struct resource dove_ehci0_resources[] = {
+	{
+		.start	= DOVE_USB0_PHYS_BASE,
+		.end	= DOVE_USB0_PHYS_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_USB0,
+		.end	= IRQ_DOVE_USB0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_ehci0 = {
+	.name		= "orion-ehci",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &dove_ehci_data,
+	},
+	.resource	= dove_ehci0_resources,
+	.num_resources	= ARRAY_SIZE(dove_ehci0_resources),
+};
+
+void __init dove_ehci0_init(void)
+{
+	platform_device_register(&dove_ehci0);
+}
+
+/*****************************************************************************
+ * EHCI1
+ ****************************************************************************/
+static struct resource dove_ehci1_resources[] = {
+	{
+		.start	= DOVE_USB1_PHYS_BASE,
+		.end	= DOVE_USB1_PHYS_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_USB1,
+		.end	= IRQ_DOVE_USB1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_ehci1 = {
+	.name		= "orion-ehci",
+	.id		= 1,
+	.dev		= {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &dove_ehci_data,
+	},
+	.resource	= dove_ehci1_resources,
+	.num_resources	= ARRAY_SIZE(dove_ehci1_resources),
+};
+
+void __init dove_ehci1_init(void)
+{
+	platform_device_register(&dove_ehci1);
+}
+
+/*****************************************************************************
+ * GE00
+ ****************************************************************************/
+struct mv643xx_eth_shared_platform_data dove_ge00_shared_data = {
+	.t_clk		= 0,
+	.dram		= &dove_mbus_dram_info,
+};
+
+static struct resource dove_ge00_shared_resources[] = {
+	{
+		.name	= "ge00 base",
+		.start	= DOVE_GE00_PHYS_BASE + 0x2000,
+		.end	= DOVE_GE00_PHYS_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dove_ge00_shared = {
+	.name		= MV643XX_ETH_SHARED_NAME,
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &dove_ge00_shared_data,
+	},
+	.num_resources	= 1,
+	.resource	= dove_ge00_shared_resources,
+};
+
+static struct resource dove_ge00_resources[] = {
+	{
+		.name	= "ge00 irq",
+		.start	= IRQ_DOVE_GE00_SUM,
+		.end	= IRQ_DOVE_GE00_SUM,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_ge00 = {
+	.name		= MV643XX_ETH_NAME,
+	.id		= 0,
+	.num_resources	= 1,
+	.resource	= dove_ge00_resources,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
+{
+	eth_data->shared = &dove_ge00_shared;
+	dove_ge00.dev.platform_data = eth_data;
+
+	platform_device_register(&dove_ge00_shared);
+	platform_device_register(&dove_ge00);
+}
+
+/*****************************************************************************
+ * SoC RTC
+ ****************************************************************************/
+static struct resource dove_rtc_resource[] = {
+	{
+		.start	= DOVE_RTC_PHYS_BASE,
+		.end	= DOVE_RTC_PHYS_BASE + 32 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_RTC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+void __init dove_rtc_init(void)
+{
+	platform_device_register_simple("rtc-mv", -1, dove_rtc_resource, 2);
+}
+
+/*****************************************************************************
+ * SATA
+ ****************************************************************************/
+static struct resource dove_sata_resources[] = {
+	{
+		.name	= "sata base",
+		.start	= DOVE_SATA_PHYS_BASE,
+		.end	= DOVE_SATA_PHYS_BASE + 0x5000 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "sata irq",
+		.start	= IRQ_DOVE_SATA,
+		.end	= IRQ_DOVE_SATA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_sata = {
+	.name		= "sata_mv",
+	.id		= 0,
+	.dev		= {
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(dove_sata_resources),
+	.resource	= dove_sata_resources,
+};
+
+void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
+{
+	sata_data->dram = &dove_mbus_dram_info;
+	dove_sata.dev.platform_data = sata_data;
+	platform_device_register(&dove_sata);
+}
+
+/*****************************************************************************
+ * UART0
+ ****************************************************************************/
+static struct plat_serial8250_port dove_uart0_data[] = {
+	{
+		.mapbase	= DOVE_UART0_PHYS_BASE,
+		.membase	= (char *)DOVE_UART0_VIRT_BASE,
+		.irq		= IRQ_DOVE_UART_0,
+		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 0,
+	}, {
+	},
+};
+
+static struct resource dove_uart0_resources[] = {
+	{
+		.start		= DOVE_UART0_PHYS_BASE,
+		.end		= DOVE_UART0_PHYS_BASE + SZ_256 - 1,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= IRQ_DOVE_UART_0,
+		.end		= IRQ_DOVE_UART_0,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_uart0 = {
+	.name			= "serial8250",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= dove_uart0_data,
+	},
+	.resource		= dove_uart0_resources,
+	.num_resources		= ARRAY_SIZE(dove_uart0_resources),
+};
+
+void __init dove_uart0_init(void)
+{
+	platform_device_register(&dove_uart0);
+}
+
+/*****************************************************************************
+ * UART1
+ ****************************************************************************/
+static struct plat_serial8250_port dove_uart1_data[] = {
+	{
+		.mapbase	= DOVE_UART1_PHYS_BASE,
+		.membase	= (char *)DOVE_UART1_VIRT_BASE,
+		.irq		= IRQ_DOVE_UART_1,
+		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 0,
+	}, {
+	},
+};
+
+static struct resource dove_uart1_resources[] = {
+	{
+		.start		= DOVE_UART1_PHYS_BASE,
+		.end		= DOVE_UART1_PHYS_BASE + SZ_256 - 1,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= IRQ_DOVE_UART_1,
+		.end		= IRQ_DOVE_UART_1,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_uart1 = {
+	.name			= "serial8250",
+	.id			= 1,
+	.dev			= {
+		.platform_data	= dove_uart1_data,
+	},
+	.resource		= dove_uart1_resources,
+	.num_resources		= ARRAY_SIZE(dove_uart1_resources),
+};
+
+void __init dove_uart1_init(void)
+{
+	platform_device_register(&dove_uart1);
+}
+
+/*****************************************************************************
+ * UART2
+ ****************************************************************************/
+static struct plat_serial8250_port dove_uart2_data[] = {
+	{
+		.mapbase	= DOVE_UART2_PHYS_BASE,
+		.membase	= (char *)DOVE_UART2_VIRT_BASE,
+		.irq		= IRQ_DOVE_UART_2,
+		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 0,
+	}, {
+	},
+};
+
+static struct resource dove_uart2_resources[] = {
+	{
+		.start		= DOVE_UART2_PHYS_BASE,
+		.end		= DOVE_UART2_PHYS_BASE + SZ_256 - 1,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= IRQ_DOVE_UART_2,
+		.end		= IRQ_DOVE_UART_2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_uart2 = {
+	.name			= "serial8250",
+	.id			= 2,
+	.dev			= {
+		.platform_data	= dove_uart2_data,
+	},
+	.resource		= dove_uart2_resources,
+	.num_resources		= ARRAY_SIZE(dove_uart2_resources),
+};
+
+void __init dove_uart2_init(void)
+{
+	platform_device_register(&dove_uart2);
+}
+
+/*****************************************************************************
+ * UART3
+ ****************************************************************************/
+static struct plat_serial8250_port dove_uart3_data[] = {
+	{
+		.mapbase	= DOVE_UART3_PHYS_BASE,
+		.membase	= (char *)DOVE_UART3_VIRT_BASE,
+		.irq		= IRQ_DOVE_UART_3,
+		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 0,
+	}, {
+	},
+};
+
+static struct resource dove_uart3_resources[] = {
+	{
+		.start		= DOVE_UART3_PHYS_BASE,
+		.end		= DOVE_UART3_PHYS_BASE + SZ_256 - 1,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= IRQ_DOVE_UART_3,
+		.end		= IRQ_DOVE_UART_3,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_uart3 = {
+	.name			= "serial8250",
+	.id			= 3,
+	.dev			= {
+		.platform_data	= dove_uart3_data,
+	},
+	.resource		= dove_uart3_resources,
+	.num_resources		= ARRAY_SIZE(dove_uart3_resources),
+};
+
+void __init dove_uart3_init(void)
+{
+	platform_device_register(&dove_uart3);
+}
+
+/*****************************************************************************
+ * SPI0
+ ****************************************************************************/
+static struct orion_spi_info dove_spi0_data = {
+	.tclk		= 0,
+};
+
+static struct resource dove_spi0_resources[] = {
+	{
+		.start	= DOVE_SPI0_PHYS_BASE,
+		.end	= DOVE_SPI0_PHYS_BASE + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_SPI0,
+		.end	= IRQ_DOVE_SPI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_spi0 = {
+	.name		= "orion_spi",
+	.id		= 0,
+	.resource	= dove_spi0_resources,
+	.dev		= {
+		.platform_data	= &dove_spi0_data,
+	},
+	.num_resources	= ARRAY_SIZE(dove_spi0_resources),
+};
+
+void __init dove_spi0_init(void)
+{
+	platform_device_register(&dove_spi0);
+}
+
+/*****************************************************************************
+ * SPI1
+ ****************************************************************************/
+static struct orion_spi_info dove_spi1_data = {
+	.tclk		= 0,
+};
+
+static struct resource dove_spi1_resources[] = {
+	{
+		.start	= DOVE_SPI1_PHYS_BASE,
+		.end	= DOVE_SPI1_PHYS_BASE + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_SPI1,
+		.end	= IRQ_DOVE_SPI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_spi1 = {
+	.name		= "orion_spi",
+	.id		= 1,
+	.resource	= dove_spi1_resources,
+	.dev		= {
+		.platform_data	= &dove_spi1_data,
+	},
+	.num_resources	= ARRAY_SIZE(dove_spi1_resources),
+};
+
+void __init dove_spi1_init(void)
+{
+	platform_device_register(&dove_spi1);
+}
+
+/*****************************************************************************
+ * I2C
+ ****************************************************************************/
+static struct mv64xxx_i2c_pdata dove_i2c_data = {
+	.freq_m		= 10, /* assumes 166 MHz TCLK gets 94.3kHz */
+	.freq_n		= 3,
+	.timeout	= 1000, /* Default timeout of 1 second */
+};
+
+static struct resource dove_i2c_resources[] = {
+	{
+		.name	= "i2c base",
+		.start	= DOVE_I2C_PHYS_BASE,
+		.end	= DOVE_I2C_PHYS_BASE + 0x20 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "i2c irq",
+		.start	= IRQ_DOVE_I2C,
+		.end	= IRQ_DOVE_I2C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_i2c = {
+	.name		= MV64XXX_I2C_CTLR_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dove_i2c_resources),
+	.resource	= dove_i2c_resources,
+	.dev		= {
+		.platform_data = &dove_i2c_data,
+	},
+};
+
+void __init dove_i2c_init(void)
+{
+	platform_device_register(&dove_i2c);
+}
+
+/*****************************************************************************
+ * Time handling
+ ****************************************************************************/
+static int get_tclk(void)
+{
+	/* use DOVE_RESET_SAMPLE_HI/LO to detect tclk */
+	return 166666667;
+}
+
+static void dove_timer_init(void)
+{
+	orion_time_init(IRQ_DOVE_BRIDGE, get_tclk());
+}
+
+struct sys_timer dove_timer = {
+	.init = dove_timer_init,
+};
+
+/*****************************************************************************
+ * XOR
+ ****************************************************************************/
+static struct mv_xor_platform_shared_data dove_xor_shared_data = {
+	.dram		= &dove_mbus_dram_info,
+};
+
+/*****************************************************************************
+ * XOR 0
+ ****************************************************************************/
+static u64 dove_xor0_dmamask = DMA_BIT_MASK(32);
+
+static struct resource dove_xor0_shared_resources[] = {
+	{
+		.name	= "xor 0 low",
+		.start	= DOVE_XOR0_PHYS_BASE,
+		.end	= DOVE_XOR0_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "xor 0 high",
+		.start	= DOVE_XOR0_HIGH_PHYS_BASE,
+		.end	= DOVE_XOR0_HIGH_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dove_xor0_shared = {
+	.name		= MV_XOR_SHARED_NAME,
+	.id		= 0,
+	.dev		= {
+		.platform_data = &dove_xor_shared_data,
+	},
+	.num_resources	= ARRAY_SIZE(dove_xor0_shared_resources),
+	.resource	= dove_xor0_shared_resources,
+};
+
+static struct resource dove_xor00_resources[] = {
+	[0] = {
+		.start	= IRQ_DOVE_XOR_00,
+		.end	= IRQ_DOVE_XOR_00,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv_xor_platform_data dove_xor00_data = {
+	.shared		= &dove_xor0_shared,
+	.hw_id		= 0,
+	.pool_size	= PAGE_SIZE,
+};
+
+static struct platform_device dove_xor00_channel = {
+	.name		= MV_XOR_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dove_xor00_resources),
+	.resource	= dove_xor00_resources,
+	.dev		= {
+		.dma_mask		= &dove_xor0_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(64),
+		.platform_data		= (void *)&dove_xor00_data,
+	},
+};
+
+static struct resource dove_xor01_resources[] = {
+	[0] = {
+		.start	= IRQ_DOVE_XOR_01,
+		.end	= IRQ_DOVE_XOR_01,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv_xor_platform_data dove_xor01_data = {
+	.shared		= &dove_xor0_shared,
+	.hw_id		= 1,
+	.pool_size	= PAGE_SIZE,
+};
+
+static struct platform_device dove_xor01_channel = {
+	.name		= MV_XOR_NAME,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(dove_xor01_resources),
+	.resource	= dove_xor01_resources,
+	.dev		= {
+		.dma_mask		= &dove_xor0_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(64),
+		.platform_data		= (void *)&dove_xor01_data,
+	},
+};
+
+void __init dove_xor0_init(void)
+{
+	platform_device_register(&dove_xor0_shared);
+
+	/*
+	 * two engines can't do memset simultaneously, this limitation
+	 * satisfied by removing memset support from one of the engines.
+	 */
+	dma_cap_set(DMA_MEMCPY, dove_xor00_data.cap_mask);
+	dma_cap_set(DMA_XOR, dove_xor00_data.cap_mask);
+	platform_device_register(&dove_xor00_channel);
+
+	dma_cap_set(DMA_MEMCPY, dove_xor01_data.cap_mask);
+	dma_cap_set(DMA_MEMSET, dove_xor01_data.cap_mask);
+	dma_cap_set(DMA_XOR, dove_xor01_data.cap_mask);
+	platform_device_register(&dove_xor01_channel);
+}
+
+/*****************************************************************************
+ * XOR 1
+ ****************************************************************************/
+static u64 dove_xor1_dmamask = DMA_BIT_MASK(32);
+
+static struct resource dove_xor1_shared_resources[] = {
+	{
+		.name	= "xor 0 low",
+		.start	= DOVE_XOR1_PHYS_BASE,
+		.end	= DOVE_XOR1_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "xor 0 high",
+		.start	= DOVE_XOR1_HIGH_PHYS_BASE,
+		.end	= DOVE_XOR1_HIGH_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dove_xor1_shared = {
+	.name		= MV_XOR_SHARED_NAME,
+	.id		= 1,
+	.dev		= {
+		.platform_data = &dove_xor_shared_data,
+	},
+	.num_resources	= ARRAY_SIZE(dove_xor1_shared_resources),
+	.resource	= dove_xor1_shared_resources,
+};
+
+static struct resource dove_xor10_resources[] = {
+	[0] = {
+		.start	= IRQ_DOVE_XOR_10,
+		.end	= IRQ_DOVE_XOR_10,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv_xor_platform_data dove_xor10_data = {
+	.shared		= &dove_xor1_shared,
+	.hw_id		= 0,
+	.pool_size	= PAGE_SIZE,
+};
+
+static struct platform_device dove_xor10_channel = {
+	.name		= MV_XOR_NAME,
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(dove_xor10_resources),
+	.resource	= dove_xor10_resources,
+	.dev		= {
+		.dma_mask		= &dove_xor1_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(64),
+		.platform_data		= (void *)&dove_xor10_data,
+	},
+};
+
+static struct resource dove_xor11_resources[] = {
+	[0] = {
+		.start	= IRQ_DOVE_XOR_11,
+		.end	= IRQ_DOVE_XOR_11,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv_xor_platform_data dove_xor11_data = {
+	.shared		= &dove_xor1_shared,
+	.hw_id		= 1,
+	.pool_size	= PAGE_SIZE,
+};
+
+static struct platform_device dove_xor11_channel = {
+	.name		= MV_XOR_NAME,
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(dove_xor11_resources),
+	.resource	= dove_xor11_resources,
+	.dev		= {
+		.dma_mask		= &dove_xor1_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(64),
+		.platform_data		= (void *)&dove_xor11_data,
+	},
+};
+
+void __init dove_xor1_init(void)
+{
+	platform_device_register(&dove_xor1_shared);
+
+	/*
+	 * two engines can't do memset simultaneously, this limitation
+	 * satisfied by removing memset support from one of the engines.
+	 */
+	dma_cap_set(DMA_MEMCPY, dove_xor10_data.cap_mask);
+	dma_cap_set(DMA_XOR, dove_xor10_data.cap_mask);
+	platform_device_register(&dove_xor10_channel);
+
+	dma_cap_set(DMA_MEMCPY, dove_xor11_data.cap_mask);
+	dma_cap_set(DMA_MEMSET, dove_xor11_data.cap_mask);
+	dma_cap_set(DMA_XOR, dove_xor11_data.cap_mask);
+	platform_device_register(&dove_xor11_channel);
+}
+
+void __init dove_init(void)
+{
+	int tclk;
+
+	tclk = get_tclk();
+
+	printk(KERN_INFO "Dove 88AP510 SoC, ");
+	printk(KERN_INFO "TCLK = %dMHz\n", (tclk + 499999) / 1000000);
+
+	dove_setup_cpu_mbus();
+
+	dove_ge00_shared_data.t_clk = tclk;
+	dove_uart0_data[0].uartclk = tclk;
+	dove_uart1_data[0].uartclk = tclk;
+	dove_uart2_data[0].uartclk = tclk;
+	dove_uart3_data[0].uartclk = tclk;
+	dove_spi0_data.tclk = tclk;
+	dove_spi1_data.tclk = tclk;
+
+	/* internal devices that every board has */
+	dove_rtc_init();
+	dove_xor0_init();
+	dove_xor1_init();
+}
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
new file mode 100644
index 0000000..b29e893
--- /dev/null
+++ b/arch/arm/mach-dove/common.h
@@ -0,0 +1,40 @@
+/*
+ * arch/arm/mach-dove/common.h
+ *
+ * Core functions for Marvell Dove 88AP510 System On Chip
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_DOVE_COMMON_H
+#define __ARCH_DOVE_COMMON_H
+
+struct mv643xx_eth_platform_data;
+struct mv_sata_platform_data;
+
+extern struct sys_timer dove_timer;
+extern struct mbus_dram_target_info dove_mbus_dram_info;
+
+/*
+ * Basic Dove init functions used early by machine-setup.
+ */
+void dove_map_io(void);
+void dove_init(void);
+void dove_init_irq(void);
+void dove_setup_cpu_mbus(void);
+void dove_ge00_init(struct mv643xx_eth_platform_data *eth_data);
+void dove_sata_init(struct mv_sata_platform_data *sata_data);
+void dove_pcie_init(int init_port0, int init_port1);
+void dove_ehci0_init(void);
+void dove_ehci1_init(void);
+void dove_uart0_init(void);
+void dove_uart1_init(void);
+void dove_uart2_init(void);
+void dove_uart3_init(void);
+void dove_spi0_init(void);
+void dove_spi1_init(void);
+void dove_i2c_init(void);
+
+#endif
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
new file mode 100644
index 0000000..0260849
--- /dev/null
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -0,0 +1,102 @@
+/*
+ * arch/arm/mach-dove/dove-db-setup.c
+ *
+ * Marvell DB-MV88AP510-BP Development Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/nand.h>
+#include <linux/timer.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/i2c.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <linux/spi/flash.h>
+#include <asm/mach-types.h>
+#include <asm/gpio.h>
+#include <asm/mach/arch.h>
+#include <mach/dove.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data dove_db_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
+};
+
+static struct mv_sata_platform_data dove_db_sata_data = {
+	.n_ports        = 1,
+};
+
+/*****************************************************************************
+ * SPI Devices:
+ * 	SPI0: 4M Flash ST-M25P32-VMF6P
+ ****************************************************************************/
+static const struct flash_platform_data dove_db_spi_flash_data = {
+	.type		= "m25p64",
+};
+
+static struct spi_board_info __initdata dove_db_spi_flash_info[] = {
+	{
+		.modalias       = "m25p80",
+		.platform_data  = &dove_db_spi_flash_data,
+		.irq            = -1,
+		.max_speed_hz   = 20000000,
+		.bus_num        = 0,
+		.chip_select    = 0,
+	},
+};
+
+/*****************************************************************************
+ * PCI
+ ****************************************************************************/
+static int __init dove_db_pci_init(void)
+{
+	if (machine_is_dove_db())
+		dove_pcie_init(1, 1);
+
+	return 0;
+}
+
+subsys_initcall(dove_db_pci_init);
+
+/*****************************************************************************
+ * Board Init
+ ****************************************************************************/
+static void __init dove_db_init(void)
+{
+	/*
+	 * Basic Dove setup. Needs to be called early.
+	 */
+	dove_init();
+
+	dove_ge00_init(&dove_db_ge00_data);
+	dove_ehci0_init();
+	dove_ehci1_init();
+	dove_sata_init(&dove_db_sata_data);
+	dove_spi0_init();
+	dove_spi1_init();
+	dove_uart0_init();
+	dove_uart1_init();
+	dove_i2c_init();
+	spi_register_board_info(dove_db_spi_flash_info,
+				ARRAY_SIZE(dove_db_spi_flash_info));
+}
+
+MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
+	.phys_io	= DOVE_SB_REGS_PHYS_BASE,
+	.io_pg_offst	= ((DOVE_SB_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= dove_db_init,
+	.map_io		= dove_map_io,
+	.init_irq	= dove_init_irq,
+	.timer		= &dove_timer,
+MACHINE_END
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
new file mode 100644
index 0000000..214a4c3
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -0,0 +1,58 @@
+/*
+ * arch/arm/mach-dove/include/mach/bridge-regs.h
+ *
+ * Mbus-L to Mbus Bridge Registers
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_BRIDGE_REGS_H
+#define __ASM_ARCH_BRIDGE_REGS_H
+
+#include <mach/dove.h>
+
+#define CPU_CONFIG		(BRIDGE_VIRT_BASE | 0x0000)
+
+#define CPU_CONTROL		(BRIDGE_VIRT_BASE | 0x0104)
+#define  CPU_CTRL_PCIE0_LINK	0x00000001
+#define  CPU_RESET		0x00000002
+#define  CPU_CTRL_PCIE1_LINK	0x00000008
+
+#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE | 0x0108)
+#define  SOFT_RESET_OUT_EN	0x00000004
+
+#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
+#define  SOFT_RESET		0x00000001
+
+#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
+#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
+#define  BRIDGE_INT_TIMER0	0x0002
+#define  BRIDGE_INT_TIMER1	0x0004
+#define  BRIDGE_INT_TIMER1_CLR	(~0x0004)
+
+#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
+#define IRQ_CAUSE_LOW_OFF	0x0000
+#define IRQ_MASK_LOW_OFF	0x0004
+#define FIQ_MASK_LOW_OFF	0x0008
+#define ENDPOINT_MASK_LOW_OFF	0x000c
+#define IRQ_CAUSE_HIGH_OFF	0x0010
+#define IRQ_MASK_HIGH_OFF	0x0014
+#define FIQ_MASK_HIGH_OFF	0x0018
+#define ENDPOINT_MASK_HIGH_OFF	0x001c
+#define PCIE_INTERRUPT_MASK_OFF	0x0020
+
+#define IRQ_MASK_LOW		(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF)
+#define FIQ_MASK_LOW		(IRQ_VIRT_BASE + FIQ_MASK_LOW_OFF)
+#define ENDPOINT_MASK_LOW	(IRQ_VIRT_BASE + ENDPOINT_MASK_LOW_OFF)
+#define IRQ_MASK_HIGH		(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF)
+#define FIQ_MASK_HIGH		(IRQ_VIRT_BASE + FIQ_MASK_HIGH_OFF)
+#define ENDPOINT_MASK_HIGH	(IRQ_VIRT_BASE + ENDPOINT_MASK_HIGH_OFF)
+#define PCIE_INTERRUPT_MASK	(IRQ_VIRT_BASE + PCIE_INTERRUPT_MASK_OFF)
+
+#define POWER_MANAGEMENT	(BRIDGE_VIRT_BASE | 0x011c)
+
+#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
new file mode 100644
index 0000000..9b89ec7
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -0,0 +1,20 @@
+/*
+ * arch/arm/mach-dove/include/mach/debug-macro.S
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <mach/bridge-regs.h>
+
+	.macro	addruart,rx
+	mrc	p15, 0, \rx, c1, c0
+	tst	\rx, #1					@ MMU enabled?
+	ldreq	\rx, =DOVE_SB_REGS_PHYS_BASE
+	ldrne	\rx, =DOVE_SB_REGS_VIRT_BASE
+	orr	\rx, \rx, #0x00012000
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
new file mode 100644
index 0000000..f6a0839
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -0,0 +1,180 @@
+/*
+ * arch/arm/mach-dove/include/mach/dove.h
+ *
+ * Generic definitions for Marvell Dove 88AP510 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_DOVE_H
+#define __ASM_ARCH_DOVE_H
+
+#include <mach/vmalloc.h>
+
+/*
+ * Marvell Dove address maps.
+ *
+ * phys		virt		size
+ * c8000000	fdb00000	1M	Cryptographic SRAM
+ * e0000000	@runtime	128M	PCIe-0 Memory space
+ * e8000000	@runtime	128M	PCIe-1 Memory space
+ * f1000000	fde00000	8M	on-chip south-bridge registers
+ * f1800000	fe600000	8M	on-chip north-bridge registers
+ * f2000000	fee00000	1M	PCIe-0 I/O space
+ * f2100000	fef00000	1M	PCIe-1 I/O space
+ */
+
+#define DOVE_CESA_PHYS_BASE		0xc8000000
+#define DOVE_CESA_VIRT_BASE		0xfdb00000
+#define DOVE_CESA_SIZE			SZ_1M
+
+#define DOVE_PCIE0_MEM_PHYS_BASE	0xe0000000
+#define DOVE_PCIE0_MEM_SIZE		SZ_128M
+
+#define DOVE_PCIE1_MEM_PHYS_BASE	0xe8000000
+#define DOVE_PCIE1_MEM_SIZE		SZ_128M
+
+#define DOVE_BOOTROM_PHYS_BASE		0xf8000000
+#define DOVE_BOOTROM_SIZE		SZ_128M
+
+#define DOVE_SCRATCHPAD_PHYS_BASE	0xf0000000
+#define DOVE_SCRATCHPAD_VIRT_BASE	0xfdd00000
+#define DOVE_SCRATCHPAD_SIZE		SZ_1M
+
+#define DOVE_SB_REGS_PHYS_BASE		0xf1000000
+#define DOVE_SB_REGS_VIRT_BASE		0xfde00000
+#define DOVE_SB_REGS_SIZE		SZ_8M
+
+#define DOVE_NB_REGS_PHYS_BASE		0xf1800000
+#define DOVE_NB_REGS_VIRT_BASE		0xfe600000
+#define DOVE_NB_REGS_SIZE		SZ_8M
+
+#define DOVE_PCIE0_IO_PHYS_BASE		0xf2000000
+#define DOVE_PCIE0_IO_VIRT_BASE		0xfee00000
+#define DOVE_PCIE0_IO_BUS_BASE		0x00000000
+#define DOVE_PCIE0_IO_SIZE		SZ_1M
+
+#define DOVE_PCIE1_IO_PHYS_BASE		0xf2100000
+#define DOVE_PCIE1_IO_VIRT_BASE		0xfef00000
+#define DOVE_PCIE1_IO_BUS_BASE		0x00100000
+#define DOVE_PCIE1_IO_SIZE		SZ_1M
+
+/*
+ * Dove Core Registers Map
+ */
+
+/* SPI, I2C, UART */
+#define DOVE_I2C_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x11000)
+#define DOVE_UART0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x12000)
+#define DOVE_UART0_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x12000)
+#define DOVE_UART1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x12100)
+#define DOVE_UART1_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x12100)
+#define DOVE_UART2_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x12200)
+#define DOVE_UART2_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x12200)
+#define DOVE_UART3_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x12300)
+#define DOVE_UART3_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x12300)
+#define DOVE_SPI0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x10600)
+#define DOVE_SPI1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x14600)
+
+/* North-South Bridge */
+#define BRIDGE_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x20000)
+
+/* Cryptographic Engine */
+#define DOVE_CRYPT_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x30000)
+
+/* PCIe 0 */
+#define DOVE_PCIE0_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x40000)
+
+/* USB */
+#define DOVE_USB0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x50000)
+#define DOVE_USB1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x51000)
+
+/* XOR 0 Engine */
+#define DOVE_XOR0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x60800)
+#define DOVE_XOR0_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x60800)
+#define DOVE_XOR0_HIGH_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x60A00)
+#define DOVE_XOR0_HIGH_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x60A00)
+
+/* XOR 1 Engine */
+#define DOVE_XOR1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x60900)
+#define DOVE_XOR1_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x60900)
+#define DOVE_XOR1_HIGH_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x60B00)
+#define DOVE_XOR1_HIGH_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x60B00)
+
+/* Gigabit Ethernet */
+#define DOVE_GE00_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x70000)
+
+/* PCIe 1 */
+#define DOVE_PCIE1_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0x80000)
+
+/* CAFE */
+#define DOVE_SDIO0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x92000)
+#define DOVE_SDIO1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x90000)
+#define DOVE_CAM_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x94000)
+#define DOVE_CAFE_WIN_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0x98000)
+
+/* SATA */
+#define DOVE_SATA_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xa0000)
+
+/* I2S/SPDIF */
+#define DOVE_AUD0_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xb0000)
+#define DOVE_AUD1_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xb4000)
+
+/* NAND Flash Controller */
+#define DOVE_NFC_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xc0000)
+
+/* MPP, GPIO, Reset Sampling */
+#define DOVE_MPP_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0200)
+#define DOVE_PMU_MPP_GENERAL_CTRL (DOVE_MPP_VIRT_BASE + 0x10)
+#define DOVE_RESET_SAMPLE_LO	(DOVE_MPP_VIRT_BASE | 0x014)
+#define DOVE_RESET_SAMPLE_HI	(DOVE_MPP_VIRT_BASE | 0x018)
+#define DOVE_GPIO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
+#define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe803c)
+#define  DOVE_AU1_SPDIFO_GPIO_EN	(1 << 1)
+#define  DOVE_NAND_GPIO_EN		(1 << 0)
+#define DOVE_MPP_CTRL4_VIRT_BASE	(DOVE_GPIO_VIRT_BASE + 0x40)
+
+
+/* Power Management */
+#define DOVE_PMU_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0000)
+
+/* Real Time Clock */
+#define DOVE_RTC_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xd8500)
+
+/* AC97 */
+#define DOVE_AC97_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xe0000)
+#define DOVE_AC97_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe0000)
+
+/* Peripheral DMA */
+#define DOVE_PDMA_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xe4000)
+#define DOVE_PDMA_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe4000)
+
+#define DOVE_GLOBAL_CONFIG_1	(DOVE_SB_REGS_VIRT_BASE | 0xe802C)
+#define  DOVE_TWSI_ENABLE_OPTION1	(1 << 7)
+#define DOVE_GLOBAL_CONFIG_2	(DOVE_SB_REGS_VIRT_BASE | 0xe8030)
+#define  DOVE_TWSI_ENABLE_OPTION2	(1 << 20)
+#define  DOVE_TWSI_ENABLE_OPTION3	(1 << 21)
+#define  DOVE_TWSI_OPTION3_GPIO		(1 << 22)
+#define DOVE_SSP_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xec000)
+#define DOVE_SSP_CTRL_STATUS_1	(DOVE_SB_REGS_VIRT_BASE | 0xe8034)
+#define  DOVE_SSP_ON_AU1		(1 << 0)
+#define  DOVE_SSP_CLOCK_ENABLE		(1 << 1)
+#define  DOVE_SSP_BPB_CLOCK_SRC_SSP	(1 << 11)
+/* Memory Controller */
+#define DOVE_MC_VIRT_BASE	(DOVE_NB_REGS_VIRT_BASE | 0x00000)
+
+/* LCD Controller */
+#define DOVE_LCD_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x10000)
+#define DOVE_LCD1_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x20000)
+#define DOVE_LCD2_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x10000)
+#define DOVE_LCD_DCON_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x30000)
+
+/* Graphic Engine */
+#define DOVE_GPU_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x40000)
+
+/* Video Engine */
+#define DOVE_VPU_PHYS_BASE	(DOVE_NB_REGS_PHYS_BASE | 0x400000)
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
new file mode 100644
index 0000000..e84c78c
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/entry-macro.S
@@ -0,0 +1,39 @@
+/*
+ * arch/arm/mach-dove/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for Marvell Dove platforms
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/bridge-regs.h>
+
+	.macro  disable_fiq
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr	\base, =IRQ_VIRT_BASE
+	.endm
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	@ check low interrupts
+	ldr	\irqstat, [\base, #IRQ_CAUSE_LOW_OFF]
+	ldr	\tmp, [\base, #IRQ_MASK_LOW_OFF]
+	mov	\irqnr, #31
+	ands	\irqstat, \irqstat, \tmp
+
+	@ if no low interrupts set, check high interrupts
+	ldreq	\irqstat, [\base, #IRQ_CAUSE_HIGH_OFF]
+	ldreq	\tmp, [\base, #IRQ_MASK_HIGH_OFF]
+	moveq	\irqnr, #63
+	andeqs	\irqstat, \irqstat, \tmp
+
+	@ find first active interrupt source
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
new file mode 100644
index 0000000..0ee70ff
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/gpio.h
@@ -0,0 +1,49 @@
+/*
+ * arch/arm/mach-dove/include/mach/gpio.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H
+
+#include <asm/errno.h>
+#include <mach/irqs.h>
+#include <plat/gpio.h>
+#include <asm-generic/gpio.h>		/* cansleep wrappers */
+
+#define GPIO_MAX	64
+
+#define GPIO_BASE_LO		(DOVE_GPIO_VIRT_BASE + 0x00)
+#define GPIO_BASE_HI		(DOVE_GPIO_VIRT_BASE + 0x20)
+
+#define GPIO_BASE(pin)		((pin < 32) ? GPIO_BASE_LO : GPIO_BASE_HI)
+
+#define GPIO_OUT(pin)		(GPIO_BASE(pin) + 0x00)
+#define GPIO_IO_CONF(pin)	(GPIO_BASE(pin) + 0x04)
+#define GPIO_BLINK_EN(pin)	(GPIO_BASE(pin) + 0x08)
+#define GPIO_IN_POL(pin)	(GPIO_BASE(pin) + 0x0c)
+#define GPIO_DATA_IN(pin)	(GPIO_BASE(pin) + 0x10)
+#define GPIO_EDGE_CAUSE(pin)	(GPIO_BASE(pin) + 0x14)
+#define GPIO_EDGE_MASK(pin)	(GPIO_BASE(pin) + 0x18)
+#define GPIO_LEVEL_MASK(pin)	(GPIO_BASE(pin) + 0x1c)
+
+static inline int gpio_to_irq(int pin)
+{
+	if (pin < NR_GPIO_IRQS)
+		return pin + IRQ_DOVE_GPIO_START;
+
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(int irq)
+{
+	if (IRQ_DOVE_GPIO_START < irq && irq < NR_IRQS)
+		return irq - IRQ_DOVE_GPIO_START;
+
+	return -EINVAL;
+}
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/hardware.h b/arch/arm/mach-dove/include/mach/hardware.h
new file mode 100644
index 0000000..32b0826
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/hardware.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-dove/include/mach/hardware.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include "dove.h"
+
+#define pcibios_assign_all_busses()	1
+
+#define PCIBIOS_MIN_IO			0x1000
+#define PCIBIOS_MIN_MEM			0x01000000
+#define PCIMEM_BASE			DOVE_PCIE0_MEM_PHYS_BASE
+
+
+/* Macros below are required for compatibility with PXA AC'97 driver.	*/
+#define __REG(x)	(*((volatile u32 *)((x) - DOVE_SB_REGS_PHYS_BASE + \
+				DOVE_SB_REGS_VIRT_BASE)))
+#define __PREG(x)	(((u32)&(x)) - DOVE_SB_REGS_VIRT_BASE + \
+		DOVE_SB_REGS_PHYS_BASE)
+#endif
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
new file mode 100644
index 0000000..3b3e472
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -0,0 +1,20 @@
+/*
+ * arch/arm/mach-dove/include/mach/io.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_IO_H
+#define __ASM_ARCH_IO_H
+
+#include "dove.h"
+
+#define IO_SPACE_LIMIT		0xffffffff
+
+#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
+				   DOVE_PCIE0_IO_VIRT_BASE))
+#define __mem_pci(a)		(a)
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-dove/include/mach/irqs.h
new file mode 100644
index 0000000..4668146
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/irqs.h
@@ -0,0 +1,101 @@
+/*
+ * arch/arm/mach-dove/include/mach/irqs.h
+ *
+ * IRQ definitions for Marvell Dove 88AP510 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H
+
+/*
+ * Dove Low Interrupt Controller
+ */
+#define IRQ_DOVE_BRIDGE		0
+#define IRQ_DOVE_H2C		1
+#define IRQ_DOVE_C2H		2
+#define IRQ_DOVE_NAND		3
+#define IRQ_DOVE_PDMA		4
+#define IRQ_DOVE_SPI1		5
+#define IRQ_DOVE_SPI0		6
+#define IRQ_DOVE_UART_0		7
+#define IRQ_DOVE_UART_1		8
+#define IRQ_DOVE_UART_2		9
+#define IRQ_DOVE_UART_3		10
+#define IRQ_DOVE_I2C		11
+#define IRQ_DOVE_GPIO_0_7	12
+#define IRQ_DOVE_GPIO_8_15	13
+#define IRQ_DOVE_GPIO_16_23	14
+#define IRQ_DOVE_PCIE0_ERR	15
+#define IRQ_DOVE_PCIE0		16
+#define IRQ_DOVE_PCIE1_ERR	17
+#define IRQ_DOVE_PCIE1		18
+#define IRQ_DOVE_I2S0		19
+#define IRQ_DOVE_I2S0_ERR	20
+#define IRQ_DOVE_I2S1		21
+#define IRQ_DOVE_I2S1_ERR	22
+#define IRQ_DOVE_USB_ERR	23
+#define IRQ_DOVE_USB0		24
+#define IRQ_DOVE_USB1		25
+#define IRQ_DOVE_GE00_RX	26
+#define IRQ_DOVE_GE00_TX	27
+#define IRQ_DOVE_GE00_MISC	28
+#define IRQ_DOVE_GE00_SUM	29
+#define IRQ_DOVE_GE00_ERR	30
+#define IRQ_DOVE_CRYPTO		31
+
+/*
+ * Dove High Interrupt Controller
+ */
+#define IRQ_DOVE_AC97		32
+#define IRQ_DOVE_PMU		33
+#define IRQ_DOVE_CAM		34
+#define IRQ_DOVE_SDIO0		35
+#define IRQ_DOVE_SDIO1		36
+#define IRQ_DOVE_SDIO0_WAKEUP	37
+#define IRQ_DOVE_SDIO1_WAKEUP	38
+#define IRQ_DOVE_XOR_00		39
+#define IRQ_DOVE_XOR_01		40
+#define IRQ_DOVE_XOR0_ERR	41
+#define IRQ_DOVE_XOR_10		42
+#define IRQ_DOVE_XOR_11		43
+#define IRQ_DOVE_XOR1_ERR	44
+#define IRQ_DOVE_LCD_DCON	45
+#define IRQ_DOVE_LCD1		46
+#define IRQ_DOVE_LCD0		47
+#define IRQ_DOVE_GPU		48
+#define IRQ_DOVE_PERFORM_MNTR	49
+#define IRQ_DOVE_VPRO_DMA1	51
+#define IRQ_DOVE_SSP_TIMER	54
+#define IRQ_DOVE_SSP		55
+#define IRQ_DOVE_MC_L2_ERR	56
+#define IRQ_DOVE_CRYPTO_ERR	59
+#define IRQ_DOVE_GPIO_24_31	60
+#define IRQ_DOVE_HIGH_GPIO	61
+#define IRQ_DOVE_SATA		62
+
+/*
+ * DOVE General Purpose Pins
+ */
+#define IRQ_DOVE_GPIO_START	64
+#define NR_GPIO_IRQS		64
+
+/*
+ * PMU interrupts
+ */
+#define IRQ_DOVE_PMU_START	(IRQ_DOVE_GPIO_START + NR_GPIO_IRQS)
+#define NR_PMU_IRQS		7
+#define IRQ_DOVE_RTC		(IRQ_DOVE_PMU_START + 5)
+
+#define NR_IRQS			(IRQ_DOVE_PMU_START + NR_PMU_IRQS)
+
+/* Required for compatability with PXA AC97 driver.	*/
+#define IRQ_AC97		IRQ_DOVE_AC97
+/* Required for compatability with PXA DMA driver.	*/
+#define IRQ_DMA			IRQ_DOVE_PDMA
+/* Required for compatability with PXA NAND driver 	*/
+#define IRQ_NAND		IRQ_DOVE_NAND
+#endif
diff --git a/arch/arm/mach-dove/include/mach/memory.h b/arch/arm/mach-dove/include/mach/memory.h
new file mode 100644
index 0000000..d668720
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/memory.h
@@ -0,0 +1,10 @@
+/*
+ * arch/arm/mach-dove/include/mach/memory.h
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PHYS_OFFSET		UL(0x00000000)
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
new file mode 100644
index 0000000..3ad9f94
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/pm.h
@@ -0,0 +1,54 @@
+/*
+ * arch/arm/mach-dove/include/mach/pm.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_PM_H
+#define __ASM_ARCH_PM_H
+
+#include <asm/errno.h>
+#include <mach/irqs.h>
+
+#define CLOCK_GATING_CONTROL	(DOVE_PMU_VIRT_BASE + 0x38)
+#define  CLOCK_GATING_USB0_MASK		(1 << 0)
+#define  CLOCK_GATING_USB1_MASK		(1 << 1)
+#define  CLOCK_GATING_GBE_MASK		(1 << 2)
+#define  CLOCK_GATING_SATA_MASK		(1 << 3)
+#define  CLOCK_GATING_PCIE0_MASK	(1 << 4)
+#define  CLOCK_GATING_PCIE1_MASK	(1 << 5)
+#define  CLOCK_GATING_SDIO0_MASK	(1 << 8)
+#define  CLOCK_GATING_SDIO1_MASK	(1 << 9)
+#define  CLOCK_GATING_NAND_MASK		(1 << 10)
+#define  CLOCK_GATING_CAMERA_MASK	(1 << 11)
+#define  CLOCK_GATING_I2S0_MASK		(1 << 12)
+#define  CLOCK_GATING_I2S1_MASK		(1 << 13)
+#define  CLOCK_GATING_CRYPTO_MASK	(1 << 15)
+#define  CLOCK_GATING_AC97_MASK		(1 << 21)
+#define  CLOCK_GATING_PDMA_MASK		(1 << 22)
+#define  CLOCK_GATING_XOR0_MASK		(1 << 23)
+#define  CLOCK_GATING_XOR1_MASK		(1 << 24)
+#define  CLOCK_GATING_GIGA_PHY_MASK	(1 << 30)
+
+#define PMU_INTERRUPT_CAUSE	(DOVE_PMU_VIRT_BASE + 0x50)
+#define PMU_INTERRUPT_MASK	(DOVE_PMU_VIRT_BASE + 0x54)
+
+static inline int pmu_to_irq(int pin)
+{
+	if (pin < NR_PMU_IRQS)
+		return pin + IRQ_DOVE_PMU_START;
+
+	return -EINVAL;
+}
+
+static inline int irq_to_pmu(int irq)
+{
+	if (IRQ_DOVE_PMU_START < irq && irq < NR_IRQS)
+		return irq - IRQ_DOVE_PMU_START;
+
+	return -EINVAL;
+}
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
new file mode 100644
index 0000000..356afda
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/system.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/mach-dove/include/mach/system.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+#include <mach/bridge-regs.h>
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
+
+
+#endif
diff --git a/arch/arm/mach-dove/include/mach/timex.h b/arch/arm/mach-dove/include/mach/timex.h
new file mode 100644
index 0000000..251d538
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/timex.h
@@ -0,0 +1,9 @@
+/*
+ * arch/arm/mach-dove/include/mach/timex.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
new file mode 100644
index 0000000..2c5cdd7
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -0,0 +1,37 @@
+/*
+ * arch/arm/mach-dove/include/mach/uncompress.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/dove.h>
+
+#define UART_THR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x0))
+#define UART_LSR ((volatile unsigned char *)(DOVE_UART0_PHYS_BASE + 0x14))
+
+#define LSR_THRE	0x20
+
+static void putc(const char c)
+{
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		/* Transmit fifo not full? */
+		if (*UART_LSR & LSR_THRE)
+			break;
+	}
+
+	*UART_THR = c;
+}
+
+static void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-dove/include/mach/vmalloc.h b/arch/arm/mach-dove/include/mach/vmalloc.h
new file mode 100644
index 0000000..a952af2
--- /dev/null
+++ b/arch/arm/mach-dove/include/mach/vmalloc.h
@@ -0,0 +1,6 @@
+/*
+ * arch/arm/mach-dove/include/mach/vmalloc.h
+ */
+
+#define VMALLOC_END	0xfd800000
+
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
new file mode 100644
index 0000000..aaf0cb5
--- /dev/null
+++ b/arch/arm/mach-dove/irq.c
@@ -0,0 +1,133 @@
+/*
+ * arch/arm/mach-dove/irq.c
+ *
+ * Dove IRQ handling.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/mach/arch.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <plat/irq.h>
+#include <asm/mach/irq.h>
+#include <mach/pm.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+
+static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	int irqoff;
+	BUG_ON(irq < IRQ_DOVE_GPIO_0_7 || irq > IRQ_DOVE_HIGH_GPIO);
+
+	irqoff = irq <= IRQ_DOVE_GPIO_16_23 ? irq - IRQ_DOVE_GPIO_0_7 :
+		3 + irq - IRQ_DOVE_GPIO_24_31;
+
+	orion_gpio_irq_handler(irqoff << 3);
+	if (irq == IRQ_DOVE_HIGH_GPIO) {
+		orion_gpio_irq_handler(40);
+		orion_gpio_irq_handler(48);
+		orion_gpio_irq_handler(56);
+	}
+}
+
+static void pmu_irq_mask(unsigned int irq)
+{
+	int pin = irq_to_pmu(irq);
+	u32 u;
+
+	u = readl(PMU_INTERRUPT_MASK);
+	u &= ~(1 << (pin & 31));
+	writel(u, PMU_INTERRUPT_MASK);
+}
+
+static void pmu_irq_unmask(unsigned int irq)
+{
+	int pin = irq_to_pmu(irq);
+	u32 u;
+
+	u = readl(PMU_INTERRUPT_MASK);
+	u |= 1 << (pin & 31);
+	writel(u, PMU_INTERRUPT_MASK);
+}
+
+static void pmu_irq_ack(unsigned int irq)
+{
+	int pin = irq_to_pmu(irq);
+	u32 u;
+
+	u = ~(1 << (pin & 31));
+	writel(u, PMU_INTERRUPT_CAUSE);
+}
+
+static struct irq_chip pmu_irq_chip = {
+	.name		= "pmu_irq",
+	.mask		= pmu_irq_mask,
+	.unmask		= pmu_irq_unmask,
+	.ack		= pmu_irq_ack,
+};
+
+static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
+
+	cause &= readl(PMU_INTERRUPT_MASK);
+	if (cause == 0) {
+		do_bad_IRQ(irq, desc);
+		return;
+	}
+
+	for (irq = 0; irq < NR_PMU_IRQS; irq++) {
+		if (!(cause & (1 << irq)))
+			continue;
+		irq = pmu_to_irq(irq);
+		desc = irq_desc + irq;
+		desc_handle_irq(irq, desc);
+	}
+}
+
+void __init dove_init_irq(void)
+{
+	int i;
+
+	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
+	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
+
+	/*
+	 * Mask and clear GPIO IRQ interrupts.
+	 */
+	writel(0, GPIO_LEVEL_MASK(0));
+	writel(0, GPIO_EDGE_MASK(0));
+	writel(0, GPIO_EDGE_CAUSE(0));
+
+	/*
+	 * Mask and clear PMU interrupts
+	 */
+	writel(0, PMU_INTERRUPT_MASK);
+	writel(0, PMU_INTERRUPT_CAUSE);
+
+	for (i = IRQ_DOVE_GPIO_START; i < IRQ_DOVE_PMU_START; i++) {
+		set_irq_chip(i, &orion_gpio_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		irq_desc[i].status |= IRQ_LEVEL;
+		set_irq_flags(i, IRQF_VALID);
+	}
+	set_irq_chained_handler(IRQ_DOVE_GPIO_0_7, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_8_15, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_16_23, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_24_31, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_HIGH_GPIO, gpio_irq_handler);
+
+	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
+		set_irq_chip(i, &pmu_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		irq_desc[i].status |= IRQ_LEVEL;
+		set_irq_flags(i, IRQF_VALID);
+	}
+	set_irq_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
+}
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
new file mode 100644
index 0000000..502d1ca
--- /dev/null
+++ b/arch/arm/mach-dove/pcie.c
@@ -0,0 +1,238 @@
+/*
+ * arch/arm/mach-dove/pcie.c
+ *
+ * PCIe functions for Marvell Dove 88AP510 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/mbus.h>
+#include <asm/mach/pci.h>
+#include <asm/mach/arch.h>
+#include <asm/setup.h>
+#include <asm/delay.h>
+#include <plat/pcie.h>
+#include <mach/irqs.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+
+struct pcie_port {
+	u8			index;
+	u8			root_bus_nr;
+	void __iomem		*base;
+	spinlock_t		conf_lock;
+	char			io_space_name[16];
+	char			mem_space_name[16];
+	struct resource		res[2];
+};
+
+static struct pcie_port pcie_port[2];
+static int num_pcie_ports;
+
+
+static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct pcie_port *pp;
+
+	if (nr >= num_pcie_ports)
+		return 0;
+
+	pp = &pcie_port[nr];
+	pp->root_bus_nr = sys->busnr;
+
+	/*
+	 * Generic PCIe unit setup.
+	 */
+	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
+
+	orion_pcie_setup(pp->base, &dove_mbus_dram_info);
+
+	/*
+	 * IORESOURCE_IO
+	 */
+	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
+		 "PCIe %d I/O", pp->index);
+	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
+	pp->res[0].name = pp->io_space_name;
+	if (pp->index == 0) {
+		pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
+		pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
+	} else {
+		pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
+		pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
+	}
+	pp->res[0].flags = IORESOURCE_IO;
+	if (request_resource(&ioport_resource, &pp->res[0]))
+		panic("Request PCIe IO resource failed\n");
+	sys->resource[0] = &pp->res[0];
+
+	/*
+	 * IORESOURCE_MEM
+	 */
+	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
+		 "PCIe %d MEM", pp->index);
+	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
+	pp->res[1].name = pp->mem_space_name;
+	if (pp->index == 0) {
+		pp->res[1].start = DOVE_PCIE0_MEM_PHYS_BASE;
+		pp->res[1].end = pp->res[1].start + DOVE_PCIE0_MEM_SIZE - 1;
+	} else {
+		pp->res[1].start = DOVE_PCIE1_MEM_PHYS_BASE;
+		pp->res[1].end = pp->res[1].start + DOVE_PCIE1_MEM_SIZE - 1;
+	}
+	pp->res[1].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[1]))
+		panic("Request PCIe Memory resource failed\n");
+	sys->resource[1] = &pp->res[1];
+
+	sys->resource[2] = NULL;
+
+	return 1;
+}
+
+static struct pcie_port *bus_to_port(int bus)
+{
+	int i;
+
+	for (i = num_pcie_ports - 1; i >= 0; i--) {
+		int rbus = pcie_port[i].root_bus_nr;
+		if (rbus != -1 && rbus <= bus)
+			break;
+	}
+
+	return i >= 0 ? pcie_port + i : NULL;
+}
+
+static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
+{
+	/*
+	 * Don't go out when trying to access nonexisting devices
+	 * on the local bus.
+	 */
+	if (bus == pp->root_bus_nr && dev > 1)
+		return 0;
+
+	return 1;
+}
+
+static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+			int size, u32 *val)
+{
+	struct pcie_port *pp = bus_to_port(bus->number);
+	unsigned long flags;
+	int ret;
+
+	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	ret = orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
+
+	return ret;
+}
+
+static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
+			int where, int size, u32 val)
+{
+	struct pcie_port *pp = bus_to_port(bus->number);
+	unsigned long flags;
+	int ret;
+
+	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	ret = orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
+
+	return ret;
+}
+
+static struct pci_ops pcie_ops = {
+	.read = pcie_rd_conf,
+	.write = pcie_wr_conf,
+};
+
+static void __devinit rc_pci_fixup(struct pci_dev *dev)
+{
+	/*
+	 * Prevent enumeration of root complex.
+	 */
+	if (dev->bus->parent == NULL && dev->devfn == 0) {
+		int i;
+
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			dev->resource[i].start = 0;
+			dev->resource[i].end   = 0;
+			dev->resource[i].flags = 0;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
+
+static struct pci_bus __init *
+dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct pci_bus *bus;
+
+	if (nr < num_pcie_ports) {
+		bus = pci_scan_bus(sys->busnr, &pcie_ops, sys);
+	} else {
+		bus = NULL;
+		BUG();
+	}
+
+	return bus;
+}
+
+static int __init dove_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pcie_port *pp = bus_to_port(dev->bus->number);
+
+	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
+}
+
+static struct hw_pci dove_pci __initdata = {
+	.nr_controllers	= 2,
+	.swizzle	= pci_std_swizzle,
+	.setup		= dove_pcie_setup,
+	.scan		= dove_pcie_scan_bus,
+	.map_irq	= dove_pcie_map_irq,
+};
+
+static void __init add_pcie_port(int index, unsigned long base)
+{
+	printk(KERN_INFO "Dove PCIe port %d: ", index);
+
+	if (orion_pcie_link_up((void __iomem *)base)) {
+		struct pcie_port *pp = &pcie_port[num_pcie_ports++];
+
+		printk(KERN_INFO "link up\n");
+
+		pp->index = index;
+		pp->root_bus_nr = -1;
+		pp->base = (void __iomem *)base;
+		spin_lock_init(&pp->conf_lock);
+		memset(pp->res, 0, sizeof(pp->res));
+	} else {
+		printk(KERN_INFO "link down, ignoring\n");
+	}
+}
+
+void __init dove_pcie_init(int init_port0, int init_port1)
+{
+	if (init_port0)
+		add_pcie_port(0, DOVE_PCIE0_VIRT_BASE);
+
+	if (init_port1)
+		add_pcie_port(1, DOVE_PCIE1_VIRT_BASE);
+
+	pci_common_init(&dove_pci);
+}
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9264d81..1549863 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -388,7 +388,7 @@ config CPU_FEROCEON_OLD_ID
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_PABRT_V6
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 70f75d2..ebfe6c1 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -130,9 +130,16 @@ ENTRY(cpu_v6_set_pte_ext)
 
 
 
-
+	.type	cpu_v6_name, #object
 cpu_v6_name:
 	.asciz	"ARMv6-compatible processor"
+	.size	cpu_v6_name, . - cpu_v6_name
+
+	.type	cpu_pj4_name, #object
+cpu_pj4_name:
+	.asciz	"Marvell PJ4 processor"
+	.size	cpu_pj4_name, . - cpu_pj4_name
+
 	.align
 
 	__INIT
@@ -241,3 +248,27 @@ __v6_proc_info:
 	.long	v6_user_fns
 	.long	v6_cache_fns
 	.size	__v6_proc_info, . - __v6_proc_info
+
+	.type	__pj4_v6_proc_info, #object
+__pj4_v6_proc_info:
+	.long	0x560f5810
+	.long	0xff0ffff0
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_BUFFERABLE | \
+		PMD_SECT_CACHEABLE | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	b	__v6_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	cpu_pj4_name
+	.long	v6_processor_functions
+	.long	v6wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v6_cache_fns
+	.size	__v6_proc_info, . - __v6_proc_info
-- 
1.6.0.4
