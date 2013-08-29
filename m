From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 16:17:29 -0700
Subject: [PATCH v3 2/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130814221237.350904818@gmail.com>
References: <20130814221043.528864175@gmail.com>
 <20130814221237.350904818@gmail.com>
Message-ID: <20130829231729.GA29606@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 15, 2013 at 12:10:45AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Platform infrastructure for the Broadcom BCM4760 based ARM11 SoCs.
> 
> v3:
> * dropped the idea of unconditionally build mach-bcm
> 
> v2:
> * clocks are now configured via DT
> * uart DT nodes have been renamed and hooked to the proper clock nodes
> * dropped unneeded config options
> * dropped misused initialization of system_rev
> * dropped unneeded early io mapping 
> * build rule of mach-bcm is moved to separated patch
> 
> v1:
> * initial release
> 
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm4760.txt |    8 ++
>  MAINTAINERS                                       |    7 ++
>  arch/arm/Makefile                                 |    1 +
>  arch/arm/boot/dts/Makefile                        |    1 +
>  arch/arm/boot/dts/bcm4760-catalina.dts            |   11 +++
>  arch/arm/boot/dts/bcm4760.dtsi                    |   71 +++++++++++++++++++++
>  arch/arm/configs/bcm4760_defconfig                |   76 ++++++++++++++++++++++
>  arch/arm/mach-bcm/Kconfig                         |    7 ++
>  arch/arm/mach-bcm/Makefile                        |    2 +
>  arch/arm/mach-bcm/bcm4760.c                       |   37 +++++++++++
>  10 files changed, 221 insertions(+)
> 
> Index: b/Documentation/devicetree/bindings/arm/bcm4760.txt
> ===================================================================
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm4760.txt
> @@ -0,0 +1,8 @@
> +Broadcom BCM4760 ARM11 SoC device tree bindings
> +-----------------------------------------------
> +
> +Boards with the BCM4760 SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible = "brcm,bcm4760";
> Index: b/arch/arm/configs/bcm4760_defconfig
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/configs/bcm4760_defconfig
> @@ -0,0 +1,76 @@
> +CONFIG_IRQ_DOMAIN_DEBUG=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_EMBEDDED=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_IOSCHED_DEADLINE is not set
> +# CONFIG_IOSCHED_CFQ is not set
> +CONFIG_ARCH_MULTI_V6=y
> +# CONFIG_ARCH_MULTI_V7 is not set
> +CONFIG_ARCH_BCM4760=y
> +CONFIG_ARM_ERRATA_411920=y
> +CONFIG_ARM_ERRATA_364296=y
> +CONFIG_AEABI=y
> +CONFIG_DEPRECATED_PARAM_STRUCT=y
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_VFP=y
> +# CONFIG_SUSPEND is not set
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_CMA=y
> +CONFIG_PROC_DEVICETREE=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_SCSI=y
> +# CONFIG_SCSI_PROC_FS is not set
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_SCSI_MULTI_LUN=y
> +# CONFIG_SCSI_LOWLEVEL is not set
> +# CONFIG_INPUT_MOUSEDEV is not set
> +CONFIG_INPUT_EVDEV=y
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_SERIO is not set
> +# CONFIG_VT is not set
> +# CONFIG_DEVKMEM is not set
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +# CONFIG_HW_RANDOM is not set
> +# CONFIG_HWMON is not set
> +# CONFIG_HID is not set
> +# CONFIG_USB_SUPPORT is not set
> +CONFIG_COMMON_CLK_DEBUG=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_EXT2_FS=y
> +CONFIG_EXT3_FS=y
> +# CONFIG_EXT3_FS_XATTR is not set
> +CONFIG_EXT4_FS=y
> +CONFIG_FANOTIFY=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +# CONFIG_PROC_PAGE_MONITOR is not set
> +CONFIG_TMPFS=y
> +CONFIG_CRAMFS=y
> +CONFIG_ROMFS_FS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_CODEPAGE_850=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_ISO8859_15=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_REDUCED=y
> +CONFIG_STRIP_ASM_SYMS=y
> +CONFIG_DEBUG_SECTION_MISMATCH=y
> +CONFIG_MAGIC_SYSRQ=y
> +# CONFIG_SCHED_DEBUG is not set
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +# CONFIG_FTRACE is not set
> +# CONFIG_CRYPTO_ANSI_CPRNG is not set
> +# CONFIG_CRYPTO_HW is not set
> Index: b/arch/arm/mach-bcm/bcm4760.c
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm4760.c
> @@ -0,0 +1,37 @@
> +/*
> + * Broadcom BCM4760 based ARM11 SoCs platform support
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
> +#include <linux/init.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +
> +static void __init bcm4760_init(void)
> +{
> +	of_clk_init(NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const bcm4760_compat[] __initconst = {
> +	"brcm,bcm4760",
> +	NULL
> +};
> +
> +DT_MACHINE_START(BCM4760, "Broadcom BCM4760")
> +	.init_machine = bcm4760_init,
> +	.dt_compat = bcm4760_compat

Please add a , after the last member too, it makes life much easier if someone
is scripting a change across all these in the future (such as sorting them).

> Index: b/arch/arm/mach-bcm/Kconfig
> ===================================================================
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -17,3 +17,10 @@ config ARCH_BCM
>  	  It currently supports the 'BCM281XX' family, which includes
>  	  BCM11130, BCM11140, BCM11351, BCM28145 and
>  	  BCM28155 variants.
> +
> +config ARCH_BCM4760
> +	bool "Broadcom BCM4760 based SoCs (ARM11)" if ARCH_MULTI_V6
> +	select ARM_AMBA
> +	select ARM_VIC
> +	select CLKSRC_OF
> +	select SOC_BUS

So I think I mentioned this during previous discussions, but I think this
should be solved by having:

config ARCH_BCM
	bool "Broadcom platforms"
	help
	  This enables support for Broadcom based systems

menu "Broadcom platform selection"
	depends on ARCH_BCM

config ARCH_BCM281XX
	... current ARCH_BCM contents

config ARCH_BCM4760
	... above conents
endmenu


> Index: b/arch/arm/mach-bcm/Makefile
> ===================================================================
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -13,3 +13,5 @@
>  obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
> +
> +obj-$(CONFIG_ARCH_BCM4760)	+= bcm4760.o
> Index: b/arch/arm/Makefile
> ===================================================================
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -147,6 +147,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
>  machine-$(CONFIG_ARCH_AT91)		+= at91
>  machine-$(CONFIG_ARCH_BCM)		+= bcm
>  machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
> +machine-$(CONFIG_ARCH_BCM4760)		+= bcm

With the above change, this isn't needed.


-Olof
