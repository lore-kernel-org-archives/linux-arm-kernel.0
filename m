From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sat, 03 Oct 2009 20:49:01 +0100
Subject: Sparsemem  on EP93XX
In-Reply-To: <20091003194155.GA21857@n2100.arm.linux.org.uk>
References: <4AC7A3D4.3080408@techworks.ie>
	<20091003194155.GA21857@n2100.arm.linux.org.uk>
Message-ID: <4AC7AAAD.4000301@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sat, Oct 03, 2009 at 08:19:48PM +0100, Christian Gagneraud wrote:
>> Hi all,
>>
>> I'm trying to get a TS72XX board working with sparsemem, but got unlucky 
>> so far. I've read all related threads in the archive and especially this 
>> one:
>> http://marc.info/?l=linux-arm&m=122754446724900&w=2
>>
>> Here is the patch I've applied:
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1c4119c..0f1d52f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -288,6 +288,7 @@ config ARCH_EP93XX
>>         select CPU_ARM920T
>>         select ARM_AMBA
>>         select ARM_VIC
>> +       select ARCH_SPARSEMEM_ENABLE
>>         select GENERIC_GPIO
>>         select HAVE_CLK
>>         select COMMON_CLKDEV
> 
> In spite of the above...
> 
>> <7>On node 0 totalpages: 16384
>> <6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] align=20 
>> goal=e7ffffff limit=0
>> <6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] align=20 
>> goal=0 limit=0
>> <1>bootmem alloc of 30081024 bytes failed!
>> <0>Kernel panic - not syncing: Out of memory
>> Backtrace:
>> [<c001c750>] (dump_backtrace+0x0/0x10c) from [<c0120c0c>]  
>> (dump_stack+0x18/0x1c)
>>  r7:00000020 r6:c01618d0 r5:00000000 r4:01cb0000
>> [<c0120bf4>] (dump_stack+0x0/0x1c) from [<c0120c5c>] (panic+0x4c/0x12c)
>> [<c0120c10>] (panic+0x0/0x12c) from [<c000f298>]  
>> (___alloc_bootmem+0x30/0x38)
>>  r3:ffffffff r2:c0156140 r1:600000d3 r0:c0144420
>> [<c000f268>] (___alloc_bootmem+0x0/0x38) from [<c000f310>]  
>> (___alloc_bootmem_node+0x70/0x74)
>>  r5:00000000 r4:c0017280
>> [<c000f2a0>] (___alloc_bootmem_node+0x0/0x74) from [<c000f3ec>]  
>> (__alloc_bootmem_node+0x44/0x90)
>>  r8:c0160de4 r7:01cb0000 r6:e7ffffff r5:00000020 r4:c0160de4
>> [<c000f3a8>] (__alloc_bootmem_node+0x0/0x90) from [<c0120a90>]  
>> (alloc_node_mem_map+0x74/0x90)
> 
> This seems to suggest that sparsemem is still disabled, since
> alloc_bootmem_node will only be called from alloc_node_mem_map
> if FLAT_NODE_MEM_MAP is enabled, and this should not be enabled
> with sparsemem.
> 
> Seeing your .config file might be useful.

Here is the relevant parts:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.32-rc2
# Sat Oct  3 19:44:47 2009
#
CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_GENERIC_GPIO=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
CONFIG_VECTORS_BASE=0xffff0000
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y

#
# General setup
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION="-twm0.0"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_TREE_PREEMPT_RCU is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_CGROUPS is not set
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y

#
# Kernel Performance Events And Counters
#
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_CLK=y

#
# GCOV-based kernel profiling
#
# CONFIG_SLOW_WORK is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_FREEZER is not set

#
# System Type
#
CONFIG_MMU=y
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_EBSA110 is not set
CONFIG_ARCH_EP93XX=y
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_STMP3XXX is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_NOMADIK is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_KIRKWOOD is not set
# CONFIG_ARCH_LOKI is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
# CONFIG_ARCH_W90X900 is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_MSM is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_S5PC1XX is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_U300 is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
# CONFIG_ARCH_BCMRING is not set

#
# Cirrus EP93xx Implementation Options
#
# CONFIG_CRUNCH is not set
CONFIG_CR1_NFBIT=y

#
# EP93xx Platforms
#
CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET=y
# CONFIG_EP93XX_SDCE0_PHYS_OFFSET is not set
# CONFIG_EP93XX_SDCE1_PHYS_OFFSET is not set
# CONFIG_EP93XX_SDCE2_PHYS_OFFSET is not set
# CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET is not set
# CONFIG_MACH_ADSSPHERE is not set
# CONFIG_MACH_EDB9301 is not set
# CONFIG_MACH_EDB9302 is not set
# CONFIG_MACH_EDB9307 is not set
# CONFIG_MACH_EDB9312 is not set
# CONFIG_MACH_EDB9315 is not set
# CONFIG_MACH_GESBC9312 is not set
# CONFIG_MACH_MICRO9H is not set
# CONFIG_MACH_MICRO9L is not set
CONFIG_MACH_TS72XX=y
CONFIG_EP93XX_EARLY_UART1=y
# CONFIG_EP93XX_EARLY_UART2 is not set
# CONFIG_EP93XX_EARLY_UART3 is not set
CONFIG_MACH_TS72XX_FORCE_MACHINEID=y

#
# Processor Type
#
CONFIG_CPU_32=y
CONFIG_CPU_ARM920T=y
CONFIG_CPU_32v4T=y
CONFIG_CPU_ABRT_EV4T=y
CONFIG_CPU_PABRT_NOIFAR=y
CONFIG_CPU_CACHE_V4WT=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_COPY_V4WB=y
CONFIG_CPU_TLB_V4WBI=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
CONFIG_ARM_THUMB=y
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
CONFIG_ARM_L1_CACHE_SHIFT=5
CONFIG_ARM_VIC=y
CONFIG_ARM_VIC_NR=2
CONFIG_COMMON_CLKDEV=y

#
# Bus support
#
CONFIG_ARM_AMBA=y
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set


#
# Kernel Features
#
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_HZ=100
CONFIG_AEABI=y
CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4096
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
CONFIG_HAVE_MLOCK=y
CONFIG_HAVE_MLOCKED_PAGE_BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ALIGNMENT_TRAP=y


Chris
