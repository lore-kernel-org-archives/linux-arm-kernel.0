From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 06:42:36 -0700
Subject: [GIT PULL 5/5] minimal omap5 support for v3.6 merge window
In-Reply-To: <E1SoaE5-0001gM-89@merlin.infradead.org>
References: <pull-1341925556-888624> <E1SoaE5-0001gM-89@merlin.infradead.org>
Message-ID: <20120710134235.GY1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120710 06:21]:
> The following changes since commit fb584511c4664573097ece7df0de06ad00b713a2:
> 
>   ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds (2012-07-09 01:44:11 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap devel-omap5

FYI, I got some merge conflicts with the am33xx and PM/smartreflex
changes, here's how I resolved them.

Regards,

Tony

--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@@ -48,5 -48,5 +48,8 @@@ Boards
  - AM335X EVM : Software Developement Board for AM335x
    compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
  
 +- AM335X Bone : Low cost community board
 +  compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
++
+ - OMAP5 EVM : Evaluation Module
+   compatible = "ti,omap5-evm", "ti,omap5"
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@@ -68,11 -71,13 +71,12 @@@ ifeq ($(CONFIG_PM),y
  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 -obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
+ obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
 -obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 -obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 -obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 +
 +obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 +obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
  
  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
@@@ -83,12 -88,10 +87,15 @@@ endi
  
  endif
  
 +ifeq ($(CONFIG_CPU_IDLE),y)
 +obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
 +obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
 +endif
 +
  # PRCM
+ omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
+ 					   prcm_mpu44xx.o prminst44xx.o \
+ 					   vc44xx_data.o vp44xx_data.o
  obj-y					+= prm_common.o
  obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
  obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
@@@ -161,7 -168,8 +172,9 @@@ obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.
  obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
  obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
  obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 +obj-$(CONFIG_SOC_AM33XX)		+= clock33xx_data.o
+ obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
+ obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
  
  # OMAP2 clock rate set data (old "OPP" data)
  obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
