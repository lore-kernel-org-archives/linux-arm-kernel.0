From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu, 29 Jul 2010 07:29:56 -0400
Subject: [PATCH v4] davinci: Add MityDSP-L138/MityARM-1808 SOM support
Message-ID: <4C516634.5040804@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 This patch adds support for the MityDSP-L138 and MityARM-1808 system on
module (SOM) under the registered machine "mityomapl138".  These SOMs
are based on the da850 davinci CPU architecture.  Information on these
SOMs may be found at http://www.mitydsp.com.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
This patch is against Kevin's tree, but is dependent on the following patch,
which is queued for 2.6.36:

[1] http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=48519f0ae03bc7e86b3dc93e56f1334d53803770

Changes since v3 patch was submitted:
    * renamed ATAG_PERIPHERALS to ATAG_MITYDSPL138
    * removed unused header files
    * renamed config structure items to remove camel case naming
    * don't use GPIO if resources aren't acquired
    * don't use device_initcall on emac config
    * handle upcoming patch to platform sound config
    * clean up mcasp configuration
    * misc cleanup per comments

 arch/arm/configs/da8xx_omapl_defconfig             |  291 ++++++-
 arch/arm/include/asm/setup.h                       |    5 +
 arch/arm/mach-davinci/Kconfig                      |    8 +
 arch/arm/mach-davinci/Makefile                     |    1 +
 arch/arm/mach-davinci/board-mityomapl138.c         |  806 ++++++++++++++++++++
 .../mach-davinci/include/mach/cb-mityomapl138.h    |  120 +++
 arch/arm/mach-davinci/include/mach/da8xx.h         |    1 +
 arch/arm/mach-davinci/include/mach/uncompress.h    |    1 +
 8 files changed, 1190 insertions(+), 43 deletions(-)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index e14c99c..0dd0d00 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -1,13 +1,15 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc5
-# Thu Oct 22 12:19:19 2009
+# Linux kernel version: 2.6.35-rc3
+# Tue Jul 20 08:30:23 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
+# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
 CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_HAVE_PROC_CPU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -20,6 +22,7 @@ CONFIG_ARCH_HAS_CPUFREQ=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_ZONE_DMA=y
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -32,8 +35,16 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_BZIP2 is not set
+# CONFIG_KERNEL_LZMA is not set
+# CONFIG_KERNEL_LZO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
@@ -48,6 +59,7 @@ CONFIG_POSIX_MQUEUE_SYSCTL=y
 #
 CONFIG_TREE_RCU=y
 # CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_FANOUT=32
 # CONFIG_RCU_FANOUT_EXACT is not set
@@ -55,11 +67,6 @@ CONFIG_RCU_FANOUT=32
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_GROUP_SCHED=y
-CONFIG_FAIR_GROUP_SCHED=y
-# CONFIG_RT_GROUP_SCHED is not set
-CONFIG_USER_SCHED=y
-# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 # CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
@@ -69,6 +76,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_ANON_INODES=y
@@ -90,10 +98,14 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
 
 #
 # Kernel Performance Events And Counters
 #
+# CONFIG_PERF_EVENTS is not set
+# CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLUB_DEBUG=y
 CONFIG_COMPAT_BRK=y
@@ -131,14 +143,41 @@ CONFIG_LBDAF=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -149,8 +188,11 @@ CONFIG_MMU=y
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_VEXPRESS is not set
 # CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_BCMRING is not set
 # CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CNS3XXX is not set
 # CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
@@ -159,7 +201,6 @@ CONFIG_MMU=y
 # CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -167,6 +208,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_DOVE is not set
 # CONFIG_ARCH_KIRKWOOD is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
@@ -175,20 +217,27 @@ CONFIG_MMU=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_NUC93X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_MSM is not set
+# CONFIG_ARCH_SHMOBILE is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
-# CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_S5P6440 is not set
+# CONFIG_ARCH_S5P6442 is not set
+# CONFIG_ARCH_S5PC100 is not set
+# CONFIG_ARCH_S5PV210 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_U8500 is not set
+# CONFIG_ARCH_NOMADIK is not set
 CONFIG_ARCH_DAVINCI=y
 # CONFIG_ARCH_OMAP is not set
-# CONFIG_ARCH_BCMRING is not set
+# CONFIG_PLAT_SPEAR is not set
 CONFIG_CP_INTC=y
 
 #
@@ -205,18 +254,18 @@ CONFIG_ARCH_DAVINCI_DA830=y
 CONFIG_ARCH_DAVINCI_DA850=y
 CONFIG_ARCH_DAVINCI_DA8XX=y
 # CONFIG_ARCH_DAVINCI_DM365 is not set
+# CONFIG_ARCH_DAVINCI_TNETV107X is not set
 
 #
 # DaVinci Board Type
 #
 CONFIG_MACH_DAVINCI_DA830_EVM=y
-CONFIG_DA830_UI=y
 CONFIG_DA830_UI_LCD=y
 # CONFIG_DA830_UI_NAND is not set
 CONFIG_MACH_DAVINCI_DA850_EVM=y
-CONFIG_DA850_UI_EXP=y
 CONFIG_DA850_UI_NONE=y
 # CONFIG_DA850_UI_RMII is not set
+CONFIG_MACH_MITYOMAPL138=y
 CONFIG_DAVINCI_MUX=y
 # CONFIG_DAVINCI_MUX_DEBUG is not set
 # CONFIG_DAVINCI_MUX_WARNINGS is not set
@@ -270,6 +319,7 @@ CONFIG_PREEMPT=y
 CONFIG_HZ=100
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
+CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set
@@ -280,13 +330,11 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4096
+CONFIG_SPLIT_PTLOCK_CPUS=999999
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 # CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_LEDS=y
@@ -354,7 +402,6 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
@@ -404,6 +451,7 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=m
 CONFIG_INET6_XFRM_MODE_BEET=m
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=m
+# CONFIG_IPV6_SIT_6RD is not set
 CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
@@ -440,6 +488,7 @@ CONFIG_NETFILTER_ADVANCED=y
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -465,10 +514,21 @@ CONFIG_NETFILTER_ADVANCED=y
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_WIRELESS is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -486,12 +546,110 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+# CONFIG_MTD_CHAR is not set
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_FTL=y
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
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
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
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
+CONFIG_MTD_NAND_ECC=y
+# CONFIG_MTD_NAND_ECC_SMC is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_SM_COMMON is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_DENALI_SCRATCH_REG_ADDR=0xFF108018
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+CONFIG_MTD_NAND_DAVINCI=y
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
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
@@ -501,9 +659,12 @@ CONFIG_BLK_DEV_RAM_SIZE=32768
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MG_DISK is not set
 CONFIG_MISC_DEVICES=y
+# CONFIG_AD525X_DPOT is not set
 # CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_ISL29003 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_C2PORT is not set
 
 #
@@ -519,6 +680,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=m
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=m
 CONFIG_SCSI_DMA=y
@@ -583,6 +745,7 @@ CONFIG_LXT_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 CONFIG_LSI_ET1011C_PHY=y
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -608,8 +771,7 @@ CONFIG_TI_DAVINCI_EMAC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 CONFIG_WLAN=y
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+# CONFIG_HOSTAP is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -631,6 +793,7 @@ CONFIG_NET_POLL_CONTROLLER=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -652,6 +815,7 @@ CONFIG_KEYBOARD_ATKBD=m
 # CONFIG_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 CONFIG_KEYBOARD_GPIO=y
+# CONFIG_KEYBOARD_TCA6416 is not set
 # CONFIG_KEYBOARD_MATRIX is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
@@ -665,6 +829,8 @@ CONFIG_KEYBOARD_XTKBD=m
 CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
 # CONFIG_TOUCHSCREEN_AD7879 is not set
+# CONFIG_TOUCHSCREEN_DYNAPRO is not set
+# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
 # CONFIG_TOUCHSCREEN_EETI is not set
 # CONFIG_TOUCHSCREEN_FUJITSU is not set
 # CONFIG_TOUCHSCREEN_GUNZE is not set
@@ -680,6 +846,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_TOUCHSCREEN_TSC2007 is not set
 # CONFIG_TOUCHSCREEN_W90X900 is not set
+# CONFIG_TOUCHSCREEN_TPS6507X is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -689,6 +856,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -701,6 +869,7 @@ CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 
 #
 # Serial drivers
@@ -716,6 +885,9 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=3
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -726,6 +898,7 @@ CONFIG_HW_RANDOM=m
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -743,7 +916,9 @@ CONFIG_I2C_DAVINCI=y
 # CONFIG_I2C_DESIGNWARE is not set
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
 
 #
 # External I2C/SMBus adapter drivers
@@ -754,18 +929,10 @@ CONFIG_I2C_DAVINCI=y
 #
 # Other I2C/SMBus bus drivers
 #
-# CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_STUB is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_DS1682 is not set
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -780,13 +947,17 @@ CONFIG_GPIOLIB=y
 #
 # Memory mapped GPIO expanders:
 #
+# CONFIG_GPIO_IT8761E is not set
 
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX7300 is not set
 # CONFIG_GPIO_MAX732X is not set
 CONFIG_GPIO_PCA953X=y
+# CONFIG_GPIO_PCA953X_IRQ is not set
 CONFIG_GPIO_PCF857X=y
+# CONFIG_GPIO_ADP5588 is not set
 
 #
 # PCI GPIO expanders:
@@ -799,6 +970,10 @@ CONFIG_GPIO_PCF857X=y
 #
 # AC97 GPIO expanders:
 #
+
+#
+# MODULbus GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
@@ -811,42 +986,50 @@ CONFIG_WATCHDOG=y
 #
 # CONFIG_SOFT_WATCHDOG is not set
 # CONFIG_DAVINCI_WATCHDOG is not set
+# CONFIG_MAX63XX_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
+# CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_HTC_I2CPLD is not set
 # CONFIG_TPS65010 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
 # CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_MAX8925 is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM831X is not set
 # CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_DUMMY is not set
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
 # CONFIG_REGULATOR_MAX1586 is not set
+# CONFIG_REGULATOR_MAX8649 is not set
+# CONFIG_REGULATOR_MAX8660 is not set
 # CONFIG_REGULATOR_LP3971 is not set
-# CONFIG_REGULATOR_TPS65023 is not set
+CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -950,10 +1133,6 @@ CONFIG_RTC_LIB=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1033,6 +1212,22 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_LOGFS is not set
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1062,6 +1257,7 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 CONFIG_SMB_FS=m
 # CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1184,6 +1380,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
 # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 # CONFIG_SYSCTL_SYSCALL_CHECK is not set
@@ -1205,6 +1402,7 @@ CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -1213,6 +1411,7 @@ CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_OC_ETM is not set
 
 #
 # Security options
@@ -1220,7 +1419,11 @@ CONFIG_DEBUG_ERRORS=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
@@ -1323,9 +1526,11 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_DECOMPRESS_GZIP=y
 CONFIG_GENERIC_ALLOCATOR=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index f392fb4..1d3a8cf 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -143,6 +143,11 @@ struct tag_memclk {
     __u32 fmemclk;
 };
 
+/** MityDSP-L138 peripheral configuration info,
+  *  see arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
+  */
+#define ATAG_MITYDSPL138 0x42000101
+
 struct tag {
     struct tag_header hdr;
     union {
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 71f90f8..8fcf47d 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -178,6 +178,14 @@ config DA850_UI_RMII
 
 endchoice
 
+config MACH_MITYOMAPL138
+    bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
+    depends on ARCH_DAVINCI_DA850
+    help
+      Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
+      System on Module.  Information on this SoM may be found at
+      http://www.mitydsp.com.
+
 config MACH_TNETV107X
     bool "TI TNETV107X Reference Platform"
     default ARCH_DAVINCI_TNETV107X
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index eab4c0f..dfc0fc4 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)    += board-dm646x-evm.o cdce949.o
 obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)    += board-dm365-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)    += board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)    += board-da850-evm.o
+obj-$(CONFIG_MACH_MITYOMAPL138)    += board-mityomapl138.o
 obj-$(CONFIG_MACH_TNETV107X)        += board-tnetv107x-evm.o
 
 # Power Management
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
new file mode 100644
index 0000000..57a4ab4
--- /dev/null
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -0,0 +1,806 @@
+/*
+ * Critical Link MityOMAP-L138 SoM
+ *
+ * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
+ *
+ * Derived from board-da850-evm.c
+ * Original Copyrights follow:
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Derived from: arch/arm/mach-davinci/board-da830-evm.c
+ * Original Copyrights follow:
+ *
+ * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/regulator/machine.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/setup.h>
+#include <mach/cp_intc.h>
+#include <mach/da8xx.h>
+#include <mach/nand.h>
+#include <mach/mux.h>
+#include <mach/cb-mityomapl138.h>
+#include <mach/spi.h>
+#include <mach/irqs.h>
+
+static struct tag_peripherals peripheral_config = {
+        .version = PERIPHERALS_VERSION,
+        .manufacturer = "Critical Link",
+        .enet.enet_config = ENET_CONFIG_MII,
+        .enet.mac = { 0x00, 0x50, 0xC2, 0x49, 0xDF, 0xFF },
+        .uart[0] = {
+            .enable = 0,
+            .is_console = 0,
+            .baud = 115200,
+        },
+        .uart[1] = {
+            .enable = 1,
+            .is_console = 1,
+            .baud = 115200,
+        },
+        .uart[2] = {
+            .enable = 0,
+            .is_console = 0,
+            .baud = 115200,
+        },
+        .spi[0] = {
+            .enable = 0,
+            .clkout = 0,
+            .cs_enable = { 0, 0, 0, 0, 0, 0, 0, 0},
+            .ena_enable = 0,
+            .clkrate = 0,
+        },
+        .spi[1] = {
+            .enable = 1,
+            .clkout = 1,
+            .cs_enable = { 1, 0, 0, 0, 0, 0, 0, 0},
+            .ena_enable = 0,
+            .clkrate = 30000000,
+        },
+        .lcd = {
+            .enable = 0,
+            .panel_name = "",
+        }
+};
+
+
+#define MITYOMAPL138_MDIO_FREQUENCY    2200000 /* PHY bus frequency */
+
+#define MSTPRI2_LCD_MASK  0x70000000
+#define MSTPRI2_LCD_SHIFT 28
+
+#define DA850_MMCSD_CD_PIN        GPIO_TO_PIN(4, 0)
+#define DA850_MMCSD_WP_PIN        GPIO_TO_PIN(4, 1)
+
+/* MityDSP-L138 includes a 256 MByte large-page NAND flash
+ * (128K blocks).
+ */
+struct mtd_partition mityomapl138_nandflash_partition[] = {
+    {
+        .name        = "rootfs",
+        .offset        = 0,
+        .size        = SZ_128M,
+        .mask_flags    = 0, /* MTD_WRITEABLE, */
+     },
+    {
+        .name        = "homefs",
+        .offset        = MTDPART_OFS_APPEND,
+        .size        = MTDPART_SIZ_FULL,
+        .mask_flags    = 0,
+    },
+};
+
+static struct davinci_nand_pdata mityomapl138_nandflash_data = {
+    .parts        = mityomapl138_nandflash_partition,
+    .nr_parts    = ARRAY_SIZE(mityomapl138_nandflash_partition),
+    .ecc_mode    = NAND_ECC_HW,
+    .options    = NAND_USE_FLASH_BBT | NAND_BUSWIDTH_16,
+    .ecc_bits   = 1, /* 4 bit mode is not supported with 16 bit NAND */
+};
+
+static struct resource mityomapl138_nandflash_resource[] = {
+    {
+        .start    = DA8XX_AEMIF_CS3_BASE,
+        .end    = DA8XX_AEMIF_CS3_BASE + SZ_512K + 2 * SZ_1K - 1,
+        .flags    = IORESOURCE_MEM,
+    },
+    {
+        .start    = DA8XX_AEMIF_CTL_BASE,
+        .end    = DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+        .flags    = IORESOURCE_MEM,
+    },
+};
+
+static struct platform_device mityomapl138_nandflash_device = {
+    .name        = "davinci_nand",
+    .id            = 0,
+    .dev        = {
+        .platform_data    = &mityomapl138_nandflash_data,
+    },
+    .num_resources    = ARRAY_SIZE(mityomapl138_nandflash_resource),
+    .resource    = mityomapl138_nandflash_resource,
+};
+
+static struct platform_device *mityomapl138_devices[] __initdata = {
+    &mityomapl138_nandflash_device,
+};
+
+static void __init mityomapl138_setup_nand(void)
+{
+    platform_add_devices(mityomapl138_devices,
+                 ARRAY_SIZE(mityomapl138_devices));
+}
+
+static int mityomapl138_mmc_get_ro(int index)
+{
+    return gpio_get_value(DA850_MMCSD_WP_PIN);
+}
+
+static int mityomapl138_mmc_get_cd(int index)
+{
+    return !gpio_get_value(DA850_MMCSD_CD_PIN);
+}
+
+static struct davinci_mmc_config da850_mmc_config = {
+    .get_ro        = mityomapl138_mmc_get_ro,
+    .get_cd        = mityomapl138_mmc_get_cd,
+    .wires        = 4,
+    .max_freq    = 50000000,
+    .caps        = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
+    .version    = MMC_CTLR_VERSION_2,
+};
+
+static void __init mityomapl138_setup_mmc(void)
+{
+    int ret;
+
+    ret = davinci_cfg_reg_list(da850_mmcsd0_pins);
+    if (ret) {
+        pr_warning("mmcsd0 mux setup failed: %d\n" ,ret);
+        return;
+    }
+    ret = gpio_request(DA850_MMCSD_CD_PIN, "MMC CD\n");
+    if (ret) {
+        pr_warning("can not open GPIO %d\n", DA850_MMCSD_CD_PIN);
+        return;
+    }
+    gpio_direction_input(DA850_MMCSD_CD_PIN);
+
+    ret = gpio_request(DA850_MMCSD_WP_PIN, "MMC WP\n");
+    if (ret) {
+        pr_warning("can not open GPIO %d\n", DA850_MMCSD_WP_PIN);
+        return;
+    }
+    gpio_direction_input(DA850_MMCSD_WP_PIN);
+
+    ret = da8xx_register_mmcsd0(&da850_mmc_config);
+    if (ret) {
+        pr_warning("mmcsd0 registration failed: %d\n", ret);
+        return;
+    }
+}
+
+static struct davinci_uart_config mityomapl138_uart_config __initdata = {
+    .enabled_uarts = 0x7,
+};
+
+static void __init mityomapl138_config_emac(void)
+{
+    void __iomem *cfg_chip3_base;
+    int ret;
+    u32 val;
+    struct davinci_soc_info *soc_info = &davinci_soc_info;
+    u8 rmii_en = 0;
+
+    switch (peripheral_config.enet.enet_config) {
+    case ENET_CONFIG_RMII:
+        soc_info->emac_pdata->rmii_en = 1;
+        rmii_en = 1;
+        break;
+    case ENET_CONFIG_MII:
+        soc_info->emac_pdata->rmii_en = 0;
+        rmii_en = 0;
+        break;
+    case ENET_CONFIG_NONE:
+    default:
+        pr_info("No Ethernet PHY Selected, EMAC disabled\n");
+        return; /* no enet... */
+        break;
+    }
+    memcpy(&soc_info->emac_pdata->mac_addr[0],
+           &peripheral_config.enet.mac[0], 6);
+
+    cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
+
+    val = __raw_readl(cfg_chip3_base);
+
+    if (rmii_en) {
+        val |= BIT(8);
+        ret = davinci_cfg_reg_list(da850_rmii_pins);
+        pr_info("RMII PHY configured, MII PHY will not be functional\n");
+    } else {
+        val &= ~BIT(8);
+        ret = davinci_cfg_reg_list(da850_cpgmac_pins);
+        pr_info("MII PHY configured, RMII PHY will not be functional\n");
+    }
+
+    if (ret) {
+        pr_warning("cpgmac/rmii mux setup failed: %d\n", ret);
+        return;
+    }
+
+    /* configure the CFGCHIP3 register for RMII or MII */
+    __raw_writel(val, cfg_chip3_base);
+
+    soc_info->emac_pdata->phy_mask = peripheral_config.enet.phy_mask ?
+            peripheral_config.enet.phy_mask : 1;
+    pr_info("setting phy_mask to %x\n", soc_info->emac_pdata->phy_mask);
+    soc_info->emac_pdata->mdio_max_freq = MITYOMAPL138_MDIO_FREQUENCY;
+
+    ret = da8xx_register_emac();
+    if (ret)
+        pr_warning("emac registration failed: %d\n", ret);
+}
+
+static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
+    .bus_freq    = 100,    /* kHz */
+    .bus_delay    = 0,    /* usec */
+};
+
+/* TPS65023 voltage regulator support */
+
+/* 1.2V Core */
+struct regulator_consumer_supply tps65023_dcdc1_consumers[] = {
+    {
+        .supply = "cvdd",
+    },
+};
+
+/* 1.8V */
+struct regulator_consumer_supply tps65023_dcdc2_consumers[] = {
+    {
+        .supply = "usb0_vdda18",
+    },
+    {
+        .supply = "usb1_vdda18",
+    },
+    {
+        .supply = "ddr_dvdd18",
+    },
+    {
+        .supply = "sata_vddr",
+    },
+};
+
+/* 1.2V */
+struct regulator_consumer_supply tps65023_dcdc3_consumers[] = {
+    {
+        .supply = "sata_vdd",
+    },
+    {
+        .supply = "usb_cvdd",
+    },
+    {
+        .supply = "pll0_vdda",
+    },
+    {
+        .supply = "pll1_vdda",
+    },
+};
+
+/* 1.8V Aux LDO */
+struct regulator_consumer_supply tps65023_ldo1_consumers[] = {
+    {
+        .supply = "1.8v_aux",
+    },
+};
+
+/* VCC Aux (1.8 or 3.3) LDO */
+struct regulator_consumer_supply tps65023_ldo2_consumers[] = {
+    {
+        .supply = "vccaux",
+    },
+};
+
+
+struct regulator_init_data tps65023_regulator_data[] = {
+    /* dcdc1 */
+    {
+        .constraints = {
+            .min_uV = 1150000,
+            .max_uV = 1350000,
+            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+                REGULATOR_CHANGE_STATUS),
+            .boot_on = 1,
+        },
+        .num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc1_consumers),
+        .consumer_supplies = tps65023_dcdc1_consumers,
+    },
+
+    /* dcdc2 */
+    {
+        .constraints = {
+            .min_uV = 1710000,
+            .max_uV = 1910000,
+            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+                REGULATOR_CHANGE_STATUS),
+            .boot_on = 1,
+        },
+        .num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc2_consumers),
+        .consumer_supplies = tps65023_dcdc2_consumers,
+    },
+
+    /* dcdc3 */
+    {
+        .constraints = {
+            .min_uV = 1120000,
+            .max_uV = 1320000,
+            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+                REGULATOR_CHANGE_STATUS),
+            .boot_on = 1,
+        },
+        .num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc3_consumers),
+        .consumer_supplies = tps65023_dcdc3_consumers,
+    },
+
+    /* ldo1 */
+    {
+        .constraints = {
+            .min_uV = 1710000,
+            .max_uV = 1890000,
+            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+                REGULATOR_CHANGE_STATUS),
+            .boot_on = 1,
+        },
+        .num_consumer_supplies = ARRAY_SIZE(tps65023_ldo1_consumers),
+        .consumer_supplies = tps65023_ldo1_consumers,
+    },
+
+    /* ldo2 */
+    {
+        .constraints = {
+            .min_uV = 3140000,
+            .max_uV = 3420000,
+            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+                REGULATOR_CHANGE_STATUS),
+            .boot_on = 1,
+        },
+        .num_consumer_supplies = ARRAY_SIZE(tps65023_ldo2_consumers),
+        .consumer_supplies = tps65023_ldo2_consumers,
+    },
+};
+
+
+static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
+    {
+        I2C_BOARD_INFO("tps65023", 0x48),
+        .platform_data = &tps65023_regulator_data[0],
+    },
+    {
+        I2C_BOARD_INFO("24c02", 0x50),
+    },
+};
+
+static int __init pmic_tps65023_init(void)
+{
+    return i2c_register_board_info(1, mityomap_tps65023_info,
+                    ARRAY_SIZE(mityomap_tps65023_info));
+}
+
+static struct davinci_spi_platform_data mityomap_spi1_pdata = {
+    .version        = SPI_VERSION_2,
+    .num_chipselect = 1,
+    .wdelay         = 0,
+    .odd_parity     = 0,
+    .parity_enable  = 0,
+    .wait_enable    = 0,
+    .timer_disable  = 0,
+    .clk_internal   = 1,
+    .cs_hold        = 1,
+    .intr_level     = 0,
+    .poll_mode      = 1,
+    .use_dma        = 0,
+    .c2tdelay       = 8,
+    .t2cdelay       = 8,
+};
+
+static struct resource mityomap_spi1_resources[] = {
+    [0] = {
+        .start = 0x01F0E000,
+        .end   = 0x01F0EFFF,
+        .flags = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start = IRQ_DA8XX_SPINT1,
+        .start = IRQ_DA8XX_SPINT1,
+        .flags = IORESOURCE_IRQ,
+    },
+    [2] = {
+        .start = EDMA_CTLR_CHAN(0, 18),
+        .end = EDMA_CTLR_CHAN(0, 18),
+        .flags = IORESOURCE_DMA,
+    },
+    [3] = {
+        .start = EDMA_CTLR_CHAN(0, 19),
+        .end = EDMA_CTLR_CHAN(0, 19),
+        .flags = IORESOURCE_DMA,
+    },
+    [4] = {
+        .start = 1,
+        .end = 1,
+        .flags = IORESOURCE_DMA,
+    },
+};
+
+static struct platform_device mityomap_spi1_device = {
+    .name = "spi_davinci",
+    .id = 1,
+    .dev = {
+        .platform_data = &mityomap_spi1_pdata,
+    },
+    .num_resources = ARRAY_SIZE(mityomap_spi1_resources),
+    .resource = mityomap_spi1_resources,
+};
+
+/*****************************************************************************
+ * SPI Devices:
+ *      SPI1_CS0: 8M Flash ST-M25P64-VME6G
+ ****************************************************************************/
+static struct mtd_partition spi_flash_partitions[] = {
+    [0] = {
+        .name = "UBL",
+        .offset = 0,
+        .size = SZ_64K,
+        .mask_flags = MTD_WRITEABLE
+    },
+    [1] = {
+        .name = "U-Boot",
+        .offset = MTDPART_OFS_APPEND,
+        .size = SZ_512K,
+        .mask_flags = 0,
+    },
+    [2] = {
+        .name = "Spare",
+        .offset = MTDPART_OFS_APPEND,
+        .size = MTDPART_SIZ_FULL,
+        .mask_flags = 0,
+    },
+};
+
+static struct flash_platform_data mityomap_spi_flash_data = {
+    .name     = "m25p80",
+    .parts    = spi_flash_partitions,
+    .nr_parts = ARRAY_SIZE(spi_flash_partitions),
+    .type     = "m25p64",
+};
+
+static struct spi_board_info mityomap_spi_flash_info[] = {
+    {
+        .modalias       = "m25p80",
+        .platform_data  = &mityomap_spi_flash_data,
+        .mode           = SPI_MODE_0,
+        .max_speed_hz   = 30000000,
+        .bus_num        = 1,
+        .chip_select    = 0,
+    },
+};
+
+void __init mityomap_init_spi1(unsigned chipselect_mask,
+                struct spi_board_info *info, unsigned len)
+{
+    int ret;
+    ret = platform_device_register(&mityomap_spi1_device);
+    if (ret)
+        pr_warning("failed to register spi device : %d\n", ret);
+
+    ret = spi_register_board_info(info, len);
+    if (ret)
+        pr_warning("failed to register board info : %d\n", ret);
+}
+
+/* davinci da850 evm audio machine driver */
+static u8 da850_iis_serializer_direction[16];
+
+static struct snd_platform_data mityomapl138_snd_data = {
+    .tx_dma_offset    = 0x2000,
+    .rx_dma_offset    = 0x2000,
+    .op_mode    = DAVINCI_MCASP_IIS_MODE,
+    .num_serializer    = ARRAY_SIZE(da850_iis_serializer_direction),
+    .tdm_slots    = 2,
+    .serial_dir    = da850_iis_serializer_direction,
+    .asp_chan_q    = EVENTQ_1,
+    .version    = MCASP_VERSION_2,
+    .txnumevt    = 0,
+    .rxnumevt    = 0,
+};
+
+short mityomapl138_mcasp_pins[24] __initdata = {
+    DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
+    DA850_AHCLKR, DA850_ACLKR, DA850_AFSR,
+    DA850_AMUTE,
+};
+
+static __init void mityomapl138_setup_mcasp(void)
+{
+    int ret, i, j;
+
+    if (!peripheral_config.mcasp.enable)
+        return;
+
+    j = 7; /* start after AMUTE pin */
+    for (i = 0; i<ARRAY_SIZE(peripheral_config.mcasp.pin_mode); i++) {
+        switch (peripheral_config.mcasp.pin_mode[i]) {
+        case MCASP_PINMODE_RX:
+            mityomapl138_mcasp_pins[j++] = DA850_AXR_0-i;
+            da850_iis_serializer_direction[i] = RX_MODE;
+            mityomapl138_snd_data.rxnumevt++;
+            break;
+        case MCASP_PINMODE_TX:
+            mityomapl138_mcasp_pins[j++] = DA850_AXR_0-i;
+            da850_iis_serializer_direction[i] = TX_MODE;
+            mityomapl138_snd_data.txnumevt++;
+            break;
+        default:
+            da850_iis_serializer_direction[i] = INACTIVE_MODE;
+            break;
+        }
+    }
+    mityomapl138_mcasp_pins[j] = -1; /* terminate the list */
+    if (!mityomapl138_snd_data.rxnumevt && !mityomapl138_snd_data.txnumevt)
+    {
+        pr_warning("mcasp pinmux did not find Tx or Rx pins\n");
+    }
+
+    ret = davinci_cfg_reg_list(mityomapl138_mcasp_pins);
+    if (ret) {
+        pr_warning("mcasp mux setup failed: %d\n", ret);
+        return;
+    }
+
+    da8xx_register_mcasp(0, &mityomapl138_snd_data);
+}
+
+static const struct display_panel disp_panel = {
+    QVGA,
+    16,
+    16,
+    COLOR_ACTIVE,
+};
+
+static struct lcd_ctrl_config lcd_cfg = {
+    &disp_panel,
+    .ac_bias        = 255,
+    .ac_bias_intrpt        = 0,
+    .dma_burst_sz        = 16,
+    .bpp            = 16,
+    .fdd            = 255,
+    .tft_alt_mode        = 0,
+    .stn_565_mode        = 0,
+    .mono_8bit_mode        = 0,
+    .invert_line_clock    = 0,
+    .invert_frm_clock    = 0,
+    .sync_edge        = 0,
+    .sync_ctrl        = 1,
+    .raster_order        = 0,
+};
+
+static struct da8xx_lcdc_platform_data sharp_lq035q7dh06_pdata = {
+    .manu_name        = "sharp",
+    .controller_data    = &lcd_cfg,
+    .type            = "Sharp_LQ035Q7DH06",
+};
+
+static struct da8xx_lcdc_platform_data chimei_p0430wqlb_pdata = {
+    .manu_name        = "ChiMei",
+    .controller_data    = &lcd_cfg,
+    .type            = "ChiMei_P0430WQLB",
+};
+
+static struct da8xx_lcdc_platform_data vga_640x480_pdata = {
+    .manu_name        = "VGA",
+    .controller_data    = &lcd_cfg,
+    .type            = "vga_640x480",
+};
+
+static struct resource da8xx_lcdc_resources[] = {
+    [0] = { /* registers */
+        .start  = DA8XX_LCD_CNTRL_BASE,
+        .end    = DA8XX_LCD_CNTRL_BASE + SZ_4K - 1,
+        .flags  = IORESOURCE_MEM,
+    },
+    [1] = { /* interrupt */
+        .start  = IRQ_DA8XX_LCDINT,
+        .end    = IRQ_DA8XX_LCDINT,
+        .flags  = IORESOURCE_IRQ,
+    },
+};
+
+static struct platform_device da8xx_lcdc_device = {
+    .name        = "da8xx_lcdc",
+    .id        = 0,
+    .num_resources    = ARRAY_SIZE(da8xx_lcdc_resources),
+    .resource    = da8xx_lcdc_resources,
+    .dev = {
+        .platform_data = &sharp_lq035q7dh06_pdata,
+    },
+};
+
+static __init void mityomapl138_setup_lcd(void)
+{
+    int ret;
+
+    if (peripheral_config.lcd.enable) {
+        u32 prio;
+
+        /* set peripheral master priority up to 1 */
+        prio = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI2_REG));
+        prio &= ~MSTPRI2_LCD_MASK;
+        prio |= 1 << MSTPRI2_LCD_SHIFT;
+        __raw_writel(prio, DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI2_REG));
+
+        if (0 == strcmp("Sharp_LQ035Q7DH06",
+                peripheral_config.lcd.panel_name)) {
+            da8xx_lcdc_device.dev.platform_data =
+                &sharp_lq035q7dh06_pdata;
+        } else if (0 == strcmp("ChiMei_P0430WQLB",
+                peripheral_config.lcd.panel_name)) {
+            da8xx_lcdc_device.dev.platform_data =
+                &chimei_p0430wqlb_pdata;
+        } else if (0 == strcmp("vga_640x480",
+                peripheral_config.lcd.panel_name)) {
+            da8xx_lcdc_device.dev.platform_data =
+                &vga_640x480_pdata;
+        } else {
+            pr_warning("unknown LCD type : %s\n",
+                peripheral_config.lcd.panel_name);
+            return;
+        }
+
+        ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
+        if (ret) {
+            pr_warning("lcd pinmux failed : %d\n", ret);
+            return;
+        }
+
+        ret = platform_device_register(&da8xx_lcdc_device);
+    } else {
+        pr_warning("no LCD device enabled\n");
+    }
+}
+
+static void __init mityomapl138_init(void)
+{
+    int ret;
+
+    ret = pmic_tps65023_init();
+    if (ret)
+        pr_warning("TPS65023 PMIC init failed: %d\n", ret);
+
+    ret = da8xx_register_edma();
+    if (ret)
+        pr_warning("edma registration failed: %d\n", ret);
+
+    ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
+    if (ret)
+        pr_warning("i2c0 registration failed: %d\n", ret);
+
+    ret = da8xx_register_watchdog();
+    if (ret)
+        pr_warning("watchdog registration failed: %d\n", ret);
+
+    davinci_serial_init(&mityomapl138_uart_config);
+
+    ret = da8xx_register_rtc();
+    if (ret)
+        pr_warning("rtc setup failed: %d\n", ret);
+
+    ret = da850_register_cpufreq();
+    if (ret)
+        pr_warning("cpufreq registration failed: %d\n", ret);
+
+    ret = da8xx_register_cpuidle();
+    if (ret)
+        pr_warning("cpuidle registration failed: %d\n", ret);
+
+    mityomapl138_setup_nand();
+
+    mityomap_init_spi1(1, mityomap_spi_flash_info,
+               ARRAY_SIZE(mityomap_spi_flash_info));
+
+    mityomapl138_setup_lcd();
+
+    mityomapl138_setup_mmc();
+
+    mityomapl138_config_emac();
+
+    mityomapl138_setup_mcasp();
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static int __init mityomapl138_console_init(void)
+{
+    return add_preferred_console("ttyS", 1, "115200");
+}
+console_initcall(mityomapl138_console_init);
+#endif
+
+static void __init mityomapl138_map_io(void)
+{
+    da850_init();
+}
+
+static int __init parse_tag_peripherals(const struct tag *tag)
+{
+    struct tag_peripherals *ptag;
+    int i, j;
+
+    ptag = (struct tag_peripherals *)&tag->u.cmdline.cmdline[0];
+    memcpy(&peripheral_config, ptag, sizeof(peripheral_config));
+    pr_info("Peripheral Config Block Found\n");
+    pr_info("Enet_Config = %d\n", peripheral_config.enet.enet_config);
+    pr_info("EMAC = %pM\n", peripheral_config.enet.mac);
+    pr_info("PHYMask = 0x%x\n", peripheral_config.enet.phy_mask);
+    if (peripheral_config.lcd.enable)
+        pr_info("LCD Configured : %s\n",
+            peripheral_config.lcd.panel_name);
+    else
+        pr_info("No LCD Configured\n");
+
+    for (i = 0; i < 3; i++) {
+        pr_info("UART[%d] : Enable=%d, Cons=%d, FlwCtl=%d, Baud=%d\n",
+            i,
+            peripheral_config.uart[i].enable,
+            peripheral_config.uart[i].is_console,
+            peripheral_config.uart[i].enable_flowctl,
+            peripheral_config.uart[i].baud);
+    }
+    for (i = 0; i < 2; i++) {
+        int mask = 0;
+        for (j = 0; j < 8; j++)
+            mask |= ((peripheral_config.spi[i].cs_enable[j]) ?
+                (1<<j) : 0);
+
+        pr_info("SPI[%d] : Enable=%d, CLKOut=%d, mask=%02X, ENA=%d,"
+            " CLKRate=%d\n", i,
+            peripheral_config.spi[i].enable,
+            peripheral_config.spi[i].clkout,
+            mask,
+            peripheral_config.spi[i].ena_enable,
+            peripheral_config.spi[i].clkrate);
+    }
+    pr_info("McASP Enable: %d\n", peripheral_config.mcasp.enable);
+    return 0;
+}
+__tagtable(ATAG_MITYDSPL138, parse_tag_peripherals);
+
+
+MACHINE_START(MITYOMAPL138, "MityDSP-L138")
+    .phys_io    = IO_PHYS,
+    .io_pg_offst    = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
+    .boot_params    = (DA8XX_DDR_BASE + 0x100),
+    .map_io        = mityomapl138_map_io,
+    .init_irq    = cp_intc_init,
+    .timer        = &davinci_timer,
+    .init_machine    = mityomapl138_init,
+MACHINE_END
diff --git a/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h b/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
new file mode 100644
index 0000000..547c876
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
@@ -0,0 +1,120 @@
+/**
+ * Factory / Peripheral Configuration Data as provided by ATAG_PERIPHERAL
+ * for the MityDSP-L138 SOMs. (mityomapl138 machines)
+ *
+ * Copyright (C) 2010 Critical Link LLC.  This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef CB_MITYOMAPL138_H_
+#define CB_MITYOMAPL138_H_
+
+#define CONFIG_MAGIC_WORD 0x00BD0138
+#define CONFIG_VERSION 0x00010000
+
+#define ENET_CONFIG_NONE 1
+#define ENET_CONFIG_MII  2
+#define ENET_CONFIG_RMII 3
+
+#define CONFIG_I2C_MAGIC_WORD 0x012C0138
+#define CONFIG_I2C_VERSION    0x00010001
+
+/**
+ * Peripherals Version History
+ * 1.00 Baseline
+ * 1.01 Added McASP Configuration
+ * 1.02 Added ethernet phy mask
+ */
+#define PERIPHERALS_VERSION   0x00010002
+
+#ifndef CONFIG_MITYDSP_ENV_SIZE
+#define CONFIG_MITYDSP_ENV_SIZE (64 << 10)
+#endif
+
+#define FPGATYPE_NONE       0
+#define FPGATYPE_XC6SLX9    1
+#define FPGATYPE_XC6SLX16   2
+#define FPGATYPE_XC6SLX25   3
+#define FPGATYPE_XC6SLX45   4
+#define FPGATYPE_UNKNOWN    10000
+
+struct i2c_factory_config {
+    u32               magic_word;    /** CONFIG_I2C_MAGIC_WORD */
+    u32               version;       /** CONFIG_I2C_VERSION */
+    u8                mac[6];        /** mac address assigned to part */
+    u32               fpga;          /** fpga installed, see above */
+    u32               spare;         /** Not Used */
+    u32               serial_no;     /** serial number of part */
+    char              partnum[32];   /** board part number */
+};
+
+struct uart_config {
+    u8           enable;            /** enable Tx/Rx */
+    u8           is_console;        /** cfg as the console */
+    u8           enable_flowctl;    /** cfg CTS/RTS */
+    u32          baud;              /** default baud rate */
+};
+
+struct spi_config {
+    u8           enable;         /** cfg dev+CLK, SIMO, SOMI pins */
+    u8           clkout;         /** drive the CLK */
+    u8           cs_enable[8];   /** cfg the associated CS as output */
+    u8           ena_enable;     /** cfg the ENA pin for SPI function */
+    u32          clkrate;        /** default clock rate */
+    u8           spare[8];
+};
+
+struct lcd_config {
+    u8           enable;
+    u8           panel_name[32];
+};
+
+struct enet_config {
+    u32          enet_config;
+    u8           mac[6];
+    u32          phy_mask;
+    u8           spare[8];
+};
+
+#define MCASP_PINMODE_INACTIVE 0
+#define MCASP_PINMODE_TX       1
+#define MCASP_PINMODE_RX       2
+
+struct mcasp_config {
+    u8           enable;
+    u8           mode;
+    u8           pin_mode[16];
+};
+/**
+ * struct tag_peripherals is passed in via kernel ATAG_PERIPHERALS
+ */
+struct tag_peripherals {
+    u32                 version; /** == PERIPHERALS_VERSION */
+    u8                  manufacturer[64]; /** null terminated string indicating manufacturer */
+    struct enet_config  enet;        /** Enable on-board ethernet */
+    struct uart_config  uart[3];     /** default UART 0,1,2 Configuration */
+    struct spi_config   spi[2];
+    struct lcd_config   lcd;
+    struct mcasp_config mcasp;
+};
+
+/**
+ * This structure can only be grown.  You cannot make it smaller...
+ */
+struct mitydspl138_config {
+    u32               magic_word;  /** == CONFIG_MAGIC_WORD */
+    u32               version;     /** version of the configuration block */
+    u32               config_size; /** configuration size, in bytes */
+    struct tag_peripherals peripherals;
+};
+
+struct mitydspl138_config_block {
+    union {
+        struct    mitydspl138_config config;
+        u8    space[CONFIG_MITYDSP_ENV_SIZE-sizeof(int)];
+    } data;
+    unsigned int    checksum; /** summed bytes of ConfigSizeBytes */
+};
+
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 1b31a9a..1989316 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -41,6 +41,7 @@ extern void __iomem *da8xx_syscfg1_base;
 #define DA8XX_SYSCFG0_BASE    (IO_PHYS + 0x14000)
 #define DA8XX_SYSCFG0_VIRT(x)    (da8xx_syscfg0_base + (x))
 #define DA8XX_JTAG_ID_REG    0x18
+#define DA8XX_MSTPRI2_REG    0x118
 #define DA8XX_CFGCHIP0_REG    0x17c
 #define DA8XX_CFGCHIP2_REG    0x184
 #define DA8XX_CFGCHIP3_REG    0x188
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 15a6192..db6f1cd 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -88,6 +88,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
         /* DA8xx boards */
         DEBUG_LL_DA8XX(davinci_da830_evm,    2);
         DEBUG_LL_DA8XX(davinci_da850_evm,    2);
+        DEBUG_LL_DA8XX(mityomapl138,    1);
 
         /* TNETV107x boards */
         DEBUG_LL_TNETV107X(tnetv107x,        1);
