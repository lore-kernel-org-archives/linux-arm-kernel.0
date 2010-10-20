From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Oct 2010 23:32:27 +0200
Subject: [PATCH 6/6] ARM Realview PCIX build file changes
In-Reply-To: <20101020130322.22199.55098.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<20101020130322.22199.55098.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <201010202332.27489.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 October 2010 15:03:22 Colin Tuckley wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9c26ba7..05c7aa2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1143,7 +1143,9 @@ config ISA_DMA_API
>         bool
>  
>  config PCI
> -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> +       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || \
> +       ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX || \
> +       MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBA8 || MACH_REALVIEW_PBX
>         help
>           Find out whether you have a PCI motherboard. PCI is the name of a
>           bus system, i.e. the way the CPU talks to the other stuff inside
> @@ -1171,6 +1173,8 @@ config PCI_HOST_ITE8152
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/pci/pcie/Kconfig"
> +
>  source "drivers/pcmcia/Kconfig"
>  
>  endmenu

Why not have a new Kconfig symbol here:

config REALVIEW_PCIX
	bool "PCI-X support for Realview-PB11MP/PB-A8/PBX"
	depends on MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBA8 || MACH_REALVIEW_PBX
	select PCI
	
and

> @@ -10,4 +10,10 @@ obj-$(CONFIG_MACH_REALVIEW_PBA8)     += realview_pba8.o
>  obj-$(CONFIG_MACH_REALVIEW_PBX)                += realview_pbx.o
>  obj-$(CONFIG_SMP)                      += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)              += hotplug.o
> +ifeq ($(CONFIG_PCI),y)
> +obj-$(CONFIG_MACH_REALVIEW_PB11MP)     += pcix.o
> +obj-$(CONFIG_MACH_REALVIEW_PBA8)       += pcix.o
> +obj-$(CONFIG_MACH_REALVIEW_PBX)                += pcix.o
> +endif
> +
>  obj-$(CONFIG_LOCAL_TIMERS)             += localtimer.o

obj-$(CONFIG_REALVIEW_PCIX)		+= pcix.o

	Arnd
