From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:38 +0800
Subject: [PATCH 13/15] ARM: shmobile: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-14-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c        |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c        |    1 +
 arch/arm/mach-shmobile/board-bonito.c        |    1 +
 arch/arm/mach-shmobile/board-g3evm.c         |    1 +
 arch/arm/mach-shmobile/board-g4evm.c         |    1 +
 arch/arm/mach-shmobile/board-kota2.c         |    1 +
 arch/arm/mach-shmobile/board-mackerel.c      |    1 +
 arch/arm/mach-shmobile/board-marzen.c        |    1 +
 arch/arm/mach-shmobile/common.c              |   24 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/cpuidle.c             |    3 +--
 arch/arm/mach-shmobile/include/mach/common.h |   14 ++++++++++++++
 arch/arm/mach-shmobile/suspend.c             |    3 +--
 13 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/common.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e7c2590..93d62fb 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o
+obj-y				:= timer.o console.o clock.o common.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index cb224a3..a99e7e6 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -598,5 +598,6 @@ MACHINE_START(AG5EVM, "ag5evm")
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= ag5evm_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b56dde2..522866d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1440,5 +1440,6 @@ MACHINE_START(AP4EVB, "ap4evb")
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= ap4evb_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 81fd95f..e6b1fd3 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -500,5 +500,6 @@ MACHINE_START(BONITO, "bonito")
 	.init_irq	= r8a7740_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= bonito_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 39b6cf8..796fa00 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -338,5 +338,6 @@ MACHINE_START(G3EVM, "g3evm")
 	.init_irq	= sh7367_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g3evm_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 0e5a39c..f125732 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -381,5 +381,6 @@ MACHINE_START(G4EVM, "g4evm")
 	.init_irq	= sh7377_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g4evm_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 200dcd4..f60f1b2 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -521,5 +521,6 @@ MACHINE_START(KOTA2, "kota2")
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= kota2_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f49e28a..4cd438f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1623,5 +1623,6 @@ MACHINE_START(MACKEREL, "mackerel")
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index ef0e13b..14de378 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -98,5 +98,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_irq	= r8a7779_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= marzen_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/common.c b/arch/arm/mach-shmobile/common.c
new file mode 100644
index 0000000..608aba9
--- /dev/null
+++ b/arch/arm/mach-shmobile/common.c
@@ -0,0 +1,24 @@
+/*
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
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <mach/common.h>
+
+void __init shmobile_init_late(void)
+{
+	shmobile_suspend_init();
+	shmobile_cpuidle_init();
+}
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 7e65591..7b541e9 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -46,7 +46,7 @@ static struct cpuidle_driver shmobile_cpuidle_driver = {
 
 void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
-static int shmobile_cpuidle_init(void)
+int shmobile_cpuidle_init(void)
 {
 	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
 	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
@@ -65,4 +65,3 @@ static int shmobile_cpuidle_init(void)
 
 	return 0;
 }
-late_initcall(shmobile_cpuidle_init);
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 83ad3fe..2a527c4 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -83,4 +83,18 @@ extern void r8a7779_secondary_init(unsigned int cpu);
 extern int r8a7779_boot_secondary(unsigned int cpu);
 extern void r8a7779_smp_prepare_cpus(void);
 
+extern void shmobile_init_late(void);
+
+#ifdef CONFIG_SUSPEND
+int shmobile_suspend_init(void);
+#else
+static inline int shmobile_suspend_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_CPU_IDLE
+int shmobile_cpuidle_init(void);
+#else
+static inline int shmobile_cpuidle_init(void) { return 0; }
+#endif
+
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/suspend.c b/arch/arm/mach-shmobile/suspend.c
index 4d1b86a..47d83f7 100644
--- a/arch/arm/mach-shmobile/suspend.c
+++ b/arch/arm/mach-shmobile/suspend.c
@@ -39,9 +39,8 @@ struct platform_suspend_ops shmobile_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int __init shmobile_suspend_init(void)
+int __init shmobile_suspend_init(void)
 {
 	suspend_set_ops(&shmobile_suspend_ops);
 	return 0;
 }
-late_initcall(shmobile_suspend_init);
-- 
1.7.5.4
