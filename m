From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 09:40:45 +0200
Subject: [PATCH 2/4] ARM: OMAP4+: Prevent CPU1 related hang with kexec
In-Reply-To: <1466495565-17480-3-git-send-email-tony@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
 <1466495565-17480-3-git-send-email-tony@atomide.com>
Message-ID: <4439074.kx9oBqeAS1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 12:52:43 AM CEST Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 04e276c..cd820f5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -8,7 +8,7 @@ ccflags-y := -I$(srctree)/$(src)/include \
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
>          common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
> -        omap_device.o sram.o drm.o
> +        omap_device.o omap-headsmp.o sram.o drm.o
>  
>  hwmod-common                           = omap_hwmod.o omap_hwmod_reset.o \
>                                           omap_hwmod_common_data.o
> @@ -32,7 +32,7 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)      += sdrc.o
>  
>  # SMP support ONLY available for OMAP4
>  
> -smp-$(CONFIG_SMP)                      += omap-smp.o omap-headsmp.o
> +smp-$(CONFIG_SMP)                      += omap-smp.o
>  smp-$(CONFIG_HOTPLUG_CPU)              += omap-hotplug.o
>  omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o
> 

This doesn't work:

arch/arm/mach-omap2/built-in.o: In function `omap5_secondary_startup':
dss-common.c:(.text+0x4cc4): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `hyp_boot':
dss-common.c:(.text+0x4cf0): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_startup':
dss-common.c:(.text+0x4d14): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `omap4460_secondary_startup':
dss-common.c:(.text+0x4d48): undefined reference to `secondary_startup'

secondary_startup() is not defined when CONFIG_SMP is disabled.

	Arnd
