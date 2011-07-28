From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 28 Jul 2011 15:45:21 -0600
Subject: [PATCH] mtd/m25p80: add device tree probe support
In-Reply-To: <4E31B713.1030901@free.fr>
References: <1311601063-16581-1-git-send-email-shawn.guo@linaro.org>
	<20110725211910.GG26735@ponder.secretlab.ca>
	<4E31B713.1030901@free.fr>
Message-ID: <20110728214521.GA4674@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 09:22:59PM +0200, manu wrote:
> Dear Grant, Shawn,
> I don't this patch is required as m25p** serial flashes are
> supported already with generic OF/SPI and OF/MTD schemes.
> I have successfully used it myself on an unmodified 2.6.36.3 vanilla
> kernel on a xilinx/powerpc platform with a m25p32 part from STM.
> You will find attached the corresponding working defconfig + dts
> files (appart from partitions which I didn't managed to configure
> properly...).
> Best Regards,
> 
> Manuel

There is a heuristic which allows spi and i2c devices to get bound
without a match table, which is why it works for you, but there is no
guarantee that the heuristic will continue to exist in the long term.
This is still probably the right thing to do.

g.

> 
> 
> Le 25/07/2011 23:19, Grant Likely a ?crit :
> >On Mon, Jul 25, 2011 at 09:37:43PM +0800, Shawn Guo wrote:
> >>It adds device tree probe support for m25p80 driver.
> >>
> >>Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> >>Cc: Grant Likely<grant.likely@secretlab.ca>
> >>Cc: Artem Bityutskiy<artem.bityutskiy@intel.com>
> >Acked-by: Grant Likely<grant.likely@secretlab.ca>
> >>---
> >>  Documentation/devicetree/bindings/mtd/st-m25p.txt |   14 ++++++++++++++
> >>  drivers/mtd/devices/m25p80.c                      |   12 ++++++++++++
> >>  2 files changed, 26 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/st-m25p.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/mtd/st-m25p.txt b/Documentation/devicetree/bindings/mtd/st-m25p.txt
> >>new file mode 100644
> >>index 0000000..a8c0485
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/mtd/st-m25p.txt
> >>@@ -0,0 +1,14 @@
> >>+* STMicroelectronics SPI Flash
> >>+
> >>+Required properties:
> >>+- compatible : "st,<model>", "st,m25p".
> >>+
> >>+Examples:
> >>+
> >>+flash: m25p32 at 1 {
> >>+	#address-cells =<1>;
> >>+	#size-cells =<1>;
> >>+	compatible = "st,m25p32", "st,m25p";
> >>+	spi-max-frequency =<20000000>;
> >>+	reg =<1>;
> >>+};
> >>diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> >>index e6ba034..d9d4101 100644
> >>--- a/drivers/mtd/devices/m25p80.c
> >>+++ b/drivers/mtd/devices/m25p80.c
> >>@@ -26,6 +26,7 @@
> >>  #include<linux/slab.h>
> >>  #include<linux/sched.h>
> >>  #include<linux/mod_devicetable.h>
> >>+#include<linux/of_device.h>
> >>
> >>  #include<linux/mtd/cfi.h>
> >>  #include<linux/mtd/mtd.h>
> >>@@ -767,6 +768,16 @@ static const struct spi_device_id m25p_ids[] = {
> >>  };
> >>  MODULE_DEVICE_TABLE(spi, m25p_ids);
> >>
> >>+#ifdef CONFIG_OF
> >>+static const struct of_device_id m25p_dt_ids[] = {
> >>+	{ .compatible = "st,m25p", },
> >>+	{ /* sentinel */ }
> >>+};
> >>+MODULE_DEVICE_TABLE(of, m25p_dt_ids);
> >>+#else
> >>+#define m25p_dt_ids NULL
> >>+#endif
> >>+
> >>  static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
> >>  {
> >>  	int			tmp;
> >>@@ -986,6 +997,7 @@ static struct spi_driver m25p80_driver = {
> >>  		.name	= "m25p80",
> >>  		.bus	=&spi_bus_type,
> >>  		.owner	= THIS_MODULE,
> >>+		.of_match_table = m25p_dt_ids,
> >>  	},
> >>  	.id_table	= m25p_ids,
> >>  	.probe	= m25p_probe,
> >>-- 
> >>1.7.4.1
> >>
> >>
> >_______________________________________________
> >devicetree-discuss mailing list
> >devicetree-discuss at lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/devicetree-discuss
> >
> >
> 

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.36.3
> # Wed Feb  9 11:27:22 2011
> #
> # CONFIG_PPC64 is not set
> 
> #
> # Processor support
> #
> # CONFIG_PPC_BOOK3S_32 is not set
> # CONFIG_PPC_85xx is not set
> # CONFIG_PPC_8xx is not set
> CONFIG_40x=y
> # CONFIG_44x is not set
> # CONFIG_E200 is not set
> CONFIG_4xx=y
> CONFIG_PPC_MMU_NOHASH=y
> CONFIG_PPC_MMU_NOHASH_32=y
> # CONFIG_PPC_MM_SLICES is not set
> CONFIG_NOT_COHERENT_CACHE=y
> CONFIG_PPC32=y
> CONFIG_WORD_SIZE=32
> # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
> CONFIG_MMU=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
> # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
> # CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
> CONFIG_IRQ_PER_CPU=y
> CONFIG_NR_IRQS=512
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_ARCH_HAS_ILOG2_U32=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
> CONFIG_PPC=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_NVRAM=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_PPC_OF=y
> CONFIG_PPC_UDBG_16550=y
> # CONFIG_GENERIC_TBSYNC is not set
> CONFIG_AUDIT_ARCH=y
> CONFIG_GENERIC_BUG=y
> CONFIG_DEFAULT_UIMAGE=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_PPC_DCR_NATIVE=y
> # CONFIG_PPC_DCR_MMIO is not set
> CONFIG_PPC_DCR=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_PPC_ADV_DEBUG_REGS=y
> CONFIG_PPC_ADV_DEBUG_IACS=2
> CONFIG_PPC_ADV_DEBUG_DACS=2
> CONFIG_PPC_ADV_DEBUG_DVCS=0
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_CONSTRUCTORS=y
> 
> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_CROSS_COMPILE=""
> CONFIG_LOCALVERSION=""
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_TREE_PREEMPT_RCU is not set
> # CONFIG_TINY_RCU is not set
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_FANOUT=32
> # CONFIG_RCU_FANOUT_EXACT is not set
> # CONFIG_TREE_RCU_TRACE is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=12
> # CONFIG_CGROUPS is not set
> # CONFIG_SYSFS_DEPRECATED_V2 is not set
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE="../rootfs_dev_script_ppc"
> CONFIG_INITRAMFS_ROOT_UID=0
> CONFIG_INITRAMFS_ROOT_GID=0
> CONFIG_RD_GZIP=y
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> # CONFIG_RD_LZO is not set
> CONFIG_INITRAMFS_COMPRESSION_NONE=y
> # CONFIG_INITRAMFS_COMPRESSION_GZIP is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_EMBEDDED=y
> CONFIG_SYSCTL_SYSCALL=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> # CONFIG_PERF_EVENTS is not set
> # CONFIG_PERF_COUNTERS is not set
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_COMPAT_BRK=y
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> # CONFIG_PROFILING is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_ATTRS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> # CONFIG_MODULES is not set
> # CONFIG_BLOCK is not set
> # CONFIG_INLINE_SPIN_TRYLOCK is not set
> # CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
> # CONFIG_INLINE_SPIN_LOCK is not set
> # CONFIG_INLINE_SPIN_LOCK_BH is not set
> # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
> # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
> # CONFIG_INLINE_SPIN_UNLOCK is not set
> # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
> # CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
> # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
> # CONFIG_INLINE_READ_TRYLOCK is not set
> # CONFIG_INLINE_READ_LOCK is not set
> # CONFIG_INLINE_READ_LOCK_BH is not set
> # CONFIG_INLINE_READ_LOCK_IRQ is not set
> # CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
> # CONFIG_INLINE_READ_UNLOCK is not set
> # CONFIG_INLINE_READ_UNLOCK_BH is not set
> # CONFIG_INLINE_READ_UNLOCK_IRQ is not set
> # CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
> # CONFIG_INLINE_WRITE_TRYLOCK is not set
> # CONFIG_INLINE_WRITE_LOCK is not set
> # CONFIG_INLINE_WRITE_LOCK_BH is not set
> # CONFIG_INLINE_WRITE_LOCK_IRQ is not set
> # CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
> # CONFIG_INLINE_WRITE_UNLOCK is not set
> # CONFIG_INLINE_WRITE_UNLOCK_BH is not set
> # CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
> # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
> # CONFIG_MUTEX_SPIN_ON_OWNER is not set
> # CONFIG_FREEZER is not set
> 
> #
> # Platform support
> #
> # CONFIG_PPC_CELL is not set
> # CONFIG_PPC_CELL_NATIVE is not set
> # CONFIG_PQ2ADS is not set
> # CONFIG_ISS4xx is not set
> # CONFIG_PPC4xx_GPIO is not set
> CONFIG_XILINX_VIRTEX=y
> # CONFIG_ACADIA is not set
> # CONFIG_EP405 is not set
> # CONFIG_HCU4 is not set
> # CONFIG_HOTFOOT is not set
> # CONFIG_KILAUEA is not set
> # CONFIG_MAKALU is not set
> # CONFIG_WALNUT is not set
> CONFIG_XILINX_VIRTEX_GENERIC_BOARD=y
> # CONFIG_PPC40x_SIMPLE is not set
> CONFIG_XILINX_VIRTEX_II_PRO=y
> CONFIG_XILINX_VIRTEX_4_FX=y
> CONFIG_IBM405_ERR77=y
> CONFIG_IBM405_ERR51=y
> # CONFIG_IPIC is not set
> # CONFIG_MPIC is not set
> # CONFIG_MPIC_WEIRD is not set
> # CONFIG_PPC_I8259 is not set
> # CONFIG_PPC_RTAS is not set
> # CONFIG_MMIO_NVRAM is not set
> # CONFIG_MPIC_U3_HT_IRQS is not set
> # CONFIG_PPC_MPC106 is not set
> # CONFIG_PPC_970_NAP is not set
> # CONFIG_PPC_INDIRECT_IO is not set
> # CONFIG_GENERIC_IOMAP is not set
> # CONFIG_CPU_FREQ is not set
> # CONFIG_FSL_ULI1575 is not set
> # CONFIG_SIMPLE_GPIO is not set
> 
> #
> # Kernel options
> #
> # CONFIG_HIGHMEM is not set
> # CONFIG_NO_HZ is not set
> # CONFIG_HIGH_RES_TIMERS is not set
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_SCHED_HRTICK is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_BINFMT_ELF=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> # CONFIG_HAVE_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> CONFIG_MATH_EMULATION=y
> # CONFIG_IOMMU_HELPER is not set
> # CONFIG_SWIOTLB is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_HAS_WALK_MEMORY=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_MAX_ACTIVE_REGIONS=32
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_PAGEFLAGS_EXTENDED=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_MIGRATION is not set
> # CONFIG_PHYS_ADDR_T_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_VIRT_TO_BUS=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_PPC_4K_PAGES=y
> CONFIG_FORCE_MAX_ZONEORDER=11
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE=""
> CONFIG_EXTRA_TARGETS=""
> # CONFIG_PM is not set
> CONFIG_SECCOMP=y
> CONFIG_ISA_DMA_API=y
> 
> #
> # Bus options
> #
> CONFIG_ZONE_DMA=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_4xx_SOC=y
> CONFIG_PPC_PCI_CHOICE=y
> # CONFIG_PCI is not set
> # CONFIG_PCI_DOMAINS is not set
> # CONFIG_PCI_SYSCALL is not set
> # CONFIG_ARCH_SUPPORTS_MSI is not set
> # CONFIG_PCCARD is not set
> # CONFIG_HAS_RAPIDIO is not set
> 
> #
> # Advanced setup
> #
> # CONFIG_ADVANCED_OPTIONS is not set
> 
> #
> # Default settings for advanced configuration options are used
> #
> CONFIG_LOWMEM_SIZE=0x30000000
> CONFIG_PAGE_OFFSET=0xc0000000
> CONFIG_KERNEL_START=0xc0000000
> CONFIG_PHYSICAL_START=0x00000000
> CONFIG_TASK_SIZE=0xc0000000
> CONFIG_CONSISTENT_SIZE=0x00200000
> # CONFIG_NET is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> # CONFIG_DEVTMPFS is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_FIRMWARE_IN_KERNEL is not set
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_SYS_HYPERVISOR is not set
> CONFIG_MTD=y
> # CONFIG_MTD_DEBUG is not set
> # CONFIG_MTD_CONCAT is not set
> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_OF_PARTS=y
> # CONFIG_MTD_AR7_PARTS is not set
> 
> #
> # User Modules And Translation Layers
> #
> # CONFIG_MTD_CHAR is not set
> # CONFIG_MTD_OOPS is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PLATRAM is not set
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_DATAFLASH is not set
> CONFIG_MTD_M25P80=y
> CONFIG_M25PXX_USE_FAST_READ=y
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOC2001PLUS is not set
> # CONFIG_MTD_NAND is not set
> # CONFIG_MTD_ONENAND is not set
> 
> #
> # LPDDR flash memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> 
> #
> # UBI - Unsorted block images
> #
> # CONFIG_MTD_UBI is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> 
> #
> # Flattened Device Tree and Open Firmware support
> #
> CONFIG_PROC_DEVICETREE=y
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_DEVICE=y
> CONFIG_OF_SPI=y
> # CONFIG_PARPORT is not set
> # CONFIG_MISC_DEVICES is not set
> CONFIG_HAVE_IDE=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_SCSI_DMA is not set
> # CONFIG_SCSI_NETLINK is not set
> # CONFIG_MACINTOSH_DRIVERS is not set
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> # CONFIG_SERIO_I8042 is not set
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_LIBPS2 is not set
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_XILINX_XPS_PS2 is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_GAMEPORT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> # CONFIG_DEVKMEM is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX3107 is not set
> CONFIG_SERIAL_UARTLITE=y
> CONFIG_SERIAL_UARTLITE_CONSOLE=y
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_OF_PLATFORM=y
> # CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_HVC_UDBG is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> # CONFIG_GEN_RTC is not set
> # CONFIG_XILINX_HWICAP is not set
> # CONFIG_R3964 is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_RAMOOPS is not set
> # CONFIG_I2C is not set
> CONFIG_SPI=y
> CONFIG_SPI_MASTER=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_PPC4xx is not set
> CONFIG_SPI_XILINX=y
> CONFIG_SPI_XILINX_OF=y
> # CONFIG_SPI_XILINX_PLTFM is not set
> # CONFIG_SPI_DESIGNWARE is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_TLE62X0 is not set
> 
> #
> # PPS support
> #
> # CONFIG_PPS is not set
> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> 
> #
> # Sonics Silicon Backplane
> #
> # CONFIG_SSB is not set
> CONFIG_MFD_SUPPORT=y
> # CONFIG_MFD_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_MFD_MC13783 is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_AB8500_CORE is not set
> # CONFIG_REGULATOR is not set
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> # CONFIG_FB is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> #
> # Display device support
> #
> # CONFIG_DISPLAY_SUPPORT is not set
> 
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_SOUND is not set
> # CONFIG_HID_SUPPORT is not set
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_EDAC is not set
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_STAGING is not set
> 
> #
> # File systems
> #
> CONFIG_FILE_LOCKING=y
> # CONFIG_FSNOTIFY is not set
> # CONFIG_DNOTIFY is not set
> # CONFIG_INOTIFY_USER is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_CONFIGFS_FS is not set
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_FS_XATTR is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=y
> # CONFIG_JFFS2_LZO is not set
> CONFIG_JFFS2_RTIME=y
> # CONFIG_JFFS2_RUBIN is not set
> # CONFIG_LOGFS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> # CONFIG_BINARY_PRINTF is not set
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_FIND_LAST_BIT=y
> CONFIG_CRC_CCITT=y
> # CONFIG_CRC16 is not set
> # CONFIG_CRC_T10DIF is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
> CONFIG_GENERIC_ATOMIC64=y
> 
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_ENABLE_WARN_DEPRECATED is not set
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=1024
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_KERNEL is not set
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> # CONFIG_SYSCTL_SYSCALL_CHECK is not set
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_PPC_DISABLE_WERROR is not set
> CONFIG_PPC_WERROR=y
> CONFIG_PRINT_STACK_DEPTH=64
> # CONFIG_PPC_EARLY_DEBUG is not set
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> # CONFIG_CRYPTO is not set
> # CONFIG_PPC_CLOCK is not set
> # CONFIG_VIRTUALIZATION is not set

> /*
>  * Device Tree Generator version: 1.3
>  *
>  * (C) Copyright 2007-2008 Xilinx, Inc.
>  * (C) Copyright 2007-2009 Michal Simek
>  *
>  * Michal SIMEK <monstr@monstr.eu>
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License as
>  * published by the Free Software Foundation; either version 2 of
>  * the License, or (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>  * MA 02111-1307 USA
>  *
>  * CAUTION: This file is automatically generated by libgen.
>  * Version: Xilinx EDK 10.1.03 EDK_K_SP3.6
>  *
>  * XPS project directory: macsoft5
>  */
> 
> /dts-v1/;
> / {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	compatible = "xlnx,virtex405", "xlnx,virtex";
> 	model = "testing";
> 	Generic_SDRAM: memory at 0 {
> 		device_type = "memory";
> 		reg = < 0x0 0x800000 >;
> 	} ;
> 	aliases {
> 		serial0 = &RS232;
> 		serial1 = &RS232_1;
> 	} ;
> 	chosen {
> 		bootargs = "console=ttyUL0";
> 		linux,stdout-path = "/plb at 0/opb at 40000000/serial at 40620000";
> 	} ;
> 	cpus {
> 		#address-cells = <1>;
> 		#cpus = <0x1>;
> 		#size-cells = <0>;
> 		ppc405_0: cpu at 0 {
> 			clock-frequency = <200000000>;
> 			compatible = "PowerPC,405", "ibm,ppc405";
> 			d-cache-line-size = <0x20>;
> 			d-cache-size = <0x4000>;
> 			dcr-access-method = "native";
> 			dcr-controller ;
> 			device_type = "cpu";
> 			i-cache-line-size = <0x20>;
> 			i-cache-size = <0x4000>;
> 			model = "PowerPC,405";
> 			reg = <0>;
> 			timebase-frequency = <200000000>;
> 			xlnx,apu-control = <0xde00>;
> 			xlnx,apu-udi-1 = <0xa18983>;
> 			xlnx,apu-udi-2 = <0xa38983>;
> 			xlnx,apu-udi-3 = <0xa589c3>;
> 			xlnx,apu-udi-4 = <0xa789c3>;
> 			xlnx,apu-udi-5 = <0xa98c03>;
> 			xlnx,apu-udi-6 = <0xab8c03>;
> 			xlnx,apu-udi-7 = <0xad8c43>;
> 			xlnx,apu-udi-8 = <0xaf8c43>;
> 			xlnx,deterministic-mult = <0x0>;
> 			xlnx,disable-operand-forwarding = <0x1>;
> 			xlnx,mmu-enable = <0x1>;
> 			xlnx,pvr-high = <0x0>;
> 			xlnx,pvr-low = <0x0>;
> 		} ;
> 	} ;
> 	plb: plb at 0 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
> 		ranges ;
> 		Generic_SDRAM: plb-sdram at 0 {
> 			compatible = "xlnx,plb-sdram-1.00.e";
> 			reg = < 0x0 0x800000 >;
> 			xlnx,family = "virtex4";
> 			xlnx,include-burst-cacheln-support = <0x1>;
> 			xlnx,include-highspeed-pipe = <0x1>;
> 			xlnx,sdram-awidth = <0xc>;
> 			xlnx,sdram-bank-awidth = <0x2>;
> 			xlnx,sdram-cas-lat = <0x2>;
> 			xlnx,sdram-col-awidth = <0x8>;
> 			xlnx,sdram-dwidth = <0x10>;
> 			xlnx,sdram-refresh-numrows = <0x1000>;
> 			xlnx,sdram-tccd = <0x1>;
> 			xlnx,sdram-tmrd = <0x2>;
> 			xlnx,sdram-tras = <0x9c40>;
> 			xlnx,sdram-trc = <0xfde8>;
> 			xlnx,sdram-trcd = <0x4e20>;
> 			xlnx,sdram-tref = <0x40>;
> 			xlnx,sdram-trefi = <0xee6b28>;
> 			xlnx,sdram-trfc = <0x124f8>;
> 			xlnx,sdram-trp = <0x4e20>;
> 			xlnx,sdram-trrd = <0x3a98>;
> 			xlnx,sdram-twr = <0x3a98>;
> 			xlnx,sim-init-time-ps = <0x5f5e100>;
> 			xlnx,use-posedge-outregs = <0x0>;
> 		} ;
> 		opb: opb at 40000000 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "xlnx,opb-v20-1.10.c", "simple-bus";
> 			ranges = < 0x40000000 0x40000000 0x40000000 >;
> 			RS232: serial at 40620000 {
> 				clock-frequency = "";
> 				compatible = "xlnx,opb-uartlite-1.00.b";
> 				current-speed = <115200>;
> 				device_type = "serial";
> 				interrupt-parent = <&opb_intc_0>;
> 				interrupts = < 5 0 >;
> 				port-number = <0>;
> 				reg = < 0x40620000 0x10000 >;
> 				xlnx,baudrate = <0x1c200>;
> 				xlnx,clk-freq = <0x5f5e100>;
> 				xlnx,data-bits = <0x8>;
> 				xlnx,odd-parity = <0x1>;
> 				xlnx,use-parity = <0x0>;
> 			} ;
> 			RS232_1: serial at 40600000 {
> 				clock-frequency = "";
> 				compatible = "xlnx,opb-uartlite-1.00.b";
> 				current-speed = <115200>;
> 				device_type = "serial";
> 				interrupt-parent = <&opb_intc_0>;
> 				interrupts = < 4 0 >;
> 				port-number = <1>;
> 				reg = < 0x40600000 0x10000 >;
> 				xlnx,baudrate = <0x1c200>;
> 				xlnx,clk-freq = <0x5f5e100>;
> 				xlnx,data-bits = <0x8>;
> 				xlnx,odd-parity = <0x1>;
> 				xlnx,use-parity = <0x0>;
> 			} ;
> 			opb_intc_0: interrupt-controller at 41200000 {
> 				#interrupt-cells = <0x2>;
> 				compatible = "xlnx,opb-intc-1.00.c", "xlnx,xps-intc-1.00.a";
> 				interrupt-controller ;
> 				reg = < 0x41200000 0x10000 >;
> 				xlnx,kind-of-intr = <0x30>;
> 				xlnx,num-intr-inputs = <0x6>;
> 			} ;
> 			opb_spi_0: opb-spi at 55000000 {
> 				compatible = "xlnx,opb-spi-1.00.e";
> 				interrupt-parent = <&opb_intc_0>;
> 				interrupts = < 2 2 >;
> 				reg = < 0x55000000 0x10000 >;
> 				xlnx,depth = <0x10>;
> 				xlnx,dev-blk-id = <0x4>;
> 				xlnx,dev-mir-enable = <0x0>;
> 				xlnx,family = "virtex4";
> 				xlnx,fifo-exist = <0x1>;
> 				xlnx,interrupt-present = <0x1>;
> 				xlnx,ip-reg-bar-offset = <0x60>;
> 				xlnx,num-bits-reg = <0x8>;
> 				xlnx,num-bits-sr = <0x8>;
> 				xlnx,num-offchip-ss-bits = <0x4>;
> 				xlnx,num-ss-bits = <0x4>;
> 				xlnx,occupancy-num-bits = <0x4>;
> 				xlnx,spi-slave-only = <0x0>;
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				spi_flash at 0 {
> 					compatible = "stm,m25p32", "m25p80";
> 					reg = <0>;
> 					spi-max-frequency = <10000000>;
> 				};
> 				spi_flash at 1 {
> 					compatible = "stm,m25p32", "m25p80";
> 					reg = <1>;
> 					spi-max-frequency = <10000000>;
> 					#address-cells = <1>;
> 					#size-cells = <1>;
> 					partition at 0x00000000 {
> 						label = "test-part1";
> 						reg = <0x00000000 0x00400000>;
> 					};
> 				};
> 			} ;
> 		} ;
> 	} ;
> }  ;
