From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 May 2013 10:08:28 -0700
Subject: [PATCH] ARM: OMAP2+: Fix multiple randconfig errors if no SoC
 is selected, take3
In-Reply-To: <20130517210317.GB10378@atomide.com>
References: <20130517210317.GB10378@atomide.com>
Message-ID: <20130520170827.GF10378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130517 14:08]:
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
> +soc-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o
>  
> @@ -85,7 +85,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
> -obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> +pm-$(CONFIG_ARCH_OMAP)			+= pm-debug.o
> +obj-$(CONFIG_PM_DEBUG)			+= $(pm-y)
>  
>  obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>  obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
> @@ -201,7 +202,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
>  
>  # EMU peripherals
>  obj-$(CONFIG_OMAP3_EMU)			+= emu.o
> -obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
> +pmu-$(CONFIG_ARCH_OMAP)			+= pmu.o
> +obj-$(CONFIG_HW_PERF_EVENTS)		+= $(pmu-y)
>  
>  obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
>  mailbox_mach-objs			:= mailbox.o

Oops, both pm-debug.o and pmu.o should now be just:

soc-$(CONFIG_PM_DEBUG)			+= pm-debug.o
soc-$(CONFIG_ARCH_OMAP)			+= pmu.o

Will repost after running make randconfig for few hours today.

Regards,

Tony
