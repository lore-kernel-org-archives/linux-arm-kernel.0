From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 21 Jan 2013 17:49:06 +0800
Subject: [PATCH] ARM: tegra114: cpuidle: add ARM_CPUIDLE_WFI_STATE support
Message-ID: <1358761746-13118-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the generic ARM_CPUIDLE_WFI_STATE support for Tegra114.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile           |  3 ++
 arch/arm/mach-tegra/cpuidle-tegra114.c | 61 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/cpuidle.c          |  3 ++
 arch/arm/mach-tegra/cpuidle.h          |  6 ++++
 4 files changed, 73 insertions(+)
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 219c2ed..1335aac 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -34,6 +34,9 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-dt-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra114.o
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
+endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
new file mode 100644
index 0000000..0f4e8c4
--- /dev/null
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include <asm/cpuidle.h>
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.owner = THIS_MODULE,
+	.en_core_tk_irqen = 1,
+	.state_count = 1,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+	},
+};
+
+static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
+
+int __init tegra114_cpuidle_init(void)
+{
+	int ret;
+	unsigned int cpu;
+	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv = &tegra_idle_driver;
+
+	ret = cpuidle_register_driver(&tegra_idle_driver);
+	if (ret) {
+		pr_err("CPUidle driver registration failed\n");
+		return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		dev = &per_cpu(tegra_idle_device, cpu);
+		dev->cpu = cpu;
+
+		dev->state_count = drv->state_count;
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("CPU%u: CPUidle device registration failed\n",
+				cpu);
+			return ret;
+		}
+	}
+	return 0;
+}
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index d065139..4b744c4 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -38,6 +38,9 @@ static int __init tegra_cpuidle_init(void)
 	case TEGRA30:
 		ret = tegra30_cpuidle_init();
 		break;
+	case TEGRA114:
+		ret = tegra114_cpuidle_init();
+		break;
 	default:
 		ret = -ENODEV;
 		break;
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index 496204d..d733f75 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -29,4 +29,10 @@ int tegra30_cpuidle_init(void);
 static inline int tegra30_cpuidle_init(void) { return -ENODEV; }
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+int tegra114_cpuidle_init(void);
+#else
+static inline int tegra114_cpuidle_init(void) { return -ENODEV; }
+#endif
+
 #endif
-- 
1.8.0.3
