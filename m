From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Tue,  3 Jul 2012 14:34:27 +0200
Subject: [PATCH 3/3] ARM: dts: dove: Integrate devicetree support
In-Reply-To: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <1341318868-24567-6-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This integrates devicetree support for Marvell Dove and currently
suppported boards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-dove/Kconfig       |   20 ++++++++++++++++++++
 arch/arm/mach-dove/Makefile      |    4 ++++
 arch/arm/mach-dove/Makefile.boot |    3 +++
 arch/arm/mach-dove/common.c      |   17 +++++++++--------
 arch/arm/mach-dove/common.h      |   25 +++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index dd937c5..8dff8fc 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -15,6 +15,26 @@ config MACH_CM_A510
 	  Say 'Y' here if you want your kernel to support the
 	  CompuLab CM-A510 Board.
 
+config ARCH_DOVE_DT
+	bool "Marvell Dove Flattened Device Tree"
+	select USE_OF
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell Dove using flattened device tree.
+
+config MACH_DOVE_DB_DT
+	bool "Marvell DB-MV88AP510 Development Board (Flattened Device Tree)"
+	select ARCH_DOVE_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell DB-MV88AP510 Development Board (Flattened Device Tree).
+
+config MACH_CM_A510_DT
+	bool "CompuLab CM-A510 Board (Flattened Device Tree)"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  CompuLab CM-A510 Board (Flattened Device Tree).
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index fa0f018..bdb39f5 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -2,3 +2,7 @@ obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
 
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
 obj-$(CONFIG_MACH_CM_A510)	+= cm-a510.o
+
+obj-$(CONFIG_ARCH_DOVE_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_DOVE_DB_DT)	+= board-dove-db.o
+obj-$(CONFIG_MACH_CM_A510_DT)	+= board-cm-a510.o
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
index 760a0ef..185e988 100644
--- a/arch/arm/mach-dove/Makefile.boot
+++ b/arch/arm/mach-dove/Makefile.boot
@@ -1,3 +1,6 @@
    zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_MACH_DOVE_DB_DT) += dove-dove-db.dtb
+dtb-$(CONFIG_MACH_CM_A510_DT) += dove-cm-a510.dtb
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 9493076..6236035 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -33,8 +33,6 @@
 #include <plat/addr-map.h>
 #include "common.h"
 
-static int get_tclk(void);
-
 /*****************************************************************************
  * I/O Address Mapping
  ****************************************************************************/
@@ -72,10 +70,10 @@ void __init dove_map_io(void)
  ****************************************************************************/
 static struct clk *tclk;
 
-static void __init clk_init(void)
+void __init dove_clk_init(void)
 {
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       get_tclk());
+				       dove_tclk);
 
 	orion_clkdev_init(tclk);
 }
@@ -187,7 +185,9 @@ void __init dove_init_early(void)
 	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
-static int get_tclk(void)
+int dove_tclk;
+
+static int __init dove_find_tclk(void)
 {
 	/* use DOVE_RESET_SAMPLE_HI/LO to detect tclk */
 	return 166666667;
@@ -195,8 +195,9 @@ static int get_tclk(void)
 
 static void __init dove_timer_init(void)
 {
+	dove_tclk = dove_find_tclk();
 	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_DOVE_BRIDGE, get_tclk());
+			IRQ_DOVE_BRIDGE, dove_tclk);
 }
 
 struct sys_timer dove_timer = {
@@ -285,7 +286,7 @@ void __init dove_sdio1_init(void)
 void __init dove_init(void)
 {
 	printk(KERN_INFO "Dove 88AP510 SoC, ");
-	printk(KERN_INFO "TCLK = %dMHz\n", (get_tclk() + 499999) / 1000000);
+	printk(KERN_INFO "TCLK = %dMHz\n", (dove_tclk + 499999) / 1000000);
 
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init();
@@ -293,7 +294,7 @@ void __init dove_init(void)
 	dove_setup_cpu_mbus();
 
 	/* Setup root of clk tree */
-	clk_init();
+	dove_clk_init();
 
 	/* internal devices that every board has */
 	dove_rtc_init();
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 6432a3b..a11f842 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -40,4 +40,29 @@ void dove_sdio0_init(void);
 void dove_sdio1_init(void);
 void dove_restart(char, const char *);
 
+/* board init functions for boards not fully converted to fdt */
+#ifdef CONFIG_MACH_DOVE_DB_DT
+void dove_db_init(void);
+#else
+static inline void dove_db_init(void) {};
+#endif
+
+#ifdef CONFIG_MACH_CM_A510_DT
+void cm_a510_init(void);
+#else
+static inline void cm_a510_init(void) {};
+#endif
+
+/* early init functions not converted to fdt yet */
+void dove_clk_init(void);
+void dove_rtc_init(void);
+void dove_xor0_init(void);
+void dove_xor1_init(void);
+
+extern int dove_tclk;
+
+#ifdef CONFIG_CACHE_TAUROS2
+#include <asm/hardware/cache-tauros2.h>
+#endif
+
 #endif
-- 
1.7.10
