From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 10:59:45 -0400
Subject: [PATCH] [ARM] mmp: enable L2 in mmp2
Message-ID: <mailman.325.1272457106.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tauros2 L2 in mmp2. Tauros2 L2 is shared in Marvell ARM cores.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/mmp2_defconfig |    2 ++
 arch/arm/mach-mmp/mmp2.c        |    5 +++++
 arch/arm/mm/Kconfig             |    4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 03f76cf..db89363 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -246,6 +246,8 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+CONFIG_OUTER_CACHE=y
+CONFIG_CACHE_TAUROS2=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_411920 is not set
 CONFIG_COMMON_CLKDEV=y
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index cca3992..e236ec0 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -15,6 +15,8 @@
 #include <linux/init.h>
 #include <linux/io.h>

+#include <asm/hardware/cache-tauros2.h>
+
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
@@ -99,6 +101,9 @@ static struct clk_lookup mmp2_clkregs[] = {
 static int __init mmp2_init(void)
 {
 	if (cpu_is_mmp2()) {
+#ifdef CONFIG_CACHE_TAUROS2
+		tauros2_init();
+#endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
 		clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bd7c89..39c4761 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -769,8 +769,8 @@ config CACHE_L2X0

 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
-	depends on ARCH_DOVE
-	default y
+	depends on (ARCH_DOVE || ARCH_MMP)
+	default n
 	select OUTER_CACHE
 	help
 	  This option enables the Tauros2 L2 cache controller (as
-- 
1.5.6.5
