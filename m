From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 14 Dec 2010 16:57:11 +0900
Subject: [PATCH 03/03] ARM: mach-shmobile: sh73a0 SMP support
In-Reply-To: <20101214075647.11275.25933.sendpatchset@t400s>
References: <20101214075647.11275.25933.sendpatchset@t400s>
Message-ID: <20101214075711.11275.31475.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SMP support for ag5evm and the sh73a0 processor.

Onlining and offlining works well, but at this point
offlined processor cores are not put into sleep mode. 

There is no spinlock for syncing the secondary core
with the first one in this implementation. The code
instead relies on the cpu_online() check in __cpu_up().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/include/mach/common.h |    5 +
 arch/arm/mach-shmobile/platsmp.c             |   14 +++
 arch/arm/mach-shmobile/smp-sh73a0.c          |   98 ++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)

--- 0007/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-14 14:36:41.000000000 +0900
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
 pfc-y				:=
--- 0007/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-12-14 14:36:41.000000000 +0900
@@ -38,4 +38,9 @@ extern void sh73a0_pinmux_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 
+extern unsigned int sh73a0_get_core_count(void);
+extern void sh73a0_secondary_init(unsigned int cpu);
+extern int sh73a0_boot_secondary(unsigned int cpu);
+extern void sh73a0_smp_prepare_cpus(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
--- 0007/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2010-12-14 14:36:41.000000000 +0900
@@ -16,25 +16,37 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/localtimer.h>
+#include <asm/mach-types.h>
+#include <mach/common.h>
 
 static unsigned int __init shmobile_smp_get_core_count(void)
 {
+	if (machine_is_ag5evm())
+		return sh73a0_get_core_count();
+
 	return 1;
 }
 
 static void __init shmobile_smp_prepare_cpus(void)
 {
-	/* do nothing for now */
+	if (machine_is_ag5evm())
+		sh73a0_smp_prepare_cpus();
 }
 
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	trace_hardirqs_off();
+
+	if (machine_is_ag5evm())
+		sh73a0_secondary_init(cpu);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	if (machine_is_ag5evm())
+		return sh73a0_boot_secondary(cpu);
+
 	return -ENOSYS;
 }
 
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2010-12-14 14:40:54.000000000 +0900
@@ -0,0 +1,98 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile - sh73a0 portion
+ *
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2010  Takashi Yoshii
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <mach/common.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
+
+#define WUPCR		0xe6151010
+#define SRESCR		0xe6151018
+#define PSTR		0xe6151040
+#define SBAR            0xe6180020
+#define APARMBAREA      0xe6f10020
+
+static void __iomem *scu_base_addr(void)
+{
+	return (void __iomem *)0xf0000000;
+}
+
+static DEFINE_SPINLOCK(scu_lock);
+static unsigned long tmp;
+
+static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+	spin_lock(&scu_lock);
+	tmp = __raw_readl(scu_base + 8);
+	tmp &= ~clr;
+	tmp |= set;
+	spin_unlock(&scu_lock);
+
+	/* disable cache coherency after releasing the lock */
+	__raw_writel(tmp, scu_base + 8);
+}
+
+unsigned int __init sh73a0_get_core_count(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+	return scu_get_core_count(scu_base);
+}
+
+void __cpuinit sh73a0_secondary_init(unsigned int cpu)
+{
+	gic_cpu_init(0, __io(0xf0000100));
+}
+
+int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
+{
+	/* enable cache coherency */
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+
+	if (((__raw_readw(__io(PSTR)) >> (4 * cpu)) & 3) == 3)
+		__raw_writel(1 << cpu, __io(WUPCR));	/* wake up */
+	else
+		__raw_writel(1 << cpu, __io(SRESCR));	/* reset */
+
+	return 0;
+}
+
+void __init sh73a0_smp_prepare_cpus(void)
+{
+#ifdef CONFIG_HAVE_ARM_TWD
+	twd_base = (void __iomem *)0xf0000600;
+#endif
+
+	scu_enable(scu_base_addr());
+
+	/* Map the reset vector (in headsmp.S) */
+	__raw_writel(0, __io(APARMBAREA));      /* 4k */
+	__raw_writel(__pa(shmobile_secondary_vector), __io(SBAR));
+
+	/* enable cache coherency on CPU0 */
+	modify_scu_cpu_psr(0, 3 << (0 * 8));
+}
+
