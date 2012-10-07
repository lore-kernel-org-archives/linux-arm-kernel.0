From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 7 Oct 2012 21:57:59 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007015405.958959522@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
Message-ID: <20121007195759.GG12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03:53 Sun 07 Oct     , Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> BCM476x's minimal infrastructure, Kernel's great reuse.
> 
> Look mom, no include/mach directory!
> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm476x.txt |    8 +
>  MAINTAINERS                                       |    9 +
>  arch/arm/Kconfig                                  |    2 +
>  arch/arm/Makefile                                 |    1 +
>  arch/arm/boot/dts/bcm476x-catalina.dts            |   11 +
>  arch/arm/boot/dts/bcm476x.dtsi                    |   31 ++
>  arch/arm/configs/bcm476x_defconfig                |  352 ++++++++++++++++++++++
>  arch/arm/include/debug/bcm476x-uncompress.h       |   53 +++
>  arch/arm/include/debug/bcm476x.S                  |   35 ++
>  arch/arm/mach-bcm476x/Kconfig                     |   17 +
>  arch/arm/mach-bcm476x/Makefile                    |    1 +
>  arch/arm/mach-bcm476x/Makefile.boot               |    5 +
>  arch/arm/mach-bcm476x/bcm476x.c                   |   83 +++++
>  13 files changed, 608 insertions(+)
> 
> Index: b/Documentation/devicetree/bindings/arm/bcm476x.txt
> ===================================================================
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm476x.txt
> @@ -0,0 +1,8 @@
> +Broadcom BCM476x device tree bindings
> +-------------------------------------------
> +
> +Boards with the BCM476x SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible = "brcm,bcm476x";
> Index: b/arch/arm/Kconfig
> ===================================================================
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1017,6 +1017,8 @@ source "arch/arm/mach-mvebu/Kconfig"
>  
>  source "arch/arm/mach-at91/Kconfig"
>  
> +source "arch/arm/mach-bcm476x/Kconfig"
> +
>  source "arch/arm/mach-clps711x/Kconfig"
>  
>  source "arch/arm/mach-cns3xxx/Kconfig"
> Index: b/arch/arm/Makefile
> ===================================================================
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -137,6 +137,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
>  # by CONFIG_* macro name.
>  machine-$(CONFIG_ARCH_AT91)		+= at91
>  machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
> +machine-$(CONFIG_ARCH_BCM476X)		:= bcm476x
>  machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
>  machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
>  machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
> Index: b/arch/arm/boot/dts/bcm476x-catalina.dts
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm476x-catalina.dts
> @@ -0,0 +1,11 @@
> +/dts-v1/;
> +/include/ "bcm476x.dtsi"
> +
> +/ {
> +	compatible = "brcm,catalina", "brcm,bcm476x";
> +	model = "Broadcom Catalina";
> +
> +	memory {
> +		reg = <0x30000000 0x4000000>;
> +	};
> +};
> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm476x.dtsi
> @@ -0,0 +1,31 @@
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "brcm,bcm476x";
> +	model = "Broadcom BCM476x";
> +
> +	chosen {
> +		bootargs = "earlyprintk";
> +	};
> +
> +	amba {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vic0: interrupt-controller at 80000 {
> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
why brcm specific compatbile?
> +			reg = <0x80000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		vic1: interrupt-controller at 81000 {
> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> +			reg = <0x81000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +	};
> +};
> Index: b/arch/arm/configs/bcm476x_defconfig
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/configs/bcm476x_defconfig
> @@ -0,0 +1,352 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> +CONFIG_HAVE_PROC_CPU=y
> +CONFIG_NO_IOPORT=y
> +CONFIG_STACKTRACE_SUPPORT=y
> +CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> +CONFIG_LOCKDEP_SUPPORT=y
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +CONFIG_RWSEM_GENERIC_SPINLOCK=y
> +CONFIG_GENERIC_HWEIGHT=y
> +CONFIG_GENERIC_CALIBRATE_DELAY=y
> +CONFIG_NEED_DMA_MAP_STATE=y
> +CONFIG_VECTORS_BASE=0xffff0000
> +CONFIG_ARM_PATCH_PHYS_VIRT=y
> +CONFIG_GENERIC_BUG=y
> +CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> +CONFIG_HAVE_IRQ_WORK=y
> +CONFIG_EXPERIMENTAL=y
> +CONFIG_BROKEN_ON_SMP=y
> +CONFIG_INIT_ENV_ARG_LIMIT=32
> +CONFIG_CROSS_COMPILE=""
> +CONFIG_LOCALVERSION=""
> +CONFIG_HAVE_KERNEL_GZIP=y
> +CONFIG_HAVE_KERNEL_LZMA=y
> +CONFIG_HAVE_KERNEL_XZ=y
> +CONFIG_HAVE_KERNEL_LZO=y
> +CONFIG_KERNEL_GZIP=y
> +CONFIG_DEFAULT_HOSTNAME="(none)"
> +CONFIG_HAVE_GENERIC_HARDIRQS=y
> +CONFIG_GENERIC_HARDIRQS=y
> +CONFIG_GENERIC_IRQ_PROBE=y
> +CONFIG_GENERIC_IRQ_SHOW=y
> +CONFIG_HARDIRQS_SW_RESEND=y
> +CONFIG_GENERIC_IRQ_CHIP=y
> +CONFIG_IRQ_DOMAIN=y
> +CONFIG_IRQ_DOMAIN_DEBUG=y
> +CONFIG_SPARSE_IRQ=y
> +CONFIG_KTIME_SCALAR=y
> +CONFIG_GENERIC_CLOCKEVENTS=y
> +CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> +CONFIG_TINY_RCU=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_LOG_BUF_SHIFT=17
> +CONFIG_NAMESPACES=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_INITRAMFS_SOURCE=""
> +CONFIG_RD_GZIP=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_SYSCTL=y
> +CONFIG_ANON_INODES=y
> +CONFIG_EXPERT=y
> +CONFIG_UID16=y
> +CONFIG_KALLSYMS=y
> +CONFIG_HOTPLUG=y
> +CONFIG_PRINTK=y
> +CONFIG_BUG=y
> +CONFIG_ELF_CORE=y
> +CONFIG_BASE_FULL=y
> +CONFIG_FUTEX=y
> +CONFIG_EPOLL=y
> +CONFIG_SIGNALFD=y
> +CONFIG_TIMERFD=y
> +CONFIG_EVENTFD=y
> +CONFIG_SHMEM=y
> +CONFIG_AIO=y
> +CONFIG_EMBEDDED=y
> +CONFIG_HAVE_PERF_EVENTS=y
> +CONFIG_PERF_USE_VMALLOC=y
> +CONFIG_VM_EVENT_COUNTERS=y
> +CONFIG_SLAB=y
> +CONFIG_HAVE_OPROFILE=y
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KRETPROBES=y
> +CONFIG_HAVE_ARCH_TRACEHOOK=y
> +CONFIG_HAVE_DMA_ATTRS=y
> +CONFIG_HAVE_DMA_CONTIGUOUS=y
> +CONFIG_GENERIC_SMP_IDLE_THREAD=y
> +CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> +CONFIG_HAVE_CLK=y
> +CONFIG_HAVE_DMA_API_DEBUG=y
> +CONFIG_HAVE_ARCH_JUMP_LABEL=y
> +CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> +CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> +CONFIG_SLABINFO=y
> +CONFIG_RT_MUTEXES=y
> +CONFIG_BASE_SMALL=0
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_BLOCK=y
> +CONFIG_MSDOS_PARTITION=y
> +CONFIG_IOSCHED_NOOP=y
> +CONFIG_DEFAULT_NOOP=y
> +CONFIG_DEFAULT_IOSCHED="noop"
> +CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> +CONFIG_INLINE_READ_UNLOCK=y
> +CONFIG_INLINE_READ_UNLOCK_IRQ=y
> +CONFIG_INLINE_WRITE_UNLOCK=y
> +CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> +CONFIG_MMU=y
> +CONFIG_ARCH_MULTIPLATFORM=y
> +CONFIG_ARCH_MULTI_V6=y
> +CONFIG_ARCH_MULTI_V6_V7=y
> +CONFIG_ARCH_BCM476X=y
> +CONFIG_CPU_V6=y
> +CONFIG_CPU_32v6=y
> +CONFIG_CPU_ABRT_EV6=y
> +CONFIG_CPU_PABRT_V6=y
> +CONFIG_CPU_CACHE_V6=y
> +CONFIG_CPU_CACHE_VIPT=y
> +CONFIG_CPU_COPY_V6=y
> +CONFIG_CPU_TLB_V6=y
> +CONFIG_CPU_HAS_ASID=y
> +CONFIG_CPU_CP15=y
> +CONFIG_CPU_CP15_MMU=y
> +CONFIG_CPU_USE_DOMAINS=y
> +CONFIG_ARM_THUMB=y
> +CONFIG_ARM_L1_CACHE_SHIFT=5
> +CONFIG_ARM_DMA_MEM_BUFFERABLE=y
> +CONFIG_ARM_NR_BANKS=8
> +CONFIG_CPU_HAS_PMU=y
> +CONFIG_MULTI_IRQ_HANDLER=y
> +CONFIG_ARM_ERRATA_411920=y
> +CONFIG_ARM_ERRATA_364296=y
> +CONFIG_ARM_VIC=y
> +CONFIG_ARM_VIC_NR=2
> +CONFIG_ARM_AMBA=y
> +CONFIG_VMSPLIT_3G=y
> +CONFIG_PAGE_OFFSET=0xC0000000
> +CONFIG_ARCH_NR_GPIO=0
> +CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_COUNT=y
> +CONFIG_HZ=100
> +CONFIG_AEABI=y
> +CONFIG_HAVE_ARCH_PFN_VALID=y
> +CONFIG_SELECT_MEMORY_MODEL=y
> +CONFIG_FLATMEM_MANUAL=y
> +CONFIG_FLATMEM=y
> +CONFIG_FLAT_NODE_MEM_MAP=y
> +CONFIG_HAVE_MEMBLOCK=y
> +CONFIG_MEMORY_ISOLATION=y
> +CONFIG_PAGEFLAGS_EXTENDED=y
> +CONFIG_SPLIT_PTLOCK_CPUS=4
> +CONFIG_MIGRATION=y
> +CONFIG_ZONE_DMA_FLAG=0
> +CONFIG_VIRT_TO_BUS=y
> +CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> +CONFIG_CROSS_MEMORY_ATTACH=y
> +CONFIG_NEED_PER_CPU_KM=y
> +CONFIG_FORCE_MAX_ZONEORDER=11
> +CONFIG_ALIGNMENT_TRAP=y
> +CONFIG_DEPRECATED_PARAM_STRUCT=y
> +CONFIG_USE_OF=y
> +CONFIG_ZBOOT_ROM_TEXT=0
> +CONFIG_ZBOOT_ROM_BSS=0
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> +CONFIG_CMDLINE="root=/dev/mmcblk0p2 ro console=ttyAMA1,115200 rootwait init=/bin/bash"
> +CONFIG_CMDLINE_FROM_BOOTLOADER=y
> +CONFIG_AUTO_ZRELADDR=y
> +CONFIG_VFP=y
> +CONFIG_BINFMT_ELF=y
> +CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
> +CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> +CONFIG_HAVE_AOUT=y
> +CONFIG_ARCH_SUSPEND_POSSIBLE=y
> +CONFIG_HAVE_BPF_JIT=y
> +CONFIG_UEVENT_HELPER_PATH=""
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_STANDALONE=y
> +CONFIG_PREVENT_FIRMWARE_BUILD=y
> +CONFIG_FW_LOADER=y
> +CONFIG_EXTRA_FIRMWARE=""
> +CONFIG_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=16
> +CONFIG_CMA_SIZE_SEL_MBYTES=y
> +CONFIG_CMA_ALIGNMENT=8
> +CONFIG_CMA_AREAS=7
> +CONFIG_DTC=y
> +CONFIG_OF=y
> +CONFIG_PROC_DEVICETREE=y
> +CONFIG_OF_FLATTREE=y
> +CONFIG_OF_EARLY_FLATTREE=y
> +CONFIG_OF_ADDRESS=y
> +CONFIG_OF_IRQ=y
> +CONFIG_OF_DEVICE=y
> +CONFIG_OF_I2C=y
> +CONFIG_BLK_DEV=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=16
> +CONFIG_BLK_DEV_RAM_SIZE=4096
> +CONFIG_SCSI_MOD=y
> +CONFIG_SCSI=y
> +CONFIG_SCSI_DMA=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_SCSI_MULTI_LUN=y
> +CONFIG_INPUT=y
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_SERIO=y
> +CONFIG_SERIO_SERPORT=y
> +CONFIG_VT=y
> +CONFIG_CONSOLE_TRANSLATIONS=y
> +CONFIG_VT_CONSOLE=y
> +CONFIG_HW_CONSOLE=y
> +CONFIG_UNIX98_PTYS=y
> +CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_CORE=y
> +CONFIG_SERIAL_CORE_CONSOLE=y
> +CONFIG_I2C=y
> +CONFIG_I2C_BOARDINFO=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_ALGOBIT=y
> +CONFIG_SPI=y
> +CONFIG_SPI_MASTER=y
> +CONFIG_SPI_PL022=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINMUX=y
> +CONFIG_PINCONF=y
> +CONFIG_DEBUG_PINCTRL=y
> +CONFIG_PINCTRL_BCM476X=y
> +CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
> +CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
> +CONFIG_SSB_POSSIBLE=y
> +CONFIG_SSB=y
> +CONFIG_SSB_SDIOHOST_POSSIBLE=y
> +CONFIG_BCMA_POSSIBLE=y
> +}
> +
> +static void __init bcm476x_timer_init(void)
> +{
> +}
> +
> +struct sys_timer bcm476x_timer = {
> +	.init = bcm476x_timer_init
> +};
> +
> +static const char * const bcm476x_compat[] = {
> +	"brcm,bcm476x",
> +	NULL
> +};
> +
> +DT_MACHINE_START(BCM476X, "Broadcom BCM476x")
> +	.map_io = bcm476x_map_io,
> +	.init_irq = bcm476x_init_irq,
> +	.handle_irq = vic_handle_irq,
> +	.init_machine = bcm476x_init,
> +	.timer = &bcm476x_timer,
> +	.dt_compat = bcm476x_compat
> +MACHINE_END
> Index: b/arch/arm/include/debug/bcm476x.S
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/include/debug/bcm476x.S
> @@ -0,0 +1,35 @@
> +/*
> + * Broadcom BCM476x SoCs DEBUG_LL support
> + *
> + * Copyright (C) 2012 Domenico Andreoli <domenico.andreoli@linux.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#if defined(CONFIG_DEBUG_BCM476X_UART0)
> +# define BCM476X_DEBUG_PHYS	0x000c0000
> +# define BCM476X_DEBUG_VIRT	0xd00c0000
> +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
> +# define BCM476X_DEBUG_PHYS	0x000c1000
> +# define BCM476X_DEBUG_VIRT	0xd00c1000
> +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
> +# define BCM476X_DEBUG_PHYS	0x000b2000
> +# define BCM476X_DEBUG_VIRT	0xd00b2000
> +#else
> +# error Unknown BCM476x debug port
> +#endif

can't you detect it?
> +
> +	.macro	addruart, rp, rv, tmp
> +	ldr	\rp, =BCM476X_DEBUG_PHYS
> +	ldr	\rv, =BCM476X_DEBUG_VIRT
> +	.endm
> +
> +#include <asm/hardware/debug-pl01x.S>
> Index: b/arch/arm/include/debug/bcm476x-uncompress.h
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/include/debug/bcm476x-uncompress.h
> @@ -0,0 +1,53 @@
> +/*
> + * Broadcom BCM476x SoCs decompressor output
> + *
> + * Copyright (C) 2012 Domenico Andreoli <domenico.andreoli@linux.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/amba/serial.h>
> +
> +#if defined(CONFIG_DEBUG_BCM476X_UART0)
> +# define BCM476X_DEBUG_PHYS	0x000c0000
> +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
> +# define BCM476X_DEBUG_PHYS	0x000c1000
> +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
> +# define BCM476X_DEBUG_PHYS	0x000b2000
> +#else
> +# error Unknown BCM476x debug port
ditto here by using the first one enable by the bootloader
> +#endif
> +
> +#define BCM476X_UART_DR IOMEM(BCM476X_DEBUG_PHYS + UART01x_DR)
> +#define BCM476X_UART_FR IOMEM(BCM476X_DEBUG_PHYS + UART01x_FR)
> +#define BCM476X_UART_CR IOMEM(BCM476X_DEBUG_PHYS + UART011_CR)
> +
> +static inline void putc(int c)
> +{
> +	while (__raw_readl(BCM476X_UART_FR) & UART01x_FR_TXFF)
> +		barrier();
> +
> +	__raw_writel(c, BCM476X_UART_DR);
> +	barrier();
> +}
> +
> +static inline void flush(void)
> +{
> +	int fr;
> +
> +	do {
> +		fr = __raw_readl(BCM476X_UART_FR);
> +		barrier();
> +	} while ((fr & (UART011_FR_TXFE | UART01x_FR_BUSY)) != UART011_FR_TXFE);
> +}
> +
> +#define arch_decomp_setup()
> Index: b/arch/arm/mach-bcm476x/Kconfig
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/mach-bcm476x/Kconfig
> @@ -0,0 +1,17 @@
> +config ARCH_BCM476X
> +	bool "Broadcom BCM476X family" if ARCH_MULTI_V6
> +	select CPU_V6
> +	select ARM_VIC
> +	select ARM_AMBA
> +	select NO_IOPORT
> +	select GENERIC_IRQ_CHIP
> +	select SPARSE_IRQ
> +	select MULTI_IRQ_HANDLER
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select GENERIC_CLOCKEVENTS
> +	select CLKSRC_MMIO
> +	select COMMON_CLK
> +	select CLKDEV_LOOKUP
> +	select PINCTRL
> +	select PINMUX
> +	select USE_OF
> Index: b/MAINTAINERS
> ===================================================================
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1618,6 +1618,15 @@ F:	arch/arm/boot/dts/bcm2835*
>  F:	arch/arm/configs/bcm2835_defconfig
>  F:	drivers/*/*bcm2835*
>  
> +ARM/BCM476x ARM ARCHITECTURE
> +M:	Domenico Andreoli <domenico.andreoli@linux.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/mach-bcm476x
> +F:	arch/arm/boot/dts/bcm476x*
> +F:	arch/arm/configs/bcm476x_defconfig
> +F:	drivers/*/*bcm476x*
> +
>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>  M:	Matt Carlson <mcarlson@broadcom.com>
>  M:	Michael Chan <mchan@broadcom.com>
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
