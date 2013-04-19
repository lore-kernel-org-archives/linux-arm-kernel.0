From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Apr 2013 00:08:28 +0200
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419215134.GY10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <201304192258.36276.arnd@arndb.de>
 <20130419215134.GY10155@atomide.com>
Message-ID: <201304200008.28716.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Tony Lindgren wrote:
> In this case the options within the ifeq have already been tested
> with randconfigs. The reason for these build errors is that no SoC
> has been selected, and there's nothing implementing the the missing
> functions. The other option for fixing the issue would be to add a
> null SoC, which probably does not make sense in this case.
> 
> I've been building various omap2+ randconfigs for quite a while,
> and in general they work with a few warnings left. But I've
> been doing that with at least one SoC selected earlier because
> of the historic "must select a target board" that no longer is
> the case with your patch.

I think part of the problem is the way the Makefile is laid
out, e.g.

clockdomain-common                      += clockdomain.o
obj-$(CONFIG_ARCH_OMAP2)                += $(clockdomain-common)
obj-$(CONFIG_ARCH_OMAP3)                += $(clockdomain-common)
obj-$(CONFIG_ARCH_OMAP4)                += $(clockdomain-common)
obj-$(CONFIG_SOC_AM33XX)                += $(clockdomain-common)
obj-$(CONFIG_SOC_OMAP5)                 += $(clockdomain-common)

This results in building clockdomain.o whenever any of the various
SoCs are enabled, but not when none of them are enabled.

However, according to the error messages, this driver is actually
referenced by code that is enabled unconditionally.

You are right that your patch would fix this scenario, but it does
so by adding extra logic, not by simplifying it. I can see two ways
to make that more logical:

a) use the new Kconfig symbol consistently:
obj-$(CONFIG_SOC_OMAP)			+= clockdomain.o

b) don't introduce a new symbol but use the Makefile consistently
omap-common += io.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
         common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
         omap_device.o sram.o
obj-$(CONFIG_ARCH_OMAP2)                += $(omap-common)
obj-$(CONFIG_ARCH_OMAP3)                += $(omap-common)
obj-$(CONFIG_ARCH_OMAP4)                += $(omap-common)
obj-$(CONFIG_SOC_AM33XX)                += $(omap-common)
obj-$(CONFIG_SOC_OMAP5)                 += $(omap-common)

	Arnd
