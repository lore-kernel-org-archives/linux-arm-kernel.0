From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Apr 2014 20:20:39 +0200
Subject: [PATCH] ARM: mvebu: refine which files are build in mach-mvebu
In-Reply-To: <20140427231044.GX28159@titan.lakedaemon.net>
References: <20140427231044.GX28159@titan.lakedaemon.net>
Message-ID: <1398709239-6126-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the integration into mach-mvebu of the Kirkwood ARMv5
support, we need to be more careful about which files get built. For
example, the pmsu.c file now calls wfi(), which only exists on ARMv7
platforms.

Therefore, this commit changes mach-mvebu/Makefile to build the Armada
370/XP/375/38x specific files only when CONFIG_MACH_MVEBU_V7 is
enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
This commit applies on top of mvebu/soc, and has been built tested
with mvebu_v7_defconfig, mvebu_v5_defconfig, multi_v7_defconfig and
multi_v5_defconfig (on top of mvebu/for-next).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 02b5389..ec0b217 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,11 +3,14 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
-obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
+obj-y				 += system-controller.o mvebu-soc-id.o
+
+ifeq ($(CONFIG_MACH_MVEBU_V7),y)
+obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o
+obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
+obj-$(CONFIG_HOTPLUG_CPU)	 += hotplug.o
+endif
+
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
-obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
-obj-$(CONFIG_SMP)                += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
-obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
 obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
-- 
1.9.2
