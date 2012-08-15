From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 Aug 2012 17:22:33 +0800
Subject: [PATCH V2 5/6] ARM: tegra20: add CPU hotplug support
In-Reply-To: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
References: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345022554-26292-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hotplug function put CPU in offline or online mode at runtime.
When the CPU been put into offline, it was been clock gated. The
offline CPU can be power gated, when the remaining CPU goes into
LP2.

Based on the worked by:
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile    |    1 +
 arch/arm/mach-tegra/common.c    |    1 +
 arch/arm/mach-tegra/hotplug.c   |    8 ++++
 arch/arm/mach-tegra/sleep-t20.S |   82 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.h     |    3 +
 5 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/sleep-t20.S

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 211e279..959a429 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-t20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-t30.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 0652056..0560538 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -136,6 +136,7 @@ void __init tegra20_init_early(void)
 	tegra_init_cache(0x331, 0x441);
 	tegra_pmc_init();
 	tegra_powergate_init();
+	tegra20_hotplug_init();
 }
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index be92d4c..d02a354 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -56,6 +56,14 @@ int platform_cpu_disable(unsigned int cpu)
 	return cpu == 0 ? -EPERM : 0;
 }
 
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+extern void tegra20_hotplug_shutdown(void);
+void __init tegra20_hotplug_init(void)
+{
+	tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
+}
+#endif
+
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 extern void tegra30_hotplug_shutdown(void);
 void __init tegra30_hotplug_init(void)
diff --git a/arch/arm/mach-tegra/sleep-t20.S b/arch/arm/mach-tegra/sleep-t20.S
new file mode 100644
index 0000000..a36ae41
--- /dev/null
+++ b/arch/arm/mach-tegra/sleep-t20.S
@@ -0,0 +1,82 @@
+/*
+ * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
+ * Copyright (c) 2011, Google, Inc.
+ *
+ * Author: Colin Cross <ccross@android.com>
+ *         Gary King <gking@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+
+#include <mach/iomap.h>
+
+#include "sleep.h"
+#include "flowctrl.h"
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
+/*
+ * tegra20_hotplug_shutdown(void)
+ *
+ * puts the current cpu in reset
+ * should never return
+ */
+ENTRY(tegra20_hotplug_shutdown)
+	/* Turn off SMP coherency */
+	exit_smp r4, r5
+
+	/* Put this CPU down */
+	cpu_id	r0
+	bl	tegra20_cpu_shutdown
+	mov	pc, lr			@ should never get here
+ENDPROC(tegra20_hotplug_shutdown)
+
+/*
+ * tegra20_cpu_shutdown(int cpu)
+ *
+ * r0 is cpu to reset
+ *
+ * puts the specified CPU in wait-for-event mode on the flow controller
+ * and puts the CPU in reset
+ * can be called on the current cpu or another cpu
+ * if called on the current cpu, does not return
+ * MUST NOT BE CALLED FOR CPU 0.
+ *
+ * corrupts r0-r3, r12
+ */
+ENTRY(tegra20_cpu_shutdown)
+	cmp	r0, #0
+	moveq	pc, lr			@ must not be called for CPU 0
+
+	cpu_to_halt_reg r1, r0
+	ldr	r3, =TEGRA_FLOW_CTRL_VIRT
+	mov	r2, #FLOW_CTRL_WAITEVENT | FLOW_CTRL_JTAG_RESUME
+	str	r2, [r3, r1]		@ put flow controller in wait event mode
+	ldr	r2, [r3, r1]
+	isb
+	dsb
+	movw	r1, 0x1011
+	mov	r1, r1, lsl r0
+	ldr	r3, =TEGRA_CLK_RESET_VIRT
+	str	r1, [r3, #0x340]	@ put slave CPU in reset
+	isb
+	dsb
+	cpu_id	r3
+	cmp	r3, r0
+	beq	.
+	mov	pc, lr
+ENDPROC(tegra20_cpu_shutdown)
+#endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 2ad9b6d..42236e1 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -23,6 +23,8 @@
 					+ IO_CPU_VIRT)
 #define TEGRA_FLOW_CTRL_VIRT (TEGRA_FLOW_CTRL_BASE - IO_PPSB_PHYS \
 					+ IO_PPSB_VIRT)
+#define TEGRA_CLK_RESET_VIRT (TEGRA_CLK_RESET_BASE - IO_PPSB_PHYS \
+					+ IO_PPSB_VIRT)
 
 #ifdef __ASSEMBLY__
 /* returns the offset of the flow controller halt register for a cpu */
@@ -71,6 +73,7 @@
 .endm
 #else
 
+void tegra20_hotplug_init(void);
 void tegra30_hotplug_init(void);
 
 #endif
-- 
1.7.0.4
