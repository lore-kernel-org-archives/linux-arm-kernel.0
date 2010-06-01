From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 1 Jun 2010 20:55:56 +0400
Subject: [PATCH 4/4] ARM: cns3xxx: Update defconfig to enable AHCI, PCIe
	and net devices
In-Reply-To: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
Message-ID: <20100601165556.GD7123@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables Platform AHCI SATA and PCIe support.

It now makes sense to enable networking and NFS support as we can
use PCIe NICs (SKY2 and E1000E were tested and enabled).

While at it, also disable oprofile, this isn't needed for default
configuration.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/configs/cns3420vb_defconfig |  410 ++++++++++++++++++++++++++++++++--
 1 files changed, 393 insertions(+), 17 deletions(-)

diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index d5c0881..deb50f8 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -1,11 +1,12 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc6
-# Sun May  2 21:58:08 2010
+# Linux kernel version: 2.6.34
+# Fri May 28 13:27:20 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_TIME=y
+# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_HAVE_PROC_CPU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -20,8 +21,6 @@ CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
-CONFIG_OPROFILE_ARMV6=y
-CONFIG_OPROFILE_ARM11_CORE=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 CONFIG_CONSTRUCTORS=y
@@ -35,6 +34,7 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_LZMA=y
 CONFIG_HAVE_KERNEL_LZO=y
 CONFIG_KERNEL_GZIP=y
 # CONFIG_KERNEL_BZIP2 is not set
@@ -43,7 +43,10 @@ CONFIG_KERNEL_GZIP=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
 
 #
 # RCU Subsystem
@@ -67,6 +70,7 @@ CONFIG_CGROUPS=y
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
 # CONFIG_CGROUP_SCHED is not set
+# CONFIG_BLK_CGROUP is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
@@ -75,6 +79,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_IPC_NS is not set
 # CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
@@ -110,12 +115,13 @@ CONFIG_PERF_USE_VMALLOC=y
 # CONFIG_PERF_EVENTS is not set
 # CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
+# CONFIG_OPROFILE is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
@@ -147,8 +153,7 @@ CONFIG_LBDAF=y
 #
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=m
-# CONFIG_CFQ_GROUP_IOSCHED is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
@@ -192,6 +197,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_VEXPRESS is not set
 # CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_BCMRING is not set
 # CONFIG_ARCH_CLPS711X is not set
@@ -231,7 +237,7 @@ CONFIG_ARCH_CNS3XXX=y
 # CONFIG_ARCH_S3C64XX is not set
 # CONFIG_ARCH_S5P6440 is not set
 # CONFIG_ARCH_S5P6442 is not set
-# CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_S5PC100 is not set
 # CONFIG_ARCH_S5PV210 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
@@ -240,6 +246,7 @@ CONFIG_ARCH_CNS3XXX=y
 # CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_DAVINCI is not set
 # CONFIG_ARCH_OMAP is not set
+# CONFIG_PLAT_SPEAR is not set
 
 #
 # CNS3XXX platform type
@@ -270,6 +277,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_ARM_L1_CACHE_SHIFT=5
+CONFIG_ARM_DMA_MEM_BUFFERABLE=y
 CONFIG_CPU_HAS_PMU=y
 # CONFIG_ARM_ERRATA_411920 is not set
 CONFIG_ARM_GIC=y
@@ -277,8 +285,12 @@ CONFIG_ARM_GIC=y
 #
 # Bus support
 #
-# CONFIG_PCI_SYSCALL is not set
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 # CONFIG_PCCARD is not set
 
 #
@@ -322,6 +334,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,38400 mem=128M root=/dev/mmcblk0p1 ro rootwait"
+# CONFIG_CMDLINE_FORCE is not set
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -355,7 +368,96 @@ CONFIG_HAVE_AOUT=y
 #
 # CONFIG_PM is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
-# CONFIG_NET is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
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
+# CONFIG_L2TP is not set
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
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -372,6 +474,7 @@ CONFIG_FW_LOADER=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_TESTS is not set
@@ -393,6 +496,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -427,11 +531,13 @@ CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_MTD_PHYSMAP_COMPAT is not set
 # CONFIG_MTD_ARM_INTEGRATOR is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_PMC551 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -457,6 +563,10 @@ CONFIG_MTD_PHYSMAP=y
 # CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -464,11 +574,14 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=20000
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -504,20 +617,160 @@ CONFIG_SCSI_WAIT_SCAN=m
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_SCSI_CXGB3_ISCSI is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
+# CONFIG_BE2ISCSI is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_HPSA is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_3W_SAS is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
 # CONFIG_LIBFC is not set
 # CONFIG_LIBFCOE is not set
+# CONFIG_FCOE is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_PMCRAID is not set
+# CONFIG_SCSI_PM8001 is not set
+# CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_BFA_FC is not set
 # CONFIG_SCSI_DH is not set
 # CONFIG_SCSI_OSD_INITIATOR is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 # CONFIG_SATA_PMP is not set
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_AHCI_PLATFORM=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_ATA_SFF is not set
 # CONFIG_MD is not set
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
+# The newer stack is recommended.
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
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+CONFIG_E1000E=y
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+CONFIG_SKY2=y
+# CONFIG_SKY2_DEBUG is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+CONFIG_CHELSIO_T3_DEPENDS=y
+# CONFIG_CHELSIO_T3 is not set
+CONFIG_CHELSIO_T4_DEPENDS=y
+# CONFIG_CHELSIO_T4 is not set
+# CONFIG_ENIC is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_EN is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
+# CONFIG_QLCNIC is not set
+# CONFIG_QLGE is not set
+# CONFIG_SFC is not set
+# CONFIG_BE2NET is not set
+# CONFIG_TR is not set
+CONFIG_WLAN=y
+# CONFIG_ATMEL is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_HOSTAP is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
+# CONFIG_ISDN is not set
 # CONFIG_PHONE is not set
 
 #
@@ -565,12 +818,15 @@ CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -580,7 +836,10 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -588,8 +847,11 @@ CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
 
@@ -616,12 +878,16 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_LPC_SCH is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+CONFIG_VGA_ARB=y
+CONFIG_VGA_ARB_MAX_GPUS=16
+# CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
@@ -640,6 +906,7 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
+# CONFIG_UWB is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -656,19 +923,20 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # MMC/SD/SDIO Host Controller Drivers
 #
 CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_PCI is not set
 CONFIG_MMC_SDHCI_PLTFM=y
+# CONFIG_MMC_TIFM_SD is not set
+# CONFIG_MMC_CB710 is not set
+# CONFIG_MMC_VIA_SDMMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -687,6 +955,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
 # CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
@@ -753,6 +1022,26 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFS_FSCACHE is not set
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
@@ -760,6 +1049,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
@@ -782,11 +1072,10 @@ CONFIG_FRAME_POINTER=y
 # CONFIG_LATENCYTOP is not set
 # CONFIG_SYSCTL_SYSCALL_CHECK is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
-CONFIG_RING_BUFFER=y
-CONFIG_RING_BUFFER_ALLOW_SWAP=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
 # CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_ARM_UNWIND is not set
@@ -804,7 +1093,93 @@ CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
 CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_DEFAULT_SECURITY=""
-# CONFIG_CRYPTO is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_MANAGER2 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
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
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
 # CONFIG_BINARY_PRINTF is not set
 
 #
@@ -828,4 +1203,5 @@ CONFIG_DECOMPRESS_LZO=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
 CONFIG_GENERIC_ATOMIC64=y
-- 
1.7.0.5
