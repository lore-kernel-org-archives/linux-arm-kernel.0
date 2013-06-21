From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:22:47 +0200
Subject: [PATCH] ARM: omap: make am43xx build with SMP enabled
Message-ID: <201306220122.47786.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With am43xx enabled, omap4 and omap5 disabled and SMP on, I get these
build errors:

arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
:(.text+0x7858): undefined reference to `omap4_get_scu_base'
arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
:(.text+0x793c): undefined reference to `omap4_get_scu_base'
arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
:(.ref.text+0x44): undefined reference to `omap4_hotplug_cpu'

The easiest way to work around that is to turn on the missing
functions, even though we know they won't be used on am43xx,
which is single-CPU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Kishore <a-kishore@ti.com>
Cc: Afzal Mohammed <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f5038f5..46d7c5f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,7 +39,7 @@ omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
 					   sleep44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common) $(smp-y)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y)
-obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
+obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common) $(smp-y)
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -89,6 +89,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
+obj-$(CONFIG_SOC_AM43XX)		+= omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
