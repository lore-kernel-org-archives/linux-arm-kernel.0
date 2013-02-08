From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Feb 2013 14:33:29 +0100
Subject: Build error: OMAP randconfig / mvebu
In-Reply-To: <5114DC44.7000107@free-electrons.com>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <2213733.Wbjy3dFgom@wuerfel> <5114DC44.7000107@free-electrons.com>
Message-ID: <4351524.MQWtq16mqg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 12:06:44 Gregory CLEMENT wrote:
> 
> I don't know what to do here, there is no point to build any of the files
> in mach-mvebu if no SoCs are selected. So either we force to have at least
> one SoCS selected if ARCH_MVEBU is selected, or we unselect  ARCH_MVEB if
> no SoCs are selected.

The latter does not work, because that would introduce a circular
dependency in Kconfig.

I suppose rearranging the mvebu Makefile like this would do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 99df4df..c0434dc 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,9 +1,15 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
-AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
+AFLAGS_coherency_ll.o		 := -Wa,-march=armv7-a
 
-obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
-obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += $(armada-y)
+armada-y			 += system-controller.o
+armada-y			 += armada-370-xp.o
+armada-y			 += irq-armada-370-xp.o
+armada-y			 += addr-map.o
+armada-y			 += coherency.o
+armada-y			 += coherency_ll.o
+armada-y			 += pmsu.o
+armada-$(CONFIG_SMP)		 += platsmp.o headsmp.o
+armada-$(CONFIG_HOTPLUG_CPU)	 += hotplug.o
