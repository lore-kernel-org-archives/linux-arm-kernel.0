From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 07 Sep 2012 18:39:54 -0600
Subject: [PATCH 4/6] ARM: OMAP2+: clean up OMAP4 PRM & sleep build
 directives in Makefile
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Message-ID: <20120908003952.4648.74268.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prm44xx.o and sleep44xx.o build directives belong with the other
PRCM- and PM-related build sections in the Makefile; move them there.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 437ca322..e9de8d2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -19,9 +19,6 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap-smc.o omap-secure.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o
-obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o
-
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
 endif
@@ -32,10 +29,8 @@ obj-$(CONFIG_TWL4030_CORE)		+= omap_twl.o
 
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
-					   sleep44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
-obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common)
+obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap4-common.o omap-wakeupgen.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -71,11 +66,11 @@ endif
 
 # Power Management
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
-obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o sleep44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -98,7 +93,8 @@ endif
 # PRCM
 omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
-					   vc44xx_data.o vp44xx_data.o
+					   vc44xx_data.o vp44xx_data.o \
+					   prm44xx.o
 obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
