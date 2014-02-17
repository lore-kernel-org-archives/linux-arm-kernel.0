From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 15:23:19 +0100
Subject: [PATCH v4 01/13] ARM: mvebu: rename armada-370-xp.c to board-v7.c
In-Reply-To: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392647011-30117-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the introduction of the support of Armada 375 and
Armada 38x, this commit renames arch/arm/mach-mvebu/armada-370-xp.c to
arch/arm/mach-mvebu/board-v7.c. The board-v7.c name as we expect this
file to ultimately contain the DT_MACHINE_START definitions for all
ARMv7 Marvell EBU platforms (370, 375, 38x, XP and Dove as of today).

In relation to this file rename, this commit also:

 * Renames the hidden Kconfig symbol MACH_ARMADA_370_XP to
   MACH_MVEBU_V7. This hidden symbol is selected by the various
   per-SoC visible Kconfig options to trigger the build of board-v7.c.

 * Renames a certain number of functions in board-v7.c so that their
   armada_370_xp prefix is replaced by a mvebu prefix. The .dt_compat
   array keeps its armada_370_xp prefix because the new SOCs will be
   introduced with separate .dt_compat arrays, due to the need for
   different SMP operations.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, this commit will create a trivial conflict with the patch that
removed armada_370_xp_map_io(), which I submitted a few days. The
conflict should be easy to resolve (simply remove the ->map_io
function).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig                         |  6 +++---
 arch/arm/mach-mvebu/Makefile                        |  2 +-
 arch/arm/mach-mvebu/{armada-370-xp.c => board-v7.c} | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)
 rename arch/arm/mach-mvebu/{armada-370-xp.c => board-v7.c} (89%)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7..eac4605 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -21,7 +21,7 @@ if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
 
-config MACH_ARMADA_370_XP
+config MACH_MVEBU_V7
 	bool
 	select ARMADA_370_XP_TIMER
 	select HAVE_SMP
@@ -31,7 +31,7 @@ config MACH_ARMADA_370_XP
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards"
 	select ARMADA_370_CLK
-	select MACH_ARMADA_370_XP
+	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_370
 	help
 	  Say 'Y' here if you want your kernel to support boards based
@@ -40,7 +40,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
-	select MACH_ARMADA_370_XP
+	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_XP
 	help
 	  Say 'Y' here if you want your kernel to support boards based
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 878aebe..2c1db29 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -4,7 +4,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
 obj-y				 += system-controller.o mvebu-soc-id.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
+obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/board-v7.c
similarity index 89%
rename from arch/arm/mach-mvebu/armada-370-xp.c
rename to arch/arm/mach-mvebu/board-v7.c
index f6c9d1d..fc2fb6e 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -31,12 +31,12 @@
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
-static void __init armada_370_xp_map_io(void)
+static void __init mvebu_map_io(void)
 {
 	debug_ll_io_init();
 }
 
-static void __init armada_370_xp_timer_and_clk_init(void)
+static void __init mvebu_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
 	clocksource_of_init();
@@ -75,7 +75,7 @@ static void __init i2c_quirk(void)
 	return;
 }
 
-static void __init armada_370_xp_dt_init(void)
+static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
 		i2c_quirk();
@@ -89,9 +89,9 @@ static const char * const armada_370_xp_dt_compat[] = {
 
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.smp		= smp_ops(armada_xp_smp_ops),
-	.init_machine	= armada_370_xp_dt_init,
-	.map_io		= armada_370_xp_map_io,
-	.init_time	= armada_370_xp_timer_and_clk_init,
+	.init_machine	= mvebu_dt_init,
+	.map_io		= mvebu_map_io,
+	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
-- 
1.8.3.2
