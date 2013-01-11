From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Jan 2013 12:05:31 -0800
Subject: arm: mvebu: Fix compile for multiplatform when ARMv6 is selected
Message-ID: <20130111200531.GO14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems compile in both ARMv6 and ARMv7 into multiplatform
configurations. This means the default compiler flags are for ARMv6,
and we will get:

arch/arm/mach-mvebu/coherency_ll.S: Assembler messages:
arch/arm/mach-mvebu/coherency_ll.S:45: Error: selected processor does not support `dsb'

Fix this by specifying ARMv7 flags for coherency_ll.o.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,6 +1,8 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
+AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
+
 obj-y += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
