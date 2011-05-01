From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  1 May 2011 18:28:42 +0200
Subject: [PATCH] shmobile: fix map_io init usage
Message-ID: <1304267322-19022-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

switch early init to init_early and introduce soc map_io

with this Patch we will not do any more early device setup during the map io

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c        |   20 ++----------
 arch/arm/mach-shmobile/board-ap4evb.c        |   20 ++----------
 arch/arm/mach-shmobile/board-g3evm.c         |   20 ++----------
 arch/arm/mach-shmobile/board-g4evm.c         |   20 ++----------
 arch/arm/mach-shmobile/board-mackerel.c      |   20 ++----------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/map_io.c              |   44 ++++++++++++++++++++++++++
 8 files changed, 61 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/map_io.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e2507f6..260e09d 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o pm_runtime.o
+obj-y				:= map_io.o timer.o console.o clock.o pm_runtime.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 3e6f0aa..b30b11d 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -43,7 +43,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -335,22 +334,8 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 	&mipidsi0_device,
 };
 
-static struct map_desc ag5evm_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init ag5evm_map_io(void)
+static void __init ag5evm_init_early(void)
 {
-	iotable_init(ag5evm_io_desc, ARRAY_SIZE(ag5evm_io_desc));
-
 	/* setup early devices and console here as well */
 	sh73a0_add_early_devices();
 	shmobile_setup_console();
@@ -474,9 +459,10 @@ struct sys_timer ag5evm_timer = {
 };
 
 MACHINE_START(AG5EVM, "ag5evm")
-	.map_io		= ag5evm_map_io,
+	.map_io		= shmobile_map_io,
 	.init_irq	= ag5evm_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
+	.init_early	= ag5evm_init_early,
 	.init_machine	= ag5evm_init,
 	.timer		= &ag5evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1e35fa9..ed55c01 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -59,7 +59,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
 
@@ -1092,22 +1091,8 @@ static struct i2c_board_info i2c1_devices[] = {
 	},
 };
 
-static struct map_desc ap4evb_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init ap4evb_map_io(void)
+static void __init ap4evb_init_early(void)
 {
-	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
-
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
 	shmobile_setup_console();
@@ -1359,9 +1344,10 @@ static struct sys_timer ap4evb_timer = {
 };
 
 MACHINE_START(AP4EVB, "ap4evb")
-	.map_io		= ap4evb_map_io,
+	.map_io		= shmobile_map_io,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
+	.init_early	= ap4evb_init_early,
 	.init_machine	= ap4evb_init,
 	.timer		= &ap4evb_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index ef4613b..20eeacf 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -36,7 +36,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
 /*
@@ -245,22 +244,8 @@ static struct platform_device *g3evm_devices[] __initdata = {
 	&irda_device,
 };
 
-static struct map_desc g3evm_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init g3evm_map_io(void)
+static void __init g3evm_init_early(void)
 {
-	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
-
 	/* setup early devices and console here as well */
 	sh7367_add_early_devices();
 	shmobile_setup_console();
@@ -364,9 +349,10 @@ static struct sys_timer g3evm_timer = {
 };
 
 MACHINE_START(G3EVM, "g3evm")
-	.map_io		= g3evm_map_io,
+	.map_io		= shmobile_map_io,
 	.init_irq	= sh7367_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
+	.init_early	= g3evm_init_early,
 	.init_machine	= g3evm_init,
 	.timer		= &g3evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index c87a7b7..079dd35 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -37,7 +37,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
 /*
@@ -259,22 +258,8 @@ static struct platform_device *g4evm_devices[] __initdata = {
 	&sdhi1_device,
 };
 
-static struct map_desc g4evm_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init g4evm_map_io(void)
+static void __init g4evm_init_early(void)
 {
-	iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
-
 	/* setup early devices and console here as well */
 	sh7377_add_early_devices();
 	shmobile_setup_console();
@@ -407,9 +392,10 @@ static struct sys_timer g4evm_timer = {
 };
 
 MACHINE_START(G4EVM, "g4evm")
-	.map_io		= g4evm_map_io,
+	.map_io		= shmobile_map_io,
 	.init_irq	= sh7377_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
+	.init_early	= g4evm_init_early,
 	.init_machine	= g4evm_init,
 	.timer		= &g4evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7da2ca2..f05a673 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -56,7 +56,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/mach/map.h>
 #include <asm/mach-types.h>
 
 /*
@@ -1007,22 +1006,8 @@ static struct i2c_board_info i2c1_devices[] = {
 	},
 };
 
-static struct map_desc mackerel_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init mackerel_map_io(void)
+static void __init mackerel_init_early(void)
 {
-	iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
-
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
 	shmobile_setup_console();
@@ -1232,9 +1217,10 @@ static struct sys_timer mackerel_timer = {
 };
 
 MACHINE_START(MACKEREL, "mackerel")
-	.map_io		= mackerel_map_io,
+	.map_io		= shmobile_map_io,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
+	.init_early	= mackerel_init_early,
 	.init_machine	= mackerel_init,
 	.timer		= &mackerel_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 013ac0e..cc7fdbc 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -1,6 +1,7 @@
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
+extern void shmobile_map_io(void);
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
diff --git a/arch/arm/mach-shmobile/map_io.c b/arch/arm/mach-shmobile/map_io.c
new file mode 100644
index 0000000..1a62855
--- /dev/null
+++ b/arch/arm/mach-shmobile/map_io.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2008  Yoshihiro Shimoda
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <mach/common.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/setup.h>
+
+static struct map_desc shmobile_io_desc[] __initdata = {
+	/* create a 1:1 entity map for 0xe6xxxxxx
+	 * used by CPGA, INTC and PFC.
+	 */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 256 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+void __init shmobile_map_io(void)
+{
+	iotable_init(shmobile_io_desc, ARRAY_SIZE(shmobile_io_desc));
+}
-- 
1.7.4.1
