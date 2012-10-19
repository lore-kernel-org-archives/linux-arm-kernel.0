From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Oct 2012 16:48:40 +0800
Subject: [PATCH V2 1/7] ARM: tegra: cpuidle: separate cpuidle driver for
 different chips
In-Reply-To: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
References: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
Message-ID: <1350636526-25920-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The different Tegra chips may have different CPU idle states and data.
Individual CPU idle driver make it more easy to maintain.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* only remove the line of file name and path in the (c) header

 arch/arm/mach-tegra/Makefile                       |    6 +++
 .../mach-tegra/{cpuidle.c => cpuidle-tegra20.c}    |    7 +--
 .../mach-tegra/{cpuidle.c => cpuidle-tegra30.c}    |    7 +--
 arch/arm/mach-tegra/cpuidle.c                      |   47 +++++--------------
 arch/arm/mach-tegra/cpuidle.h                      |   32 +++++++++++++
 5 files changed, 55 insertions(+), 44 deletions(-)
 copy arch/arm/mach-tegra/{cpuidle.c => cpuidle-tegra20.c} (91%)
 copy arch/arm/mach-tegra/{cpuidle.c => cpuidle-tegra30.c} (91%)
 create mode 100644 arch/arm/mach-tegra/cpuidle.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e6929c6..9b80c1e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -14,9 +14,15 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
+endif
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
+endif
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_SMP)                       += reset.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
similarity index 91%
copy from arch/arm/mach-tegra/cpuidle.c
copy to arch/arm/mach-tegra/cpuidle-tegra20.c
index 4e0b07c..d32e8b0 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/cpuidle.c
- *
  * CPU idle driver for Tegra CPUs
  *
  * Copyright (c) 2010-2012, NVIDIA Corporation.
@@ -27,7 +25,7 @@
 
 #include <asm/cpuidle.h>
 
-struct cpuidle_driver tegra_idle_driver = {
+static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
@@ -39,7 +37,7 @@ struct cpuidle_driver tegra_idle_driver = {
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
-static int __init tegra_cpuidle_init(void)
+int __init tegra20_cpuidle_init(void)
 {
 	int ret;
 	unsigned int cpu;
@@ -66,4 +64,3 @@ static int __init tegra_cpuidle_init(void)
 	}
 	return 0;
 }
-device_initcall(tegra_cpuidle_init);
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
similarity index 91%
copy from arch/arm/mach-tegra/cpuidle.c
copy to arch/arm/mach-tegra/cpuidle-tegra30.c
index 4e0b07c..37e7551 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/cpuidle.c
- *
  * CPU idle driver for Tegra CPUs
  *
  * Copyright (c) 2010-2012, NVIDIA Corporation.
@@ -27,7 +25,7 @@
 
 #include <asm/cpuidle.h>
 
-struct cpuidle_driver tegra_idle_driver = {
+static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
@@ -39,7 +37,7 @@ struct cpuidle_driver tegra_idle_driver = {
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
-static int __init tegra_cpuidle_init(void)
+int __init tegra30_cpuidle_init(void)
 {
 	int ret;
 	unsigned int cpu;
@@ -66,4 +64,3 @@ static int __init tegra_cpuidle_init(void)
 	}
 	return 0;
 }
-device_initcall(tegra_cpuidle_init);
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 4e0b07c..d065139 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -23,47 +23,26 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/cpuidle.h>
 
-#include <asm/cpuidle.h>
-
-struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
-	.state_count = 1,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-	},
-};
-
-static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
+#include "fuse.h"
+#include "cpuidle.h"
 
 static int __init tegra_cpuidle_init(void)
 {
 	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
 
-	ret = cpuidle_register_driver(&tegra_idle_driver);
-	if (ret) {
-		pr_err("CPUidle driver registration failed\n");
-		return ret;
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		ret = tegra20_cpuidle_init();
+		break;
+	case TEGRA30:
+		ret = tegra30_cpuidle_init();
+		break;
+	default:
+		ret = -ENODEV;
+		break;
 	}
 
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(tegra_idle_device, cpu);
-		dev->cpu = cpu;
-
-		dev->state_count = drv->state_count;
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("CPU%u: CPUidle device registration failed\n",
-				cpu);
-			return ret;
-		}
-	}
-	return 0;
+	return ret;
 }
 device_initcall(tegra_cpuidle_init);
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
new file mode 100644
index 0000000..496204d
--- /dev/null
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
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
+#ifndef __MACH_TEGRA_CPUIDLE_H
+#define __MACH_TEGRA_CPUIDLE_H
+
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+int tegra20_cpuidle_init(void);
+#else
+static inline int tegra20_cpuidle_init(void) { return -ENODEV; }
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+int tegra30_cpuidle_init(void);
+#else
+static inline int tegra30_cpuidle_init(void) { return -ENODEV; }
+#endif
+
+#endif
-- 
1.7.0.4
