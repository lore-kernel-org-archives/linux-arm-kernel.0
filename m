From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 13:40:29 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <201304192211.13356.arnd@arndb.de>
References: <5170B4C6.1030300@gmail.com> <517173C0.6010902@ti.com>
 <20130419194323.GP10155@atomide.com>
 <201304192211.13356.arnd@arndb.de>
Message-ID: <20130419204028.GU10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130419 13:18]:
> On Friday 19 April 2013, Tony Lindgren wrote:
> > This might happen when no SoC selected. There was a patch posted
> > by Arnd to always select 2420 if nothing else is selected as it's the
> > most minimal one. But Russell did not like that, so probably the way
> > to fix that would be to have bool OMAP_SOC and if not selected, don't
> > even try to build anything. I'll take a look at that.
> 
> My patch was actually just necessary to avoid building a kernel with
> no platforms selected at all, but we now have a patch that makes that
> a working option.

Yes that's cool.
 
> I think all the bugs that Rob reported can be fixed individually.
> 
> Note that the "dss-common.c" part there might be a Red Herring, the symbols
> are likely to be used from somewhere else than that file.

Yeah. Here's an initial patch of what I had in mind, seems to
do the trick. Will spend a little more time looking at it.

Regards,

Tony


--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,6 +1,9 @@
 config ARCH_OMAP
 	bool
 
+config SOC_OMAP
+	bool
+
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
 	select ARCH_HAS_CPUFREQ
@@ -97,6 +100,7 @@ config ARCH_OMAP4
 	select PL310_ERRATA_727915
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
+	select SOC_OMAP
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select COMMON_CLK
 	select ARM_ERRATA_754322
@@ -110,6 +114,7 @@ config SOC_OMAP5
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
+	select SOC_OMAP
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
@@ -120,22 +125,26 @@ config SOC_OMAP2420
 	default y
 	select OMAP_DM_TIMER
 	select SOC_HAS_OMAP2_SDRC
+	select SOC_OMAP
 
 config SOC_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 	default y
 	select SOC_HAS_OMAP2_SDRC
+	select SOC_OMAP
 
 config SOC_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
 	default y
 	select SOC_HAS_OMAP2_SDRC
+	select SOC_OMAP
 
 config SOC_TI81XX
 	bool "TI81XX support"
 	depends on ARCH_OMAP3
+	select SOC_OMAP
 	default y
 
 config SOC_AM33XX
@@ -145,6 +154,7 @@ config SOC_AM33XX
 	select CPU_V7
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
+	select SOC_OMAP
 
 config OMAP_PACKAGE_ZAF
        bool
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,8 +5,12 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
+obj-y := id.o control.o
+
+ifeq ($(CONFIG_SOC_OMAP),y)
+
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
+obj-y := io.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o
 
@@ -293,3 +297,5 @@ emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
 obj-y					+= $(emac-m) $(emac-y)
 
 obj-y					+= common-board-devices.o twl-common.o dss-common.o
+
+endif
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -25,8 +25,17 @@
 struct i2c_board_info;
 struct omap_i2c_bus_platform_data;
 
+#if defined(CONFIG_ARCH_OMAP1) || defined(SOC_OMAP)
 int omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
 			int bus_id);
+#else
+static inline int
+omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
+			int bus_id)
+{
+	return -ENODEV;
+}
+#endif
 
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
